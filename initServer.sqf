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

//  Mission Settings Loading//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

waitUntil {((count (allMapMarkers select {markerType _x == "b_installation"}) > 0) or (HQLOCC == 1)) && (count (allMapMarkers select {markerType _x == "loc_SafetyZone"}) == 7)};

	
 if (markerText "Friendly_Handle" == "CUSTOM_PLAYER_FACTION") then {  null = execVM "CUSTOM_PLAYER_FACTION.sqf" };
 if (markerText "Enemy_Handle" == "CUSTOM_ENEMY_FACTION") then {  null = execVM "CUSTOM_ENEMY_FACTION.sqf" };
 if (markerText "Civilian_Handle" == "CUSTOM_CIVILIAN_FACTION") then {  null = execVM "CUSTOM_CIVILIAN_FACTION.sqf" };

//All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script ////////

_Enemy = execVM "Scripts\Enemy_Vars.sqf"; 
waitUntil { scriptDone _Enemy };

_Friendly = execVM "Scripts\Friendly_Vars.sqf"; 
waitUntil { scriptDone _Friendly };

_Civilian = execVM "Scripts\Civilian_Vars.sqf"; 
waitUntil { scriptDone _Civilian };


//  Custom Loadouts//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{	{[_x] execVM "Scripts\LDTInit.sqf" ;} forEach allPlayers ;  } remoteExec ["call", 0];


//  Resource Loops////  Convoy Loops////  Radio Tower Loops/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

[] spawn {  
while { sleep 90 ; time > 0  } do{  
 
 _allENMMarks = allMapMarkers select {markerShape _x == "RECTANGLE" && markerBrush _x == "FDiagonal"};   
	{deleteMarker _x} forEach _allENMMarks ;

  if (count (allMapMarkers select { markerType _x == "loc_Transmitter" && markerColor _x == "colorBLUFOR"}) > 0) then {
	  
			remoteExec ["BSPCO_fnc_ICS", 2] ;

  };


if  (ConVLocc == 1 ) then {
	
 _RoadMrks = allMapMarkers select {markerType _x == "mil_dot"  && markerColor _x == "colorCivilian" &&  markerAlpha _x == 0.3};  
	{deleteMarker _x} forEach _RoadMrks ;

{deleteWaypoint((waypoints CGM)select 0);}forEach waypoints CGM; 


(calculatePath ["wheeled_APC","safe",position V0,position (selectRandom ((getMarkerPos "ConvoyDest") nearRoads 500))]) addEventHandler ["PathCalculated", {   
_posesArr = _this select 1;  
_posesArrCnt = count _posesArr ;  
_posesArrCntndd = round (_posesArrCnt / 10) ;  
 _indexed = [1,2,3,4,5,6,7,8,9] ;   
 
 {  
   _Waypos = _posesArr select (_x * _posesArrCntndd) ;  
   _wp = CGM addWaypoint [_Waypos, 0];   
   _wp SetWaypointType "MOVE";   
   _wp setWaypointBehaviour "SAFE";   
   _wp setWaypointSpeed "LIMITED";  
     } forEach _indexed ;  

	{ 
	private _marker = createMarkerLocal [(str position V0) + str _forEachIndex, _x]; 
	_marker setMarkerTypeLocal "mil_dot"; 
	_marker setMarkerSizeLocal [0.5, 0.5]; 
	_marker setMarkerColorLocal "colorCivilian" ;
	_marker setMarkerAlpha 0.3 ;
	} forEach (_this select 1); 
 
}]; 

sleep 2 ; 
CGM setFormation "WEDGE";
sleep 2 ; 
CGM setFormation "COLUMN";

	};
 
_BluezoneMarks = allMapMarkers select { markerType _x == "b_installation" && (markerColor _x == "colorBLUFOR" or markerColor _x == "ColorWEST") };
{ [1] execVM 'Scripts\Reward.sqf'; } foreach _BluezoneMarks;
 
  };  
};
 
 //  Dynamic Virtualization System/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

[] spawn {  
while { sleep 20 ; time > 0  } do {  
		remoteExec ["BSPCO_fnc_CDVS", 2] ;
	};  
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

SAT1 = "camera" camCreate [0,0,0];
SAT1 attachTo [TSAT, [0, 0, 300] ];  
SAT1 camSetFov 0.9; 
SAT1 setVectorDirAndUp [[0, 0, -1], [0, 1, 0]];
SAT1 cameraEffect ["Internal", "Back", "SATELLITE_V"]; 
SAT1 cameraEffect ["Internal", "Back", "SATELLITE"]; 
TSAT setPos (position player);
"SATELLITE_V" setPiPEffect [0];
"SATELLITE" setPiPEffect [0];	

remoteExec ["BSPCO_fnc_MissionStartup", 2] ;
[] spawn {
	while {true} do {
		remoteExec ["BSPCO_fnc_MissionFrontline", 2];
		sleep 300; // Loop every 5 minutes
	};
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 AutoSaveSwitchVal = "AutoSaveSwitch" call BIS_fnc_getParamValue;
 AutoSaveIntervalVal = "AutoSaveInterval" call BIS_fnc_getParamValue;

if (AutoSaveSwitchVal == 1) then {
	[] spawn {  
		while { true } do {  
			remoteExec ["BSPCO_fnc_MissionSave", 2];
			remoteExec ["BSPCO_fnc_MissionSaveGroups", 2]; 

			sleep AutoSaveIntervalVal;  
		};  
	};
};


