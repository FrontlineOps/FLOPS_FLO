/* Retire the durable owner, preserving orders issued later by another system. */
params ["_commander", "_intent", "_success", "_reason"];
private _id = _intent get "id";
private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _tracks = _commander get "_tracks";
private _index = _tracks findIf { (_x get "id") == _id };
if (_index >= 0) then {
    ((_tracks select _index) get "planner") call ["_cancel", [_commander get "_executor", "INTENT_RETIRED"]];
    _tracks deleteAt _index;
};
private _released = [];
{
    if !(_x in _groups) then { continue };
    private _group = _groups get _x;
    if ((_group get "commanderIntent") != _id) then { continue };
    _group set ["commanderIntent", ""];
    if (!_success) then {
        private _withdrawn = false;
        if ((_intent get "kind") == "CAPTURE") then {
            _withdrawn = [_commander, _x, _group, _intent get "targetPos"] call FLO_fnc_gtnCombatWithdrawGroup;
        };
        if (!_withdrawn) then {
            [_x, createHashMapFromArray [["postDismountWaypoint", []]]] call FLO_fnc_virtualizationPatchGroup;
            [_group] call FLO_fnc_virtualizationClearCommanderOrder;
            if !([_x, [], true, "GTN_INTENT_CANCEL"] call FLO_fnc_updateVirtualGroupWaypoints) then {
                throw format ["GTN failed clearing cancelled intent %1 group %2", _id, _x];
            };
            _released pushBack _x;
        };
    };
    [_commander get "_worldState", _x, _group] call FLO_fnc_gtnObserveOwnGroup;
} forEach (_intent get "groupIds");
_commander set ["_gtnTaskedGroups", (_commander get "_gtnTaskedGroups") - _released];
(_commander get "_intents") deleteAt _id;
(_commander get "_intentRetryAt") set [format ["%1:%2", _intent get "kind", _intent get "objectiveId"], diag_tickTime + ([120, 30] select _success)];
["GTN", [2, 3] select _success, format ["%1 intent %2 retired success=%3 reason=%4 groups=%5", _commander get "_sideKey", _id, _success, _reason, count (_intent get "groupIds")]] call FLO_fnc_log;
true
