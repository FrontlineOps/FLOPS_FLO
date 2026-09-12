/*
 * Function: FLO_fnc_gtnCombatExitState
 * Author: Frontline Operations Development Group
 * Description:
 *   Clears the combat overlay from a group and restores its next appropriate
 *   operational state.
 *
 * Arguments:
 *   0: Group ID <STRING>
 *   1: Group data <HASHMAP>
 *   2: Resume states map <HASHMAP>
 *
 * Return Value:
 *   None
 */

params ["_groupId", "_gData", "_resumeStates"];

private _resumeState = _resumeStates getOrDefault [_groupId, ""];
[_gData] call FLO_fnc_virtualizationResetMovementClock;
[
    _groupId,
    createHashMapFromArray [["inCombat", false]]
] call FLO_fnc_virtualizationPatchGroup;
[_gData, [_gData, _resumeState] call FLO_fnc_gtnCombatDerivePostCombatState] call FLO_fnc_virtualizationSetRuntimeState;
_resumeStates deleteAt _groupId;

if (_gData get "isActive") then {
    private _group = _gData get "realGroup";
    private _posture = _group getVariable ["FLO_combatPosture", []];
    if (_posture isNotEqualTo []) then {
        // A current order takes precedence over the posture captured on entry.
        private _wpIndex = currentWaypoint _group;
        if ((_gData get "waypoints") isNotEqualTo [] && {_wpIndex > 0} && {_wpIndex < count waypoints _group}) then {
            private _wp = [_group, _wpIndex];
            private _ordered = [waypointBehaviour _wp, waypointCombatMode _wp, waypointSpeed _wp];
            {
                if (_x != "" && {_x != "UNCHANGED"}) then { _posture set [_forEachIndex, _x] };
            } forEach _ordered;
        };
        _group setBehaviour (_posture select 0);
        _group setCombatMode (_posture select 1);
        _group setSpeedMode (_posture select 2);
        _group setVariable ["FLO_combatPosture", nil];
    };
};
