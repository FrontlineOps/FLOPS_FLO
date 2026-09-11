#pragma hemtt ignore_variables ["_self"]
/* _orderGroupDefend implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
params ["_groupId", "_pos", ["_objectiveId", ""], ["_skipSaturationCheck", false, [true]], ["_consumeAssignmentBudget", false, [true]]];

private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _gData = _groups get _groupId;
if (isNil "_gData") exitWith {
    ["GTN", 2, format["Cannot order defend - group %1 not found", _groupId]] call FLO_fnc_log;
    false
};

if (!(_pos isEqualType []) || {count _pos < 2}) exitWith {
    ["GTN", 2, format["Cannot order defend - invalid destination for %1: %2", _groupId, _pos]] call FLO_fnc_log;
    false
};

private _ownSide = _self get "_ownSide";
if !([_gData, _ownSide, ["infantry", "motorized", "mechanized", "armor"], []] call FLO_fnc_gtnGroupIsStrategicallyAssignable) exitWith {
    ["GTN", 2, format[
        "Cannot order defend - group %1 not strategically assignable (type=%2 lock=%3 replacement=%4 transport=%5 attached=%6 mounted=%7)",
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

private _alreadyAssigned = false;
private _saturated = false;
if (_objectiveId != "") then {
    private _hasRouteContext = ((_gData get "waypoints") isNotEqualTo []);
    private _sameObjectiveAssigned = ((_gData get "commanderOrder") == "DEFEND") && {(_gData get "defendObjective") == _objectiveId} && {_hasRouteContext};
    private _currentDefendPos = _gData get "orderTargetPos";
    private _sameHoldPos = _currentDefendPos isEqualType [] && {count _currentDefendPos >= 2} && {(_currentDefendPos distance2D _pos) < 20};
    _alreadyAssigned = _sameObjectiveAssigned && {_sameHoldPos};
    if (!_sameObjectiveAssigned && {!_skipSaturationCheck}) then {
        private _assigned = _self call ["_countObjectiveDefenders", [_objectiveId]];
        private _cap = _self call ["_getDefenseCapForObjective", [_objectiveId]];
        if (_cap > 0 && {_assigned >= _cap}) then {
            ["GTN", 3, format[
                "Defend order skipped for %1: %2 already saturated (%3/%4)",
                _groupId,
                _objectiveId,
                _assigned,
                _cap
            ]] call FLO_fnc_log;
            _saturated = true;
        };
    };
};

if (_alreadyAssigned) exitWith {
    if (isNil "FLO_GTN_OrderNoOps") then { FLO_GTN_OrderNoOps = createHashMap; };
    FLO_GTN_OrderNoOps set ["DEFEND", (FLO_GTN_OrderNoOps getOrDefault ["DEFEND", 0]) + 1];
    private _leaseSeconds = (_self get "_config") get "defenseLeaseSeconds";
    [_gData, diag_tickTime, diag_tickTime + _leaseSeconds] call FLO_fnc_virtualizationRefreshDefendLease;
    true
};

if (_saturated) exitWith { false };

if (_consumeAssignmentBudget && {!(_self call ["_consumeStrategicOrderBudget", ["DEFEND"]])}) exitWith {
    ["GTN", 4, format["Skipped DEFEND order for %1: strategic order budget exhausted", _groupId]] call FLO_fnc_log;
    false
};

private _formation = selectRandom ["STAG COLUMN", "WEDGE", "VEE", "DIAMOND", "LINE", "COLUMN"];

private _waypoints = [
    [_pos, "MOVE", "AWARE", "FULL", _formation, "YELLOW", 40],
    [_pos, "GUARD", "AWARE", "FULL", _formation, "YELLOW", 60]
];

private _leaseSeconds = (_self get "_config") get "defenseLeaseSeconds";
private _commitResult = [_groupId, _gData, "DEFEND", _waypoints, _pos, "GTN_DEFEND", _objectiveId, "", diag_tickTime, diag_tickTime + _leaseSeconds] call FLO_fnc_virtualizationCommitCommanderOrder;
_commitResult params ["_commitSuccess", "_routeMs", "_assignMs", "_transportMs", "_orderMs"];
if (!_commitSuccess) exitWith {
    if (_consumeAssignmentBudget) then {
        _self call ["_refundStrategicOrderBudget", ["DEFEND"]];
    };
    false
};
[_self, "DEFEND", _groupId, _gData get "groupType", _objectiveId, _routeMs, _assignMs, _transportMs, _orderMs] call FLO_fnc_gtnLogStrategicOrderPerf;

if (_objectiveId != "") then {
    private _assignmentCache = _self get "_objectiveAssignmentCache";
    private _defenderCounts = _assignmentCache get "defenderCounts";
    private _claimedPositions = _assignmentCache get "claimedPositionsByObjective";

    private _count = if (_objectiveId in _defenderCounts) then {
        _defenderCounts get _objectiveId
    } else {
        0
    };
    _defenderCounts set [_objectiveId, _count + 1];

    private _bucket = if (_objectiveId in _claimedPositions) then {
        _claimedPositions get _objectiveId
    } else {
        []
    };
    _bucket pushBack _pos;
    _claimedPositions set [_objectiveId, _bucket];
};

// Mark as tasked
_self call ["_taskGroups", [[_groupId]]];

["GTN", 5, format["Ordered group %1 to defend %2", _groupId, _pos]] call FLO_fnc_log;
true
