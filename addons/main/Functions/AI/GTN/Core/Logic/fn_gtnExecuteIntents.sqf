/* Every admitted intent is monitored each cycle; order work shares one budget. */
params ["_commander"];
private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _intents = _commander get "_intents";
private _ids = keys _intents;
_ids sort true;
private _processed = 0;
private _completed = 0;
private _failed = 0;
private _planMs = 0;
private _executeMs = 0;
private _count = count _ids;
private _cursor = if (_count > 0) then { (_commander get "_nextTrackExecutionIndex") mod _count } else { 0 };
for "_offset" from 0 to (_count - 1) do {
    private _id = _ids select ((_cursor + _offset) mod _count);
    private _intent = _intents get _id;
    private _reason = "";
    private _remaining = [];
    private _units = 0;
    {
        if !(_x in _groups) then { continue };
        private _group = _groups get _x;
        if ((_group get "commanderIntent") != _id) then { _reason = "FORCE_REASSIGNED"; continue };
        if ((_group get "unitCount") <= 0) then { _group set ["commanderIntent", ""]; continue };
        _remaining pushBack _x;
        _units = _units + (_group get "unitCount");
    } forEach (_intent get "groupIds");
    _intent set ["groupIds", _remaining];
    _intent set ["issued", (_intent get "issued") arrayIntersect _remaining];
    if ((_intent get "initialUnits") > 0 && {_units < ((_intent get "initialUnits") * (1 - ((_commander get "_config") get "intentWithdrawalLossFraction")))}) then { _reason = "FORCE_LOSSES" };
    private _state = [_commander get "_worldState", _id] call FLO_fnc_gtnIntentSnapshot;
    if !([_state, [_id]] call FLO_fnc_gtnIntentGoalValid) then { _reason = "OBJECTIVE_OR_SUPPLY_LOST" };
    private _phaseLimit = [1800, 3600] select ((_intent get "phase") == "SECURE");
    if (diag_tickTime - (_intent get "phaseStartedAt") > _phaseLimit) then { _reason = "PHASE_TIMEOUT" };
    if (_reason != "") then {
        [_commander, _intent, false, _reason] call FLO_fnc_gtnRetireIntent;
        _failed = _failed + 1;
        continue;
    };
    private _tracks = _commander get "_tracks";
    private _track = _tracks select (_tracks findIf { (_x get "id") == _id });
    private _objective = ((_commander get "_worldState") get "_objectives") get (_intent get "objectiveId");
    if ((_intent get "kind") == "CAPTURE" && {(_objective get "owner") == (_commander get "_ownSide")}
        && {!((_intent get "phase") in ["SECURE", "COMPLETE"])}) then {
        (_track get "planner") call ["_cancel", [_commander get "_executor", "OBJECTIVE_CAPTURED"]];
        _intent set ["issued", []];
        [_commander, _intent, "SECURE"] call FLO_fnc_gtnSetIntentPhase;
        _track set ["status", "IDLE"];
        _track set ["retryAt", -1];
    };
    private _metrics = [_commander, _track] call FLO_fnc_gtnExecuteTrackCycle;
    _processed = _processed + 1;
    _planMs = _planMs + (_metrics get "planMs");
    _executeMs = _executeMs + (_metrics get "primitiveExecMs") + (_metrics get "checkMs");
    if ((_metrics get "plansFailed") > 0) then {
        [_commander, _intent, false, (_track get "planner") get "_failureReason"] call FLO_fnc_gtnRetireIntent;
        _failed = _failed + 1;
    } else {
        if ((_track get "status") == "COMPLETE") then {
            [_commander, _intent, true, "GOAL_SATISFIED"] call FLO_fnc_gtnRetireIntent;
            _completed = _completed + 1;
        };
    };
};
_commander set ["_nextTrackExecutionIndex", _cursor + 1];
createHashMapFromArray [["processed", _processed], ["completed", _completed], ["failed", _failed], ["planMs", _planMs], ["executeMs", _executeMs]]
