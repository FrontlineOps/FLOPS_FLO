////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

thisOutpostTrigger = _this select 0;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_DANSCORE = parseNumber (markerText _mrkr) ;  

_Chance = selectRandom [1, 2, 3]; 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


[thisOutpostTrigger] execVM "Scripts\HMGspawn.sqf" ; 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (count ( nearestobjects [getPos thisOutpostTrigger, ["Land_HelipadCircle_F","Land_HelipadCivil_F","Heli_H_rescue","Land_HelipadRescue_F","Land_HelipadSquare_F","HeliHRescue","Heli_H_civil","HeliHCivil","HeliH"], 100]) > 0) then { 
_HPAD = nearestobjects [getPos thisOutpostTrigger, ["Land_HelipadCircle_F","Land_HelipadCivil_F","Heli_H_rescue","Land_HelipadRescue_F","Land_HelipadSquare_F","HeliHRescue","Heli_H_civil","HeliHCivil","HeliH"], 100] select 0;
_V = createVehicle [ selectRandom East_Air_Heli, getpos _HPAD, [], 0, "NONE"]; 
_V setVehicleLock "LOCKED";
_dir =  getDir _HPAD;
_V setDir _dir; 



_V addEventHandler ["Killed", {  
["ScoreAdded", ["Enemy Aircraft Sabotaged", 20]] remoteExec ["BIS_fnc_showNotification", 0];
[20] execVM "Scripts\Reward.sqf";
 playMusic "EventTrack01_F_Curator"; 
 execVM 'Scripts\HeliDis.sqf';
}];
} ;

if (count ( nearestobjects [getPos thisOutpostTrigger, ["Land_Tyre_F"], 100]) > 0) then { 
_objectLoc = nearestobjects [getPos thisOutpostTrigger, ["Land_Tyre_F"], 100] ; 

{  
_x hideObject true ; 
sleep 1;

_dir = getDirVisual _x ;
_pos = position _x ;

_NewVeh = createVehicle [selectRandom East_Ground_Transport, [0,0, (500 + random 2000)], [], 0, "CAN_COLLIDE"] ;
	_NewVeh setDir _dir ;
	_NewVeh setVehicleLock "LOCKED";

deleteVehicle _x ;

_NewVeh setVehiclePosition [ [_pos select 0, _pos select 1, (_pos select 2) + 2], [], 0, "CAN_COLLIDE"];


sleep 1;
	_NewVeh addEventHandler ["Killed", {
["ScoreAdded", ["Enemy Armor Sabotaged", 30]] remoteExec ["BIS_fnc_showNotification", 0];
[30] execVM "Scripts\Reward.sqf"; 
 playMusic "EventTrack01_F_Curator"; 
 execVM 'Scripts\LogisDis.sqf';
}];

} forEach _objectLoc;
};


//////GROUPS//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////Veicle////////////////////////////////////////////////////////////////////////

if (count ( (getPos thisOutpostTrigger) nearRoads 200 ) > 0 ) then {

_nearRoad = selectRandom ( (getPos thisOutpostTrigger) nearRoads 200 ) ; 
_V = createVehicle [ selectRandom East_Ground_Vehicles_Light, (_nearRoad getRelPos [0, 0]), [], 2, "NONE"]; 

CrewGroup = createVehicleCrew _V; 
_VC = createGroup East;
{[_x] join _VC} forEach units CrewGroup;


_nearRoad2 =thisOutpostTrigger nearRoads 1500 ; 
_nearRoad1 = thisOutpostTrigger nearRoads 800 ; 

_nearRoadleft = _nearRoad2 - _nearRoad1;
_nearRoad0 = selectRandom _nearRoadleft; 
I1_WP_0 = _VC addWaypoint [getPos _nearRoad0, 0];
I1_WP_0 SetWaypointType "MOVE";
I1_WP_0 setWaypointBehaviour "SAFE";
I1_WP_0 setWaypointSpeed "LIMITED";

I1_WP_00 = _VC addWaypoint [getPos _nearRoad, 0];
I1_WP_00 SetWaypointType "MOVE";
I1_WP_00 setWaypointBehaviour "SAFE";
I1_WP_00 setWaypointSpeed "LIMITED";

I1_WP_1 = _VC addWaypoint [getPos _nearRoad, 3];
I1_WP_1 SetWaypointType "CYCLE";
I1_WP_1 setWaypointBehaviour "SAFE";
I1_WP_1 setWaypointSpeed "LIMITED";


if (_DANSCORE > 10) then {
_nearRoad = selectRandom ( (getPos thisOutpostTrigger) nearRoads 150 ) ; 
_V = createVehicle [ selectRandom East_Ground_Vehicles_Heavy, (_nearRoad getRelPos [0, 0]), [], 2, "NONE"]; 

CrewGroup = createVehicleCrew _V; 
_VC = createGroup East;
{[_x] join _VC} forEach units CrewGroup;


_nearRoad2 =thisOutpostTrigger nearRoads 1500 ; 
_nearRoad1 = thisOutpostTrigger nearRoads 800 ; 

_nearRoadleft = _nearRoad2 - _nearRoad1;
_nearRoad0 = selectRandom _nearRoadleft; 
I1_WP_0 = _VC addWaypoint [getPos _nearRoad0, 0];
I1_WP_0 SetWaypointType "MOVE";
I1_WP_0 setWaypointBehaviour "SAFE";
I1_WP_0 setWaypointSpeed "LIMITED";

I1_WP_00 = _VC addWaypoint [getPos _nearRoad, 0];
I1_WP_00 SetWaypointType "MOVE";
I1_WP_00 setWaypointBehaviour "SAFE";
I1_WP_00 setWaypointSpeed "LIMITED";

I1_WP_1 = _VC addWaypoint [getPos _nearRoad, 3];
I1_WP_1 SetWaypointType "CYCLE";
I1_WP_1 setWaypointBehaviour "SAFE";
I1_WP_1 setWaypointSpeed "LIMITED";
};
};
//////Assault////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



if (_DANSCORE > 5) then {
			_AssltDestMrks = allMapMarkers select {markerType _x == "b_installation"  && (markerColor _x == "ColorYellow" or  markerColor _x == "colorBLUFOR" or markerColor _x == "colorWEST")};  
			_AssltDest = [_AssltDestMrks,  thisOutpostTrigger] call BIS_fnc_nearestPosition;
[thisOutpostTrigger, _AssltDest] execVM "Scripts\VehiInsert_CSAT_2.sqf";			

};

if (_DANSCORE > 10) then {
			_AssltDestMrks = allMapMarkers select {markerType _x == "b_installation"  && (markerColor _x == "ColorYellow" or  markerColor _x == "colorBLUFOR" or markerColor _x == "colorWEST")};  
			_StrtM = [_AssltDestMrks,  thisOutpostTrigger] call BIS_fnc_nearestPosition;
[thisOutpostTrigger, _StrtM] execVM "Scripts\VehiInsert_CSAT_2.sqf";	
};
///////Garrisons//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_poss = [(getpos thisOutpostTrigger), 10, 80, 5, 1 , 0] call BIS_fnc_findSafePos;
G = [_poss, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;

_poss = [(getpos thisOutpostTrigger), 10, 80, 5, 1 , 0] call BIS_fnc_findSafePos;
G = [_poss, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;

_poss = [(getpos thisOutpostTrigger), 10, 80, 5, 1 , 0] call BIS_fnc_findSafePos;
G = [_poss, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;


if (_DANSCORE > 5) then {
_poss = [(getpos thisOutpostTrigger), 10, 80, 5, 1 , 0] call BIS_fnc_findSafePos;
G = [_poss, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;

_poss = [(getpos thisOutpostTrigger), 10, 80, 5, 1 , 0] call BIS_fnc_findSafePos;
G = [_poss, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;

_poss = [(getpos thisOutpostTrigger), 10, 80, 5, 1 , 0] call BIS_fnc_findSafePos;
G = [_poss, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;
};


if (_DANSCORE > 10) then {
_poss = [(getpos thisOutpostTrigger), 10, 80, 5, 1 , 0] call BIS_fnc_findSafePos;
G = [_poss, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;

_poss = [(getpos thisOutpostTrigger), 10, 80, 5, 1 , 0] call BIS_fnc_findSafePos;
G = [_poss, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;

_poss = [(getpos thisOutpostTrigger), 10, 80, 5, 1 , 0] call BIS_fnc_findSafePos;
G = [_poss, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

_poss = [(getpos thisOutpostTrigger), 10, 20, 4, 0.1 , 0] call BIS_fnc_findSafePos;
_VLAMP = createVehicle [ "Land_LampAirport_F", _poss, [], 5, "NONE"];


if (count [(getpos thisOutpostTrigger) nearRoads 70] > 0) then {

_nearRoad = selectRandom ( (getpos thisOutpostTrigger) nearRoads 70 ) ; 
_V = createVehicle [selectRandom East_Ground_Vehicles_Ambient, (_nearRoad getRelPos [0, 0]), [], 4, "NONE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;

_nearRoad = selectRandom ( (getpos thisOutpostTrigger) nearRoads 70 ) ; 
_V = createVehicle [ selectRandom East_Ground_Vehicles_Ambient, (_nearRoad getRelPos [0, 0]), [], 4, "NONE"]; 
_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
_dir = _nearRoad getDir _nextRoad;
_V setDir _dir;
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_allBuildings = nearestObjects [(getpos thisOutpostTrigger), ["House", "Land_MilOffices_V1_F", "Land_Cargo_Tower_V3_F", "Land_Cargo_Tower_V2_F", "Land_Cargo_Tower_V1_F", "Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V2_F", "Land_Cargo_HQ_V1_F", "Land_Cargo_House_V3_F", "Land_Cargo_House_V1_F"], 300];  

HQBLDNG = selectRandom _allBuildings;
_dir = getDirVisual HQBLDNG;
[ "Intel_01", (selectRandom (HQBLDNG buildingPos -1)), [0,0,0], _dir, false, false, true ] call LARs_fnc_spawnComp; 

HQBLDNG = selectRandom _allBuildings;
_dir = getDirVisual HQBLDNG;
[ "Intel_01", (selectRandom (HQBLDNG buildingPos -1)), [0,0,0], _dir, false, false, true ] call LARs_fnc_spawnComp; 

HQBLDNG = selectRandom _allBuildings;
_dir = getDirVisual HQBLDNG;
[ "Intel_01", (selectRandom (HQBLDNG buildingPos -1)), [0,0,0], _dir, false, false, true ] call LARs_fnc_spawnComp; 

_V = createVehicle [(selectRandom _CRT), (selectRandom (HQBLDNG buildingPos -1)), [], 0, "NONE"]; 
_V = createVehicle [(selectRandom _CRT), (selectRandom (HQBLDNG buildingPos -1)), [], 0, "NONE"]; 
_V = createVehicle [(selectRandom _CRT), (selectRandom (HQBLDNG buildingPos -1)), [], 0, "NONE"]; 
_V = createVehicle [(selectRandom _CRT), (selectRandom (HQBLDNG buildingPos -1)), [], 0, "NONE"]; 


if (_DANSCORE > 5) then {
	HQBLDNG = selectRandom _allBuildings;
_dir = getDirVisual HQBLDNG;
[ "Intel_01", (selectRandom (HQBLDNG buildingPos -1)), [0,0,0], _dir, false, false, true ] call LARs_fnc_spawnComp; 
};

if (_DANSCORE > 10) then {
HQBLDNG = selectRandom _allBuildings;
_dir = getDirVisual HQBLDNG;
[ "Intel_01", (selectRandom (HQBLDNG buildingPos -1)), [0,0,0], _dir, false, false, true ] call LARs_fnc_spawnComp; 
};

_allPositions = [];  
_allBuildings apply {_allPositions append (_x buildingPos -1)};  
 

G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;         
			G deleteGroupWhenEmpty true;
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;     
			G deleteGroupWhenEmpty true;
if (_DANSCORE > 5) then {
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;         
			G deleteGroupWhenEmpty true;
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
			G deleteGroupWhenEmpty true;
};
if (_DANSCORE > 10) then {
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;         
			G deleteGroupWhenEmpty true;
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
			G deleteGroupWhenEmpty true;
};



_HeavGuns =  nearestObjects [(getpos thisOutpostTrigger), ["O_G_HMG_02_high_F", "O_G_Mortar_01_F"], 200];

{
CrewGroup = createVehicleCrew _x; 
{_x setUnitLoadout (selectRandom East_Units)} forEach units CrewGroup;
} forEach _HeavGuns;


if (count nearestObjects [(getpos thisOutpostTrigger), ["Land_BagBunker_Large_F", "Land_BagBunker_Small_F", "Land_Cargo_House_V3_F", "Land_Cargo_House_V1_F", "Land_Cargo_Patrol_V3_F", "Land_Cargo_Patrol_V2_F", "Land_Cargo_Patrol_V1_F"], 200] > 0) then {

_allBuildings = nearestObjects [(getpos thisOutpostTrigger), ["Land_BagBunker_Large_F", "Land_BagBunker_Small_F", "Land_Cargo_House_V3_F", "Land_Cargo_House_V1_F", "Land_Cargo_Patrol_V3_F", "Land_Cargo_Patrol_V2_F", "Land_Cargo_Patrol_V1_F"], 200];  
_allPositions = [];  
_allBuildings apply {_allPositions append (_x buildingPos -1)}; 
 
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
((units G) select 0) disableAI "PATH";   
			G deleteGroupWhenEmpty true;
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;     
			G deleteGroupWhenEmpty true;
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;     
			G deleteGroupWhenEmpty true;

_V = createVehicle [(selectRandom _CRT), selectRandom _allPositions, [], 0, "NONE"]; 
_V = createVehicle [(selectRandom _CRT), selectRandom _allPositions, [], 0, "NONE"]; 
_V = createVehicle [(selectRandom _CRT), selectRandom _allPositions, [], 0, "NONE"]; 


if (_DANSCORE > 5) then {
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
((units G) select 0) disableAI "PATH";   
			G deleteGroupWhenEmpty true;
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;     
			G deleteGroupWhenEmpty true;
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;     
			G deleteGroupWhenEmpty true;

};

if (_DANSCORE > 10) then {
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;
G = [selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;     
			G deleteGroupWhenEmpty true;
};
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
{
_nvg = hmd _x;
 _x unassignItem _nvg;
 _x removeItem _nvg;
	  _x addPrimaryWeaponItem "acc_flashlight";
	  _x assignItem "acc_flashlight";
	  _x enableGunLights "ForceOn";
  } foreach (allUnits select {side _x == east}); 
 

 /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
 
_trg = createTrigger ["EmptyDetector", getPos thisOutpostTrigger, false];  
_trg setTriggerArea [1000, 1000, 0, false, 200];  
_trg setTriggerTimeout [2, 2, 2, true];
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this",  "[thisTrigger, 1500] execVM 'Scripts\ZONEs.sqf';", ""]; 
  
  
_trg = createTrigger ["EmptyDetector", getPos thisOutpostTrigger, false];  
_trg setTriggerArea [120, 120, 0, false, 200];  
_trg setTriggerTimeout [10, 10, 10, true];
_trg setTriggerActivation ["WEST SEIZED", "PRESENT", true];  
_trg setTriggerStatements [  
"this",  "  

[parseText '<t color=""#1AA3FF"" font=""PuristaBold"" align = ""right"" shadow = ""1"" size=""2"">SITREP</t><br /><t color=""#959393"" align = ""right"" shadow = ""1"" size=""0.8"">Friendly Forces Dominating the Battle,</t><br /><t color=""#959393"" align = ""right"" shadow = ""1"" size=""0.8"">Keep Up the Fight, We will Capture and Secure the Outpost,</t>', [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ['BIS_fnc_textTiles', 0];
_allMarks = allMapMarkers select {markerType _x == 'o_support'};  
_FOBMrk = [_allMarks,  thisTrigger] call BIS_fnc_nearestPosition;
						_FOBMrk setMarkerColor 'ColorGrey' ;	
									_attackingAtGrid = mapGridPosition getMarkerPos _FOBMrk;
								[[west,'HQ'], 'Friendly Forces Dominating the Battle at grid ' + _attackingAtGrid] remoteExec ['sideChat', 0];

[thisTrigger] execVM 'Scripts\Outpost_CSAT_CAPTURE_West.sqf';

", "

_allMarks = allMapMarkers select {markerType _x == 'o_support'};  
_FOBMrk = [_allMarks,  thisTrigger] call BIS_fnc_nearestPosition;
						_FOBMrk setMarkerColor 'colorOPFOR' ;	

"]; 






{ if !((side _x) == west) then {
            ZEUS removeCuratorEditableObjects [[_x],true];
}; } foreach allUnits;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

[thisOutpostTrigger, 200] execVM "Scripts\INTLitems.sqf";
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
sleep 2 ;

