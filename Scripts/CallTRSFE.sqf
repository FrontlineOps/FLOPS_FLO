_CAST = screenToWorld [0.5,0.5];


if ((getPosATL laserTarget player) select 0 != 0) then { _CAST = getPosATL laserTarget player; };

_allFOBMarks = allMapMarkers select {markerType _x == "b_installation"  && markerColor _x == "ColorYellow" &&  markerText _x == "FOB"};  
_NearFOBMark = [_allFOBMarks,  _CAST] call BIS_fnc_nearestPosition ;


_AA = nearestobjects [_CAST,["O_SAM_System_01_F", "O_SAM_System_04_F"],1500];

if (count ( nearestobjects [player,["B_Radar_System_01_F", "I_E_Radar_System_01_F"],40000]) > 0 ) then {
	if ({alive _x} count _AA == 0 ) then {

_GSHPs = nearestobjects [(getMarkerPos _NearFOBMark),[F_Heli_03],40000] select {count (fullCrew [_x, "cargo", false]) == 0 && alive _x == true && (getMarkerPos _NearFOBMark) distance (position _x) < 500 };
	if (count _GSHPs > 0 ) then {
		
_Cost = 50;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  

if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;	
		
_GSHP = _GSHPs select 0;
_GSHPGroup = group (driver _GSHP)  ;


_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "colorBLUFOR" ;
_CASD setMarkerAlpha 0.7;
_CASD setMarkerText "Insertion";

playSound3D ["A3\dubbing_f\modules\supports\transport_request.ogg", player];
sleep 10;


sleep 1;

_GSHPGroup setBehaviourStrong "CARELESS";
_GSHPGroup setCombatMode "YELLOW";
_GSHP = vehicle ((units _GSHPGroup) select 0);
_GSHP engineOn true ;
_GSHP flyInHeight 10;
_GSHP forceSpeed 100;
_poss0 = position _GSHP ;
_GSHP disableAI "LIGHTS"; 
_GSHP setPilotLight true;
_GSHP setCollisionLight true; 


AsltGrp = [[_poss0 select 0, _poss0 select 1, 0], West, [F_Assault_Eng, F_Assault_Amm, F_Assault_Eod, F_Assault_Med]] call BIS_fnc_spawnGroup;
publicVariable "AsltGrp";
_L = (units AsltGrp) select 0;
_L setUnitLoadout F_Assault_Eng;
	if (isClass (configfile >> 'CfgVehicles' >> 'Box_cTab_items') == true ) then { {_x addItem 'ItemAndroid'; _x addItem 'ItemcTabHCam'; _x addItem 'ItemcTab'; } forEach Units AsltGrp; };
		_L linkItem 'B_UavTerminal';
_L addWeapon 'Laserdesignator_03';
_L addBinocularItem 'Laserbatteries';
_L addWeapon 'Rangefinder';
_L addWeapon 'launch_MRAWS_olive_F';
_L addSecondaryWeaponItem 'MRAWS_HEAT_F'; 
{_x linkItem 'NVGoggles_OPFOR'; } forEach Units AsltGrp;
	   {  	{
[_x,'MENU_COMMS_SUPPLYDROP',nil,nil,''] call BIS_fnc_addCommMenuItem;
[_x,'MENU_COMMS_UAV_RECON',nil,nil,''] call BIS_fnc_addCommMenuItem;
[_x,'MENU_COMMS_CAS_HELI',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[_x,'MENU_COMMS_ARTI',nil,nil,''] call BIS_fnc_addCommMenuItem;	} foreach Units AsltGrp; } remoteExec ["call", 0];

//{	{[_x] execVM "Scripts\LDTInit.sqf" ;} forEach Units AsltGrp ;  } remoteExec ["call", 2];

_WP = _GSHPGroup addWaypoint [_CAST, 0];
_WP SetWaypointType "MOVE"; 
_WP setWaypointBehaviour "CARELESS"; 
_WP setWaypointForceBehaviour true;
_WP setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; group ((fullCrew [(vehicle this), 'cargo', false] select 0) select 0) leaveVehicle (vehicle this); "];
_WP setWaypointSpeed "FULL"; 
 
_WP_2 = _GSHPGroup addWaypoint [_poss0, 0];
_WP_2 SetWaypointType "MOVE";
_WP_2 setWaypointSpeed "FULL";


{_x moveInCargo _GSHP} foreach units AsltGrp;  


playSound3D ["A3\dubbing_f\modules\supports\transport_acknowledged.ogg", player];

sleep 5;
_GRPs = (allGroups select {side _x == west});
{player hcSetGroup [_x];} forEach _GRPs;
sleep 180;

deleteMarker _CASD;

	}else{hint "Not enough Resources"; }; 

	} else {

_Cost = 110;
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
_CASD setMarkerText "Insertion";


	   _CASStrtMrks = allMapMarkers select {markerType _x == "b_installation" && markerText _x == "FOB"};
	   _CASStrt = [_CASStrtMrks,  player] call BIS_fnc_nearestPosition ;

playSound3D ["A3\dubbing_f\modules\supports\transport_request.ogg", player];
sleep 10;


_CAS_group_Veh = createVehicle [F_Heli_03, (getMarkerpos _CASStrt) , [], 0, "FLY"] ;
sleep 0.5;
_CAS_group = createVehicleCrew _CAS_group_Veh ;
 

sleep 1;


_CAS_group setBehaviourStrong "CARELESS";
_CAS_group setCombatMode "YELLOW";
_CAS_group_Veh = vehicle ((units _CAS_group) select 0);
_CAS_group_Veh engineOn true ;
_CAS_group_Veh flyInHeight 10;
_CAS_group_Veh forceSpeed 100;
_poss0 = position _CAS_group_Veh ;
_CAS_group_Veh disableAI "LIGHTS"; 
_CAS_group_Veh setPilotLight true;
_CAS_group_Veh setCollisionLight true; 



AsltGrp = [[_poss0 select 0, _poss0 select 1, 0], West, [F_Assault_Eng, F_Assault_Amm, F_Assault_Eod, F_Assault_Med]] call BIS_fnc_spawnGroup;
publicVariable "AsltGrp";
_L = Leader AsltGrp;
_L setUnitLoadout F_Assault_Eng;
	if (isClass (configfile >> 'CfgVehicles' >> 'Box_cTab_items') == true ) then { {_x addItem 'ItemAndroid'; _x addItem 'ItemcTabHCam'; _x addItem 'ItemcTab'; } forEach Units AsltGrp; };
		_L linkItem 'B_UavTerminal';
_L addWeapon 'Laserdesignator_03';
_L addBinocularItem 'Laserbatteries';
_L addWeapon 'Rangefinder';
_L addWeapon 'launch_MRAWS_olive_F';
_L addSecondaryWeaponItem 'MRAWS_HEAT_F'; 
	   {  	{
[_x,'MENU_COMMS_SUPPLYDROP',nil,nil,''] call BIS_fnc_addCommMenuItem;
[_x,'MENU_COMMS_UAV_RECON',nil,nil,''] call BIS_fnc_addCommMenuItem;
[_x,'MENU_COMMS_CAS_HELI',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[_x,'MENU_COMMS_ARTI',nil,nil,''] call BIS_fnc_addCommMenuItem;	} foreach Units AsltGrp; } remoteExec ['call', 0];

//{	{[_x] execVM "Scripts\LDTInit.sqf" ;} forEach Units AsltGrp ;  } remoteExec ["call", 2];

_WP = _CAS_group addWaypoint [_CAST, 0];
_WP SetWaypointType "MOVE"; 
_WP setWaypointBehaviour "CARELESS"; 
_WP setWaypointForceBehaviour true;
_WP setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; group ((fullCrew [(vehicle this), 'cargo', false] select 0) select 0) leaveVehicle (vehicle this); "];
_WP setWaypointSpeed "FULL"; 
 
_WP_2 = _CAS_group addWaypoint [_poss0, 0];
_WP_2 SetWaypointType "MOVE";
_WP_2 setWaypointSpeed "FULL";


{_x moveInCargo _CAS_group_Veh} foreach units AsltGrp;  


playSound3D ["A3\dubbing_f\modules\supports\transport_acknowledged.ogg", player];

sleep 5;
_GRPs = (allGroups select {side _x == west});
{player hcSetGroup [_x];} forEach _GRPs;
sleep 180;

deleteMarker _CASD;
	}else{hint "Not enough Resources"; }; };
    }else{hint "AntiAir threats Found";}; 
}else{hint "No Air Control System Found";};