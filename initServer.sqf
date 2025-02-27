HQLOCC = 0 ;
publicVariable "HQLOCC";

TRG1LOCC = 0;
publicVariable "TRG1LOCC";
TRG2LOCC = 0;
publicVariable "TRG2LOCC";
TRG3LOCC = 0;
publicVariable "TRG3LOCC";
MarLOCC = 0;
publicVariable "MarLOCC";
AVENGLOCC = 1 ;
publicVariable "AVENGLOCC";

COMMSDIS = 0;
publicVariable "COMMSDIS";
HELIDIS = 0;
publicVariable "HELIDIS";
AIRDIS = 0;
publicVariable "AIRDIS";
LOGDIS = 0;
publicVariable "LOGDIS";
INFDIS = 0;
publicVariable "INFDIS";
ARMDIS = 0;
publicVariable "ARMDIS";
ConVLocc = 0 ;
publicVariable "ConVLocc";

StartingLocationDone = false;

VSDistance = 2500; //750; 
VS_FPS = [];
VSTimeDelay = 20;
VSCurrentTime = diag_tickTime;
VS_IsWorking = false;

if (isNil "F_Init") then {F_Init = false;};

// After Mission Loaded
waitUntil {MissionLoadedLitterally};

//Mission Settings Loading
waitUntil {StartingLocationDone};

// Dedicated server needs to know factions too
if (isDedicated) then {

	execVM "Scripts\init\init_groups.sqf"; 

	setViewDistance 3000; // for knowsabout

	sleep 1;

    waitUntil {F_Init};

    // SYSTEMs Init Server 
    // Run these only if dedicated (not hosted - hosted servers run initPlayerLocal)

	// R3F Init - Everyone

	execVM "R3F_LOG\init.sqf";

	// ETV Init - Everyone

	execVM "Scripts\EtV.sqf";
	waitUntil {!isNil "EtVInitialized"};
};


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

HC1Present = if (isNil "HC_1") then {false} else {true}; 
HC2Present = if (isNil "HC_2") then {false} else {true}; 
HC3Present = if (isNil "HC_3") then {false} else {true}; 
// Handle the case where no headless clients are present
if (!HC1Present && !HC2Present && !HC3Present) then {
    [["Scripts\init_Triggers_1.sqf", "Scripts\init_Triggers_2.sqf", "Scripts\init_Triggers_3.sqf"]] call _executeAndWait;
};

//Resource Loops//Convoy Loops//Radio Tower Loops
[] spawn {  
    while { sleep 90 ; time > 0 } do {  
        private _allENMMarks = allMapMarkers select {markerShape _x == "RECTANGLE" && markerBrush _x == "FDiagonal"};
        {deleteMarker _x} forEach _allENMMarks;

        if (count (allMapMarkers select { markerType _x == "loc_Transmitter" && markerColor _x == "colorBLUFOR"}) > 0) then {
            remoteExec ["FLO_fnc_ICS", 2];
        };

        // Why is this here?
        // This is a convoy loop, move it to it's own file so we can preprocessFileLineNumbers it and pass CGM Properly
        // This causes convoys to be broken due to no CGM being passed
        if (ConVLocc == 1) then {
            private _RoadMrks = allMapMarkers select {markerType _x == "mil_dot" && markerColor _x == "colorCivilian" && markerAlpha _x == 0.3};
            {deleteMarker _x} forEach _RoadMrks;

            {deleteWaypoint((waypoints CGM) select 0);} forEach waypoints CGM;

            (calculatePath ["wheeled_APC", "safe", position V0, position (selectRandom ((getMarkerPos "ConvoyDest") nearRoads 500))]) addEventHandler ["PathCalculated", {
                private _posesArr = _this select 1;
                private _posesArrCnt = count _posesArr;
                private _posesArrCntndd = round (_posesArrCnt / 10);
                private _indexed = [1,2,3,4,5,6,7,8,9];

                {
                    private _Waypos = _posesArr select (_x * _posesArrCntndd);
                    private _wp = CGM addWaypoint [_Waypos, 0];
                    _wp SetWaypointType "MOVE";
                    _wp setWaypointBehaviour "SAFE";
                    _wp setWaypointSpeed "LIMITED";
                } forEach _indexed;

                {
                    private _marker = createMarkerLocal [(str position V0) + str _forEachIndex, _x];
                    _marker setMarkerTypeLocal "mil_dot";
                    _marker setMarkerSizeLocal [0.5, 0.5];
                    _marker setMarkerColorLocal "colorCivilian";
                    _marker setMarkerAlpha 0.3;
                } forEach (_this select 1);
            }];
            sleep 2;
            CGM setFormation "WEDGE";
            sleep 2;
            CGM setFormation "COLUMN";
        };

        private _BluezoneMarks = allMapMarkers select { markerType _x == "b_installation" && (markerColor _x == "colorBLUFOR" or markerColor _x == "ColorWEST") };
        { [1] execVM 'Scripts\Reward.sqf'; } foreach _BluezoneMarks;
    };
};

//Dynamic Virtualization System
[] spawn { 
	sleep 20; 
	addMissionEventHandler ["EachFrame", {[] call FLO_fnc_CDVS}];
};

//Mission Commander System
remoteExec ["FLO_fnc_MissionStartup", 2];
[] call FLO_fnc_MissionFrontline;

//Saving System
AutoSaveSwitchVal = "AutoSaveSwitch" call BIS_fnc_getParamValue;
AutoSaveIntervalVal = "AutoSaveInterval" call BIS_fnc_getParamValue;

if (AutoSaveSwitchVal == 1) then {
    [] spawn {  
        while { true } do {  
            call FLO_fnc_MissionSave;
            sleep AutoSaveIntervalVal;  
        };
    };
};

FLO_configCache = createHashMapFromArray [
    ["helipads", ["Land_HelipadCircle_F","Land_HelipadCivil_F","Heli_H_rescue","Land_HelipadRescue_F","Land_HelipadSquare_F","HeliHRescue","Heli_H_civil","HeliHCivil","HeliH"]],
    ["tyres", ["Land_Tyre_F"]],
    ["vehicles", [East_Air_Heli, East_Ground_Transport, East_Ground_Vehicles_Light, East_Ground_Vehicles_Heavy, East_Ground_Vehicles_Ambient, East_Air_Transport, East_Air_Jet, East_Ground_Artillery, East_Air_Drone]],
    ["units", East_Units],
    ["buildings", ["House", "Land_MilOffices_V1_F", "Land_Cargo_Tower_V3_F", "Land_Cargo_Tower_V2_F", "Land_Cargo_Tower_V1_F", "Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V2_F", "Land_Cargo_HQ_V1_F", "Land_Cargo_House_V3_F", "Land_Cargo_House_V1_F"]],
    ["SOVbuildings", ["Sign_Pointer_Cyan_F", "Land_Garbage_square3_F", "Land_Garbage_line_F", "Sign_Pointer_Yellow_F", "Sign_Sphere10cm_F", "Land_vn_controltower_01_f", "Sign_Pointer_Blue_F", "Land_InvisibleBarrier_F", "Land_HelipadEmpty_F",
    "O_Radar_System_02_F", "O_G_Mortar_01_F", "O_G_HMG_02_high_F", "Land_TripodScreen_01_large_black_F", "Land_vn_b_prop_mapstand_01", "MapBoard_altis_F", "Land_Laptop_device_F", "Land_Map_Malden_F",
    "Land_Document_01_F", "Land_File2_F", "Land_i_Barracks_V1_F", "Land_u_Barracks_V2_F", "Land_i_Barracks_V2_F", "Land_Barracks_01_grey_F", "Land_Barracks_01_dilapidated_F", "Land_Radar_F", "Land_TTowerBig_1_F",
    "Land_TTowerBig_2_F", "Land_TripodScreen_01_large_F", "Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_dual_v2_sand_F", "Land_TripodScreen_01_dual_v2_F", "Box_FIA_Support_F", "Box_FIA_Ammo_F",
    "Land_PowerGenerator_F", "Land_Barracks_01_camo_F", "Land_vn_barracks_01_camo_f", "Land_Cargo_House_V1_F", "Land_Cargo_Tower_V1_F", "Land_Cargo_Tower_V3_F", "Land_Cargo_Tower_V2_F", "Land_Cargo_House_V3_F", "Land_Cargo_HQ_V3_F",
    "Land_Cargo_HQ_V1_F", "B_Slingload_01_Cargo_F", "B_Slingload_01_Repair_F"]],
	["HQbuildings", ["Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V1_F", "Land_Cargo_House_V1_F", "Land_Cargo_House_V3_F", "Land_Cargo_HQ_V3_ruins_F", "Land_Cargo_HQ_V1_ruins_F", "Land_Cargo_House_V1_ruins_F", "Land_Cargo_House_V3_ruins_F", "House"]],
    ["bunkers", ["Land_BagBunker_Large_F", "Land_BagBunker_Small_F", "Land_Cargo_House_V3_F", "Land_Cargo_House_V1_F", "Land_Cargo_Patrol_V3_F", "Land_Cargo_Patrol_V2_F", "Land_Cargo_Patrol_V1_F"]]
];