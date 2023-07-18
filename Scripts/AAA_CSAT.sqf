
_thisAAATrigger = _this select 0; 
_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_AGGRSCORE = parseNumber (markerText _mrkr) ;  



_Buildings = nearestObjects [_thisAAATrigger, ["HOUSE", "Strategic"], 70] ;  
_allPositionBuildings = _Buildings select {count (_x buildingPos -1) > 0}; 
_allPositions = [];  
_allPositionBuildings apply {_allPositions append (_x buildingPos -1)};  

G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH";  
			G deleteGroupWhenEmpty true;
G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH"; 
			G deleteGroupWhenEmpty true;
G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;
G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH"; 
			G deleteGroupWhenEmpty true;

PRL = [_thisAAATrigger getpos [(20 + (random 20)), (0 + (random 350))], East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, _thisAAATrigger getpos [(20 + (random 20)), (0 + (random 350))], 50] call BIS_fnc_taskPatrol;
			PRL deleteGroupWhenEmpty true;


if (_AGGRSCORE > 5) then {
PRL = [_thisAAATrigger getpos [(0 + (random 20)), (0 + (random 350))], East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, _thisAAATrigger getpos [(0 + (random 20)), (0 + (random 350))], 150] call BIS_fnc_taskPatrol;
			PRL deleteGroupWhenEmpty true;

G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;
G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH"; 
			G deleteGroupWhenEmpty true;
};

if (_AGGRSCORE > 10) then {
PRL = [_thisAAATrigger getpos [(0 + (random 20)), (0 + (random 350))], East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, _thisAAATrigger getpos [(0 + (random 20)), (0 + (random 350))], 200] call BIS_fnc_taskPatrol;
			PRL deleteGroupWhenEmpty true;

G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH"; 
			G deleteGroupWhenEmpty true;
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
[_thisAAATrigger, 100] execVM "Scripts\INTLitems.sqf";

// {
// _nvg = hmd _x;
//  _x unassignItem _nvg;
//  _x removeItem _nvg;
// 	  _x addPrimaryWeaponItem "acc_flashlight";
// 	  _x assignItem "acc_flashlight";
// 	  _x enableGunLights "ForceOn";
//   } foreach (allUnits select {side _x == east}); 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
