
_nearRoad = _this select 0;
_dir = _this select 1;

_allWatchposts = [ 
"Watchpost_1", 
"Watchpost_2", 
"Watchpost_3", 
"Watchpost_4", 
"Watchpost_5", 
"Watchpost_6",
"Watchpost_7",
"Watchpost_8",
"Watchpost_9",
"Watchpost_10",
"Road_Post_CSAT_01", 
"Road_Post_CSAT_02",
"Road_Post_CSAT_03",  
"Road_Post_CSAT_04",
"Road_Post_CSAT_01", 
"Road_Post_CSAT_02",
"Road_Post_CSAT_03",  
"Road_Post_CSAT_04"
]; 



_TERR = nearestTerrainObjects [getPos _nearRoad, ["House", "TREE", "SMALL TREE", "BUSH", "ROCK", "ROCKS"], 15]; 
{[_x, true] remoteExec ['hideObjectGlobal', 0];} forEach _TERR ;

_COM = [ selectRandom _allWatchposts, getPos _nearRoad, [0,0,0], (0 + (random 350)), false, false, true ] call LARs_fnc_spawnComp; 


PRL = [(getPos _nearRoad) getPos [(10 +(random 20)), (0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, getPos _nearRoad, 50] call BIS_fnc_taskPatrol;
			PRL deleteGroupWhenEmpty true;

// if (_AGGRSCORE > 5) then {
// PRL = [(getPos _nearRoad) getPos [(10 +(random 20)), (0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
// [PRL, getPos _nearRoad, 100] call BIS_fnc_taskPatrol;
// 			PRL deleteGroupWhenEmpty true;
// };

sleep 5 ;


_allBuildings = nearestObjects [(getPos _nearRoad), ["HOUSE", "Strategic"], 20];  
_allPositions = [];  
_allBuildings apply {_allPositions append (_x buildingPos -1)};  

G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH";  
			G deleteGroupWhenEmpty true;

G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH";  
			G deleteGroupWhenEmpty true;

G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;


G = [(getPos _nearRoad) getPos [(15 +(random 15)), (0 + (random 360))] , East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH";  
			G deleteGroupWhenEmpty true;

G = [(getPos _nearRoad) getPos [(15 +(random 15)), (0 + (random 360))], East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH";  
			G deleteGroupWhenEmpty true;

G = [(getPos _nearRoad) getPos [(15 +(random 15)), (0 + (random 360))], East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH";  
			G deleteGroupWhenEmpty true;

G = [(getPos _nearRoad) getPos [(15 +(random 15)), (0 + (random 360))], East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH";  
			G deleteGroupWhenEmpty true;

G = [ (getPos _nearRoad) getPos [(15 +(random 15)), (0 + (random 360))], East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;


// {

// _nvg = hmd _x;
//  _x unassignItem _nvg;
//  _x removeItem _nvg;
// 	  _x addPrimaryWeaponItem "acc_flashlight";
// 	  _x assignItem "acc_flashlight";
// 	  _x enableGunLights "ForceOn";
//   } foreach (allUnits select {side _x == east}); 



sleep 5 ;
_WeaponsARRAY = nearestObjects [(getPos _nearRoad), ["O_G_HMG_02_high_F", "O_G_Mortar_01_F"], 100] ;
{[_x, 3, position _x, "ATL"] call BIS_fnc_setHeight; _x setVectorUp [0,0,1]; } forEach _WeaponsARRAY;


_HeavGun =  nearestObjects [(getPos _nearRoad), ["O_G_Mortar_01_F", "O_G_HMG_02_high_F"], 100] select 0;
if !(isnil "_HeavGun") then {HeavWeapGroup = createVehicleCrew _HeavGun;}; 
