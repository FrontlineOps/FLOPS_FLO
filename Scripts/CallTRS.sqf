
_VEHCLSS = _this select 0 ;
_VEHCLSSNME = missionNamespace getVariable _VEHCLSS;

_CAST = screenToWorld [0.5,0.5];
if ((getPosATL laserTarget player) select 0 != 0) then { _CAST = getPosATL laserTarget player; };

_AA = nearestobjects [_CAST,["O_SAM_System_01_F", "O_SAM_System_04_F", "O_Radar_System_02_F"],1500];

if (count ( nearestobjects [player,["B_Radar_System_01_F", "I_E_Radar_System_01_F"],40000]) > 0 ) then {
	if ({alive _x} count _AA == 0 ) then {

_GSHPs = nearestobjects [player,[_VEHCLSSNME],40000] select {count (fullCrew [_x, "cargo", false]) == 0 && alive _x == true && count (waypoints group ((crew _x) select 0)) == 1 && driver _x != objNull};
	if (count _GSHPs > 0 ) then {
		
_GSHP = _GSHPs select 0;
_GSHPGroup = group (driver _GSHP)  ;

_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "colorBLUFOR" ;
_CASD setMarkerAlpha 0.7;
_CASD setMarkerText "Extraction";

			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGTransport.ogg"]), player];

sleep 10;


sleep 1;

_GSHPGroup setBehaviourStrong "CARELESS";
_GSHPGroup setCombatMode "YELLOW";
_GSHP = vehicle ((units _GSHPGroup) select 0);
_GSHP setDammage 0;
_GSHP setVehicleAmmo 1;
_GSHP engineOn true ;
_GSHP flyInHeight 100;

_GSHP disableAI "LIGHTS"; 
_GSHP setPilotLight true;
_GSHP setCollisionLight true; 

_WP = _GSHPGroup addWaypoint [_CAST, 0];
_WP SetWaypointType "MOVE"; 
_WP setWaypointBehaviour "CARELESS"; 
_WP setWaypointForceBehaviour true;
_WP setWaypointStatements ["true", "(vehicle this) land 'GET IN';"];



playSound3D ["A3\dubbing_f\modules\supports\transport_acknowledged.ogg", player];

sleep 5;
_GRPs = (allGroups select {side _x == west});
{player hcSetGroup [_x];} forEach _GRPs;
sleep 180;

deleteMarker _CASD;

	} else {

_Cost = _this select 1;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  

if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;


_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "colorBLUFOR" ;
_CASD setMarkerAlpha 1;
_CASD setMarkerText "Extraction";


	   _CASStrtMrks = allMapMarkers select {markerType _x == "b_installation" && markerText _x == "FOB"};
	   _CASStrt = [_CASStrtMrks,  player] call BIS_fnc_nearestPosition ;

			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGTransport.ogg"]), player];
sleep 10;


_CAS_group_Veh = createVehicle [_VEHCLSSNME, (getMarkerpos _CASStrt) , [], 0, "FLY"] ;
sleep 0.5;
_CAS_group = createVehicleCrew _CAS_group_Veh ;
 

sleep 1;


_CAS_group setBehaviourStrong "CARELESS";
_CAS_group setCombatMode "YELLOW";
_CAS_group_Veh = vehicle ((units _CAS_group) select 0);
_CAS_group_Veh engineOn true ;
_CAS_group_Veh flyInHeight 100;

_CAS_group_Veh disableAI "LIGHTS"; 
_CAS_group_Veh setPilotLight true;
_CAS_group_Veh setCollisionLight true; 


_WP = _CAS_group addWaypoint [_CAST, 0];
_WP SetWaypointType "MOVE"; 
_WP setWaypointBehaviour "CARELESS"; 
_WP setWaypointForceBehaviour true;
_WP setWaypointStatements ["true", "(vehicle this) land 'GET IN';"];



playSound3D ["A3\dubbing_f\modules\supports\transport_acknowledged.ogg", player];

sleep 5;
_GRPs = (allGroups select {side _x == west});
{player hcSetGroup [_x];} forEach _GRPs;
sleep 180;

deleteMarker _CASD;
	}else{hint "Not enough Resources"; }; };
    }else{hint "AntiAir threats Found";}; 
}else{hint "No OPERATION CONTROL SYSTEM Found";};