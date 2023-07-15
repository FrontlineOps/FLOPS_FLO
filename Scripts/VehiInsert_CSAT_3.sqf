
if ( COMMSDIS == 0 ) then {
	
_Chance = selectRandom [0,1,2]; 
_thisVehiInsertTrigger = _this select 0;
 
 	   _allZoneMarks = allMapMarkers select {((getMarkerPos _x) distance  (getPos _thisVehiInsertTrigger) > 2000) && (markerType _x == "n_installation" || markerType _x == "o_installation" || markerType _x == "o_antiair" || markerType _x == "o_service" || markerType _x == "o_armor" || markerType _x == "loc_Power" || markerType _x == "o_recon" || markerType _x == "o_support" || markerType _x == "n_support" || markerType _x == "loc_Ruin" )} ;  
       _MM = [_allZoneMarks,  _thisVehiInsertTrigger] call BIS_fnc_nearestPosition ;
 	   _allZoneMarksNew = _allZoneMarks - [_MM] ;
       _M = [_allZoneMarksNew,  _MM] call BIS_fnc_nearestPosition ;
	   
 _nearRoad = selectRandom ((getMarkerPos _M) nearRoads 1000 ) ; 	

if ( LOGDIS == 0 ) then {
	
if (_Chance > 0) then {
_Veh = createVehicle [selectRandom East_Ground_Vehicles_Heavy, (getPosATL _nearRoad), [], 2, "NONE"];
_Group = createVehicleCrew _Veh; 
_VC = createGroup East;
{[_x] join _VC} forEach units _Group;


(driver _Veh) disableAI "LIGHTS"; 
_Veh setPilotLight true;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


I1_WP_0 = _VC addWaypoint [getPos _thisVehiInsertTrigger, 0];
I1_WP_0 SetWaypointType "MOVE";
I1_WP_0 setWaypointBehaviour "AWARE";
I1_WP_0 setWaypointSpeed "LIMITED";

I1_WP_00 = _VC addWaypoint [(getMarkerPos _M), 0];
I1_WP_00 SetWaypointType "MOVE";
I1_WP_00 setWaypointBehaviour "AWARE";
I1_WP_00 setWaypointSpeed "LIMITED";

I1_WP_1 = _VC addWaypoint [(getMarkerPos _M), 3];
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
