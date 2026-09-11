/*
 * Function: FLO_fnc_shouldOpenFactionDialog
 * Author: Frontline Operations Development Group
 * Description:
 *   Returns true only when the mission setup dialog is still valid to open.
 *   Fresh starts are allowed to open during Phase 1 for a logged-in admin or
 *   hosted server while the server is waiting for submitted config. Once
 *   configuration has already been submitted or later initialization is
 *   underway/completed, reconnecting players must not see setup again.
 *
 * Arguments:
 *   None
 *
 * Return Value:
 *   BOOL - True when the faction dialog may be opened
 */

// Display 0 remains open behind Eden previews, including hosted multiplayer.
if (!hasInterface || {is3DEN} || {isNull findDisplay 46} || {!is3DENPreview && {!isNull findDisplay 0}}) exitWith { false };
// Absence of an initialization phase is not permission to start a campaign.
if (isNil "FLO_InitPhase") exitWith { false };
if (FLO_InitPhase != 1) exitWith { false };

private _isLoadedSave = missionNamespace getVariable ["FLO_IsLoadedSave", false];
if (_isLoadedSave) exitWith { false };

private _missionConfigReady = !isNil "FLO_MissionConfig"
    && {FLO_MissionConfig isEqualType createHashMap}
    && {(keys FLO_MissionConfig) isNotEqualTo []};
if (_missionConfigReady) exitWith { false };

private _canAdminServer = isServer || {
    (serverCommandAvailable "#kick") && {serverCommandAvailable "#debug"}
};
if (!_canAdminServer) exitWith { false };

missionNamespace getVariable ["FLO_MissionReady", false] isEqualTo false
