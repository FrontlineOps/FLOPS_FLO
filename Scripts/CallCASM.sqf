_CAST = screenToWorld [0.5,0.5];
if ((getPosATL laserTarget player) select 0 != 0) then { _CAST = getPosATL laserTarget player; };

_AA = nearestobjects [_CAST,["O_SAM_System_01_F", "O_SAM_System_04_F", "O_Radar_System_02_F"],1500];

if (count ( nearestobjects [_CAST,["B_Radar_System_01_F", "I_E_Radar_System_01_F"],40000]) > 0 ) then {
	if ({alive _x} count _AA == 0 ) then {

_Cost = 50;
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
_CASD setMarkerText "CAS";


playSound3D ["A3\dubbing_f\modules\supports\cas_bombing_request.ogg", player];
sleep 10;


_logic = "Logic" createVehicleLocal (getMarkerpos _CASD);
_logic setVariable ["vehicle",F_Plane_01_CAS];
_logic setVariable ["type",1];

[_logic,nil,true] call BIS_fnc_moduleCAS;

deleteVehicle _logic;


sleep 1;

playSound3D ["A3\dubbing_f\modules\supports\cas_bombing_acknowledged.ogg", player];

sleep 5;
_GRPs = (allGroups select {side _x == west});
{player hcSetGroup [_x];} forEach _GRPs;
sleep 180;

deleteMarker _CASD;
         }else{hint "Not enough Resources"; };
    }else{hint "AntiAir threats Found";}; 
}else{hint "No Air Control System Found";};