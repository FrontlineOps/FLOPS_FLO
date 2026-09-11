/*
 * Function: FLO_fnc_virtualizationResumeSavedRoutes
 * Author: Frontline Operations Development Group
 * Description:
 *   Reissues saved virtual-group routes whose pending pathfinding callbacks
 *   were lost across save/load. This primarily restores logistics
 *   reinforcements that were saved in a planning state.
 *
 * Arguments: None
 *
 * Return Value:
 * NUMBER - Count of groups whose routes were reissued
 */

if (isNil "FLO_VirtualForceRegistry") exitWith { 0 };

private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _resumed = 0;

{
    private _groupId = _x;
    private _groupData = _y;
    private _waypoints = _groupData get "waypoints";

    if (_waypoints isNotEqualTo []) then { continue };

    private _replacementState = _groupData get "replacementState";
    if (_replacementState == "") then { continue };
    private _target = _groupData get "reinforcementTargetPos";
    if !([_target] call FLO_fnc_validateGroupPosition) then {
        throw format ["[VIRTUALIZATION] Saved replacement %1 has no valid destination", _groupId];
    };
    private _allowTrails = (_groupData get "groupType") == "infantry";
    private _source = ["LOGI_REINF", "LOGI_STATIC_AA"] select (_replacementState == "AA_DEPLOY");
    private _completionRadius = [20, 80] select (_replacementState == "AA_DEPLOY");
    private _resumeWaypoint = [_target, "MOVE", "SAFE", "NORMAL", "COLUMN", "GREEN", _completionRadius];

    if ([_groupId, [_resumeWaypoint], _allowTrails, _source] call FLO_fnc_updateVirtualGroupWaypoints) then {
        _resumed = _resumed + 1;
    } else {
        ["VIRTUALIZATION", 1, format ["Required saved route could not resume for %1", _groupId]] call FLO_fnc_log;
        throw format ["FLO_fnc_virtualizationResumeSavedRoutes: no land route for %1", _groupId];
    };
} forEach _groups;

if (_resumed > 0) then {
    ["VIRTUALIZATION", 3, format ["Reissued %1 saved route requests after load", _resumed]] call FLO_fnc_log;
};

_resumed
