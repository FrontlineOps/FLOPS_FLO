 
thisCityCivTrigger = _this select 0;
_Chance = selectRandom [1, 2, 3]; 
_mrkrs = allMapMarkers select {markerColor _x == "Color4_FD_F"};
_mrkr = _mrkrs select 0;
_REPSCORE = parseNumber (markerText _mrkr) ;  



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_allBuildings = nearestObjects [(getPos thisCityCivTrigger), ["HOUSE"], 150];   
 
{ 
_x removeAllEventHandlers "Killed"; 
_x addEventHandler ["Killed", { 
[playerSide, "HQ"] commandChat "WATCH for CIVILIAN PROPERTIES Corporal !"; 

[] execVM "Scripts\ReputationMinus.sqf";
[] execVM "Scripts\Civ_Relations.sqf";

}]; 
} forEach _allBuildings;

//////Generator////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_Houses= nearestObjects [(getPos thisCityCivTrigger) , ["HOUSE"], 300] ;  
_OtherHouses = nearestObjects [(getPos thisCityCivTrigger) , ["HOUSE"], 50] ; 
_PowerHouses = _Houses - _OtherHouses;
_allPowerHouses = _PowerHouses select {count (_x buildingPos -1) > 2}; 
_PowerHouse = selectRandom _allPowerHouses;  
_dir = getDirVisual _PowerHouse;
_V = createVehicle ["Land_PowerGenerator_F", (selectRandom (_PowerHouse buildingPos -1)), [], 0, "FLY"]; 
_V addEventHandler ["Killed", { 
[] execVM "Scripts\ReputationMinus.sqf";
execVM "Scripts\Civ_Relations.sqf";
[(_this select 0)] execVM 'Scripts\Sabotage.sqf';
}];
_V allowDammage false;
_V setPos (selectRandom (_PowerHouse buildingPos -1));
_V setDir _dir;
sleep 3;
_V allowDammage true;
_V = createVehicle ["Land_TTowerSmall_2_F", getPos _PowerHouse, [], 0, "NONE"]; 

_markerName = "PowerHouseMark" + (str (getPos _PowerHouse));  
_mrkr = createMarker [_markerName, getPos _PowerHouse];   
_mrkr setMarkerType "loc_Lighthouse";
_mrkr setMarkerColor "colorOPFOR";
_mrkr setMarkerSize [0.6, 0.6]; 
_mrkr setMarkerAlpha 0.001;  

 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 if (_Chance > 0) then {
 _nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 300 ) ; 
_pos = _nearRoad getRelPos [6, 0];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 10], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;

 _nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 300 ) ; 
_pos = _nearRoad getRelPos [6, 0];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 10], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;

 _nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 2000 ) ; 
_pos = _nearRoad getRelPos [6, 0];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 10], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;
 };
 
 sleep 1;
 
  if (_Chance > 1) then {
 _nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 300 ) ; 
_pos = _nearRoad getRelPos [6, 0];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 10], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;
 
 _nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 300 ) ; 
_pos = _nearRoad getRelPos [6, 0];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 10], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;

 _nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 2000 ) ; 
_pos = _nearRoad getRelPos [6, 0];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 10], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;

 };

 sleep 1;
 
  if (_Chance > 2) then {
 _nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 300 ) ; 
_pos = _nearRoad getRelPos [6, 0];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 10], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;

 _nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 300 ) ; 
_pos = _nearRoad getRelPos [6, 0];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 10], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;

 _nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 2000 ) ; 
_pos = _nearRoad getRelPos [6, 0];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 10], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;
 };

 sleep 1;
  
if (_Chance > 0) then {
_nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 300 ) ; 
_pos = _nearRoad getRelPos [6, 0];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 10], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;
_Group = createVehicleCrew _V; 

sleep 3;
_Wposs0 = [_V, 70, 300, 1, 0, 1, 0] call BIS_fnc_findSafePos; 
_nearRoad0 = ( _Wposs0 nearRoads 5000 ) select 0; 
I1_WP_0 = _Group addWaypoint [getPos _nearRoad0, 0];
I1_WP_0 SetWaypointType "MOVE";
I1_WP_0 setWaypointBehaviour "SAFE";
I1_WP_0 setWaypointSpeed "LIMITED";

_nearRoad1 = ( _Wposs0 nearRoads 5000 ) select 0; 
I1_WP_00 = _Group addWaypoint [getPos _nearRoad1, 0];
I1_WP_00 SetWaypointType "MOVE";
I1_WP_00 setWaypointBehaviour "SAFE";
I1_WP_00 setWaypointSpeed "LIMITED";

I1_WP_1 = _Group addWaypoint [getPos _nearRoad1, 3];
I1_WP_1 SetWaypointType "CYCLE";
I1_WP_1 setWaypointBehaviour "SAFE";
I1_WP_1 setWaypointSpeed "LIMITED";
  };
 
 sleep 1;
  
 
if (_Chance > 1) then {
_nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 300 ) ; 
_pos = _nearRoad getRelPos [6, 0];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 10], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;
_Group = createVehicleCrew _V; 
if (_REPSCORE < 7) then {
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [15, 15, 0, false, 6];  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this or (vehicle player) inArea thisTrigger",  " [thisTrigger, 'Sh_155mm_AMOS', 0, 1, 0] spawn BIS_fnc_fireSupportVirtual;", ""]; 
_V addEventHandler ["Killed", { [(_this select 0), "Sh_155mm_AMOS", 0, 1, 0] spawn BIS_fnc_fireSupportVirtual;}]; 


_trg attachTo [_V, [0, 0, 0]]; 
};
sleep 3;

_nearRoad0 = selectRandom (_nearRoad nearRoads 5000 ) ; 
_I1_WP_0 = _Group addWaypoint [getPos _nearRoad0, 0];
_I1_WP_0 SetWaypointType "MOVE";
_I1_WP_0 setWaypointBehaviour "SAFE";
_I1_WP_0 setWaypointSpeed "LIMITED";

_nearRoad1 = selectRandom ( _nearRoad0 nearRoads 5000 ) ; 
_I1_WP_00 = _Group addWaypoint [getPos _nearRoad1, 0];
_I1_WP_00 SetWaypointType "MOVE";
_I1_WP_00 setWaypointBehaviour "SAFE";
_I1_WP_00 setWaypointSpeed "LIMITED";

_I1_WP_1 = _Group addWaypoint [getPos _nearRoad1, 7];
_I1_WP_1 SetWaypointType "CYCLE";
  };


 sleep 1;
 
if (_Chance > 2) then {
_nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 300 ) ; 
_pos = _nearRoad getRelPos [6, 0];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 10], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;
_Group = createVehicleCrew _V; 
if (_REPSCORE < 7) then {
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [15, 15, 0, false, 6];  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this or (vehicle player) inArea thisTrigger",  " [thisTrigger, 'Sh_155mm_AMOS', 0, 1, 0] spawn BIS_fnc_fireSupportVirtual;", ""]; 
_V addEventHandler ["Killed", { [(_this select 0), "Sh_155mm_AMOS", 0, 1, 0] spawn BIS_fnc_fireSupportVirtual;}]; 

_trg attachTo [_V, [0, 0, 0]]; 
};

sleep 3;
_nearRoad0 = selectRandom (_nearRoad nearRoads 5000 ) ; 
_I1_WP_0 = _Group addWaypoint [getPos _nearRoad0, 0];
_I1_WP_0 SetWaypointType "MOVE";
_I1_WP_0 setWaypointBehaviour "SAFE";
_I1_WP_0 setWaypointSpeed "LIMITED";

_nearRoad1 = selectRandom ( _nearRoad0 nearRoads 5000 ) ; 
_I1_WP_00 = _Group addWaypoint [getPos _nearRoad1, 0];
_I1_WP_00 SetWaypointType "MOVE";
_I1_WP_00 setWaypointBehaviour "SAFE";
_I1_WP_00 setWaypointSpeed "LIMITED";

_I1_WP_1 = _Group addWaypoint [getPos _nearRoad1, 7];
_I1_WP_1 SetWaypointType "CYCLE";
  };
  
 ///////////////////////////////////////////////////////////////////////////////
_all = nearestObjects [(getPos thisCityCivTrigger), ["HOUSE"], 20];  
_Buildings = _all select {count (_x buildingPos -1) > 7}; 
{
_Lantern = createVehicle ["Land_Camping_Light_F", [(getPos _x) select 0, (getPos _x) select 1, ((getPos _x) select 2) + 1], [], 0, "NONE"];
} forEach _Buildings;
 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
_allBuildings = nearestObjects [getPos thisCityCivTrigger, ["HOUSE"], 200];  
_allPositions = [];  
_allBuildings apply {_allPositions append (_x buildingPos -1)};  
G_stuff = ["C_UavTerminal","ItemRadio","MobilePhone","Rangefinder","acc_pointer_IR","U_BG_leader","ItemCompass","MineDetector","U_I_FullGhillie_lsh","U_BG_Guerilla1_1","C_UavTerminal","ItemRadio","MobilePhone","Rangefinder","acc_pointer_IR","U_BG_leader","ItemCompass","MineDetector","U_I_FullGhillie_lsh","U_BG_Guerilla1_1","MobilePhone","C_UavTerminal","ItemRadio","MobilePhone","Rangefinder","acc_pointer_IR","U_BG_leader","ItemCompass","MineDetector","U_I_FullGhillie_lsh","U_BG_Guerilla1_1","arifle_Mk20_F","arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F","arifle_Mk20_plain_F","arifle_Mk20C_F","arifle_Mk20C_plain_F","arifle_SDAR_F","arifle_TRG20_F","arifle_TRG21_F","arifle_TRG21_GL_F","hgun_ACPC2_F","hgun_PDW2000_F","hgun_Pistol_Signal_F","launch_I_Titan_F","launch_I_Titan_short_F","launch_NLAW_F","launch_RPG32_F","launch_Titan_F","launch_Titan_short_F","LMG_Mk200_F","srifle_DMR_06_camo_F","srifle_DMR_06_olive_F","srifle_EBR_F","srifle_GM6_camo_F","srifle_GM6_F"];
_M = [allMapMarkers,  thisCityCivTrigger] call BIS_fnc_nearestPosition;


G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "ANIM";
_WHB = (nearestObjects [(getPos ((units G) select 0)), ["HOUSE"], 30]) select 0;  
_POSB = selectRandom (_WHB buildingPos -1) ;
_BARREL = createVehicle ["Land_BarrelEmpty_F",[(_POSB select 0),(_POSB select 1),(_POSB select 2)+0.1], [], 0, "can_Collide"];
sleep 0.5;
_WH = createVehicle ["groundweaponholder",[(_POSB select 0),(_POSB select 1),(getposATL _BARREL select 2)], [], 0, "can_Collide"];
			deletevehicle _BARREL;
_WH addItemCargo [selectRandom G_stuff, 1];
_chance = selectRandom [0, 1, 2] ; if (_chance > 0) then { ((units G) select 0) setUnitTrait ["engineer", true]; };
if (_chance > 1) then { _WHV = (nearestObjects [(getPos ((units G) select 0)), ["LandVehicle"], 50]) select 0; _WHV addItemCargo [selectRandom G_stuff, 1]; ((units G) select 0) setUnitTrait ["engineer", true]; };

G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "ANIM";
if ((markerColor _M == "colorOPFOR") or (_REPSCORE < 7)) then {
_WHB = (nearestObjects [(getPos ((units G) select 0)), ["HOUSE"], 30]) select 0;  
_POSB = selectRandom (_WHB buildingPos -1) ;
_BARREL = createVehicle ["Land_BarrelEmpty_F",[(_POSB select 0),(_POSB select 1),(_POSB select 2)+0.1], [], 0, "can_Collide"];
sleep 0.5;
_WH = createVehicle ["groundweaponholder",[(_POSB select 0),(_POSB select 1),(getposATL _BARREL select 2)], [], 0, "can_Collide"];
			deletevehicle _BARREL;
_WH addItemCargo [selectRandom G_stuff, 1];
_chance = selectRandom [0, 1, 2] ; if (_chance > 0) then { ((units G) select 0) setUnitTrait ["engineer", true]; };
if (_chance > 1) then { _WHV = (nearestObjects [(getPos ((units G) select 0)), ["LandVehicle"], 50]) select 0; _WHV addItemCargo [selectRandom G_stuff, 1]; ((units G) select 0) setUnitTrait ["engineer", true]; };
};

G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "ANIM";
if ((markerColor _M == "colorOPFOR") or (_REPSCORE < 5)) then {
_WHB = (nearestObjects [(getPos ((units G) select 0)), ["HOUSE"], 30]) select 0;  
_POSB = selectRandom (_WHB buildingPos -1) ;
_BARREL = createVehicle ["Land_BarrelEmpty_F",[(_POSB select 0),(_POSB select 1),(_POSB select 2)+0.1], [], 0, "can_Collide"];
sleep 0.5;
_WH = createVehicle ["groundweaponholder",[(_POSB select 0),(_POSB select 1),(getposATL _BARREL select 2)], [], 0, "can_Collide"];
			deletevehicle _BARREL;
_WH addItemCargo [selectRandom G_stuff, 1];
_chance = selectRandom [0, 1, 2] ; if (_chance > 0) then { ((units G) select 0) setUnitTrait ["engineer", true]; };
if (_chance > 1) then { _WHV = (nearestObjects [(getPos ((units G) select 0)), ["LandVehicle"], 50]) select 0; _WHV addItemCargo [selectRandom G_stuff, 1]; ((units G) select 0) setUnitTrait ["engineer", true]; };
};

G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "ANIM";
if ((markerColor _M == "colorOPFOR") or (_REPSCORE < 5)) then {
_WHB = (nearestObjects [(getPos ((units G) select 0)), ["HOUSE"], 30]) select 0;  
_POSB = selectRandom (_WHB buildingPos -1) ;
_BARREL = createVehicle ["Land_BarrelEmpty_F",[(_POSB select 0),(_POSB select 1),(_POSB select 2)+0.1], [], 0, "can_Collide"];
sleep 0.5;
_WH = createVehicle ["groundweaponholder",[(_POSB select 0),(_POSB select 1),(getposATL _BARREL select 2)], [], 0, "can_Collide"];
			deletevehicle _BARREL;
_WH addItemCargo [selectRandom G_stuff, 1];
_chance = selectRandom [0, 1, 2] ; if (_chance > 0) then { ((units G) select 0) setUnitTrait ["engineer", true]; };
if (_chance > 1) then { _WHV = (nearestObjects [(getPos ((units G) select 0)), ["LandVehicle"], 50]) select 0; _WHV addItemCargo [selectRandom G_stuff, 1]; ((units G) select 0) setUnitTrait ["engineer", true]; };
};

G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "ANIM";

G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "ANIM";

G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "ANIM";




if ((markerColor _M == "colorOPFOR") or (_REPSCORE < 7)) then {
G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "MOVE";
((units G) select 0) enableAI "ANIM";
((units G) select 0) enableAI "PATH";
((units G) select 0) enableAI "TEAMSWITCH";  
((units G) select 0) setUnitTrait ["engineer", true];
[G,thisCityCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], (100 + (random 250))] call BIS_fnc_taskPatrol;
G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "MOVE";
((units G) select 0) enableAI "ANIM";
((units G) select 0) enableAI "PATH";  
((units G) select 0) enableAI "TEAMSWITCH";  
((units G) select 0) setUnitTrait ["engineer", true];
[G,thisCityCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], (100 + (random 250))] call BIS_fnc_taskPatrol;
};


G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "MOVE";
((units G) select 0) enableAI "ANIM";
((units G) select 0) enableAI "PATH";  
((units G) select 0) enableAI "TEAMSWITCH";  
[G,thisCityCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], (100 + (random 250))] call BIS_fnc_taskPatrol;
G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "MOVE";
((units G) select 0) enableAI "ANIM";
((units G) select 0) enableAI "PATH";  
((units G) select 0) enableAI "TEAMSWITCH";  
[G,thisCityCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], (100 + (random 250))] call BIS_fnc_taskPatrol;
G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "MOVE";
((units G) select 0) enableAI "ANIM";
((units G) select 0) enableAI "PATH";  
((units G) select 0) enableAI "TEAMSWITCH";  
[G,thisCityCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], (100 + (random 250))] call BIS_fnc_taskPatrol;
G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;   
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "MOVE";
((units G) select 0) enableAI "ANIM";
((units G) select 0) enableAI "PATH";    
((units G) select 0) enableAI "TEAMSWITCH";  
[G,thisCityCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], (100 + (random 250))] call BIS_fnc_taskPatrol;
G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;   
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "MOVE";
((units G) select 0) enableAI "ANIM";
((units G) select 0) enableAI "PATH";    
((units G) select 0) enableAI "TEAMSWITCH";  
[G,thisCityCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], (100 + (random 250))] call BIS_fnc_taskPatrol;

 	   _allZoneMarks = allMapMarkers select {markerType _x == "n_installation" || markerType _x == "o_installation" || markerType _x == "o_antiair" || markerType _x == "o_service" || markerType _x == "o_armor" || markerType _x == "loc_Power" || markerType _x == "o_recon" || markerType _x == "o_support" || markerType _x == "n_support" || markerType _x == "loc_Ruin" } ;  
       _MMM = [_allZoneMarks,  thisCityCivTrigger] call BIS_fnc_nearestPosition ;


if (((getMarkerPos _MMM) distance (getPos thisCityCivTrigger)) < 1500) then {


if ((_REPSCORE > 10) or (_REPSCORE < 7)) then {


G = [selectRandom _allPositions, independent,[selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     

G = [selectRandom _allPositions, independent,[selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
[G,thisCityCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], 90] call BIS_fnc_taskPatrol;

G = [selectRandom _allPositions, independent,[selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
[G,thisCityCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], 90] call BIS_fnc_taskPatrol;

G = [selectRandom _allPositions, independent,[selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
[G,thisCityCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], 90] call BIS_fnc_taskPatrol;
};

if ((_REPSCORE > 12) or (_REPSCORE < 5)) then {


G = [selectRandom _allPositions, independent,[selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     

G = [selectRandom _allPositions, independent,[selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
[G,thisCityCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], 90] call BIS_fnc_taskPatrol;

G = [selectRandom _allPositions, independent,[selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
[G,thisCityCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], 90] call BIS_fnc_taskPatrol;

G = [selectRandom _allPositions, independent,[selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
[G,thisCityCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], 90] call BIS_fnc_taskPatrol;
};

if (_REPSCORE < 7) then {
_nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 100 ) ; 
_RoadSide =  selectRandom [0, 180] ;
_pos = _nearRoad getRelPos [8, _RoadSide];
_Clutter = createVehicle [selectRandom _Clutters, _pos, [], (0 + (random 3)), "CAN_COLLIDE"] ;
_IED = createMine [selectRandom _IEDs,  _pos, [], 0];
_Clutter setVectorUp [0,0,1];
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [10, 10, 0, false, 4];  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this && stance player != 'PRONE' ", " [thisTrigger, 'Sh_82mm_AMOS', 0, 1, 0, false, 0, 10, ['']] spawn BIS_fnc_fireSupportVirtual;", ""]; 

_nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 100 ) ; 
_RoadSide =  selectRandom [0, 180] ;
_pos = _nearRoad getRelPos [8, _RoadSide];
_Clutter = createVehicle [selectRandom _Clutters, _pos, [], (0 + (random 3)), "CAN_COLLIDE"] ;
_IED = createMine [selectRandom _IEDs,  _pos, [], 0];
_Clutter setVectorUp [0,0,1];
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [10, 10, 0, false, 4];  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this && stance player != 'PRONE' ", " [thisTrigger, 'Sh_82mm_AMOS', 0, 1, 0, false, 0, 10, ['']] spawn BIS_fnc_fireSupportVirtual;", ""]; 

_nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 100 ) ; 
_RoadSide =  selectRandom [0, 180] ;
_pos = _nearRoad getRelPos [8, _RoadSide];
_Clutter = createVehicle [selectRandom _Clutters, _pos, [], (0 + (random 3)), "CAN_COLLIDE"] ;
_IED = createMine [selectRandom _IEDs,  _pos, [], 0];
_Clutter setVectorUp [0,0,1];
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [10, 10, 0, false, 4];  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this && stance player != 'PRONE' ", " [thisTrigger, 'Sh_82mm_AMOS', 0, 1, 0, false, 0, 10, ['']] spawn BIS_fnc_fireSupportVirtual;", ""]; 

_nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 100 ) ; 
_RoadSide =  selectRandom [0, 180] ;
_pos = _nearRoad getRelPos [8, _RoadSide];
_Clutter = createVehicle [selectRandom _Clutters, _pos, [], (0 + (random 3)), "CAN_COLLIDE"] ;
_IED = createMine [selectRandom _IEDs,  _pos, [], 0];
_Clutter setVectorUp [0,0,1];
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [10, 10, 0, false, 4];  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this && stance player != 'PRONE' ", " [thisTrigger, 'Sh_82mm_AMOS', 0, 1, 0, false, 0, 10, ['']] spawn BIS_fnc_fireSupportVirtual;", ""]; 

if (_REPSCORE < 5) then {

_nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 100 ) ; 
_RoadSide =  selectRandom [0, 180] ;
_pos = _nearRoad getRelPos [8, _RoadSide];
_Clutter = createVehicle [selectRandom _Clutters, _pos, [], (0 + (random 3)), "CAN_COLLIDE"] ;
_IED = createMine [selectRandom _IEDs,  _pos, [], 0];
_Clutter setVectorUp [0,0,1];
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [10, 10, 0, false, 4];  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this && stance player != 'PRONE' ", " [thisTrigger, 'Sh_82mm_AMOS', 0, 1, 0, false, 0, 10, ['']] spawn BIS_fnc_fireSupportVirtual;", ""]; 


	
_nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 100 ) ; 
_RoadSide =  selectRandom [0, 180] ;
_pos = _nearRoad getRelPos [8, _RoadSide];
_Clutter = createVehicle [selectRandom _Clutters, _pos, [], (0 + (random 3)), "CAN_COLLIDE"] ;
_IED = createMine [selectRandom _IEDs,  _pos, [], 0];
_Clutter setVectorUp [0,0,1];
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [10, 10, 0, false, 4];  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this && stance player != 'PRONE' ", " [thisTrigger, 'Sh_82mm_AMOS', 0, 1, 0, false, 0, 10, ['']] spawn BIS_fnc_fireSupportVirtual;", ""]; 



_nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 100 ) ; 
_RoadSide =  selectRandom [0, 180] ;
_pos = _nearRoad getRelPos [8, _RoadSide];
_Clutter = createVehicle [selectRandom _Clutters, _pos, [], (0 + (random 3)), "CAN_COLLIDE"] ;
_IED = createMine [selectRandom _IEDs,  _pos, [], 0];
_Clutter setVectorUp [0,0,1];
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [10, 10, 0, false, 4];  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this && stance player != 'PRONE' ", " [thisTrigger, 'Sh_82mm_AMOS', 0, 1, 0, false, 0, 10, ['']] spawn BIS_fnc_fireSupportVirtual;", ""]; 



_nearRoad = selectRandom ((getpos thisCityCivTrigger) nearRoads 100 ) ; 
_RoadSide =  selectRandom [0, 180] ;
_pos = _nearRoad getRelPos [8, _RoadSide];
_Clutter = createVehicle [selectRandom _Clutters, _pos, [], (0 + (random 3)), "CAN_COLLIDE"] ;
_IED = createMine [selectRandom _IEDs,  _pos, [], 0];
_Clutter setVectorUp [0,0,1];
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [10, 10, 0, false, 4];  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this && stance player != 'PRONE' ", " [thisTrigger, 'Sh_82mm_AMOS', 0, 1, 0, false, 0, 10, ['']] spawn BIS_fnc_fireSupportVirtual;", ""]; 

    };
};

};

////////////////////NIGHTLIFE////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  if ((dayTime < 19) && (dayTime > 7)) then { {_x hideObjectGlobal false; _x enableSimulationGlobal true; } foreach (allUnits select {side _x == civilian && _x checkAIFeature "PATH" == true}) ; } ; 
  if ((dayTime > 19) or (dayTime < 7)) then { {_x hideObjectGlobal true; _x enableSimulationGlobal false; } foreach (allUnits select {side _x == civilian && _x checkAIFeature "PATH" == true}) ; } ; 

////////////////////NIGHTLIFE////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


sleep 5;


execVM "Scripts\Civ_Relations.sqf";

{

_nvg = hmd _x;
 _x unassignItem _nvg;
 _x removeItem _nvg;
	  _x addPrimaryWeaponItem "acc_flashlight";
	  _x assignItem "acc_flashlight";
	  _x enableGunLights "ForceOn";
  } foreach (allUnits select {side _x != west}); 

 