

thisRoadPostTrigger = _this select 0;

_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_DANSCORE = parseNumber (markerText _mrkr) ; 

sleep 15 ; 

_TERR = nearestTerrainObjects [(getpos thisRoadPostTrigger), ["House", "TREE", "SMALL TREE", "BUSH", "ROCK", "ROCKS"], 15]; 
{[_x, true] remoteExec ['hideObjectGlobal', 0];} forEach _TERR ;





G = [thisRoadPostTrigger getPos [(0 + (random 70)),(0 + (random 360))], East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
((units G) select 0) disableAI "PATH";   
			G deleteGroupWhenEmpty true;

G = [thisRoadPostTrigger getPos [(0 + (random 70)),(0 + (random 360))], East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
			G deleteGroupWhenEmpty true;

if (_DANSCORE > 5) then {
G = [thisRoadPostTrigger getPos [(0 + (random 70)),(0 + (random 360))], East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
((units G) select 0) disableAI "PATH"; 
			G deleteGroupWhenEmpty true;
  
G = [thisRoadPostTrigger getPos [(0 + (random 70)),(0 + (random 360))], East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
			G deleteGroupWhenEmpty true;

};

if (_DANSCORE > 10) then {
G = [thisRoadPostTrigger getPos [(0 + (random 70)),(0 + (random 360))], East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
((units G) select 0) disableAI "PATH";   
			G deleteGroupWhenEmpty true;
G = [thisRoadPostTrigger getPos [(0 + (random 70)),(0 + (random 360))], East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
			G deleteGroupWhenEmpty true;
};

_allBuildings = nearestObjects [(getpos thisRoadPostTrigger), ["House" , "Land_BagBunker_Large_F", "Land_BagBunker_Small_F", "Land_Cargo_House_V3_F", "Land_Cargo_House_V1_F"], 50];  
_allPositions = [];  
_allBuildings apply {_allPositions append (_x buildingPos -1)}; 
 
 _CRT = [
"Box_IND_WpsSpecial_F",
"Box_IND_WpsSpecial_F",
"Box_East_WpsSpecial_F",
"Box_East_WpsSpecial_F",
"Box_IND_Support_F",
"Box_IND_Support_F",
"Box_IND_Support_F",
"Box_East_Support_F",
"Box_East_Support_F",
"Box_East_Support_F",
"Box_CSAT_Equip_F",
"Box_AAF_Equip_F",
"Box_East_WpsLaunch_F",
"Box_East_WpsLaunch_F",
"Box_IND_WpsLaunch_F",
"Box_IND_WpsLaunch_F",
"Box_East_AmmoOrd_F",
"Box_East_Ammo_F",
"Box_IND_Ammo_F",
"Box_IND_AmmoOrd_F",
"Box_East_Wps_F",
"Box_IND_Wps_F"
];
 
_V = createVehicle [(selectRandom _CRT), selectRandom _allPositions, [], 0, "NONE"]; 
_V = createVehicle [(selectRandom _CRT), selectRandom _allPositions, [], 0, "NONE"]; 
[ "Intel_01", selectRandom _allPositions, [0,0,0], _dir, false, false, true ] call LARs_fnc_spawnComp; 
 _V = createVehicle [(selectRandom _CRT), selectRandom _allPositions, [], 0, "NONE"]; 
_V = createVehicle [(selectRandom _CRT), selectRandom _allPositions, [], 0, "NONE"]; 

 G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
((units G) select 0) disableAI "PATH";   
			G deleteGroupWhenEmpty true;
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
((units G) select 0) disableAI "PATH";   
			G deleteGroupWhenEmpty true;
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
			G deleteGroupWhenEmpty true;

G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;     
			G deleteGroupWhenEmpty true;
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;

if (_DANSCORE > 5) then {
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
((units G) select 0) disableAI "PATH";   
			G deleteGroupWhenEmpty true;
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;     
			G deleteGroupWhenEmpty true;
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;
};

if (_DANSCORE > 10) then {
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
((units G) select 0) disableAI "PATH";   
			G deleteGroupWhenEmpty true;
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;     
			G deleteGroupWhenEmpty true;
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;
};

PRL = [thisRoadPostTrigger getPos [(10 + (random 40)),(0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, getPos _thisCityTrigger, (100 + (random 300))] call BIS_fnc_taskPatrol;

if (_DANSCORE > 5) then {
PRL = [thisRoadPostTrigger getPos [(10 + (random 40)),(0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, getPos _thisCityTrigger, (100 + (random 300))] call BIS_fnc_taskPatrol;	
};

if (_DANSCORE > 10) then {
PRL = [thisRoadPostTrigger getPos [(10 + (random 40)),(0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, getPos _thisCityTrigger, (100 + (random 300))] call BIS_fnc_taskPatrol;	
};
	
{

_nvg = hmd _x;
 _x unassignItem _nvg;
 _x removeItem _nvg;
	  _x addPrimaryWeaponItem "acc_flashlight";
	  _x assignItem "acc_flashlight";
	  _x enableGunLights "ForceOn";
  } foreach (allUnits select {side _x == east}); 

sleep 10;

_trg = createTrigger ["EmptyDetector", getpos thisRoadPostTrigger, false];  
_trg setTriggerArea [120, 120, 0, false, 200];  
_trg setTriggerInterval 6;  
_trg setTriggerActivation ["WEST SEIZED", "PRESENT", false];  
_trg setTriggerStatements [  
"this && {(alive _x) && ((side _x) == EAST) && (position _x inArea thisTrigger)} count allUnits < 3", "  

{ if (((side _x) == east) && (position _x inArea  thisTrigger))then {
_x disableAI 'PATH';
_x disableAI 'ANIM'; 
removeAllWeapons _x;
removeBackpack _x;
_x setCaptive true;
_x switchMove 'AmovPercMstpSsurWnonDnon';

_x addEventHandler ['Killed', { 
[] execVM 'Scripts\DangerPlusSurr.sqf';
removeAllActions (_this select 0) ;
}];

[
  _x,
'Arrest',
'Screens\FOBA\holdAction_secure_ca.paa',
'Screens\FOBA\holdAction_secure_ca.paa',
'_this distance _target < 3',       
'_caller distance _target < 3',  
{},
{},
{
(_this select 0) enableAI 'ANIM';
(_this select 0) enableAI 'PATH';
(_this select 0) switchMove '';
(_this select 0) setBehaviour 'AWARE';
[(_this select 0)] joinSilent player;
				(_this select 0) setCaptive true ;	
removeAllActions (_this select 0);
},
{},
[],
3,
0,
true,
false
] remoteExec ['BIS_fnc_holdActionAdd', 0, _x]; 

[
  _x,
'Release',
'\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_unbind_ca.paa',
'\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_unbind_ca.paa',
'_this distance _target < 3',       
'_caller distance _target < 3',  
{(_this select 0) setDir (position (_this select 0) getDir position player);},
{},
{
(_this select 0) enableAI 'ANIM';
(_this select 0) enableAI 'PATH';
(_this select 0) switchMove '';
(_this select 0) setBehaviour 'AWARE';
removeAllActions (_this select 0);
_x removeAllEventHandlers 'Killed';
( group (_this select 0)) addWaypoint [ player getPos [ (3000 + (random 1000)),(0 + (random 360))], 0];

[] execVM 'Scripts\DangerMinusSurr.sqf';

[(_this select 0),(_this select 2)] remoteExec ['bis_fnc_holdActionRemove',[0,-2] select isDedicated,true];

},
{},
[],
3,
0,
true,
false
] remoteExec ['BIS_fnc_holdActionAdd', 0, _x]; 

}; } foreach allUnits;


_MMarks = allMapMarkers select { markerType _x == ""o_service""};
_M = [_MMarks,  thisTrigger] call BIS_fnc_nearestPosition;

deleteMarker _M ; 

[30] execVM 'Scripts\Reward.sqf';
[thisTrigger, 1000] execVM 'Scripts\QuickRF.sqf';
[] execVM 'Scripts\DangerPlusSurr.sqf';
				[30, 'ROADBLOCK'] execVM 'Scripts\NOtification.sqf' ;


", ""]; 


{ if !((side _x) == west) then {
            ZEUS removeCuratorEditableObjects [[_x],true];
}; } foreach allUnits;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

[thisRoadPostTrigger, 100] execVM "Scripts\INTLitems.sqf";

sleep 2 ;


sleep 5 ;
_WeaponsARRAY = nearestObjects [(getPos thisRoadPostTrigger), ["O_G_HMG_02_high_F", "O_G_Mortar_01_F"], 100] ;
{[_x, 3, position _x, "ATL"] call BIS_fnc_setHeight; _x setVectorUp [0,0,1]; } forEach _WeaponsARRAY;


_HeavGun =  nearestObjects [(getPos thisRoadPostTrigger), ["O_G_Mortar_01_F", "O_G_HMG_02_high_F"], 100] select 0;
Group = createVehicleCrew _HeavGun; 
