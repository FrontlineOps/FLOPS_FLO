params ["_player", "_didJIP"];

titleText ["Frontline Operations Group Presents...", "BLACK IN",9999];
5 fadeSound 0;

sleep 1;

StartingLocationDone = false;

// After Mission Loaded
waitUntil {MissionLoadedLitterally};

// Check if the starting location has been set & blufor installations already exist
// if so assume the mission has been loaded from a saved game
private _installationCount = count (allMapMarkers select {markerType _x == "b_installation"});
if (count (allMapMarkers select {markerType _x == "loc_SafetyZone"}) == 6 && (_installationCount > 0)) then {
    StartingLocationDone = true; 
    publicVariable "StartingLocationDone";
};

// If starting location has not been set 
// Assume the mission is a fresh start
if (!StartingLocationDone) then {
	// Faction Selection & Starting Location
	if (isNil "TheCommander") then {titleText ["Commander must be assigned to a player at fresh start.\nHave someone return to Lobby and pick Commander.", "BLACK IN",9999]; waitUntil {!isNil "TheCommander"};};

	if (_player == TheCommander) then { 
		execVM "Scripts\Dialog_Faction.sqf"; 
	};
};


// After Faction Selection / Safe Zones
waitUntil {StartingLocationDone};

hintSilent "LOADING . . . "; 

F_Init = false;
execVM "Scripts\init\init_groups.sqf"; 

sleep 1;

HCIV = 0;
cooldn = 0 ;

enableSaving [false, false] ;

waitUntil {F_Init};

// (findDisplay 46) displayAddEventHandler ["MouseButtonDown", "params ['_displayOrControl', '_button', '_xPos', '_yPos', '_shift', '_ctrl', '_alt'];  if ((_ctrl) && (_button == 1) && ((ctrlMapMouseOver (findDisplay 12 displayCtrl 51)) select 0 == 'marker')) then {[(ctrlMapMouseOver (findDisplay 12 displayCtrl 51)) select 1] execVM 'Scripts\MarkerIntro.sqf';}"]; 
// (findDisplay 46) displayAddEventHandler ["KeyDown", {params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"]; if ((_ctrl) && (_key == 24) && (!dialog)) then { createDialog "Satellite_Control_Tablet"; HCAM_0 cameraEffect ["Internal", "Back", "HCAM_S"]; }; }];
// (findDisplay 46) displayAddEventHandler ["KeyDown", {params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"]; if (_key == 24) then { titleFadeOut 0.01;}; }];
(findDisplay 46) displayAddEventHandler ["KeyDown", {params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"]; if ((_ctrl) && (_key == 37) && (!dialog)) then {execVM "Scripts\TEAMS.sqf" ;};}];

// R3F Init - Everyone 
execVM "R3F_LOG\init.sqf";

// ETV Init - Everyone
execVM "Scripts\EtV.sqf";
waitUntil {!isNil "EtVInitialized"};

// Misc
if (isClass (configfile >> "CfgVehicles" >> "Box_cTab_items") == true ) then { player addItem "ItemAndroid"; player addItem "ItemcTab"; };

call compileScript ["Scripts\init\init_CommsMenu.sqf"];

[player,'MENU_COMMS_UAV_RECON',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[player,'MENU_COMMS_SUPPLYDROP',nil,nil,''] call BIS_fnc_addCommMenuItem;
[player,'MENU_COMMS_INF',nil,nil,''] call BIS_fnc_addCommMenuItem;	
// [player,'MENU_COMMS_GRD',nil,nil,''] call BIS_fnc_addCommMenuItem;	
// [player,'MENU_COMMS_CAS_HELI',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[player,'MENU_COMMS_ARTI',nil,nil,''] call BIS_fnc_addCommMenuItem;	


// Headless Clients / Everyone
HC1Present = if (isNil "HC_1") then {false} else {true}; 
HC2Present = if (isNil "HC_2") then {false} else {true}; 
HC3Present = if (isNil "HC_3") then {false} else {true}; 

waitUntil {(MarLOCC == 1) || (count (allMapMarkers select {markerType _x == "b_installation"}) > 0) || (count (allMapMarkers select {markerType _x == "b_unknown"}) > 0)};

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
/* 
private _executeAndWait= {
    params ["_script"];
    {
        private _handle = execVM _x;
        waitUntil {sleep 1; scriptDone _handle };
    } forEach _script;
};
*/

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

waitUntil {(didJIP) || (TRG1LOCC == 1)};
waitUntil {(didJIP) || (TRG2LOCC == 1)};
waitUntil {(didJIP) || (TRG3LOCC == 1)};

// SYSTEMs Init Clients
Triggers0 = execVM "Scripts\init_Triggers.sqf";
waitUntil {sleep 1; scriptDone Triggers0 };

// Hint end of init
hintSilent "LOADED!"; 