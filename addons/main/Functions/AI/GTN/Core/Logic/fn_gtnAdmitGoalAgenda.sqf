params ["_commander"];
private _world = _commander get "_worldState";
private _objectives = _world get "_objectives";
private _picture = _world get "_strategicPicture";
private _config = _commander get "_config";
private _admitted = 0;
private _attempts = 0;
private _supportAdmitted = createHashMap;
{
    if (_admitted >= (_config get "goalsAdmittedPerCycle") || {count (_commander get "_tracks") >= (_config get "maxActiveGoals")}) exitWith {};
    _x params ["_negativeScore", "_objectiveId", "_kind"];
    if (_kind in _supportAdmitted) then { continue };
    _attempts = _attempts + 1;
    private _objective = _objectives get _objectiveId;
    private _stageId = _objectiveId;
    private _targetPos = +(_objective get "position");
    if (_kind == "CAPTURE") then {
        _targetPos = [_objectiveId, _objective] call FLO_fnc_gtnResolveAttackLandAnchor;
        if (_targetPos isEqualTo []) then { continue };
        private _sources = [];
        {
            private _source = _picture get _x;
            _sources pushBack [(_source get "threat") + (_source get "supplyExposure") * 15, -(_source get "friendlyLinks"), ((_objectives get _x) get "position") distance2D _targetPos, _x];
        } forEach ((_picture get _objectiveId) get "sources");
        _sources sort true;
        if (_sources isEqualTo []) then { continue };
        _stageId = (_sources select 0) select 3;
    };
    private _groupIds = [];
    if (_kind in ["GARRISON", "DEFEND", "CAPTURE"]) then {
        _groupIds = [_commander, _kind, _objectiveId, _stageId] call FLO_fnc_gtnSelectIntentForces;
        if (_groupIds isEqualTo []) then { continue };
    } else { _supportAdmitted set [_kind, true] };
    [_commander, _kind, _objectiveId, _groupIds, _stageId, (_objectives get _stageId) get "position", _targetPos, -_negativeScore] call FLO_fnc_gtnCreateIntent;
    _admitted = _admitted + 1;
} forEach (_commander get "_goalAgenda");
createHashMapFromArray [["candidates", count (_commander get "_goalAgenda")], ["attempts", _attempts], ["admitted", _admitted]]
