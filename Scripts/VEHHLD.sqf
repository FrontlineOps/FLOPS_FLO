


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




sleep 2.5 ;  

if (_VALCDE == 121) then {

			playSound3D [getMissionPath (selectRandom ["Sounds\Stop.ogg"]), player];
	
	_FSCVeh = _ALLFACVEHs select 0 ; 
if (isNull (driver _FSCVeh)) exitWith { hint "COMMAND ABORTED" };
if (!alive (driver _FSCVeh)) exitWith { hint "COMMAND ABORTED" };  
  (driver _FSCVeh) disableAI "PATH" ; 
  hint "VEHICLE MOVEMENT HALTED" ;
}; 
  
  
if (_VALCDE == 212) then {

			playSound3D [getMissionPath (selectRandom ["Sounds\Stop.ogg"]), player];

	{
		(driver _x) disableAI "PATH" ; 
	} forEach _ALLFACVEHs ; 
  hint "VEHICLES MOVEMENT HALTED" ;

}; 


if (_VALCDE == 222) then {

			playSound3D [getMissionPath (selectRandom ["Sounds\Advance.ogg"]), player];

	{
		(driver _x) enableAI "PATH" ; 
	} forEach _ALLFACVEHs ; 
	
  hint "VEHICLES MOVEMENT RELEASED" ;

}; 









