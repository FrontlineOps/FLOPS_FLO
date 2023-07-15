 
thisTownCivTrigger = _this select 0;
_Chance = selectRandom [1, 2, 3]; 
_mrkrs = allMapMarkers select {markerColor _x == "Color4_FD_F"};
_mrkr = _mrkrs select 0;
_REPSCORE = parseNumber (markerText _mrkr) ;  


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_allBuildings = nearestObjects [(getPos thisTownCivTrigger), ["HOUSE"], 80];   
 
{ 
_x removeAllEventHandlers "Killed"; 
_x addEventHandler ["Killed", { 

[] execVM "Scripts\ReputationMinus.sqf";
[] execVM "Scripts\Civ_Relations.sqf";

}]; 
} forEach _allBuildings;

 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 if (_Chance > 0) then {
 _nearRoad = selectRandom ((getpos thisTownCivTrigger) nearRoads 100 ) ; 
_pos = _nearRoad getRelPos [6, selectRandom [90, -90]];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 5], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;



 _nearRoad = selectRandom ((getpos thisTownCivTrigger) nearRoads 100 ) ; 
_pos = _nearRoad getRelPos [6, selectRandom [90, -90]];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 5], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;

 };

sleep 1;

  if (_Chance > 1) then {
 _nearRoad = selectRandom ((getpos thisTownCivTrigger) nearRoads 100 ) ; 
_pos = _nearRoad getRelPos [6, selectRandom [90, -90]];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 5], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;

 _nearRoad = selectRandom ((getpos thisTownCivTrigger) nearRoads 2000 ) ; 
_pos = _nearRoad getRelPos [6, selectRandom [90, -90]];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 5], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;

 };
sleep 1;
  if (_Chance > 2) then {
 _nearRoad = selectRandom ((getpos thisTownCivTrigger) nearRoads 100 ) ; 
_pos = _nearRoad getRelPos [6, selectRandom [90, -90]];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 5], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;

 _nearRoad = selectRandom ((getpos thisTownCivTrigger) nearRoads 2000 ) ; 
_pos = _nearRoad getRelPos [6, selectRandom [90, -90]];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 5], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;
 
 };
sleep 1;
  if (_Chance > 1) then {
_nearRoad = selectRandom ((getpos thisTownCivTrigger) nearRoads 100 ) ; 
_pos = _nearRoad getRelPos [6, selectRandom [90, -90]];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 5], [], 0, "CAN_COLLIDE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;
_Group = createVehicleCrew _V; 

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
_nearRoad = selectRandom ((getpos thisTownCivTrigger) nearRoads 100 ) ; 
_pos = _nearRoad getRelPos [6, selectRandom [90, -90]];
_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 5], [], 0, "CAN_COLLIDE"]; 

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
//////////////////////////////////////////////////////////////////////////////
_all = nearestObjects [(getPos thisTownCivTrigger), ["HOUSE"], 20];  
_Buildings = _all select {count (_x buildingPos -1) > 4}; 
{
_Lantern = createVehicle ["Land_Camping_Light_F", [(getPos _x) select 0, (getPos _x) select 1, ((getPos _x) select 2) + 1], [], 0, "NONE"];
} forEach _Buildings;
 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
_allBuildings = nearestObjects [(getPos thisTownCivTrigger), ["HOUSE"], 80];  
_allPositions = [];  
_allBuildings apply {_allPositions append (_x buildingPos -1)};  
G_stuff = ["C_UavTerminal","ItemRadio","MobilePhone","Rangefinder","acc_pointer_IR","U_BG_leader","ItemCompass","MineDetector","U_I_FullGhillie_lsh","U_BG_Guerilla1_1","C_UavTerminal","ItemRadio","MobilePhone","Rangefinder","acc_pointer_IR","U_BG_leader","ItemCompass","MineDetector","U_I_FullGhillie_lsh","U_BG_Guerilla1_1","MobilePhone","C_UavTerminal","ItemRadio","MobilePhone","Rangefinder","acc_pointer_IR","U_BG_leader","ItemCompass","MineDetector","U_I_FullGhillie_lsh","U_BG_Guerilla1_1","arifle_Mk20_F","arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F","arifle_Mk20_plain_F","arifle_Mk20C_F","arifle_Mk20C_plain_F","arifle_SDAR_F","arifle_TRG20_F","arifle_TRG21_F","arifle_TRG21_GL_F","hgun_ACPC2_F","hgun_PDW2000_F","hgun_Pistol_Signal_F","launch_I_Titan_F","launch_I_Titan_short_F","launch_NLAW_F","launch_RPG32_F","launch_Titan_F","launch_Titan_short_F","LMG_Mk200_F","srifle_DMR_06_camo_F","srifle_DMR_06_olive_F","srifle_EBR_F","srifle_GM6_camo_F","srifle_GM6_F"];
_M = [allMapMarkers,  thisTownCivTrigger] call BIS_fnc_nearestPosition;


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
if (_chance > 1) then { _WHV = (nearestObjects [(getPos ((units G) select 0)), ["LandVehicle"], 30]) select 0; _WHV addItemCargo [selectRandom G_stuff, 1]; ((units G) select 0) setUnitTrait ["engineer", true]; };

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
if (_chance > 1) then { _WHV = (nearestObjects [(getPos ((units G) select 0)), ["LandVehicle"], 30]) select 0; _WHV addItemCargo [selectRandom G_stuff, 1]; ((units G) select 0) setUnitTrait ["engineer", true]; };
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
if (_chance > 1) then { _WHV = (nearestObjects [(getPos ((units G) select 0)), ["LandVehicle"], 30]) select 0; _WHV addItemCargo [selectRandom G_stuff, 1]; ((units G) select 0) setUnitTrait ["engineer", true]; };
};


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
[G,thisTownCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], 90] call BIS_fnc_taskPatrol;
};

G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "MOVE";
((units G) select 0) enableAI "ANIM";
((units G) select 0) enableAI "PATH";  
((units G) select 0) enableAI "TEAMSWITCH";  
[G,thisTownCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], 90] call BIS_fnc_taskPatrol;

G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;   
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "MOVE";
((units G) select 0) enableAI "ANIM";
((units G) select 0) enableAI "PATH";    
((units G) select 0) enableAI "TEAMSWITCH";  
[G,thisTownCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], 90] call BIS_fnc_taskPatrol;

G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;    
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "MOVE";
((units G) select 0) enableAI "ANIM";
((units G) select 0) enableAI "PATH";   
((units G) select 0) enableAI "TEAMSWITCH";  
[G,thisTownCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], 90] call BIS_fnc_taskPatrol;

G = [selectRandom _allPositions, civilian,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;   
((units G) select 0) disableAI "all";
((units G) select 0) enableAI "MOVE";
((units G) select 0) enableAI "ANIM";
((units G) select 0) enableAI "PATH";    
((units G) select 0) enableAI "TEAMSWITCH";  
[G,thisTownCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], 90] call BIS_fnc_taskPatrol;


 	   _allZoneMarks = allMapMarkers select {markerType _x == "n_installation" || markerType _x == "o_installation" || markerType _x == "o_antiair" || markerType _x == "o_service" || markerType _x == "o_armor" || markerType _x == "loc_Power" || markerType _x == "o_recon" || markerType _x == "o_support" || markerType _x == "n_support" || markerType _x == "loc_Ruin" } ;  
       _MMM = [_allZoneMarks,  thisTownCivTrigger] call BIS_fnc_nearestPosition ;


if (((getMarkerPos _MMM) distance (getPos thisTownCivTrigger)) < 1500) then {


_IEDs = ["IEDUrbanSmall_F","IEDUrbanBig_F","IEDLandSmall_F","IEDLandBig_F"] ;
_Clutters = ["Land_Garbage_square3_F","Land_Garbage_square3_F","Land_Garbage_line_F","Land_Garbage_line_F", "Land_Garbage_line_F"] ;


	
if ((_REPSCORE > 10) or (_REPSCORE < 7)) then {

G = [selectRandom _allPositions, independent,[selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     

G = [selectRandom _allPositions, independent,[selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
[G,thisTownCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], 90] call BIS_fnc_taskPatrol;

G = [selectRandom _allPositions, independent,[selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
[G,thisTownCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], 90] call BIS_fnc_taskPatrol;

};

if ((_REPSCORE > 12) or (_REPSCORE < 5)) then {

G = [selectRandom _allPositions, independent,[selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     

G = [selectRandom _allPositions, independent,[selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
[G,thisTownCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], 90] call BIS_fnc_taskPatrol;

G = [selectRandom _allPositions, independent,[selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
[G,thisTownCivTrigger getPos [(0 + (random 100)), (0 + (random 350))], 90] call BIS_fnc_taskPatrol;
};

if (_REPSCORE < 7) then {
	
	
_nearRoad = selectRandom ((getpos thisTownCivTrigger) nearRoads 100 ) ; 
_RoadSide =  selectRandom [0, 180] ;
_pos = _nearRoad getRelPos [8, _RoadSide];
_Clutter = createVehicle [selectRandom _Clutters, _pos, [], (0 + (random 2)), "CAN_COLLIDE"] ;
_IED = createMine [selectRandom _IEDs,  _pos, [], 0];
_Clutter setVectorUp [0,0,1];
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [10, 10, 0, false, 4];  
_trg setTriggerInterval 1;  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this && stance player != 'PRONE' ", " 
[(getPos thisTrigger)] execVM 'Scripts\IEDEXP.sqf' ; 

_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {triggerInterval _x == 2 && getPos _x distance thisTrigger < 7};
_referencePos = getPos thisTrigger; 
_sortedByRange = [_triggers,[],{_referencePos distanceSqr getPos _x},'ASCEND'] call BIS_fnc_sortBy;
_sortedByRange params ['_nearesttrigger'];
deleteVehicle _nearesttrigger;
deleteVehicle thisTrigger;
", ""]; 

_DisArmT = createTrigger ["EmptyDetector",_pos];  
_DisArmT setTriggerArea [5, 5, 0, false, 5];  
_DisArmT setTriggerInterval 2;  
_DisArmT setTriggerActivation ["ANYPLAYER", "PRESENT", false];  
_DisArmT setTriggerStatements [  
"count (allMines select {position _x inArea thisTrigger}) == 0",  
"
_MMarks = allMapMarkers select { markerType _x == 'hd_unknown' && markerPos _x inArea thisTrigger};
if (count _MMarks> 0) then {deleteMarker (_MMarks select 0) } ;
				[70, 'IED'] execVM 'Scripts\NOtification.sqf' ;
[70] execVM 'Scripts\Reward.sqf';
[] execVM 'Scripts\ReputationPlus.sqf';
execVM 'Scripts\Civ_Relations.sqf';

_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {triggerInterval _x == 1 && getPos _x distance thisTrigger < 7};
_referencePos = getPos thisTrigger; 
_sortedByRange = [_triggers,[],{_referencePos distanceSqr getPos _x},'ASCEND'] call BIS_fnc_sortBy;
_sortedByRange params ['_nearesttrigger'];
deleteVehicle _nearesttrigger;
deleteVehicle thisTrigger;

", ""];



	
_nearRoad = selectRandom ((getpos thisTownCivTrigger) nearRoads 100 ) ; 
_RoadSide =  selectRandom [0, 180] ;
_pos = _nearRoad getRelPos [8, _RoadSide];
_Clutter = createVehicle [selectRandom _Clutters, _pos, [], (0 + (random 2)), "CAN_COLLIDE"] ;
_IED = createMine [selectRandom _IEDs,  _pos, [], 0];
_Clutter setVectorUp [0,0,1];
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [10, 10, 0, false, 4];  
_trg setTriggerInterval 1;  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this && stance player != 'PRONE' ", " 
[(getPos thisTrigger)] execVM 'Scripts\IEDEXP.sqf' ; 

_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {triggerInterval _x == 2 && getPos _x distance thisTrigger < 7};
_referencePos = getPos thisTrigger; 
_sortedByRange = [_triggers,[],{_referencePos distanceSqr getPos _x},'ASCEND'] call BIS_fnc_sortBy;
_sortedByRange params ['_nearesttrigger'];
deleteVehicle _nearesttrigger;
deleteVehicle thisTrigger;
", ""]; 

_DisArmT = createTrigger ["EmptyDetector",_pos];  
_DisArmT setTriggerArea [5, 5, 0, false, 5];  
_DisArmT setTriggerInterval 2;  
_DisArmT setTriggerActivation ["ANYPLAYER", "PRESENT", false];  
_DisArmT setTriggerStatements [  
"count (allMines select {position _x inArea thisTrigger}) == 0",  
"
_MMarks = allMapMarkers select { markerType _x == 'hd_unknown' && markerPos _x inArea thisTrigger};
if (count _MMarks> 0) then {deleteMarker (_MMarks select 0) } ;
				[70, 'IED'] execVM 'Scripts\NOtification.sqf' ;
[70] execVM 'Scripts\Reward.sqf';
[] execVM 'Scripts\ReputationPlus.sqf';
execVM 'Scripts\Civ_Relations.sqf';

_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {triggerInterval _x == 1 && getPos _x distance thisTrigger < 7};
_referencePos = getPos thisTrigger; 
_sortedByRange = [_triggers,[],{_referencePos distanceSqr getPos _x},'ASCEND'] call BIS_fnc_sortBy;
_sortedByRange params ['_nearesttrigger'];
deleteVehicle _nearesttrigger;
deleteVehicle thisTrigger;

", ""];


	
_nearRoad = selectRandom ((getpos thisTownCivTrigger) nearRoads 100 ) ; 
_RoadSide =  selectRandom [0, 180] ;
_pos = _nearRoad getRelPos [8, _RoadSide];
_Clutter = createVehicle [selectRandom _Clutters, _pos, [], (0 + (random 2)), "CAN_COLLIDE"] ;
_IED = createMine [selectRandom _IEDs,  _pos, [], 0];
_Clutter setVectorUp [0,0,1];
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [10, 10, 0, false, 4];  
_trg setTriggerInterval 1;  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this && stance player != 'PRONE' ", " 
[(getPos thisTrigger)] execVM 'Scripts\IEDEXP.sqf' ; 

_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {triggerInterval _x == 2 && getPos _x distance thisTrigger < 7};
_referencePos = getPos thisTrigger; 
_sortedByRange = [_triggers,[],{_referencePos distanceSqr getPos _x},'ASCEND'] call BIS_fnc_sortBy;
_sortedByRange params ['_nearesttrigger'];
deleteVehicle _nearesttrigger;
deleteVehicle thisTrigger;
", ""]; 

_DisArmT = createTrigger ["EmptyDetector",_pos];  
_DisArmT setTriggerArea [5, 5, 0, false, 5];  
_DisArmT setTriggerInterval 2;  
_DisArmT setTriggerActivation ["ANYPLAYER", "PRESENT", false];  
_DisArmT setTriggerStatements [  
"count (allMines select {position _x inArea thisTrigger}) == 0",  
"
_MMarks = allMapMarkers select { markerType _x == 'hd_unknown' && markerPos _x inArea thisTrigger};
if (count _MMarks> 0) then {deleteMarker (_MMarks select 0) } ;
				[70, 'IED'] execVM 'Scripts\NOtification.sqf' ;
[70] execVM 'Scripts\Reward.sqf';
[] execVM 'Scripts\ReputationPlus.sqf';
execVM 'Scripts\Civ_Relations.sqf';

_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {triggerInterval _x == 1 && getPos _x distance thisTrigger < 7};
_referencePos = getPos thisTrigger; 
_sortedByRange = [_triggers,[],{_referencePos distanceSqr getPos _x},'ASCEND'] call BIS_fnc_sortBy;
_sortedByRange params ['_nearesttrigger'];
deleteVehicle _nearesttrigger;
deleteVehicle thisTrigger;

", ""];


if (_REPSCORE < 5) then {

	
_nearRoad = selectRandom ((getpos thisTownCivTrigger) nearRoads 100 ) ; 
_RoadSide =  selectRandom [0, 180] ;
_pos = _nearRoad getRelPos [8, _RoadSide];
_Clutter = createVehicle [selectRandom _Clutters, _pos, [], (0 + (random 2)), "CAN_COLLIDE"] ;
_IED = createMine [selectRandom _IEDs,  _pos, [], 0];
_Clutter setVectorUp [0,0,1];
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [10, 10, 0, false, 4];  
_trg setTriggerInterval 1;  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this && stance player != 'PRONE' ", " 
[(getPos thisTrigger)] execVM 'Scripts\IEDEXP.sqf' ; 

_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {triggerInterval _x == 2 && getPos _x distance thisTrigger < 7};
_referencePos = getPos thisTrigger; 
_sortedByRange = [_triggers,[],{_referencePos distanceSqr getPos _x},'ASCEND'] call BIS_fnc_sortBy;
_sortedByRange params ['_nearesttrigger'];
deleteVehicle _nearesttrigger;
deleteVehicle thisTrigger;
", ""]; 

_DisArmT = createTrigger ["EmptyDetector",_pos];  
_DisArmT setTriggerArea [5, 5, 0, false, 5];  
_DisArmT setTriggerInterval 2;  
_DisArmT setTriggerActivation ["ANYPLAYER", "PRESENT", false];  
_DisArmT setTriggerStatements [  
"count (allMines select {position _x inArea thisTrigger}) == 0",  
"
_MMarks = allMapMarkers select { markerType _x == 'hd_unknown' && markerPos _x inArea thisTrigger};
if (count _MMarks> 0) then {deleteMarker (_MMarks select 0) } ;
				[70, 'IED'] execVM 'Scripts\NOtification.sqf' ;
[70] execVM 'Scripts\Reward.sqf';
[] execVM 'Scripts\ReputationPlus.sqf';
execVM 'Scripts\Civ_Relations.sqf';

_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {triggerInterval _x == 1 && getPos _x distance thisTrigger < 7};
_referencePos = getPos thisTrigger; 
_sortedByRange = [_triggers,[],{_referencePos distanceSqr getPos _x},'ASCEND'] call BIS_fnc_sortBy;
_sortedByRange params ['_nearesttrigger'];
deleteVehicle _nearesttrigger;
deleteVehicle thisTrigger;

", ""];


	
_nearRoad = selectRandom ((getpos thisTownCivTrigger) nearRoads 100 ) ; 
_RoadSide =  selectRandom [0, 180] ;
_pos = _nearRoad getRelPos [8, _RoadSide];
_Clutter = createVehicle [selectRandom _Clutters, _pos, [], (0 + (random 2)), "CAN_COLLIDE"] ;
_IED = createMine [selectRandom _IEDs,  _pos, [], 0];
_Clutter setVectorUp [0,0,1];
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [10, 10, 0, false, 4];  
_trg setTriggerInterval 1;  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this && stance player != 'PRONE' ", " 
[(getPos thisTrigger)] execVM 'Scripts\IEDEXP.sqf' ; 

_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {triggerInterval _x == 2 && getPos _x distance thisTrigger < 7};
_referencePos = getPos thisTrigger; 
_sortedByRange = [_triggers,[],{_referencePos distanceSqr getPos _x},'ASCEND'] call BIS_fnc_sortBy;
_sortedByRange params ['_nearesttrigger'];
deleteVehicle _nearesttrigger;
deleteVehicle thisTrigger;
", ""]; 

_DisArmT = createTrigger ["EmptyDetector",_pos];  
_DisArmT setTriggerArea [5, 5, 0, false, 5];  
_DisArmT setTriggerInterval 2;  
_DisArmT setTriggerActivation ["ANYPLAYER", "PRESENT", false];  
_DisArmT setTriggerStatements [  
"count (allMines select {position _x inArea thisTrigger}) == 0",  
"
_MMarks = allMapMarkers select { markerType _x == 'hd_unknown' && markerPos _x inArea thisTrigger};
if (count _MMarks> 0) then {deleteMarker (_MMarks select 0) } ;
				[70, 'IED'] execVM 'Scripts\NOtification.sqf' ;
[70] execVM 'Scripts\Reward.sqf';
[] execVM 'Scripts\ReputationPlus.sqf';
execVM 'Scripts\Civ_Relations.sqf';

_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {triggerInterval _x == 1 && getPos _x distance thisTrigger < 7};
_referencePos = getPos thisTrigger; 
_sortedByRange = [_triggers,[],{_referencePos distanceSqr getPos _x},'ASCEND'] call BIS_fnc_sortBy;
_sortedByRange params ['_nearesttrigger'];
deleteVehicle _nearesttrigger;
deleteVehicle thisTrigger;

", ""];


	
_nearRoad = selectRandom ((getpos thisTownCivTrigger) nearRoads 100 ) ; 
_RoadSide =  selectRandom [0, 180] ;
_pos = _nearRoad getRelPos [8, _RoadSide];
_Clutter = createVehicle [selectRandom _Clutters, _pos, [], (0 + (random 2)), "CAN_COLLIDE"] ;
_IED = createMine [selectRandom _IEDs,  _pos, [], 0];
_Clutter setVectorUp [0,0,1];
_trg = createTrigger ["EmptyDetector", _pos];  
_trg setTriggerArea [10, 10, 0, false, 4];  
_trg setTriggerInterval 1;  
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this && stance player != 'PRONE' ", " 

[(getPos thisTrigger)] execVM 'Scripts\IEDEXP.sqf' ; 

_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {triggerInterval _x == 2 && getPos _x distance thisTrigger < 7};
_referencePos = getPos thisTrigger; 
_sortedByRange = [_triggers,[],{_referencePos distanceSqr getPos _x},'ASCEND'] call BIS_fnc_sortBy;
_sortedByRange params ['_nearesttrigger'];
deleteVehicle _nearesttrigger;
deleteVehicle thisTrigger;
", ""]; 

_DisArmT = createTrigger ["EmptyDetector",_pos];  
_DisArmT setTriggerArea [5, 5, 0, false, 5];  
_DisArmT setTriggerInterval 2;  
_DisArmT setTriggerActivation ["ANYPLAYER", "PRESENT", false];  
_DisArmT setTriggerStatements [  
"count (allMines select {position _x inArea thisTrigger}) == 0",  
"
_MMarks = allMapMarkers select { markerType _x == 'hd_unknown' && markerPos _x inArea thisTrigger};
if (count _MMarks> 0) then {deleteMarker (_MMarks select 0) } ;
				[70, 'IED'] execVM 'Scripts\NOtification.sqf' ;
[70] execVM 'Scripts\Reward.sqf';
[] execVM 'Scripts\ReputationPlus.sqf';
execVM 'Scripts\Civ_Relations.sqf';

_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {triggerInterval _x == 1 && getPos _x distance thisTrigger < 7};
_referencePos = getPos thisTrigger; 
_sortedByRange = [_triggers,[],{_referencePos distanceSqr getPos _x},'ASCEND'] call BIS_fnc_sortBy;
_sortedByRange params ['_nearesttrigger'];
deleteVehicle _nearesttrigger;
deleteVehicle thisTrigger;

", ""];

    };
};

};

////////////////////NIGHTLIFE////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if ((dayTime < 19) && (dayTime > 7)) then { {_x hideObjectGlobal false; _x enableSimulationGlobal true; } foreach (allUnits select {side _x == civilian && _x checkAIFeature "PATH" == true}) ; } ; 
  if ((dayTime > 19) or (dayTime < 7)) then { {_x hideObjectGlobal true; _x enableSimulationGlobal false; } foreach (allUnits select {side _x == civilian && _x checkAIFeature "PATH" == true}) ; } ; 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 

 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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



