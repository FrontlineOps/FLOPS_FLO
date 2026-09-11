/*
 * Function: FLO_fnc_virtualizationAssignAutoPatrol
 * Author: Frontline Operations Development Group
 * Description:
 *   Assigns persistent auto-patrol data to an eligible virtual group.
 */

params [
    "_groupId",
    ["_centerOverride", [], [[]]]
];

private _groupData = [_groupId] call FLO_fnc_virtualizationRequireGroup;

if (!([_groupData] call FLO_fnc_virtualizationCanAutoPatrol)) exitWith { false };
if ((_groupData get "state") != "idle") exitWith { false };
if (_groupData get "autoPatrol") exitWith { false };
if ((_groupData get "patrolConfig") isNotEqualTo []) exitWith { false };
if ((_groupData get "waypoints") isNotEqualTo []) exitWith { false };
private _position = if (_centerOverride isEqualTo []) then { _groupData get "position" } else { _centerOverride };
if (
    (_groupData get "landRouteStartBlocked")
    && {diag_tickTime < (_groupData get "landRouteRetryAt")}
    && {surfaceIsWater _position}
) exitWith { false };

private _home = _groupData get "homeObjective";
private _retry = _groupData get "autoPatrolRetry";
private _sameLocation = _retry isNotEqualTo []
    && {(_retry select 0) isEqualTo _position}
    && {(_retry select 1) == _home};
if (_sameLocation && {diag_tickTime < (_retry select 2)}) exitWith { false };

private _patrolPlan = [_groupData, _centerOverride] call FLO_fnc_virtualizationBuildPatrolPlan;
private _assigned = false;
if (_patrolPlan isNotEqualTo []) then {
    _patrolPlan params ["_patrolWaypoints", "_patrolConfig"];
    _assigned = [_groupId, _patrolWaypoints, true, "AUTO_PATROL", true, _patrolConfig] call FLO_fnc_updateVirtualGroupWaypoints;
};
if (!_assigned) exitWith {
    private _retrySeconds = ["landRouteBlockedRetrySeconds"] call FLO_fnc_virtualizationGetConfigValue;
    _groupData set ["autoPatrolRetry", [+_position, _home, diag_tickTime + _retrySeconds]];
    if (!_sameLocation && {!(_groupData get "landRouteStartBlocked")}) then {
        ["VIRTUALIZATION", 2, format ["Auto-patrol deferred group=%1 reason=NO_VALID_LAND_PATROL retrySeconds=%2", _groupId, _retrySeconds]] call FLO_fnc_log;
    };
    false
};

_groupData set ["autoPatrolRetry", []];
["VIRTUALIZATION", 5, format ["Assigned persistent auto-patrol to %1 (%2 waypoints)", _groupId, count (_patrolPlan select 0)]] call FLO_fnc_log;

true
