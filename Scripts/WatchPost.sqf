
MountSel = _this select 0;
_Watchpost = _this select 1;

_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_AGGRSCORE = parseNumber (markerText _mrkr) ;  

_TERR = nearestTerrainObjects [locationPosition MountSel, ["House", "TREE", "SMALL TREE", "BUSH", "ROCK", "ROCKS"], 15]; 
{_x hideObjectGlobal true;} forEach _TERR ;

WPdir = 0 + (random 360);
if (count (nearestObjects [(locationPosition MountSel), ["House"], 200]) != 0) then {
WPdir = getDirVisual ((nearestObjects [(locationPosition MountSel), ["House"], 200]) select 0);
};
_COM = [ _Watchpost, locationPosition MountSel, [0,0,0], WPdir, true ] call LARs_fnc_spawnComp;	


PRL = [(locationPosition MountSel) getPos [(10 +(random 10)), (0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, locationPosition MountSel, 50] call BIS_fnc_taskPatrol;
			PRL deleteGroupWhenEmpty true;

if (_AGGRSCORE > 5) then {
PRL = [(locationPosition MountSel) getPos [(10 +(random 10)), (0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, locationPosition MountSel, 100] call BIS_fnc_taskPatrol;
			PRL deleteGroupWhenEmpty true;
};

sleep 1 ;
_ARRAY = [ _COM ] call LARs_fnc_getCompObjects;
{_x setVectorUp [0,0,1];} forEach _ARRAY; 

_allBuildings = nearestObjects [(locationPosition MountSel), ["HOUSE", "Strategic"], 20];  
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

if (_AGGRSCORE > 5) then {
G = [(locationPosition MountSel) getPos [(10 +(random 10)), (0 + (random 360))] , East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH";  
			G deleteGroupWhenEmpty true;

G = [(locationPosition MountSel) getPos [(10 +(random 10)), (0 + (random 360))], East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH";  
			G deleteGroupWhenEmpty true;


G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;
};

//TODO : Is this ok?
// if (_AGGRSCORE > 10) then {
// G = [(locationPosition MountSel) getPos [(10 +(random 10)), (0 + (random 360))] , East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
// ((units G) select 0) disableAI "PATH";  
// 			G deleteGroupWhenEmpty true;

// G = [(locationPosition MountSel) getPos [(10 +(random 10)), (0 + (random 360))], East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
// ((units G) select 0) disableAI "PATH";  
// 			G deleteGroupWhenEmpty true;


// G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
// 			G deleteGroupWhenEmpty true;
// };

// {

// _nvg = hmd _x;
//  _x unassignItem _nvg;
//  _x removeItem _nvg;
// 	  _x addPrimaryWeaponItem "acc_flashlight";
// 	  _x assignItem "acc_flashlight";
// 	  _x enableGunLights "ForceOn";
//   } foreach (allUnits select {side _x == east}); 


sleep 1 ;
_WeaponsARRAY = nearestObjects [(locationPosition MountSel), ["O_G_HMG_02_high_F", "O_G_Mortar_01_F"], 100] ;
{[_x, 3, position _x, "ATL"] call BIS_fnc_setHeight; _x setVectorUp [0,0,1]; } forEach _WeaponsARRAY;


HeavGuns =  nearestObjects [(locationPosition MountSel), ["O_G_Mortar_01_F", "O_G_HMG_02_high_F"], 100] ;
if (count HeavGuns > 0) then {
{HeavWeapGroup = createVehicleCrew _x; } forEach HeavGuns ; 
};
