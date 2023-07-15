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


CASD = createMarker [str _CAST, _CAST];
CASD setMarkerType "mil_marker_noShadow";
CASD setMarkerColor "ColorOrange" ;
CASD setMarkerAlpha 0.7;
CASD setMarkerText "Air Strike";
publicVariable "CASD";

			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGCASBombing.ogg"]), player];

sleep 10;

nul = [[(getMarkerPos CASD),(0 + (random 360)),"B_Plane_CAS_01_F",3],"Scripts\CASB.sqf"] remoteExec ["BIS_fnc_execVM",2];



sleep 1;

playSound3D ["A3\dubbing_f\modules\supports\cas_bombing_acknowledged.ogg", player];

sleep 5;
_GRPs = (allGroups select {side _x == west});
{player hcSetGroup [_x];} forEach _GRPs;

sleep 25;
			playSound3D [getMissionPath (selectRandom ["Sounds\cas_bombing_accomplished.ogg"]), player];

sleep 180;

deleteMarker CASD;
         }else{{hint "Not enough Resources"; } remoteExec ["call", 0];};
    }else{{hint "AntiAir threats Found";} remoteExec ["call", 0];}; 
}else{{hint "No Air Control System Found";} remoteExec ["call", 0];};