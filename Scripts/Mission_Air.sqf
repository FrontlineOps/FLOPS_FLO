

/////////////////////Air Patrol////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_thisAirTrigger = _this select 0;

_Chance = selectRandom [1, 2, 3]; 

_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_DANSCORE = parseNumber (markerText _mrkr) ;  
//////Vehicles/////////////////////////////////////////////////////////////////////////////////////////



_V = createVehicle [ selectRandom East_Air_Jet, (getpos _thisAirTrigger) getPos [100, 0], [], 100, "FLY"]; 
_V addEventHandler ["Killed", { 
_MMarks = allMapMarkers select { markerType _x == "o_plane"};
_M = [_MMarks,  (_this select 0)] call BIS_fnc_nearestPosition;

deleteMarker _M ; 

				[50, "AIR PATROL"] execVM "Scripts\NOtification.sqf" ;


[50] execVM "Scripts\Reward.sqf";
[] execVM "Scripts\DangerPlus.sqf";

}];

_Group = createVehicleCrew _V; 
_VC = createGroup East;
{[_x] join _VC} forEach units _Group;

_V flyInHeight 100; 
_V disableAI "LIGHTS"; 
_V setPilotLight true;
_V setCollisionLight true; 

[_VC, (getPos _thisAirTrigger), 3000] call BIS_fnc_taskPatrol;

_V = createVehicle [ selectRandom East_Air_Jet, (getpos _thisAirTrigger) getPos [100, 60], [], 100, "FLY"]; 
_Group = createVehicleCrew _V; 
_VC = createGroup East;
{[_x] join _VC} forEach units _Group;

_V flyInHeight 100; 
_V disableAI "LIGHTS"; 
_V setPilotLight true;
_V setCollisionLight true; 

[_VC, (getPos _thisAirTrigger), 5000] call BIS_fnc_taskPatrol;

if (_DANSCORE > 5) then {

_V = createVehicle [ selectRandom East_Air_Jet, (getpos _thisAirTrigger) getPos [100, 120], [], 100, "FLY"]; 
_Group = createVehicleCrew _V; 
_VC = createGroup East;
{[_x] join _VC} forEach units _Group;

_V flyInHeight 100; 
_V disableAI "LIGHTS"; 
_V setPilotLight true;
_V setCollisionLight true; 

[_VC, (getPos _thisAirTrigger), 3000] call BIS_fnc_taskPatrol;
};
	
if (_DANSCORE > 10) then {


_V = createVehicle [ selectRandom East_Air_Jet, (getpos _thisAirTrigger) getPos [100, 180], [], 100, "FLY"]; 
_Group = createVehicleCrew _V; 
_VC = createGroup East;
{[_x] join _VC} forEach units _Group;

_V flyInHeight 100; 
_V disableAI "LIGHTS"; 
_V setPilotLight true;
_V setCollisionLight true; 

[_VC, (getPos _thisAirTrigger), 5000] call BIS_fnc_taskPatrol;

 };



{_nvg = hmd _x;
 _x unassignItem _nvg;
 _x removeItem _nvg;
	  _x addPrimaryWeaponItem "acc_flashlight";
	  _x assignItem "acc_flashlight";
	  _x enableGunLights "ForceOn";
  } foreach (allUnits select {side _x == east}); 

{ if !((side _x) == west) then {
            ZEUS removeCuratorEditableObjects [[_x],true];
}; } foreach allUnits;

