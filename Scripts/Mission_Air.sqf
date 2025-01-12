private _thisAirTrigger = _this select 0;

private _mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
private _mrkr = _mrkrs select 0;
private _AGGRSCORE = parseNumber (markerText _mrkr);  

// Create Air Patrol
private _V = createVehicle [ selectRandom East_Air_Jet, (getpos _thisAirTrigger) getPos [100, 0], [], 100, "FLY"]; 
_V addEventHandler ["Killed", { 
	private _MMarks = allMapMarkers select { markerType _x == "o_plane"};
	private _M = [_MMarks,  (_this select 0)] call BIS_fnc_nearestPosition;

	deleteMarker _M ; 

	[50, "AIR PATROL"] execVM "Scripts\NOtification.sqf" ;

	[50] execVM "Scripts\Reward.sqf";
	[] execVM "Scripts\DangerPlus.sqf";
}];

private _Group = createVehicleCrew _V; 
private _VC = createGroup East;
{[_x] join _VC} forEach units _Group;

_V flyInHeight 100; 
_V disableAI "LIGHTS"; 
_V setPilotLight true;
_V setCollisionLight true; 

[_VC, (getPos _thisAirTrigger), 3000] call BIS_fnc_taskPatrol;

private _V = createVehicle [ selectRandom East_Air_Jet, (getpos _thisAirTrigger) getPos [100, 60], [], 100, "FLY"]; 
private _Group = createVehicleCrew _V; 
private _VC = createGroup East;
{[_x] join _VC} forEach units _Group;

_V flyInHeight 100; 
_V disableAI "LIGHTS"; 
_V setPilotLight true;
_V setCollisionLight true; 

[_VC, (getPos _thisAirTrigger), 5000] call BIS_fnc_taskPatrol;

if (_AGGRSCORE > 5) then {
	private _V = createVehicle [ selectRandom East_Air_Jet, (getpos _thisAirTrigger) getPos [100, 120], [], 100, "FLY"]; 
	private _Group = createVehicleCrew _V; 
	private _VC = createGroup East;
	{[_x] join _VC} forEach units _Group;

	_V flyInHeight 100; 
	_V disableAI "LIGHTS"; 
	_V setPilotLight true;
	_V setCollisionLight true; 

	[_VC, (getPos _thisAirTrigger), 3000] call BIS_fnc_taskPatrol;
};
	
if (_AGGRSCORE > 10) then {
	private _V = createVehicle [ selectRandom East_Air_Jet, (getpos _thisAirTrigger) getPos [100, 180], [], 100, "FLY"]; 
	private _Group = createVehicleCrew _V; 
	private _VC = createGroup East;
	{[_x] join _VC} forEach units _Group;

	_V flyInHeight 100; 
	_V disableAI "LIGHTS"; 
	_V setPilotLight true;
	_V setCollisionLight true; 

	[_VC, (getPos _thisAirTrigger), 5000] call BIS_fnc_taskPatrol;
};