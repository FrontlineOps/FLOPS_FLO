/*
 * Function: FLO_fnc_gtnCombatDerivePostCombatState
 * Author: Frontline Operations Development Group
 * Description:
 *   Derives the appropriate group state after the combat overlay is removed.
 *
 * Arguments:
 *   0: Group data <HASHMAP>
 *   1: Saved resume state <STRING>
 *
 * Return Value:
 *   Post-combat state <STRING>
 */

params ["_gData", "_resumeState"];

if ((_gData get "groupType") == "static_aa") exitWith { "holding" };
// A withdrawal can replace a hold order while the combat overlay is active.
// Do not restore the old hold state over the newly committed escape route.
if ((_gData get "orderMode") == "WITHDRAW" && {(_gData get "waypoints") isNotEqualTo []}) exitWith { "moving" };
if (_resumeState != "" && {_resumeState != "inCombat"}) exitWith { _resumeState };
if ((_gData get "waypoints") isNotEqualTo []) exitWith { "moving" };
if ((_gData get "replacementState") != "") exitWith { "moving" };

switch (_gData get "commanderOrder") do {
    case "ATTACK": { "holding" };
    case "DEFEND": { "holding" };
    case "MOVE": { "moving" };
    default {
        ["idle", "holding"] select (((_gData get "aaDeployState")) == "DEPLOYED");
    };
}
