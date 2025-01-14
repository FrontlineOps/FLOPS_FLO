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
DIALOCC = 0;
publicVariable "DIALOCC";
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

VSDistance = 2500; //750; 
VS_FPS = [];
VSTimeDelay = 5;
VSCurrentTime = diag_tickTime;
VS_IsWorking = false;

//Mission Settings Loading
waitUntil { sleep 1; ((count (allMapMarkers select {markerType _x == "b_installation"}) > 0) or (HQLOCC == 1)) && (count (allMapMarkers select {markerType _x == "loc_SafetyZone"}) == 7)};

if (markerText "Friendly_Handle" == "CUSTOM_PLAYER_FACTION") then {  null = execVM "CUSTOM_PLAYER_FACTION.sqf" };
if (markerText "Enemy_Handle" == "CUSTOM_ENEMY_FACTION") then {  null = execVM "CUSTOM_ENEMY_FACTION.sqf" };
if (markerText "Civilian_Handle" == "CUSTOM_CIVILIAN_FACTION") then {  null = execVM "CUSTOM_CIVILIAN_FACTION.sqf" };

private _Enemy = execVM "Scripts\Enemy_Vars.sqf"; 
waitUntil { sleep 1; scriptDone _Enemy };

private _Friendly = execVM "Scripts\Friendly_Vars.sqf"; 
waitUntil { sleep 1; scriptDone _Friendly };

private _Civilian = execVM "Scripts\Civilian_Vars.sqf"; 
waitUntil { sleep 1; scriptDone _Civilian };

//Resource Loops//Convoy Loops//Radio Tower Loops
[] spawn {  
    while { sleep 90 ; time > 0 } do {  
        private _allENMMarks = allMapMarkers select {markerShape _x == "RECTANGLE" && markerBrush _x == "FDiagonal"};
        {deleteMarker _x} forEach _allENMMarks;

        if (count (allMapMarkers select { markerType _x == "loc_Transmitter" && markerColor _x == "colorBLUFOR"}) > 0) then {
            remoteExec ["FLO_fnc_ICS", 2];
        };

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
[] spawn {
    [[west,"HQ"], "Mission FrontLines System Activated ..."] remoteExec ["sideChat", 0];
    while {true} do {
        frontLineComplete = false;
        call FLO_fnc_MissionFrontline;
        waitUntil(frontLineComplete); // wait until function has completed
        sleep 300; // Loop every 5 minutes (this is plus the extra time wait inside MissionFrontline)
    };
};

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