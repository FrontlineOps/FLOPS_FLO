
if ( COMMSDIS == 0 ) then {

_thisVehiInsertStrt = _this select 0;
_AssltDestMrk =  _this select 1;
 		_chance = selectRandom [0,1] ;	

 _nearRoad = selectRandom (_thisVehiInsertStrt nearRoads 1000 ) ; 	

if ( LOGDIS == 0 ) then {
	
if (_Chance > 0) then {
_Veh = createVehicle [selectRandom East_Ground_Transport, (getPosATL _nearRoad), [], 2, "NONE"];

_SCount = [(typeOf _Veh), true] call BIS_fnc_crewCount;
_CREWC = _SCount - 1;
_VC = createGroup East; 
 
for "_x" from 0 to _CREWC do { 
_unit = _VC createunit [selectRandom East_Units,(getPosATL _nearRoad),[],0,"None"]; 
[_unit] JoinSilent _VC; 
}; 
{_x moveInAny _Veh} foreach units _VC;  

(driver _Veh) disableAI "LIGHTS"; 
_Veh setPilotLight true;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_INTSTF = [
"FlashDisk",
"FilesSecret",
"SmartPhone",
"MobilePhone",
"DocumentsSecret"
];

_INTENMALL = units _VC;
_INTENMCNT = count _INTENMALL;
_INTENMCNTNEW = round ( _INTENMCNT / 2 );
_INTENMALLNEW = _INTENMALL call BIS_fnc_arrayShuffle;
_INTENMSEL = _INTENMALLNEW select [0, _INTENMCNTNEW];

{_x addItem selectRandom _INTSTF ;} foreach _INTENMSEL;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{_x addEventHandler ["Killed", {
_Veh = nearestObjects [(_this select 0),['LandVehicle'],50] select 0; 
{
  [_x] ordergetin false; 
  [_x] allowGetIn false; 
  unassignvehicle _x;  
 doGetOut _x;  
 } foreach crew _Veh; 
}]; } foreach units _VC;     



I1_WP_0 = _VC addWaypoint [getMarkerPos _AssltDestMrk, 0];
I1_WP_0 SetWaypointType "GETOUT";
I1_WP_0 setWaypointBehaviour "AWARE";
I1_WP_0 setWaypointSpeed "LIMITED";

I1_WP_00 = _VC addWaypoint [(getPosATL _nearRoad), 0];
I1_WP_00 SetWaypointType "MOVE";
I1_WP_00 setWaypointBehaviour "AWARE";
I1_WP_00 setWaypointSpeed "LIMITED";

I1_WP_1 = _VC addWaypoint [(getPosATL _nearRoad), 3];
I1_WP_1 SetWaypointType "CYCLE";
I1_WP_1 setWaypointBehaviour "AWARE";
I1_WP_1 setWaypointSpeed "LIMITED";


_TRGA = createTrigger ["EmptyDetector", getPos _Veh];  
_TRGA setTriggerArea [200, 200, 0, false, 100];  
_TRGA setTriggerActivation ["WEST", "PRESENT", false];  
_TRGA setTriggerStatements [  
"this",  
"  
_Veh = nearestObjects [thisTrigger,['LandVehicle'],50] select 0; 
{
  [_x] ordergetin false; 
  [_x] allowGetIn false; 
  unassignvehicle _x;  
 doGetOut _x;  
 } foreach crew _Veh; 
 
 ", ""]; 

_TRGA attachTo [_Veh, [0, 0, 0]]; 

}else{
	
_Veh = createVehicle [selectRandom East_Ground_Vehicles_Light, (getPosATL _nearRoad), [], 2, "NONE"];
_Group = createVehicleCrew _Veh; 
_VC = createGroup East;
{[_x] join _VC} forEach units _Group;

(driver _Veh) disableAI "LIGHTS"; 
_Veh setPilotLight true;

I1_WP_0 = _VC addWaypoint [(getMarkerPos _AssltDestMrk), 0];
I1_WP_0 SetWaypointType "MOVE";
I1_WP_0 setWaypointBehaviour "AWARE";
I1_WP_0 setWaypointSpeed "LIMITED";

I1_WP_00 = _VC addWaypoint [(getPosATL _nearRoad), 0];
I1_WP_00 SetWaypointType "MOVE";
I1_WP_00 setWaypointBehaviour "AWARE";
I1_WP_00 setWaypointSpeed "LIMITED";

I1_WP_1 = _VC addWaypoint [(getPosATL _nearRoad), 3];
I1_WP_1 SetWaypointType "CYCLE";
I1_WP_1 setWaypointBehaviour "AWARE";
I1_WP_1 setWaypointSpeed "LIMITED";

}; };

	{ removeFromRemainsCollector [_x]; } foreach (allUnits select { side _x != west }) ;
	{ removeFromRemainsCollector [_x]; } foreach (vehicles select { side (driver  _x) != west }) ; 


sleep 3 ; 

	{ addToRemainsCollector [_x]; } foreach (allUnits select { side _x != west }) ;
	{ addToRemainsCollector [_x]; } foreach (vehicles select { side (driver  _x) != west }) ; 

};
