/*
 * Function: FLO_fnc_virtualizationCommitCommanderOrder
 * Author: Frontline Operations Development Group
 * Description:
 *   Applies one GTN commander order through the canonical virtualization order
 *   pipeline: route update, commander-order state, then optional reassignment
 *   transport request. This keeps order application consistent while leaving
 *   commander target selection outside virtualization.
 *
 * Arguments:
 *   0: Group ID <STRING>
 *   1: Group data <HASHMAP>
 *   2: Order type <STRING> - MOVE, ATTACK, DEFEND, or GARRISON
 *   3: Waypoints <ARRAY>
 *   4: Target position <ARRAY>
 *   5: Route source tag <STRING>
 *   6: Objective ID <STRING>
 *   7: Order mode <STRING> - MOVE or GARRISON
 *   8: Defend lease issued at <NUMBER>
 *   9: Defend lease until <NUMBER>
 *
 * Return Value:
 *   ARRAY - [success, routeMs, assignMs, transportMs, orderMs]
 */

params [
    ["_groupId", "", [""]],
    ["_groupData", createHashMap, [createHashMap]],
    ["_orderType", "", [""]],
    ["_waypoints", [], [[]]],
    ["_targetPos", [], [[]]],
    ["_routeSource", "", [""]],
    ["_objectiveId", "", [""]],
    ["_orderMode", "", [""]],
    ["_leaseIssuedAt", -1, [0]],
    ["_leaseUntil", -1, [0]]
];

if (canSuspend) exitWith {
    private _result = [];
    private _failure = [];
    isNil {
        try { _result = _this call FLO_fnc_virtualizationCommitCommanderOrder; } catch { _failure = [_exception]; };
    };
    if (_failure isNotEqualTo []) then { throw (_failure select 0) };
    _result
};

if (_groupId == "") then {
    throw "FLO_fnc_virtualizationCommitCommanderOrder: empty group id";
};

if !([_targetPos] call FLO_fnc_validateGroupPosition) then {
    throw format [
        "FLO_fnc_virtualizationCommitCommanderOrder: invalid target position for %1: %2",
        _groupId,
        _targetPos
    ];
};

private _order = toUpper _orderType;
if (_order == "ATTACK" && {_objectiveId == ""}) then {
    throw "FLO_fnc_virtualizationCommitCommanderOrder: ATTACK requires an objective";
};
private _orderStart = diag_tickTime;

private _candidate = [_groupData] call FLO_fnc_virtualizationCloneValue;
private _tAssign = diag_tickTime;
switch (_order) do {
    case "MOVE": {
        [_candidate, _targetPos, _orderMode] call FLO_fnc_virtualizationAssignMoveOrder;
    };
    case "ATTACK": {
        [_candidate, _targetPos, _objectiveId] call FLO_fnc_virtualizationAssignAttackOrder;
    };
    case "DEFEND": {
        [_candidate, _targetPos, _objectiveId, _leaseIssuedAt, _leaseUntil] call FLO_fnc_virtualizationAssignDefendOrder;
    };
    case "GARRISON": {
        [_candidate, _targetPos, _objectiveId, _orderMode] call FLO_fnc_virtualizationAssignGarrisonOrder;
    };
    default {
        throw format [
            "FLO_fnc_virtualizationCommitCommanderOrder: unsupported order type %1 for %2",
            _orderType,
            _groupId
        ];
    };
};
private _assignMs = (diag_tickTime - _tAssign) * 1000;

private _orderFields = (keys _candidate) select { (_candidate get _x) isNotEqualTo (_groupData get _x) };
private _tRoute = diag_tickTime;
private _routeAllowed = [_groupId, _candidate, _waypoints, true, _routeSource, false, []] call FLO_fnc_virtualizationBuildRouteCandidate;
if (!_routeAllowed) exitWith {
    { _groupData set [_x, _candidate get _x] } forEach ["landRouteStartBlocked", "landRouteRetryAt"];
    [false, (diag_tickTime - _tRoute) * 1000, _assignMs, 0, (diag_tickTime - _orderStart) * 1000]
};
private _routeCommitted = [_groupId, _groupData, _candidate, _orderFields] call FLO_fnc_virtualizationPublishRoute;
private _routeMs = (diag_tickTime - _tRoute) * 1000;
if (!_routeCommitted) exitWith {
    [false, _routeMs, _assignMs, 0, (diag_tickTime - _orderStart) * 1000]
};

private _tTransport = diag_tickTime;
if (_orderMode != "WITHDRAW") then {
    [_groupId, _groupData, _targetPos, _order] call FLO_fnc_transportMaybeRequestReassignmentPickup;
};
private _transportMs = (diag_tickTime - _tTransport) * 1000;

private _orderMs = (diag_tickTime - _orderStart) * 1000;

[true, _routeMs, _assignMs, _transportMs, _orderMs]
