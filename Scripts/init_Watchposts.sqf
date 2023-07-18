_allWatchposts = [ 
"Watchpost_1", 
"Watchpost_2", 
"Watchpost_3", 
"Watchpost_4", 
"Watchpost_5" 
]; 
 
_allMounts = nearestLocations [position player, ["Mount"], 30000];   
_allNearMounts = nearestLocations [position player, ["Mount"], 1000];   
_Mounts = _allMounts - _allNearMounts; 
 
_Mount = selectRandom _Mounts; 
_Watchpost = selectRandom _allWatchposts; 
[ _Watchpost, locationPosition _Mount, [0,0,0], (0 + (random 350)), false,  true, false] call LARs_fnc_spawnComp; 
{_x setUnitLoadout selectRandom East_Units;} forEach nearestObjects [(locationPosition _Mount),["Man"],50];

_Mount = selectRandom _Mounts; 
_Watchpost = selectRandom _allWatchposts; 
[ _Watchpost, locationPosition _Mount, [0,0,0], (0 + (random 350)), false,  true, false] call LARs_fnc_spawnComp; 
{_x setUnitLoadout selectRandom East_Units;} forEach nearestObjects [(locationPosition _Mount),["Man"],50];

_Mount = selectRandom _Mounts; 
_Watchpost = selectRandom _allWatchposts; 
[ _Watchpost, locationPosition _Mount, [0,0,0], (0 + (random 350)), false,  true, false] call LARs_fnc_spawnComp; 
{_x setUnitLoadout selectRandom East_Units;} forEach nearestObjects [(locationPosition _Mount),["Man"],50];

_Mount = selectRandom _Mounts; 
_Watchpost = selectRandom _allWatchposts; 
[ _Watchpost, locationPosition _Mount, [0,0,0], (0 + (random 350)), false,  true, false] call LARs_fnc_spawnComp; 
{_x setUnitLoadout selectRandom East_Units;} forEach nearestObjects [(locationPosition _Mount),["Man"],50];

_Mount = selectRandom _Mounts; 
_Watchpost = selectRandom _allWatchposts; 
[ _Watchpost, locationPosition _Mount, [0,0,0], (0 + (random 350)), false,  true, false] call LARs_fnc_spawnComp; 
{_x setUnitLoadout selectRandom East_Units;} forEach nearestObjects [(locationPosition _Mount),["Man"],50];

_Mount = selectRandom _Mounts; 
_Watchpost = selectRandom _allWatchposts; 
[ _Watchpost, locationPosition _Mount, [0,0,0], (0 + (random 350)), false,  true, false] call LARs_fnc_spawnComp; 
{_x setUnitLoadout selectRandom East_Units;} forEach nearestObjects [(locationPosition _Mount),["Man"],50];

_Mount = selectRandom _Mounts; 
_Watchpost = selectRandom _allWatchposts; 
[ _Watchpost, locationPosition _Mount, [0,0,0], (0 + (random 350)), false,  true, false] call LARs_fnc_spawnComp; 
{_x setUnitLoadout selectRandom East_Units;} forEach nearestObjects [(locationPosition _Mount),["Man"],50];

_Mount = selectRandom _Mounts; 
_Watchpost = selectRandom _allWatchposts; 
[ _Watchpost, locationPosition _Mount, [0,0,0], (0 + (random 350)), false,  true, false] call LARs_fnc_spawnComp; 
{_x setUnitLoadout selectRandom East_Units;} forEach nearestObjects [(locationPosition _Mount),["Man"],50];

_Mount = selectRandom _Mounts; 
_Watchpost = selectRandom _allWatchposts; 
[ _Watchpost, locationPosition _Mount, [0,0,0], (0 + (random 350)), false,  true, false] call LARs_fnc_spawnComp; 
{_x setUnitLoadout selectRandom East_Units;} forEach nearestObjects [(locationPosition _Mount),["Man"],50];


{
   if (((side _x) == East) && ((getMarkerpos "MB1") distance _x < 200)) then { 
                        // _x unassignItem "NVGoggles_OPFOR";
                        // _x removeItem "NVGoggles_OPFOR";
						// _x unassignItem "acc_pointer_IR";
	                    // _x removePrimaryWeaponItem "acc_pointer_IR";
	                    // _x addPrimaryWeaponItem "acc_flashlight";
	                    // _x assignItem "acc_flashlight";
	                    // _x enableGunLights "ForceOn";
	                    _x setskill ["spotDistance",(0 + random 0.2)];
	                    _x setskill ["spotTime",(0 + random 0.2)];
                     }; 
  } foreach allUnits + vehicles;