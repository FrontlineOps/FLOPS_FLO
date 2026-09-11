#pragma hemtt ignore_variables ["_self"]
/* _orderGroupMove implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
params ["_groupId", "_pos", ["_mode", "AWARE"]];

private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _gData = _groups get _groupId;
if (isNil "_gData") exitWith {
    ["GTN", 2, format["Cannot order move - group %1 not found", _groupId]] call FLO_fnc_log;
    false
};

if (!(_pos isEqualType []) || {count _pos < 2}) exitWith {
    ["GTN", 2, format["Cannot order move - invalid destination for %1: %2", _groupId, _pos]] call FLO_fnc_log;
    false
};

private _existingTarget = _gData get "orderTargetPos";
private _existingMode = _gData get "orderMode";
private _hasRouteContext = ((_gData get "waypoints") isNotEqualTo []) || {(_gData get "pathToken") >= 0};
if ((_gData get "commanderOrder") == "MOVE" && {_existingMode == _mode} && {_hasRouteContext} && {count _existingTarget >= 2} && {_existingTarget distance2D _pos < 35}) exitWith {
    if (isNil "FLO_GTN_OrderNoOps") then { FLO_GTN_OrderNoOps = createHashMap; };
    FLO_GTN_OrderNoOps set ["MOVE", (FLO_GTN_OrderNoOps getOrDefault ["MOVE", 0]) + 1];
    _self call ["_taskGroups", [[_groupId]]];
    true
};

private _formation = selectRandom ["STAG COLUMN", "WEDGE", "VEE", "DIAMOND", "LINE", "COLUMN"];

private _waypoints = [
    [_pos, "MOVE", _mode, "FULL", _formation, "YELLOW", 30]
];

private _commitResult = [_groupId, _gData, "MOVE", _waypoints, _pos, "GTN_MOVE", "", _mode] call FLO_fnc_virtualizationCommitCommanderOrder;
if !(_commitResult select 0) exitWith { false };

// Mark as tasked
_self call ["_taskGroups", [[_groupId]]];

["GTN", 5, format["Ordered group %1 to move to %2 (%3)", _groupId, _pos, _mode]] call FLO_fnc_log;
true
