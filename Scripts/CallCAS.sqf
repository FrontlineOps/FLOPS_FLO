
_VEHCLSS = _this select 0 ;
_VEHCLSSNME = missionNamespace getVariable _VEHCLSS;

_CAST = screenToWorld [0.5,0.5];
if ((getPosATL laserTarget player) select 0 != 0) then { _CAST = getPosATL laserTarget player; };



_allFOBMarks = allMapMarkers select {markerType _x == "b_installation"  && markerColor _x == "ColorYellow" &&  markerText _x == "FOB"};  
_NearFOBMark = [_allFOBMarks,  _CAST] call BIS_fnc_nearestPosition ;

_AA = nearestobjects [_CAST,["O_SAM_System_01_F", "O_SAM_System_04_F"],1500];

if (count ( nearestobjects [player,["B_Radar_System_01_F", "I_E_Radar_System_01_F"],40000]) > 0 ) then {
	if ({alive _x} count _AA == 0 ) then {

_GSHPs = nearestobjects [player,[_VEHCLSSNME],40000] select {alive _x == true  && (getMarkerPos _NearFOBMark) distance (position _x) < 500 };

	if ({alive _x} count _GSHPs > 0 ) then {
_GSHP = nearestobjects [(getMarkerPos _NearFOBMark),[_VEHCLSSNME],40000] select 0;
_poss0 = getPos _GSHP ;
_GSHPGroup = group ((crew _GSHP) select 0) ;
	


_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "ColorYellow" ;
_CASD setMarkerAlpha 0.7;
_CASD setMarkerText "CAS";

			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGCASHelicopter.ogg"]), player];

sleep 10;


sleep 1;


_GSHPGroup setBehaviourStrong "SAFE";
_GSHPGroup setCombatMode "YELLOW";
_GSHP = vehicle ((units _GSHPGroup) select 0);
_GSHP engineOn true ;
_GSHP setdamage 0;
_GSHP setVehicleAmmo 1;
_GSHP flyInHeight 70;
_GSHP forceSpeed 100;
_GSHP disableAI "LIGHTS"; 
_GSHP setPilotLight true;
_GSHP setCollisionLight true; 


[_GSHPGroup,_CAST, 500] call BIS_fnc_taskPatrol;

_TRGTs = _CAST nearEntities [["Man","Car","Tank", "Air", "Ship", "LandVehicle"], 500] ; 
	{_GSHPGroup reveal _x } forEach _TRGTs ;


playSound3D ["A3\dubbing_f\modules\supports\cas_heli_acknowledged.ogg", player];

sleep 5;
_GRPs = (allGroups select {side _x == west});
{player hcSetGroup [_x];} forEach _GRPs;



sleep 120;


sleep 120;

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
_CASD setMarkerColor "ColorYellow" ;
_CASD setMarkerAlpha 1;
_CASD setMarkerText "CAS";


	   _CASStrtMrks = allMapMarkers select {markerType _x == "b_installation" && markerText _x == "FOB"};
	   _CASStrt = [_CASStrtMrks,  player] call BIS_fnc_nearestPosition ;

			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGCASHelicopter.ogg"]), player];
sleep 10;

_CAS_group_Veh = createVehicle [_VEHCLSSNME, (getMarkerpos _CASStrt) , [], 0, "FLY"] ;
_poss0 = getMarkerpos _CASStrt ;
sleep 0.5;
_CAS_group = createVehicleCrew _CAS_group_Veh ;


_CAS_group setBehaviourStrong "SAFE";
_CAS_group setCombatMode "YELLOW";
_CAS_group_Veh engineOn true ;
_CAS_group_Veh flyInHeight 70;
_CAS_group_Veh forceSpeed 100;

_CAS_group_Veh disableAI "LIGHTS"; 
_CAS_group_Veh setPilotLight true;
_CAS_group_Veh setCollisionLight true; 

[_CAS_group,_CAST, 500] call BIS_fnc_taskPatrol;
_TRGTs = _CAST nearEntities [["Man","Car","Tank", "Air", "Ship", "LandVehicle"], 500] ; 
	{_CAS_group reveal _x } forEach _TRGTs ;
	
playSound3D ["A3\dubbing_f\modules\supports\cas_heli_acknowledged.ogg", player];

sleep 5;
_GRPs = (allGroups select {side _x == west});
{player hcSetGroup [_x];} forEach _GRPs;
	


sleep 120;



sleep 10;

deleteMarker _CASD;

	}else{hint "Not enough Resources"; };};
	


    }else{hint "AntiAir threats Found";}; 
}else{hint "No OPERATION CONTROL SYSTEM Found";};


