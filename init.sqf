////////////////////////////////////////////////Intro
HQLOCC = 0 ;
publicVariable "HQLOCC";

titleText ["B.S.P Group Presents...", "BLACK IN",9999];
5 fadeSound 0;

sleep 5;
////////////////////////////////////////////////Mission Loading - Variables // Server & HC
sleep 2;

if !(didJIP) then {
waitUntil {MissionLoadedLitterally == 1};
}; 

////////////////////////////////////////////// //Mission Parameters   // TheCommander ////////////////////////////////////////////////

sleep 2;

if ((count (allMapMarkers select {markerType _x == "loc_SafetyZone"}) != 7) && (player == TheCommander) && (not didJIP)) then { execVM "Scripts\Dialog_Faction.sqf"; };
waitUntil {((count (allMapMarkers select {markerType _x == "b_installation"}) > 0) or (HQLOCC == 1)) && (count (allMapMarkers select {markerType _x == "loc_SafetyZone"}) == 7)};

Hints = true ;
[] spawn {  
  while {Hints == true} do{  
_HMS = selectRandom ["Hints0"];
titleRsc [_HMS, "BLACK"];
 sleep 10;  
  }  
};

////////////////////////////////////////////// // MAIN Init   // Everyone ////////////////////////////////////////////////

_InitMain = execVM "initMain.sqf"; waitUntil { scriptDone _InitMain }; 



//playMusic "LeadTrack01_F_EPA";

hintSilent "LOADING . . . "; 

HCIV = 0;
cooldn = 0 ;

enableSaving [false, false] ;
setViewDistance 1000;
setobjectViewDistance [1000, 200];

////////////////////////////////////////////// // Custom Factions Init   // SERVER ////////////////////////////////////////////////


waitUntil {F_Init == "Done"};
waitUntil {E_Init == "Done"}; 
waitUntil {C_Init == "Done"};

if (hasInterface) then {
    _Triggers0 = execVM "Scripts\init_Triggers.sqf";
    waitUntil { scriptDone _Triggers0 };
};

waitUntil {(count (allMapMarkers select {markerType _x == "loc_SafetyZone"}) == 7)};

if ((isServer)  && !(didJIP)) then {SYSINT = 0} else {SYSINT = 1} ;


////////////////////////////////////////////// // SYSTEMs Init   // Everyone ////////////////////////////////////////////////

(findDisplay 46) displayAddEventHandler ["MouseButtonDown", "params ['_displayOrControl', '_button', '_xPos', '_yPos', '_shift', '_ctrl', '_alt'];  if ((_ctrl) && (_button == 1) && ((ctrlMapMouseOver (findDisplay 12 displayCtrl 51)) select 0 == 'marker')) then {[(ctrlMapMouseOver (findDisplay 12 displayCtrl 51)) select 1] execVM 'Scripts\MarkerIntro.sqf';}"]; 
(findDisplay 46) displayAddEventHandler ["KeyDown", {params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"]; if ((_ctrl) && (_key == 24) && (!dialog)) then { createDialog "Satellite_Control_Tablet"; HCAM_0 cameraEffect ["Internal", "Back", "HCAM_S"]; }; }];
(findDisplay 46) displayAddEventHandler ["KeyDown", {params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"]; if (_key == 24) then { titleFadeOut 0.01;}; }];
(findDisplay 46) displayAddEventHandler ["KeyDown", {params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"]; if ((_ctrl) && (_key == 37) && (!dialog) && ((player getVariable ["AIS_unconscious", false]) != true)) then {execVM "Scripts\TEAMS.sqf" ;};}];

////////////////////////////////////////////// // R3F Init   // Everyone ////////////////////////////////////////////////

execVM "R3F_LOG\init.sqf";

////////////////////////////////////////////// // ETV Init   // Everyone ////////////////////////////////////////////////

execVM "Scripts\EtV.sqf";
waitUntil {!isNil "EtVInitialized"};

////////////////////////////////////////////// // Exec Vcom AI function ////////////////////////////////////////////////

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

// Directly assign triggers to headless clients without using an array
if (HC1Present) then {
    if (player == HC_1) then {
        ["Scripts\init_Triggers_1.sqf", "Scripts\init_Triggers_2.sqf"] call _executeAndWait;
    };
};

if (HC2Present) then {
    if (player == HC_2) then {
        ["Scripts\init_Triggers_3.sqf"] call _executeAndWait;
    };
};

if (HC3Present) then {
    if (player == HC_3) then {
        ["Scripts\init_Triggers_3.sqf"] call _executeAndWait;
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
