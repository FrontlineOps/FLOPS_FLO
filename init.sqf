// Intro Title for the Mission
HQLOCC = 0 ;
publicVariable "HQLOCC";

titleText ["Frontline Operations Group Presents...", "BLACK IN",9999];
5 fadeSound 0;

sleep 5;
// Wait till the Mission is Loaded
sleep 2;

if !(didJIP) then {
waitUntil {MissionLoadedLitterally == 1};
}; 

sleep 2;
// This is for when the mission is first ever created. 
if ((count (allMapMarkers select {markerType _x == "loc_SafetyZone"}) != 7) && (player == TheCommander) && (not didJIP)) then { execVM "Scripts\Dialog_Faction.sqf"; };

// This is for when the mission is being loaded from a saved game.
// After the Else statement is when the mission is first ever created and the creation of the initial Dialog_Faction.sqf is done and we have generated the safety zones around the Starting Point.
waitUntil {
    private _installationCount = count (allMapMarkers select {markerType _x == "b_installation"});
    if (_installationCount == 0 && HQLOCC != 1) then {
        [[west, "HQ"], "You have been defeated. Please reset the mission and restart."] remoteExec ["sideChat", 0];
        false // Exit the waitUntil loop
    } else {
        ((_installationCount > 0) || (HQLOCC == 1)) && (count (allMapMarkers select {markerType _x == "loc_SafetyZone"}) == 7)
    };
};

// Init Main
InitMain = execVM "initMain.sqf"; waitUntil { scriptDone InitMain }; 

hintSilent "LOADING . . . "; 

HCIV = 0;
cooldn = 0 ;

enableSaving [false, false] ;
setViewDistance 1000;
setobjectViewDistance [1000, 200];

// Init Custom Factions if they are selected
waitUntil {F_Init == "Done"};
waitUntil {E_Init == "Done"}; 
waitUntil {C_Init == "Done"};

if (hasInterface) then {
    Triggers0 = execVM "Scripts\init_Triggers.sqf";
    waitUntil { scriptDone Triggers0 };
};

waitUntil {(count (allMapMarkers select {markerType _x == "loc_SafetyZone"}) == 7)};

if ((isServer)  && !(didJIP)) then {SYSINT = 0} else {SYSINT = 1} ;


// Init UI Elements
(findDisplay 46) displayAddEventHandler ["MouseButtonDown", "params ['_displayOrControl', '_button', '_xPos', '_yPos', '_shift', '_ctrl', '_alt'];  if ((_ctrl) && (_button == 1) && ((ctrlMapMouseOver (findDisplay 12 displayCtrl 51)) select 0 == 'marker')) then {[(ctrlMapMouseOver (findDisplay 12 displayCtrl 51)) select 1] execVM 'Scripts\MarkerIntro.sqf';}"]; 
(findDisplay 46) displayAddEventHandler ["KeyDown", {params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"]; if ((_ctrl) && (_key == 24) && (!dialog)) then { createDialog "Satellite_Control_Tablet"; HCAM_0 cameraEffect ["Internal", "Back", "HCAM_S"]; }; }];
(findDisplay 46) displayAddEventHandler ["KeyDown", {params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"]; if (_key == 24) then { titleFadeOut 0.01;}; }];
(findDisplay 46) displayAddEventHandler ["KeyDown", {params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"]; if ((_ctrl) && (_key == 37) && (!dialog) && ((player getVariable ["AIS_unconscious", false]) != true)) then {execVM "Scripts\TEAMS.sqf" ;};}];

// Init R3F_LOG
execVM "R3F_LOG\init.sqf";

// Init EtV
execVM "Scripts\EtV.sqf";
waitUntil {!isNil "EtVInitialized"};

// Init VCOM AI

// Helper function to execute and wait for a script
private _executeAndWait = {
    params ["_script"];
    private _handle = execVM _script;
    waitUntil { scriptDone _handle };
};

sleep 2;

HC1Present = if ( isNil "HC_1" ) then { False } else {True } ; 
HC2Present = if ( isNil "HC_2" ) then { False } else {True } ; 
HC3Present = if ( isNil "HC_3" ) then { False } else {True } ; 

waitUntil {(DIALOCC == 1) || (MarLOCC == 1) || (count (allMapMarkers select {markerType _x == "b_installation"}) > 0) || (count (allMapMarkers select {markerType _x == "b_unknown"}) > 0)};

// Directly assign triggers to headless clients
if (HC1Present) then {
    if (player == HC_1) then {
        ["Scripts\init_Triggers_1.sqf", "Scripts\init_Triggers_2.sqf", "Scripts\init_Triggers_3.sqf"] call _executeAndWait;
    };
};

if (HC2Present) then {
    if (player == HC_2) then {
        ["Scripts\init_Triggers_1.sqf", "Scripts\init_Triggers_2.sqf", "Scripts\init_Triggers_3.sqf"] call _executeAndWait;
    };
};

if (HC3Present) then {
    if (player == HC_3) then {
        ["Scripts\init_Triggers_1.sqf", "Scripts\init_Triggers_2.sqf", "Scripts\init_Triggers_3.sqf"] call _executeAndWait;
    };
};

// Handle the case where no headless clients are present
if (!HC1Present && !HC2Present && !HC3Present) then {
    if (isServer) then {
        ["Scripts\init_Triggers_1.sqf", "Scripts\init_Triggers_2.sqf", "Scripts\init_Triggers_3.sqf"] call _executeAndWait;
    };
};

waitUntil {(didJIP) or (TRG1LOCC == 1)};
waitUntil {(didJIP) or (TRG2LOCC == 1)};
waitUntil {(didJIP) or (TRG3LOCC == 1)};

///////////////////////////////////////////////////////////////////////////////////
if (isClass (configfile >> "CfgVehicles" >> "Box_cTab_items") == true ) then { player addItem "ItemAndroid"; player addItem "ItemcTab"; };
