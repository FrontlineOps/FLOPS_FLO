


_VALCDE = _this select 0 ;

_ALLFACVEHs = nearestobjects [(Position Player),[
F_Car_01,
F_Car_02,
F_Car_03,
F_Car_04,
F_Car_05,
F_Car_06,
F_MRAP_01,
F_MRAP_02,
F_MRAP_03,
F_MRAP_04,
F_MRAP_05,
F_MRAP_06,
F_Truck_01,
F_Truck_02,
F_Truck_03,
F_Truck_04,
F_Truck_05,
F_Truck_06,
F_APC_01,
F_APC_02,
F_APC_03,
F_APC_04,
F_APC_05,
F_APC_06,
F_TNK_01,
F_TNK_02,
F_TNK_03,
F_TNK_04
],500] ;


 _ins = lineIntersectsSurfaces [ 
  AGLToASL positionCameraToWorld [0,0,0], 
  AGLToASL positionCameraToWorld [0,0,1000], 
  player 
 ]; 
 if (count _ins == 0) exitWith { hint "INVALID LOCATION" }; 


sleep 2.5 ;  

if (_VALCDE == 121) then {

			playSound3D [getMissionPath (selectRandom ["Sounds\Advance.ogg"]), player];

	
	_FSCVeh = _ALLFACVEHs select 0 ; 
	_FSCVehgrp = (group (driver _FSCVeh)) ;
_AllWs = waypoints _FSCVehgrp ; 

for "_i" from count waypoints _FSCVehgrp - 1 to 0 step -1 do
{deleteWaypoint [_FSCVehgrp, _i];};

_NewWP = _FSCVehgrp addWaypoint [(_ins select 0 select 0), 0];
_NewWP setWaypointType "SAD";
_NewWP setWaypointSpeed "LIMITED";

};
  
  
if (_VALCDE == 212) then {

			playSound3D [getMissionPath (selectRandom ["Sounds\Advance.ogg"]), player];

	_FSCVehgrps = [] ; 
	{
	_grp = (group (driver _x)) ;
	_FSCVehgrps append [_grp] ;
	} forEach _ALLFACVEHs ; 
	
_AllWs = {waypoints _x } foreach _FSCVehgrps; 

{
for "_i" from count waypoints _x - 1 to 0 step -1 do
{deleteWaypoint [_x, _i];};
} foreach _FSCVehgrps;

sleep 2 ;

{
	_NewWP = _x addWaypoint [(_ins select 0 select 0), 0]; 
	_NewWP setWaypointType "SAD";
	_NewWP setWaypointSpeed "LIMITED";

} foreach _FSCVehgrps;


}; 











