

_VALCDE = _this select 0 ;

_ALLFACVEHs = nearestobjects [(Position Player),[
"B_GMG_01_A_F",
"B_HMG_01_A_F",
F_turret_01,
F_turret_02,
F_turret_03,
F_turret_01,
F_turret_02,
F_turret_03,
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

			playSound3D [getMissionPath (selectRandom ["Sounds\SuppressiveFire.ogg"]), player];


sleep 2.5 ;  

if (_VALCDE == 121) then {
	
	_FSCVeh = _ALLFACVEHs select 0 ; 
	

 _ins = lineIntersectsSurfaces [ 
  AGLToASL positionCameraToWorld [0,0,0], 
  AGLToASL positionCameraToWorld [0,0,1000], 
  player 
 ]; 
 if (count _ins == 0) exitWith { hint "NO TARGET" }; 
TRGSuppVeh = createVehicle ["CBA_O_InvisibleTargetVehicle", [0,0,0], [], 0, "NONE"]; 
TRGSuppVeh setPosASL (_ins select 0 select 0) ; 
_Hght = (getPosATL TRGSuppVeh) select 2 ; 
 
 if (!isNull cursorObject) then {  
 
 _AzM = (getPos TRGSuppVeh) getDir (Position Player) ; 
 _Dist = (getPos TRGSuppVeh) distance (Position Player) ; 
 _position = (Player getPos [_Dist - 5 , _AzM - 180]) ;
 TRGSuppVeh setPosATL _position ; 
[TRGSuppVeh, _Hght, _position, "ATL"] call BIS_fnc_setHeight ;

 }; 

createVehicleCrew TRGSuppVeh ;
_FSCVeh reveal TRGSuppVeh ;
_FSCVeh doTarget TRGSuppVeh ;
_FSCVeh commandSuppressiveFire TRGSuppVeh;	
_FSCVeh doFire TRGSuppVeh;

			playSound3D [getMissionPath (selectRandom ["Sounds\c_in2_65_apc_engage_ABB_0.ogg"]), player];

_CASDFSC = createMarker [str (getPos TRGSuppVeh), (getPos TRGSuppVeh)];
_CASDFSC setMarkerType "mil_marker_noShadow";
_CASDFSC setMarkerColor "ColorOrange" ;
_CASDFSC setMarkerAlpha 0.7;
_CASDFSC setMarkerText "Suppresive Fire"; 

sleep 40 ;

_NearTargets = TRGSuppVeh nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], 70] select {((side _x == east) or (side (driver _x) == east)) && (alive _x)} ; 
 if (count _NearTargets > 0) then {
	 deleteVehicle TRGSuppVeh ; 
	 TRGSuppVehNew = selectRandom _NearTargets ; 
_FSCVeh reveal TRGSuppVehNew ;
_FSCVeh doTarget TRGSuppVehNew ;
_FSCVeh commandSuppressiveFire TRGSuppVehNew;	
_FSCVeh doFire TRGSuppVehNew;
 };
 
sleep 30 ;

deleteMarker _CASDFSC ; 

} else {
	
 _ins = lineIntersectsSurfaces [ 
  AGLToASL positionCameraToWorld [0,0,0], 
  AGLToASL positionCameraToWorld [0,0,1000], 
  player 
 ]; 
 if (count _ins == 0) exitWith { hint "NO TARGET" }; 
TRGSuppVeh = createVehicle ["CBA_O_InvisibleTargetVehicle", [0,0,0], [], 0, "NONE"]; 
TRGSuppVeh setPosASL (_ins select 0 select 0) ; 
_Hght = (getPosATL TRGSuppVeh) select 2 ; 
 
 if (!isNull cursorObject) then {  
 
 _AzM = (getPos TRGSuppVeh) getDir (Position Player) ; 
 _Dist = (getPos TRGSuppVeh) distance (Position Player) ; 
 _position = (Player getPos [_Dist - 5 , _AzM - 180]) ;
 TRGSuppVeh setPosATL _position ; 
[TRGSuppVeh, _Hght, _position, "ATL"] call BIS_fnc_setHeight ;

 }; 

createVehicleCrew TRGSuppVeh ;
{
	_x reveal TRGSuppVeh ;
	_x doTarget TRGSuppVeh ;
	_x commandSuppressiveFire TRGSuppVeh;	
	_x doFire TRGSuppVeh;
	
} forEach _ALLFACVEHs ; 

			playSound3D [getMissionPath (selectRandom ["Sounds\c_in2_65_apc_engage_ABB_0.ogg"]), player];

_CASDFSC = createMarker [str (getPos TRGSuppVeh), (getPos TRGSuppVeh)];
_CASDFSC setMarkerType "mil_marker_noShadow";
_CASDFSC setMarkerColor "ColorOrange" ;
_CASDFSC setMarkerAlpha 0.7;
_CASDFSC setMarkerText "Suppresive Fire"; 

sleep 40 ;



_NearTargets = TRGSuppVeh nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], 70] select {((side _x == east) or (side (driver _x) == east)) && (alive _x)} ; 
 if (count _NearTargets > 0) then {
{
	deleteVehicle TRGSuppVeh ; 
TRGSuppVehNew = selectRandom _NearTargets ; 
_x reveal TRGSuppVehNew ;
_x doTarget TRGSuppVehNew ;
_x commandSuppressiveFire TRGSuppVehNew;	
_x doFire TRGSuppVehNew;
} forEach _ALLFACVEHs ; 

 };
 
sleep 30 ;

deleteMarker _CASDFSC ; 
deleteMarker _CASDFSC ; 

};

