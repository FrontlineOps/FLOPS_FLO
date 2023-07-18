
/////////////////////Enemy Armor////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_thisArmorTrigger = _this select 0;


_Chance = selectRandom [1, 2, 3]; 

if ( count ((getpos _thisArmorTrigger) nearRoads 300) > 0)  then {
ARMLC = selectRandom ((getpos _thisArmorTrigger) nearRoads 300) ;
}else{
ARMLC = _this select 0;
} ; 
 

trgARM = 0;

_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_AGGRSCORE = parseNumber (markerText _mrkr) ;  
//////Vehicles/////////////////////////////////////////////////////////////////////////////////////////
	


_V0 = createVehicle [ selectRandom East_Ground_Vehicles_Heavy, (ARMLC getRelPos [(70 +(random 30)), (0 + (random 360))]), [], 4, "NONE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V0 setDir _dir;
_Group = createVehicleCrew _V0; 
_VC0 = createGroup East;
{[_x] join _VC0} forEach units _Group;

_V0 disableAI "LIGHTS"; 
_V0 setPilotLight true;

_V0 addEventHandler ["Killed", { 
_MMarks = allMapMarkers select { markerType _x == "o_armor"};
_M = [_MMarks, (_this select 0)] call BIS_fnc_nearestPosition;

deleteMarker _M ; 
  
  				[100, "AROMR PATROL"] execVM "Scripts\NOtification.sqf" ;


[100] execVM "Scripts\Reward.sqf";
[] execVM "Scripts\DangerPlus.sqf";

}];


_nearRoad = selectRandom ( (getpos ARMLC) nearRoads 140 ) ; 
_V1 = createVehicle [ selectRandom East_Ground_Vehicles_Heavy, (ARMLC getRelPos [(70 +(random 30)), (0 + (random 360))]), [], 4, "NONE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V1 setDir _dir;
_VC1 = createVehicleCrew _V1; 	
_V1 disableAI "LIGHTS"; 
_V1 setPilotLight true;
{[_x] join _VC0} forEach units _VC1; 


if (_AGGRSCORE > 5) then {
_nearRoad = selectRandom ( (getpos ARMLC) nearRoads 140 ) ; 
_V1 = createVehicle [ selectRandom East_Ground_Vehicles_Heavy, (ARMLC getRelPos [(70 +(random 30)), (0 + (random 360))]), [], 4, "NONE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V1 setDir _dir;
_VC1 = createVehicleCrew _V1; 	
_V1 disableAI "LIGHTS"; 
_V1 setPilotLight true;
{[_x] join _VC0} forEach units _VC1; 

_nearRoad = selectRandom ( (getpos ARMLC) nearRoads 70 ) ; 
_V1 = createVehicle [ selectRandom East_Ground_Vehicles_Heavy, (ARMLC getRelPos [(70 +(random 30)), (0 + (random 360))]), [], 4, "NONE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V1 setDir _dir;
_VC1 = createVehicleCrew _V1; 	
_V1 disableAI "LIGHTS"; 
_V1 setPilotLight true;
{[_x] join _VC0} forEach units _VC1; 
	
	};

if (_AGGRSCORE > 10) then {
	
_nearRoad = selectRandom ( (getpos ARMLC) nearRoads 70 ) ; 
_V2= createVehicle [ selectRandom East_Ground_Vehicles_Heavy, (ARMLC getRelPos [(70 +(random 30)), (0 + (random 360))]), [], 4, "NONE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V2 setDir _dir;
_VC2 = createVehicleCrew _V2; 
_V2 disableAI "LIGHTS"; 
_V2 setPilotLight true;
{[_x] join _VC0} forEach units _VC2; 		
	
_nearRoad = selectRandom ( (getpos ARMLC) nearRoads 70 ) ; 
_V2= createVehicle [ selectRandom East_Ground_Vehicles_Heavy, (ARMLC getRelPos [(70 +(random 30)), (0 + (random 360))]), [], 4, "NONE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V2 setDir _dir;
_VC2 = createVehicleCrew _V2; 
_V2 disableAI "LIGHTS"; 
_V2 setPilotLight true;
{[_x] join _VC0} forEach units _VC2; 	

	};


[_VC0, _thisArmorTrigger getPos [(70 +(random 90)), (0 + (random 360))], 50] call BIS_fnc_taskPatrol;


sleep 3;


//   {
//       _nvg = hmd _x;
//       _x unassignItem _nvg;
//       _x removeItem _nvg;
// 	  _x addPrimaryWeaponItem "acc_flashlight";
// 	  _x assignItem "acc_flashlight";
// 	  _x enableGunLights "ForceOn";
//   } foreach (allUnits select {side _x == east}); 

  
  



