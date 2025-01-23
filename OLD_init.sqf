/*
   File: init.sqf
   Description:
   Executed when mission is started (before briefing screen),
   This script will check if the mission is being loaded from a saved game or if it is a new game.
    New game? it will show the faction selection dialog. TOCHANGE: Make it also to prod and not only debug).
    Saved game? it will check if the mission is being loaded from a saved game.

   Usage:
   - Should be in the main mission folder.

   Details:
   - See description.

   Notes:
   - None
*/
private _MissionHighCommander = missionNamespace getVariable ["TheCommander", objNull];

Intro Title for the Mission
titleText ["Frontline Operations Group Presents...", "BLACK IN",9999];
5 fadeSound 0;

if !(didJIP) then {
    waitUntil { sleep 1; MissionLoadedLitterally == 1};
}; 

// This is for when the mission is first ever created. (checking against safeZones and if notJoingInProgress)
// py_core: I removed the check if player is commander,
//          it will only make sure if there not enough safezones and not joining in progress, then it will prompt to show starting loc.

if ((count (allMapMarkers select {markerType _x == "loc_SafetyZone"}) != 7) && (not didJIP)) then
{
    execVM "Scripts\Dialog_Faction.sqf";
};

// This is for when the mission is being loaded from a saved game.
// After the Else statement is when the mission is first ever created and the creation of the initial Dialog_Faction.sqf is done and we have generated the safety zones around the Starting Point.
waitUntil {
    sleep 1;
    private _installationCount = count (allMapMarkers select {markerType _x == "b_installation"});
    if (_installationCount == 0 && HQLOCC != 1) then {
        [[west, "HQ"], "You have been defeated. Please reset the mission and restart."] remoteExec ["sideChat", 0];
        false // Exit the waitUntil loop
    } else {
        ((_installationCount > 0) || (HQLOCC == 1)) && (count (allMapMarkers select {markerType _x == "loc_SafetyZone"}) == 7)
    };
};

// Init Main
execVM "Scripts\Init\init_groups.sqf"; 

// Hint start of init
hintSilent "LOADING . . . "; 

HCIV = 0;
cooldn = 0 ;

enableSaving [false, false] ;

// Init Custom Factions if they are selected
F_Init = false;

waitUntil {F_Init == "Done"};

if (hasInterface) then {
    Triggers0 = execVM "Scripts\init_Triggers.sqf";
    waitUntil {sleep 1; scriptDone Triggers0 };
};

waitUntil {sleep 1; (count (allMapMarkers select {markerType _x == "loc_SafetyZone"}) == 7)};

if ((isServer)  && !(didJIP)) then {SYSINT = 0} else {SYSINT = 1} ;

// Init UI Elements
(findDisplay 46) displayAddEventHandler ["MouseButtonDown", "params ['_displayOrControl', '_button', '_xPos', '_yPos', '_shift', '_ctrl', '_alt'];  if ((_ctrl) && (_button == 1) && ((ctrlMapMouseOver (findDisplay 12 displayCtrl 51)) select 0 == 'marker')) then {[(ctrlMapMouseOver (findDisplay 12 displayCtrl 51)) select 1] execVM 'Scripts\MarkerIntro.sqf';}"]; 
(findDisplay 46) displayAddEventHandler ["KeyDown", {params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"]; if ((_ctrl) && (_key == 24) && (!dialog)) then { createDialog "Satellite_Control_Tablet"; HCAM_0 cameraEffect ["Internal", "Back", "HCAM_S"]; }; }];
(findDisplay 46) displayAddEventHandler ["KeyDown", {params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"]; if (_key == 24) then { titleFadeOut 0.01;}; }];
(findDisplay 46) displayAddEventHandler ["KeyDown", {params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"]; if ((_ctrl) && (_key == 37) && (!dialog) && ((player getVariable ["AIS_unconscious", false]) != true)) then {execVM "Scripts\TEAMS.sqf" ;};}];

// Init R3F Logistics
execVM "R3F_LOG\init.sqf";

// Init EtV
execVM "Scripts\EtV.sqf";
waitUntil {!isNil "EtVInitialized"};

// Init VCOM AI

/* 
   Function: _executeAndWait
   Execute array of sqf scripts and wait for each on of them to finish before continuing iteration.

   Example:
   (start code)
   // Example usage
   [param] call _executeAndWait;
   (end)

   Parameters:
   param - Array of sqf scripts.
*/
private _executeAndWait= {
    params ["_script"];
    {
        private _handle = execVM _x;
        waitUntil {sleep 1; scriptDone _handle };
    } forEach _script;
};

HC1Present = if ( isNil "HC_1" ) then { False } else {True } ; 
HC2Present = if ( isNil "HC_2" ) then { False } else {True } ; 
HC3Present = if ( isNil "HC_3" ) then { False } else {True } ; 

waitUntil {(MarLOCC == 1) || (count (allMapMarkers select {markerType _x == "b_installation"}) > 0) || (count (allMapMarkers select {markerType _x == "b_unknown"}) > 0)};

//TODO: If we have performance issues in the future we can do this
// Directly assign triggers to headless clients
// if (HC1Present) then {
//     if (player == HC_1) then {
//         [["Scripts\init_Triggers_1.sqf", "Scripts\init_Triggers_2.sqf", "Scripts\init_Triggers_3.sqf"]] call _executeAndWait;
//     };
// };

// if (HC2Present) then {
//     if (player == HC_2) then {
//         ["Scripts\init_Triggers_1.sqf", "Scripts\init_Triggers_2.sqf", "Scripts\init_Triggers_3.sqf"] call _executeAndWait;
//     };
// };

// if (HC3Present) then {
//     if (player == HC_3) then {
//         ["Scripts\init_Triggers_1.sqf", "Scripts\init_Triggers_2.sqf", "Scripts\init_Triggers_3.sqf"] call _executeAndWait;
//     };
// };

// Handle the case where no headless clients are present
if (!HC1Present && !HC2Present && !HC3Present) then {
    if (isServer) then {
        [["Scripts\init_Triggers_1.sqf", "Scripts\init_Triggers_2.sqf", "Scripts\init_Triggers_3.sqf"]] call _executeAndWait;
    };
};

waitUntil {(didJIP) or (TRG1LOCC == 1)};
waitUntil {(didJIP) or (TRG2LOCC == 1)};
waitUntil {(didJIP) or (TRG3LOCC == 1)};

///////////////////////////////////////////////////////////////////////////////////
if (isClass (configfile >> "CfgVehicles" >> "Box_cTab_items") == true ) then { player addItem "ItemAndroid"; player addItem "ItemcTab"; };

call compileScript ["Scripts\Init\init_CommsMenu.sqf"];

[player,'MENU_COMMS_UAV_RECON',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[player,'MENU_COMMS_SUPPLYDROP',nil,nil,''] call BIS_fnc_addCommMenuItem;
[player,'MENU_COMMS_INF',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[player,'MENU_COMMS_ARTI',nil,nil,''] call BIS_fnc_addCommMenuItem;	

// Hint end of init
hintSilent "LOADED!"; 