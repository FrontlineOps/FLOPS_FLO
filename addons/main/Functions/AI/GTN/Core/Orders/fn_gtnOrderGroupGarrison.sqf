#pragma hemtt ignore_variables ["_self"]
/* _orderGroupGarrison implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
params ["_groupId", "_routePlan", ["_objectiveId", ""], ["_consumeAssignmentBudget", false, [true]]];

private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _gData = _groups get _groupId;
if (isNil "_gData") exitWith {
    ["GTN", 2, format["Cannot order garrison - group %1 not found", _groupId]] call FLO_fnc_log;
    false
};

if !(_routePlan isEqualType createHashMap) then {
    throw format ["Cannot order garrison %1 with route-plan type %2", _groupId, typeName _routePlan];
};
private _pos = _routePlan get "targetPos";
private _waypoints = _routePlan get "waypoints";
private _orderMode = _routePlan get "orderMode";
if (!(_pos isEqualType []) || {count _pos < 2}) exitWith {
    ["GTN", 2, format["Cannot order garrison - invalid destination for %1: %2", _groupId, _pos]] call FLO_fnc_log;
    false
};
if (_waypoints isEqualTo [] || {!(_orderMode in ["GARRISON_BUILDING", "GARRISON_PATROL"])}) then {
    throw format ["Cannot order garrison %1 with invalid route mode/topology %2/%3", _groupId, _orderMode, count _waypoints];
};

private _ownSide = _self get "_ownSide";
if !([_gData, _ownSide, ["infantry", "motorized", "mechanized", "armor"], []] call FLO_fnc_gtnGroupIsStrategicallyAssignable) exitWith {
    ["GTN", 2, format[
        "Cannot order garrison - group %1 not strategically assignable (type=%2 lock=%3 replacement=%4 transport=%5 attached=%6 mounted=%7)",
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

private _hasRouteContext = ((_gData get "waypoints") isNotEqualTo []);
private _currentGarrisonPos = _gData get "garrisonPosition";
private _sameHoldPos = _currentGarrisonPos isEqualType [] && {count _currentGarrisonPos >= 2} && {(_currentGarrisonPos distance2D _pos) < 20};
if (
    (_gData get "commanderOrder") == "GARRISON"
    && {(_gData get "garrisonObjective") == _objectiveId}
    && {(_gData get "orderMode") == _orderMode}
    && {_hasRouteContext}
    && {_sameHoldPos}
) exitWith {
    if (isNil "FLO_GTN_OrderNoOps") then { FLO_GTN_OrderNoOps = createHashMap; };
    FLO_GTN_OrderNoOps set ["GARRISON", (FLO_GTN_OrderNoOps getOrDefault ["GARRISON", 0]) + 1];
    _self call ["_taskGroups", [[_groupId]]];
    true
};

if (_consumeAssignmentBudget && {!(_self call ["_consumeStrategicOrderBudget", ["GARRISON"]])}) exitWith {
    ["GTN", 4, format["Skipped GARRISON order for %1: strategic order budget exhausted", _groupId]] call FLO_fnc_log;
    false
};

private _commitResult = [
    _groupId,
    _gData,
    "GARRISON",
    _waypoints,
    _pos,
    _orderMode,
    _objectiveId,
    _orderMode
] call FLO_fnc_virtualizationCommitCommanderOrder;
_commitResult params ["_commitSuccess", "_routeMs", "_assignMs", "_transportMs", "_orderMs"];
if (!_commitSuccess) exitWith {
    if (_consumeAssignmentBudget) then {
        _self call ["_refundStrategicOrderBudget", ["GARRISON"]];
    };
    false
};
[_self, "GARRISON", _groupId, _gData get "groupType", _objectiveId, _routeMs, _assignMs, _transportMs, _orderMs] call FLO_fnc_gtnLogStrategicOrderPerf;

if (_objectiveId != "") then {
    private _assignmentCache = _self get "_objectiveAssignmentCache";
    private _garrisonCounts = _assignmentCache get "garrisonCounts";
    private _defenderCounts = _assignmentCache get "defenderCounts";
    private _claimedPositions = _assignmentCache get "claimedPositionsByObjective";

    private _garrisonCount = if (_objectiveId in _garrisonCounts) then {
        _garrisonCounts get _objectiveId
    } else {
        0
    };
    _garrisonCounts set [_objectiveId, _garrisonCount + 1];

    private _defenderCount = if (_objectiveId in _defenderCounts) then {
        _defenderCounts get _objectiveId
    } else {
        0
    };
    _defenderCounts set [_objectiveId, _defenderCount + 1];

    private _bucket = if (_objectiveId in _claimedPositions) then {
        _claimedPositions get _objectiveId
    } else {
        []
    };
    _bucket pushBack _pos;
    _claimedPositions set [_objectiveId, _bucket];
};

_self call ["_taskGroups", [[_groupId]]];

["GTN", 5, format["Ordered group %1 to garrison %2 mode=%3", _groupId, _objectiveId, _orderMode]] call FLO_fnc_log;
true
