_CAST = screenToWorld [0.5,0.5];
if ((getPosATL laserTarget player) select 0 != 0) then { _CAST = getPosATL laserTarget player; };

_AA = nearestobjects [_CAST,["O_SAM_System_01_F", "O_SAM_System_04_F", "O_Radar_System_02_F"],3500];

if (count ( nearestobjects [player,["B_Radar_System_01_F", "I_E_Radar_System_01_F"],40000]) > 0 ) then {
	if ({alive _x} count _AA == 0 ) then {

_GSHPs = nearestobjects [player,[F_UAV_01],40000] select {alive _x == true};
	if (count _GSHPs > 0 ) then {
		
_UAV = nearestobjects [player,[F_UAV_01],40000] select 0;
_VC = group ((crew _UAV) select 0) ;

_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "colorBLUFOR" ;
_CASD setMarkerAlpha 0.7;
_CASD setMarkerText "UAV Drone";

_UAV flyInHeight 2000; 
_UAV disableAI "LIGHTS"; 
_UAV setPilotLight false;
_UAV setCollisionLight false; 

_WP = _VC addWaypoint [(getMarkerpos _CASD), 0];
_WP SetWaypointType "LOITER";
_WP setWaypointBehaviour "CARELESS";
_WP setWaypointLoiterAltitude 2000;
_WP setWaypointLoiterRadius 2000;

playSound3D ["A3\dubbing_f\modules\supports\uav_acknowledged.ogg", player];

sleep 5;
_GRPs = (allGroups select {side _x == west});
{player hcSetGroup [_x];} forEach _GRPs;
sleep 180;

deleteMarker _CASD;

	} else {
		
_Cost = 80;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  
if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;


_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "colorBLUFOR" ;
_CASD setMarkerAlpha 0.7;
_CASD setMarkerText "UAV Drone";

  _CASStrtMrks = allMapMarkers select {markerType _x == "b_installation" && markerColor _x == "ColorYellow"};
	   _CASStrt = [_CASStrtMrks,  player] call BIS_fnc_nearestPosition ;


playSound3D ["A3\dubbing_f\modules\supports\uav_request.ogg", player];
sleep 10;



_UAV = createVehicle [F_UAV_01,(getMarkerpos _CASStrt), [], 0, "FLY"];

_Group = createVehicleCrew _UAV; 
_VC = createGroup West;
{[_x] join _VC} forEach units _Group;

_UAV flyInHeight 2000; 
_UAV disableAI "LIGHTS"; 
_UAV setPilotLight false;
_UAV setCollisionLight false; 

_WP = _VC addWaypoint [(getMarkerpos _CASD), 0];
_WP SetWaypointType "LOITER";
_WP setWaypointBehaviour "CARELESS";
_WP setWaypointLoiterAltitude 2000;
_WP setWaypointLoiterRadius 2000;

playSound3D ["A3\dubbing_f\modules\supports\uav_acknowledged.ogg", player];

sleep 5;
_GRPs = (allGroups select {side _x == west});
{player hcSetGroup [_x];} forEach _GRPs;
sleep 180;

deleteMarker _CASD;

	}else{hint "Not enough Resources"; }; };
		 
    }else{hint "AntiAir threats Found";}; 
}else{hint "No Air Control System Found";};