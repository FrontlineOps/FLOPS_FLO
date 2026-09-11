/*
 * Function: FLO_fnc_updateVirtualGroupWaypoints
 * Description:
 *   Canonical route mutation boundary. LAND routes are fully resolved before
 *   state changes; AIR and WATER routes remain direct.
 *
 * Return Value:
 *   Success <BOOLEAN>
 */

params [
    ["_groupId", "", [""]],
    ["_waypoints", [], [[]]],
    ["_allowTrails", true, [true]],
    ["_requestSource", "", [""]],
    ["_closeLoop", false, [true]],
    ["_patrolConfig", [], [[]]]
];

if (canSuspend) exitWith {
    private _result = false;
    private _failure = [];
    isNil {
        try { _result = _this call FLO_fnc_updateVirtualGroupWaypoints; } catch { _failure = [_exception]; };
    };
    if (_failure isNotEqualTo []) then { throw (_failure select 0) };
    _result
};

private _groupData = [_groupId] call FLO_fnc_virtualizationRequireGroup;
private _candidate = [_groupData] call FLO_fnc_virtualizationCloneValue;
if !([_groupId, _candidate, _waypoints, _allowTrails, _requestSource, _closeLoop, _patrolConfig] call FLO_fnc_virtualizationBuildRouteCandidate) exitWith {
    { _groupData set [_x, _candidate get _x] } forEach ["landRouteStartBlocked", "landRouteRetryAt"];
    false
};
[_groupId, _groupData, _candidate] call FLO_fnc_virtualizationPublishRoute
