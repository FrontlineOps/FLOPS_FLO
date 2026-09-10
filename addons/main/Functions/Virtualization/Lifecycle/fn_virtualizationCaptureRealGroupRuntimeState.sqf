/*
 * Function: FLO_fnc_virtualizationCaptureRealGroupRuntimeState
 */

params ["_groupData", "_realGroup"];

// Remaining route ownership is independent of the leader's combat posture.
// Virtual waypoint completion decides when an arrived terminal waypoint holds.
private _state = "moving";
if ((_groupData get "waypoints") isEqualTo []) then {
    _state = [_groupData] call FLO_fnc_virtualizationResolveRouteCompletionState;
};

[_groupData, _state] call FLO_fnc_virtualizationSetRuntimeState;

_state
