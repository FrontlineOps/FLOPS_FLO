#pragma hemtt ignore_variables ["_self"]
/* _orderGroupAttack implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
params [
    "_groupId",
    "_attackPos",
    ["_objectiveId", ""],
    ["_consumeAssignmentBudget", false, [true]]
];

if (_objectiveId == "") then {
    throw "GTN ATTACK requires an objective";
};

private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _gData = _groups get _groupId;
if (isNil "_gData") exitWith {
    ["GTN", 2, format["Cannot order attack - group %1 not found", _groupId]] call FLO_fnc_log;
    false
};

if (!(_attackPos isEqualType []) || {count _attackPos < 2}) then {
    throw format ["GTN ATTACK has invalid target position for %1: %2", _groupId, _attackPos];
};

private _ownSide = _self get "_ownSide";
if !([_gData, _ownSide, ["infantry", "motorized", "mechanized", "armor"]] call FLO_fnc_gtnGroupIsStrategicallyAssignable) exitWith {
    ["GTN", 2, format[
        "Cannot order attack - group %1 not strategically assignable (type=%2 lock=%3 replacement=%4 transport=%5 attached=%6 mounted=%7)",
        _groupId,
        _gData get "groupType",
        _gData get "missionLock",
        _gData get "replacementState",
        _gData get "transportRole",
        _gData get "attachedTo",
        _gData get "mountedIn"
    ]] call FLO_fnc_log;
    false
};

private _existingAttackObjective = _gData get "attackObjective";
private _hasRouteContext = ((_gData get "waypoints") isNotEqualTo []) || {(_gData get "pathToken") >= 0};
if (
    (_gData get "commanderOrder") == "ATTACK"
    && {_hasRouteContext}
    && {_existingAttackObjective == _objectiveId}
) exitWith {
    if (isNil "FLO_GTN_OrderNoOps") then { FLO_GTN_OrderNoOps = createHashMap; };
    FLO_GTN_OrderNoOps set ["ATTACK", (FLO_GTN_OrderNoOps getOrDefault ["ATTACK", 0]) + 1];
    _self call ["_taskGroups", [[_groupId]]];
    true
};

if (_consumeAssignmentBudget && {!(_self call ["_consumeStrategicOrderBudget", ["ATTACK"]])}) exitWith {
    ["GTN", 4, format["Skipped ATTACK order for %1: strategic order budget exhausted", _groupId]] call FLO_fnc_log;
    false
};

private _formation = selectRandom ["STAG COLUMN", "WEDGE", "VEE", "DIAMOND", "LINE", "COLUMN"];

private _waypoints = [
    [_attackPos, "MOVE", "AWARE", "FULL", _formation, "YELLOW", 75],
    [_attackPos, "MOVE", "AWARE", "FULL", _formation, "YELLOW", 50]
];

private _commitResult = [
    _groupId,
    _gData,
    "ATTACK",
    _waypoints,
    _attackPos,
    "GTN_ATTACK",
    _objectiveId,
    "",
    -1,
    -1
] call FLO_fnc_virtualizationCommitCommanderOrder;
_commitResult params ["_commitSuccess", "_routeMs", "_assignMs", "_transportMs", "_orderMs"];
if (!_commitSuccess) exitWith {
    if (_consumeAssignmentBudget) then {
        _self call ["_refundStrategicOrderBudget", ["ATTACK"]];
    };
    false
};

[_self, "ATTACK", _groupId, _gData get "groupType", _objectiveId, _routeMs, _assignMs, _transportMs, _orderMs] call FLO_fnc_gtnLogStrategicOrderPerf;

private _assignmentCache = _self get "_objectiveAssignmentCache";
private _attackCounts = _assignmentCache get "attackCounts";
private _count = if (_objectiveId in _attackCounts) then { _attackCounts get _objectiveId } else { 0 };
_attackCounts set [_objectiveId, _count + 1];

// Mark as tasked
_self call ["_taskGroups", [[_groupId]]];

["GTN", 5, format["Ordered group %1 to attack %2 (%3)", _groupId, _attackPos, _objectiveId]] call FLO_fnc_log;
true
