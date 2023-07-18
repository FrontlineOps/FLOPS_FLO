
ThisCityTrigger = _this select 0;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_AGGRSCORE = parseNumber (markerText _mrkr) ;  
//////Resources////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
sleep 15 ; 

_posit = ThisCityTrigger getPos [(10 +(random 150)), (0 + (random 360))] ;
_V = createVehicle [ "CargoNet_01_box_F", [_posit select 0, _posit select 1, (_posit select 2) + 6], [], 2, "NONE"]; 
_V allowDammage false;

_posit = ThisCityTrigger getPos [(10 +(random 150)), (0 + (random 360))] ;
_V = createVehicle [ "CargoNet_01_box_F", [_posit select 0, _posit select 1, (_posit select 2) + 6], [], 2, "NONE"]; 
_V allowDammage false;

_posit = ThisCityTrigger getPos [(10 +(random 150)), (0 + (random 360))] ;
_V = createVehicle [ "CargoNet_01_box_F", [_posit select 0, _posit select 1, (_posit select 2) + 6], [], 2, "NONE"]; 
_V allowDammage false;

	if (count ( (getPos ThisCityTrigger) nearRoads 150 ) > 0 ) then {

_nearRoad = selectRandom ((getPos ThisCityTrigger) nearRoads 150 ) ; 
		_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
		_dir = _nearRoad getDir _nextRoad;
[_nearRoad, _dir] execVM "Scripts\WatchPostBB.sqf";

sleep 1;

if (_AGGRSCORE > 5) then {
_nearRoad = selectRandom ((getPos ThisCityTrigger) nearRoads 150 ) ; 
		_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
		_dir = _nearRoad getDir _nextRoad;
[_nearRoad, _dir] execVM "Scripts\WatchPostBB.sqf";
sleep 1;
};

if (_AGGRSCORE > 10) then {
_nearRoad = selectRandom ((getPos ThisCityTrigger) nearRoads 150 ) ; 
		_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
		_dir = _nearRoad getDir _nextRoad;
[_nearRoad, _dir] execVM "Scripts\WatchPostBB.sqf";
sleep 1;
};

	};


//////CrewGroups////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////Watchpost////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////Assault////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


			_AssltDestMrks = allMapMarkers select {markerType _x == "b_installation"  && (markerColor _x == "ColorYellow" or  markerColor _x == "colorBLUFOR" or markerColor _x == "colorWEST")};  
			_StrtM = [_AssltDestMrks,  ThisCityTrigger] call BIS_fnc_nearestPosition;
[ThisCityTrigger, _StrtM] execVM "Scripts\VehiInsert_CSAT_2.sqf";			



if (_AGGRSCORE > 10) then {
			_AssltDestMrks = allMapMarkers select {markerType _x == "b_installation"  && (markerColor _x == "ColorYellow" or  markerColor _x == "colorBLUFOR" or markerColor _x == "colorWEST")};  
			_StrtM = [_AssltDestMrks,  ThisCityTrigger] call BIS_fnc_nearestPosition;
[ThisCityTrigger, _StrtM] execVM "Scripts\VehiInsert_CSAT_2.sqf";	
};


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

PRL = [ThisCityTrigger getPos [(10 +(random 90)), (0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, ThisCityTrigger getPos [(10 +(random 90)), (0 + (random 360))], 50] call BIS_fnc_taskPatrol;
PRL deleteGroupWhenEmpty true ;

PRLL = Leader PRL ;
PRLL removeAllEventHandlers "Killed";
PRLL addEventHandler ["Killed", { 
 _QRF = selectRandom [ "Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"]; 
 [(_this select 0)] execVM _QRF;
 _flare = "F_20mm_Red" createVehicle [getPos (_this select 0) select 0, getPos (_this select 0) select 1, 120]; 
_flare setVelocity [0,0,-0.1];
 }];
 
if (_AGGRSCORE > 5) then {
PRL = [ThisCityTrigger getPos [(10 +(random 90)), (0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, ThisCityTrigger getPos [(10 +(random 90)), (0 + (random 360))], 100] call BIS_fnc_taskPatrol;
PRL deleteGroupWhenEmpty true;


PRLL = Leader PRL ;
PRLL removeAllEventHandlers "Killed";
PRLL addEventHandler ["Killed", { 
 _QRF = selectRandom [ "Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"]; 
 [(_this select 0)] execVM _QRF;
 _flare = "F_20mm_Red" createVehicle [getPos (_this select 0) select 0, getPos (_this select 0) select 1, 120]; 
_flare setVelocity [0,0,-0.1];
 }];
};


if (_AGGRSCORE >10) then {
PRL = [ThisCityTrigger getPos [(10 +(random 90)), (0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, ThisCityTrigger getPos [(10 +(random 90)), (0 + (random 360))], 200] call BIS_fnc_taskPatrol;
PRL deleteGroupWhenEmpty true;

PRLL = Leader PRL;
PRLL removeAllEventHandlers "Killed";
PRLL addEventHandler ["Killed", { 
 _QRF = selectRandom [ "Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"]; 
 [(_this select 0)] execVM _QRF;
 _flare = "F_20mm_Red" createVehicle [getPos (_this select 0) select 0, getPos (_this select 0) select 1, 120]; 
_flare setVelocity [0,0,-0.1];
 }];
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if ( LOGDIS == 0 ) then {
	
		if (count ( (getPos ThisCityTrigger) nearRoads 150 ) > 0 ) then {


_nearRoad = selectRandom ( (getPos ThisCityTrigger) nearRoads 150 ) ; 
_V = createVehicle [ selectRandom EastGround_Vehicles_Light, (_nearRoad getRelPos [0, 0]), [], 2, "NONE"]; 

CrewGroup = createVehicleCrew _V; 
_VC = createGroup East;
{[_x] join _VC} forEach units CrewGroup;

sleep 3;
_nearRoad2 =ThisCityTrigger nearRoads 1500 ; 
_nearRoad1 = ThisCityTrigger nearRoads 800 ; 

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


if (_AGGRSCORE > 5) then {
	
_nearRoad = selectRandom ( (getPos ThisCityTrigger) nearRoads 150 ) ; 
_V = createVehicle [ selectRandom EastGround_Vehicles_Light, (_nearRoad getRelPos [0, 0]), [], 2, "NONE"]; 

CrewGroup = createVehicleCrew _V; 
_VC = createGroup East;
{[_x] join _VC} forEach units CrewGroup;

sleep 3;
_nearRoad2 =ThisCityTrigger nearRoads 1500 ; 
_nearRoad1 = ThisCityTrigger nearRoads 800 ; 

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


if (_AGGRSCORE > 10) then {

_nearRoad = selectRandom ( (getPos ThisCityTrigger) nearRoads 150 ) ; 
_V = createVehicle [ selectRandom EastGround_Vehicles_Light, (_nearRoad getRelPos [0, 0]), [], 2, "NONE"]; 

CrewGroup = createVehicleCrew _V; 
_VC = createGroup East;
{[_x] join _VC} forEach units CrewGroup;

sleep 3;
_nearRoad2 =ThisCityTrigger nearRoads 1500 ; 
_nearRoad1 = ThisCityTrigger nearRoads 800 ; 

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
};
 

//////Garrisons////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_all = nearestObjects [(getPos ThisCityTrigger), ["HOUSE"], 100];  
_allBuildings = _all select {count (_x buildingPos -1) > 1}; 

_rndSolX = selectRandom East_Units; 
_rndBuilding = selectRandom _allBuildings;  
_PosAGL = ASLToAGL getPosASL _rndBuilding;
G = [_PosAGL, East,[_rndSolX]] call BIS_fnc_spawnGroup;    
[((units G) select 0), 10, _PosAGL, "ATL"] call BIS_fnc_setHeight;
((units G) select 0) setUnitPos "MIDDLE";
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;

_rndSolX = selectRandom East_Units; 
_rndBuilding = selectRandom _allBuildings;  
_PosAGL = ASLToAGL getPosASL _rndBuilding;
G = [_PosAGL, East,[_rndSolX]] call BIS_fnc_spawnGroup;    
[((units G) select 0), 10, _PosAGL, "ATL"] call BIS_fnc_setHeight;
((units G) select 0) setUnitPos "MIDDLE";
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;

_rndSolX = selectRandom East_Units; 
_rndBuilding = selectRandom _allBuildings;  
_PosAGL = ASLToAGL getPosASL _rndBuilding;
G = [_PosAGL, East,[_rndSolX]] call BIS_fnc_spawnGroup;    
[((units G) select 0), 10, _PosAGL, "ATL"] call BIS_fnc_setHeight;
((units G) select 0) setUnitPos "MIDDLE";
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;

if (_AGGRSCORE > 10) then {

_rndSolX = selectRandom East_Units; 
_rndBuilding = selectRandom _allBuildings;  
_PosAGL = ASLToAGL getPosASL _rndBuilding;
G = [_PosAGL, East,[_rndSolX]] call BIS_fnc_spawnGroup;    
[((units G) select 0), 10, _PosAGL, "ATL"] call BIS_fnc_setHeight;
((units G) select 0) setUnitPos "MIDDLE";
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;

_rndSolX = selectRandom East_Units; 
_rndBuilding = selectRandom _allBuildings;  
_PosAGL = ASLToAGL getPosASL _rndBuilding;
G = [_PosAGL, East,[_rndSolX]] call BIS_fnc_spawnGroup;    
[((units G) select 0), 10, _PosAGL, "ATL"] call BIS_fnc_setHeight;
((units G) select 0) setUnitPos "MIDDLE";
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;

_rndSolX = selectRandom East_Units; 
_rndBuilding = selectRandom _allBuildings;  
_PosAGL = ASLToAGL getPosASL _rndBuilding;
G = [_PosAGL, East,[_rndSolX]] call BIS_fnc_spawnGroup;    
[((units G) select 0), 10, _PosAGL, "ATL"] call BIS_fnc_setHeight;
((units G) select 0) setUnitPos "MIDDLE";
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;

};



//////Garrisons////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_CRT = [
"Box_IND_WpsSpecial_F",
"Box_East_WpsSpecial_F",
"Box_IND_Support_F",
"Box_East_Support_F",
"Box_CSAT_Equip_F",
"Box_AAF_Equip_F",
"Box_East_WpsLaunch_F",
"Box_IND_WpsLaunch_F",
"Box_East_AmmoOrd_F",
"Box_East_Ammo_F",
"Box_IND_Ammo_F",
"Box_IND_AmmoOrd_F",
"Box_East_Wps_F",
"Box_IND_Wps_F"
];

_allBuildings = nearestObjects [(getPos ThisCityTrigger), ["HOUSE"], 300];  
_allPositions = [];  
_allBuildings apply {_allPositions append (_x buildingPos -1)};  


G = [ selectRandom _allPositions, East,[selectRandom East_Units_Officers, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;


_Buildings = nearestObjects [(getPos ThisCityTrigger), ["HOUSE"], 100] ;  
_allPositionBuildings = _Buildings select {count (_x buildingPos -1) > 2}; 
_HQ = _allPositionBuildings select 0;
_dir = getDirVisual _HQ;
[ "Intel_01", (selectRandom (_HQ buildingPos -1)), [0,0,0], _dir, false, false, true ] call LARs_fnc_spawnComp; 
_V = createVehicle [(selectRandom _CRT), (selectRandom (_HQ buildingPos -1)), [], 0, "NONE"]; 
_V = createVehicle [(selectRandom _CRT), (selectRandom (_HQ buildingPos -1)), [], 0, "NONE"]; 

G = [ (selectRandom (_HQ buildingPos -1)), East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH";  
			G deleteGroupWhenEmpty true;


G = [ (selectRandom (_HQ buildingPos -1)), East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;

G = [ (selectRandom (_HQ buildingPos -1)), East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;

if (_AGGRSCORE > 5) then {
	
G = [selectRandom _allPositions, East,[selectRandom East_Units_Officers, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;

_Buildings = nearestObjects [(getPos ThisCityTrigger), ["HOUSE"], 100] ;  
_allPositionBuildings = _Buildings select {count (_x buildingPos -1) > 2}; 
_HQ = _allPositionBuildings select 1;
_dir = getDirVisual _HQ;
[ "Intel_01", (selectRandom (_HQ buildingPos -1)), [0,0,0], _dir, false, false, true ] call LARs_fnc_spawnComp; 
_V = createVehicle [(selectRandom _CRT), (selectRandom (_HQ buildingPos -1)), [], 0, "NONE"]; 
_V = createVehicle [(selectRandom _CRT), (selectRandom (_HQ buildingPos -1)), [], 0, "NONE"]; 
G = [ (selectRandom (_HQ buildingPos -1)), East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH";  
			G deleteGroupWhenEmpty true;
G = [ (selectRandom (_HQ buildingPos -1)), East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;

G = [ (selectRandom (_HQ buildingPos -1)), East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;

 };

if (_AGGRSCORE > 10) then {
	
G = [selectRandom _allPositions, East,[selectRandom East_Units_Officers, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "PATH";
			G deleteGroupWhenEmpty true;


_Buildings = nearestObjects [(getPos ThisCityTrigger), ["HOUSE"], 100] ;  
_allPositionBuildings = _Buildings select {count (_x buildingPos -1) > 2}; 
_HQ = _allPositionBuildings select 2;
_dir = getDirVisual _HQ;
[ "Intel_01", (selectRandom (_HQ buildingPos -1)), [0,0,0], _dir, false, false, true ] call LARs_fnc_spawnComp; 
_V = createVehicle [(selectRandom _CRT), (selectRandom (_HQ buildingPos -1)), [], 0, "NONE"]; 
_V = createVehicle [(selectRandom _CRT), (selectRandom (_HQ buildingPos -1)), [], 0, "NONE"]; 
G = [ (selectRandom (_HQ buildingPos -1)), East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units G) select 0) disableAI "PATH";  
			G deleteGroupWhenEmpty true;
G = [ (selectRandom (_HQ buildingPos -1)), East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;

G = [ (selectRandom (_HQ buildingPos -1)), East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;



};
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if ( HELIDIS == 0 ) then {
_Chance = selectRandom [1, 2, 3]; 
if (_Chance > 2) then {
_V = createVehicle [selectRandom East_Air_Heli, (getPos ThisCityTrigger), [], 1000, "FLY"]; 
CrewGroup = createVehicleCrew _V; 
_VC = createGroup East;
{[_x] join _VC} forEach units CrewGroup;
[_VC, (getPos ThisCityTrigger), 700] call BIS_fnc_taskPatrol;
_V  addeventhandler ["fuel", {(_this select 0) setfuel 1}] ;
_V flyInHeight 100; 
_V disableAI "LIGHTS"; 
_V setPilotLight true;
_V setCollisionLight true; 
  };
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

_trg = createTrigger ["EmptyDetector", getPos ThisCityTrigger, false];  
_trg setTriggerArea [1000, 1000, 0, false, 200];  
_trg setTriggerTimeout [2, 2, 2, true];
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this",  "[thisTrigger, 1500] execVM 'Scripts\ZONEs.sqf';", ""]; 


_trg = createTrigger ["EmptyDetector", getPos ThisCityTrigger, false];  
_trg setTriggerArea [200, 200, 0, false, 40];  
_trg setTriggerTimeout [2, 2, 2, true];
_trg setTriggerActivation ["WEST", "PRESENT", false];  
_trg setTriggerStatements [  
"this",  "[thisTrigger] execVM 'Scripts\CQBURB.sqf';", ""]; 


_trgINT = createTrigger ["EmptyDetector", getPos ThisCityTrigger, false];
_trgINT setTriggerArea [400, 400, 0, false, 50];
_trgINT setTriggerTimeout [30, 30, 30, true];
_trgINT setTriggerActivation ["WEST", "PRESENT", true];
_trgINT setTriggerStatements [
			"this && AVENGLOCC == 1 && ({((side _x) == east) && (getPos _x distance thisTrigger < 200)} count allUnits < 25)", "

					AVENGLOCC = 0 ;
					publicVariable 'AVENGLOCC';
				
					if ( ({((side _x) == east) && (position _x inArea  thisTrigger)} count allUnits < 25) && ({(getNumber (configfile >> 'CfgVehicles' >> typeOf _x >> 'side') == 0) && (getPos _x inArea thisTrigger)} count allDeadMen > 0) ) then {
					_allDEAD = allDeadMen select {(getNumber (configfile >> 'CfgVehicles' >> typeOf _x >> 'side') == 0) && (getPos _x inArea thisTrigger)} ; 
					_aDEAD = _allDEAD select 0 ; 
					_pos = getPos _aDEAD ;
					_Buildings = nearestObjects [thisTrigger, ['HOUSE'], 60] ;  
					_allPositionBuildings = _Buildings select {count (_x buildingPos -1) > 1}; 
					_HQ = selectRandom _allPositionBuildings ;
					_Avenger = [(selectRandom (_HQ buildingPos -1)), East,[selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
								_Avenger deleteGroupWhenEmpty true;
					_W_1 = _Avenger addWaypoint [_pos, 0] ;
					_W_1 SetWaypointType 'SAD';
								};
					if ( ({((side _x) == east) && (position _x inArea  thisTrigger)} count allUnits < 25) && ({(getNumber (configfile >> 'CfgVehicles' >> typeOf _x >> 'side') == 0) && (getPos _x inArea thisTrigger)} count allDeadMen > 0) ) then {
					_allDEAD = allDeadMen select {(getNumber (configfile >> 'CfgVehicles' >> typeOf _x >> 'side') == 0) && (getPos _x inArea thisTrigger)} ; 
					_aDEAD = _allDEAD select 0 ; 
					_pos = getPos _aDEAD ;
					_Buildings = nearestObjects [thisTrigger, ['HOUSE'], 60] ;  
					_allPositionBuildings = _Buildings select {count (_x buildingPos -1) > 1}; 
					_HQ = selectRandom _allPositionBuildings ;
					_Avenger = [(selectRandom (_HQ buildingPos -1)), East,[selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
								_Avenger deleteGroupWhenEmpty true;
					_W_1 = _Avenger addWaypoint [_pos, 0] ;
					_W_1 SetWaypointType 'SAD';
								};				
								
				 execVM 'Scripts\AVENGLOCCER.sqf';

			", ""];


_trg = createTrigger ["EmptyDetector", getPos ThisCityTrigger, false];  
_trg setTriggerArea [220, 220, 0, false, 200];  
_trg setTriggerTimeout [10, 10, 10, true];
_trg setTriggerActivation ["WEST SEIZED", "PRESENT", true];  
_trg setTriggerStatements [  
"this",  "  

[parseText '<t color=""#1AA3FF"" font=""PuristaBold"" align = ""right"" shadow = ""1"" size=""2"">SITREP</t><br /><t color=""#959393"" align = ""right"" shadow = ""1"" size=""0.8"">Friendly Forces Dominating the Battle,</t><br /><t color=""#959393"" align = ""right"" shadow = ""1"" size=""0.8"">Keep Up the Fight, We will Capture and Secure the Outpost,</t>', [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ['BIS_fnc_textTiles', 0];
_allMarks = allMapMarkers select {markerType _x == 'o_installation'};  
_FOBMrk = [_allMarks,  thisTrigger] call BIS_fnc_nearestPosition;
						_FOBMrk setMarkerColor 'ColorGrey' ;	
									_attackingAtGrid = mapGridPosition getMarkerPos _FOBMrk;
								[[west,'HQ'], 'Friendly Forces Dominating the Battle at grid ' + _attackingAtGrid] remoteExec ['sideChat', 0];

[thisTrigger] execVM 'Scripts\City_CSAT_CAPTURE_West.sqf';

", "

_allMarks = allMapMarkers select {markerType _x == 'o_installation'};  
_FOBMrk = [_allMarks,  thisTrigger] call BIS_fnc_nearestPosition;
						_FOBMrk setMarkerColor 'colorOPFOR' ;	

"]; 





{ if !((side _x) == west) then {
            ZEUS removeCuratorEditableObjects [[_x],true];
}; } foreach allUnits;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

[ThisCityTrigger, 300] execVM "Scripts\INTLitems.sqf";



sleep 2 ;

