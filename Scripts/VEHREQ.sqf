

_Cost = _this select 1;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  

if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;	

_ARRVLOC = screenToWorld [0.5,0.5];
if ((getPosATL laserTarget player) select 0 != 0) then { _ARRVLOC = getPosATL laserTarget player; };

_VEHCLSS = _this select 0 ;
_VEHCLSSNME = missionNamespace getVariable _VEHCLSS;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if (_VEHCLSSNME == "") exitWith {hint "No Vehicle Selected"} ;

 _allFOBMarks = allMapMarkers select {markerType _x == "b_installation" && markerText _x == "FOB" && markerColor _x == "ColorYellow"};   
 _NRFMRK = [_allFOBMarks,  player] call BIS_fnc_nearestPosition;

 
if ((position player) distance (getMarkerpos _NRFMRK) < 400) exitWith {hint "You are Near the FOB"} ;



_nearRoad2 =(getMarkerPos _NRFMRK) nearRoads 400 ; 
_nearRoad1 = (getMarkerPos _NRFMRK) nearRoads 300 ; 

_nearRoadleft = _nearRoad2 - _nearRoad1;

if (count _nearRoadleft > 0) then { nearRoadpos = getpos (selectRandom _nearRoadleft); } else { nearRoadpos = [ (getMarkerPos _NRFMRK), 300, 400, 20, 0, 1, 0 ] call BIS_fnc_findSafePos; } ; 

hint "GCE Deployed" ; 
_Veh = createVehicle [_VEHCLSSNME, nearRoadpos, [], 0, "NONE"];


_Group = createVehicleCrew _Veh; 
_VC = createGroup west;
{[_x] join _VC} forEach units _Group;


(driver _Veh) disableAI "LIGHTS"; 
_Veh setPilotLight true;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

I1_WP_0 = _VC addWaypoint [_ARRVLOC, 0];
I1_WP_0 SetWaypointType "MOVE";
I1_WP_0 setWaypointBehaviour "AWARE";



_CASD = createMarker [str _ARRVLOC, _ARRVLOC];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "colorBLUFOR" ;
_CASD setMarkerAlpha 0.7;
_CASD setMarkerText "Ground Support"; 


private _headlessClients = entities "HeadlessClient_F";
private _humanPlayers = allPlayers - _headlessClients;
hcRemoveAllGroups player;  
 {player hcRemoveGroup _x ;} forEach (allGroups select {side _x == west}); 
 _GRPs = (allGroups select {(side _x == (side player)) && !(((units _x) select 0) in switchableUnits)}); 
if (count _humanPlayers == 1 ) then {
{player hcSetGroup [_x];} forEach _GRPs;
}else{
{TheCommander hcSetGroup [_x];} forEach _GRPs;
};

sleep 60 ;




deleteMarker _CASD ; 

	}else{hint "Not enough Resources"; };