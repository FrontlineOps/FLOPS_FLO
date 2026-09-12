/*
 * Function: FLO_fnc_gtnCombatPrepareRealGroupForCombat
 * Author: Frontline Operations Development Group
 * Description:
 *   Pushes an active real AI group into combat posture for live-area handoff.
 *
 * Arguments:
 *   0: Group data <HASHMAP>
 *
 * Return Value:
 *   None
 */

params ["_gData"];

if !(_gData get "isActive") exitWith {};
if ((_gData get "groupType") in ["static_aa", "air", "helicopter", "jet"]) exitWith {};

private _realGroup = _gData get "realGroup";
if (isNull _realGroup) exitWith {};

if (isNil {_realGroup getVariable "FLO_combatPosture"}) then {
    _realGroup setVariable ["FLO_combatPosture", [behaviour leader _realGroup, combatMode _realGroup, speedMode _realGroup]];
};

_realGroup setBehaviour "COMBAT";
_realGroup setCombatMode "RED";
_realGroup setSpeedMode "FULL";
