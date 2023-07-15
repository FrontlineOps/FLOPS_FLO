

if ( COMMSDIS == 0 ) then {

_thisHeliInsertTrigger = _this select 0;
 	   _allZoneMarks = allMapMarkers select {((getMarkerPos _x) distance  (getPos _thisHeliInsertTrigger) > 2000) && (markerType _x == "n_installation" || markerType _x == "o_installation" || markerType _x == "o_antiair" || markerType _x == "o_service" || markerType _x == "o_armor" || markerType _x == "loc_Power" || markerType _x == "o_recon" || markerType _x == "o_support" || markerType _x == "n_support" || markerType _x == "loc_Ruin" )} ;  
       _MM = [_allZoneMarks,  _thisHeliInsertTrigger] call BIS_fnc_nearestPosition ;
 	   _allZoneMarksNew = _allZoneMarks - [_MM] ;
       _M = [_allZoneMarksNew,  _MM] call BIS_fnc_nearestPosition ;

_poss = getMarkerPos _M;
_chance = selectRandom [0, 1, 2] ;

if ( HELIDIS == 0 ) then {
		
if (_chance != 2) then {

_poss1 = [_thisHeliInsertTrigger, 50, 200, 1, 0, 1, 0] call BIS_fnc_findSafePos; 
 
_Heli_1 = createVehicle [selectRandom East_Air_Transport, _poss, [], 100, "FLY"]; 
 
_Group = createGroup East; 
Heli_1_crew = createVehicleCrew _Heli_1; 
{[_x] join _Group} forEach units Heli_1_crew; 

GroupQRF = createGroup East; 
_SCount = [(typeOf _Heli_1), true] call BIS_fnc_crewCount; 
 
_CREWC = _SCount - (count (units _Group)) - 1 ; 
 
for "_x" from 0 to _CREWC do { 
_unit = GroupQRF createunit [selectRandom East_Units,_poss,[],0,"None"]; 
[_unit] JoinSilent GroupQRF; 
}; 
 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_INTSTF = [
"FlashDisk",
"FilesSecret",
"SmartPhone",
"MobilePhone",
"DocumentsSecret"
];

_INTENMALL = units GroupQRF;
_INTENMCNT = count _INTENMALL;
_INTENMCNTNEW = round ( _INTENMCNT / 2 );
_INTENMALLNEW = _INTENMALL call BIS_fnc_arrayShuffle;
_INTENMSEL = _INTENMALLNEW select [0, _INTENMCNTNEW];

{_x addItem selectRandom _INTSTF ;} foreach _INTENMSEL;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
 _WPAB_1 = _Group addWaypoint [_poss1, 0]; 
_WPAB_1 SetWaypointType "MOVE"; 
_WPAB_1 setWaypointBehaviour "CARELESS"; 
_WPAB_1 setWaypointForceBehaviour true;
_WPAB_1 setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; GroupQRF leaveVehicle (vehicle this); "];
_WPAB_1 setWaypointSpeed "FULL"; 
 
_WPAB_2 = _Group addWaypoint [_poss, 0];
_WPAB_2 SetWaypointType "MOVE";
_WPAB_2 setWaypointSpeed "FULL";
 
_WPS_1 = GroupQRF addWaypoint [_poss1, 0]; 
_WPS_1 SetWaypointType "GETOUT"; 
_WPS_1 setWaypointBehaviour "COMBAT"; 
_WPS_1 setWaypointCompletionRadius 100;
_WPS_2 = GroupQRF addWaypoint [getPos _thisHeliInsertTrigger, 0]; 
_WPS_2 SetWaypointType "SAD"; 
_WPS_2 setWaypointBehaviour "COMBAT"; 
 
{_x moveInCargo _Heli_1} foreach units GroupQRF;  
 
(driver _Heli_1) disableAI "LIGHTS"; 
_Heli_1 setPilotLight true;
_Heli_1 setCollisionLight true; 
 
_flare = "F_20mm_Red" createVehicle [getPos _thisHeliInsertTrigger select 0, getPos _thisHeliInsertTrigger select 1, 120]; 
_flare setVelocity [0,0,-0.1];

	sleep 600 ;
	deleteVehicle _Heli_1 ;
	
}else{

_Heli_1 = createVehicle [selectRandom East_Air_Heli, _poss, [], 100, "FLY"]; 
_Group = createVehicleCrew _Heli_1; 
_VC = createGroup East;
{[_x] join _VC} forEach units _Group;
[_VC, (getPos _thisHeliInsertTrigger), (500 + (random 500))] call BIS_fnc_taskPatrol;
_Heli_1  addeventhandler ["fuel", {(_this select 0) setfuel 1}] ;
_Heli_1 flyInHeight 100; 

_VC setSpeedMode "NORMAL" ;

(driver _Heli_1) disableAI "LIGHTS"; 
_Heli_1 setPilotLight true;
_Heli_1 setCollisionLight true; 
	

	};
	
		{ removeFromRemainsCollector [_x]; } foreach (allUnits select { side _x != west }) ;
	{ removeFromRemainsCollector [_x]; } foreach (vehicles select { side (driver  _x) != west }) ; 


sleep 3 ; 

	{ addToRemainsCollector [_x]; } foreach (allUnits select { side _x != west }) ;
	{ addToRemainsCollector [_x]; } foreach (vehicles select { side (driver  _x) != west }) ; 

	
};

};

