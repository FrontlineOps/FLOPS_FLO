/* Starts a validated setup request, then presents its scheduled progress. */
disableSerialization;
private _display = uiNamespace getVariable ["FLO_FactionDialog", displayNull];
if (isNull _display) exitWith {
    ["UI", 1, "Cannot start mission - faction dialog is null"] call FLO_fnc_log;
};
private _startBtn = _display displayCtrl 1600;
_startBtn ctrlEnable false;
private _config = [_display] call FLO_fnc_factionDialogReadConfig;
if (count _config == 0) exitWith { _startBtn ctrlEnable true; };
_display closeDisplay 1;
["UI", 3, format ["Mission setup accepted for player side %1", _config get "playerSideKey"]] call FLO_fnc_log;
[_config] spawn {
    params ["_config"];
    missionNamespace setVariable ["FLO_missionStartTime", diag_tickTime, true];
    hint "Setting up mission...";
    _config set ["startPosition", call FLO_fnc_factionDialogSelectStartPosition];
    FLO_MissionConfig = _config;
    publicVariable "FLO_MissionConfig";
    ["UI", 3, "Mission config sent to server - Phase Manager will handle initialization"] call FLO_fnc_log;
    call FLO_fnc_factionDialogWaitForMission;
};
