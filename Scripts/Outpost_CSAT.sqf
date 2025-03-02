thisOutpostTrigger = _this select 0;

private _mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
private _mrkr = _mrkrs select 0;
private _AGGRSCORE = parseNumber (markerText _mrkr) ;  

[thisOutpostTrigger] execVM "Scripts\HMGspawn.sqf" ; 

// Create Static Helicopter in Outpost
if (count (nearestObjects [getPos thisOutpostTrigger, FLO_configCache get "helipads", 100]) > 0) then {
    private _HPAD = nearestObjects [getPos thisOutpostTrigger, FLO_configCache get "helipads", 100] select 0;
    private _V = createVehicle [selectRandom (FLO_configCache get "vehicles" select 5), getPos _HPAD, [], 0, "NONE"];
    _V setVehicleLock "LOCKED";
    private _dir = getDir _HPAD;
    _V setDir _dir;

    _V addEventHandler ["Killed", {
        ["ScoreAdded", ["Enemy Aircraft Sabotaged", 20]] remoteExec ["BIS_fnc_showNotification", 0];
        [20] execVM "Scripts\Reward.sqf";
        playMusic "EventTrack01_F_Curator";
        execVM 'Scripts\HeliDis.sqf';
    }];
};

// Create Transport in Outpost
if (count (nearestObjects [getPos thisOutpostTrigger, FLO_configCache get "tyres", 100]) > 0) then {
    private _objectLoc = nearestObjects [getPos thisOutpostTrigger, FLO_configCache get "tyres", 100];

    {
        _x hideObject true;
        sleep 1;

        private _dir = getDirVisual _x;
        private _pos = position _x;

        private _NewVeh = createVehicle [selectRandom (FLO_configCache get "vehicles" select 3), [0,0, (500 + random 2000)], [], 0, "CAN_COLLIDE"];
        _NewVeh setDir _dir;
        _NewVeh setVehicleLock "LOCKED";

        deleteVehicle _x;   

        _NewVeh setVehiclePosition [[_pos select 0, _pos select 1, (_pos select 2) + 2], [], 0, "CAN_COLLIDE"];

        sleep 1;
        _NewVeh addEventHandler ["Killed", {
            ["ScoreAdded", ["Enemy Armor Sabotaged", 30]] remoteExec ["BIS_fnc_showNotification", 0];
            [30] execVM "Scripts\Reward.sqf";
            playMusic "EventTrack01_F_Curator";
            execVM 'Scripts\LogisDis.sqf';
        }];
    } forEach _objectLoc;
};

// Enemy Garrison Creation //
// Create Enemy Operational Vehicles if Roads are near
if (count ((getPos thisOutpostTrigger) nearRoads 200) > 0) then {
    private _nearRoad = selectRandom ((getPos thisOutpostTrigger) nearRoads 200);
    private _V = createVehicle [selectRandom (FLO_configCache get "vehicles" select 2), (_nearRoad getRelPos [0, 0]), [], 2, "NONE"];

    private _CrewGroup = createVehicleCrew _V;
    private _VC = createGroup East;
    {[_x] join _VC} forEach units _CrewGroup;

    private _nearRoad2 = thisOutpostTrigger nearRoads 1500;
    private _nearRoad1 = thisOutpostTrigger nearRoads 800;

    private _nearRoadleft = _nearRoad2 - _nearRoad1;
    private _nearRoad0 = selectRandom _nearRoadleft;
    private _I1_WP_0 = _VC addWaypoint [getPos _nearRoad0, 0];
    _I1_WP_0 SetWaypointType "MOVE";
    _I1_WP_0 setWaypointBehaviour "SAFE";
    _I1_WP_0 setWaypointSpeed "LIMITED";

    private _I1_WP_00 = _VC addWaypoint [getPos _nearRoad, 0];
    _I1_WP_00 SetWaypointType "MOVE";
    _I1_WP_00 setWaypointBehaviour "SAFE";
    _I1_WP_00 setWaypointSpeed "LIMITED";

    private _I1_WP_1 = _VC addWaypoint [getPos _nearRoad, 3];
    _I1_WP_1 SetWaypointType "CYCLE";
    _I1_WP_1 setWaypointBehaviour "SAFE";
    _I1_WP_1 setWaypointSpeed "LIMITED";
};

if (_AGGRSCORE > 10) then {
    private _nearRoad = selectRandom ((getPos thisOutpostTrigger) nearRoads 150);
    private _V = createVehicle [selectRandom (FLO_configCache get "vehicles" select 3), (_nearRoad getRelPos [0, 0]), [], 2, "NONE"];

    private _CrewGroup = createVehicleCrew _V;
    private _VC = createGroup East;
    {[_x] join _VC} forEach units _CrewGroup;

    private _nearRoad2 = thisOutpostTrigger nearRoads 1500;
    private _nearRoad1 = thisOutpostTrigger nearRoads 800;

    private _nearRoadleft = _nearRoad2 - _nearRoad1;
    private _nearRoad0 = selectRandom _nearRoadleft;
    private _I1_WP_0 = _VC addWaypoint [getPos _nearRoad0, 0];
    _I1_WP_0 SetWaypointType "MOVE";
    _I1_WP_0 setWaypointBehaviour "SAFE";
    _I1_WP_0 setWaypointSpeed "LIMITED";

    private _I1_WP_00 = _VC addWaypoint [getPos _nearRoad, 0];
    _I1_WP_00 SetWaypointType "MOVE";
    _I1_WP_00 setWaypointBehaviour "SAFE";
    _I1_WP_00 setWaypointSpeed "LIMITED";

    private _I1_WP_1 = _VC addWaypoint [getPos _nearRoad, 3];
    _I1_WP_1 SetWaypointType "CYCLE";
    _I1_WP_1 setWaypointBehaviour "SAFE";
    _I1_WP_1 setWaypointSpeed "LIMITED";
};

// If AGGRSCORE > 5, Create Enemy Assault Vehicles and assault nearest BLUFOR Outpost
if (_AGGRSCORE > 5) then {
    private _AssltDestMrks = allMapMarkers select {markerType _x == "b_installation"  && (markerColor _x == "ColorYellow" or  markerColor _x == "colorBLUFOR" or markerColor _x == "colorWEST")};  
    private _AssltDest = [_AssltDestMrks,  thisOutpostTrigger] call BIS_fnc_nearestPosition;
    [thisOutpostTrigger, _AssltDest] execVM "Scripts\VehiInsert_CSAT_2.sqf";            

};

if (_AGGRSCORE > 10) then {
    private _AssltDestMrks = allMapMarkers select {markerType _x == "b_installation"  && (markerColor _x == "ColorYellow" or  markerColor _x == "colorBLUFOR" or markerColor _x == "colorWEST")};  
    private _StrtM = [_AssltDestMrks,  thisOutpostTrigger] call BIS_fnc_nearestPosition;
    [thisOutpostTrigger, _StrtM] execVM "Scripts\VehiInsert_CSAT_2.sqf";    
};

// // Create Enemy Garrison
// _poss = [(getpos thisOutpostTrigger), 10, 80, 5, 1 , 0] call BIS_fnc_findSafePos;
// _G = [_poss, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup; 
// ((units _G) select 0) disableAI "PATH";
//     _G deleteGroupWhenEmpty true;

// _poss = [(getpos thisOutpostTrigger), 10, 80, 5, 1 , 0] call BIS_fnc_findSafePos;
// _G = [_poss, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup; 
//     _G deleteGroupWhenEmpty true;

// if (_AGGRSCORE > 5) then {
//     _poss = [(getpos thisOutpostTrigger), 10, 80, 5, 1 , 0] call BIS_fnc_findSafePos;
//     _G = [_poss, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup; 
//     ((units _G) select 0) disableAI "PATH";
//     _G deleteGroupWhenEmpty true;

//     _poss = [(getpos thisOutpostTrigger), 10, 80, 5, 1 , 0] call BIS_fnc_findSafePos;
//     _G = [_poss, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup; 
//     _G deleteGroupWhenEmpty true;
// };

// if (_AGGRSCORE > 10) then {
//     _poss = [(getpos thisOutpostTrigger), 10, 80, 5, 1 , 0] call BIS_fnc_findSafePos;
//     _G = [_poss, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup; 
//     ((units _G) select 0) disableAI "PATH";
//     _G deleteGroupWhenEmpty true;

//     _poss = [(getpos thisOutpostTrigger), 10, 80, 5, 1 , 0] call BIS_fnc_findSafePos;
//     _G = [_poss, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup; 
//     _G deleteGroupWhenEmpty true;
// };


// Create Ambient Enemy Vehicle
_poss = [(getpos thisOutpostTrigger), 10, 20, 4, 0.1 , 0] call BIS_fnc_findSafePos;
_VLAMP = createVehicle [ "Land_LampAirport_F", _poss, [], 5, "NONE"];


private _nearRoads = (getPos thisOutpostTrigger) nearRoads 150;
private _nearRoad = selectRandom _nearRoads;

if (!isNil "_nearRoad") then {
    _V = createVehicle [selectRandom (FLO_configCache get "vehicles" select 4), (_nearRoad getRelPos [0, 0]), [], 4, "NONE"];
    _nextRoad = (roadsConnectedTo _nearRoad) select 0;
    _dir = _nearRoad getDir _nextRoad;
    _V setDir _dir;

    _V = createVehicle [selectRandom (FLO_configCache get "vehicles" select 4), (_nearRoad getRelPos [0, 0]), [], 4, "NONE"];
    _nextRoad = (roadsConnectedTo _nearRoad) select 0;
    _dir = _nearRoad getDir _nextRoad;
    _V setDir _dir;
};

// Create Intel
// Reason it's like this is because we want intel to be in different buildings
_allBuildings = nearestObjects [(getpos thisOutpostTrigger), (FLO_configCache get "buildings"), 300];  

HQBLDNG = selectRandom _allBuildings;
_dir = getDirVisual HQBLDNG;
[ "Intel_01", (selectRandom (HQBLDNG buildingPos -1)), [0,0,0], _dir, false, false, true ] call LARs_fnc_spawnComp; 

HQBLDNG = selectRandom _allBuildings;
_dir = getDirVisual HQBLDNG;
[ "Intel_01", (selectRandom (HQBLDNG buildingPos -1)), [0,0,0], _dir, false, false, true ] call LARs_fnc_spawnComp; 

HQBLDNG = selectRandom _allBuildings;
_dir = getDirVisual HQBLDNG;
[ "Intel_01", (selectRandom (HQBLDNG buildingPos -1)), [0,0,0], _dir, false, false, true ] call LARs_fnc_spawnComp;

if (_AGGRSCORE > 5) then {
    HQBLDNG = selectRandom _allBuildings;
    _dir = getDirVisual HQBLDNG;
    [ "Intel_01", (selectRandom (HQBLDNG buildingPos -1)), [0,0,0], _dir, false, false, true ] call LARs_fnc_spawnComp; 
};

if (_AGGRSCORE > 10) then {
    HQBLDNG = selectRandom _allBuildings;
    _dir = getDirVisual HQBLDNG;
    [ "Intel_01", (selectRandom (HQBLDNG buildingPos -1)), [0,0,0], _dir, false, false, true ] call LARs_fnc_spawnComp; 
};

_allPositions = [];  
_allBuildings apply {_allPositions append (_x buildingPos -1)};  


// _G = [selectRandom _allPositions, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup;         
//     _G deleteGroupWhenEmpty true;
// _G = [selectRandom _allPositions, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup;     
//     _G deleteGroupWhenEmpty true;
// if (_AGGRSCORE > 5) then {
//     _G = [selectRandom _allPositions, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup;         
//     _G deleteGroupWhenEmpty true;
//     _G = [selectRandom _allPositions, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup;  
//     _G deleteGroupWhenEmpty true;
// };
// if (_AGGRSCORE > 10) then {
//     _G = [selectRandom _allPositions, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup;         
//     _G deleteGroupWhenEmpty true;
//     _G = [selectRandom _allPositions, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup;  
//     _G deleteGroupWhenEmpty true;
// };


private _HeavGuns =  nearestObjects [(getpos thisOutpostTrigger), ["O_G_HMG_02_high_F", "O_G_Mortar_01_F"], 200];

{
    private _CrewGroup = createVehicleCrew _x; 
    {_x setUnitLoadout (selectRandom (FLO_configCache get "units"))} forEach units _CrewGroup;
} forEach _HeavGuns;


// if (count nearestObjects [(getpos thisOutpostTrigger), (FLO_configCache get "bunkers"), 200] > 0) then {

//     _allBuildings = nearestObjects [(getpos thisOutpostTrigger), (FLO_configCache get "bunkers"), 200];  
//     _allPositions = [];  
//     _allBuildings apply {_allPositions append (_x buildingPos -1)}; 
 
//     _G = [selectRandom _allPositions, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup;  
//     ((units _G) select 0) disableAI "PATH";   
//     _G deleteGroupWhenEmpty true;
//     _G = [selectRandom _allPositions, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup;     
//     _G deleteGroupWhenEmpty true;     

//     if (_AGGRSCORE > 5) then {
//         _G = [selectRandom _allPositions, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup;  
//         ((units _G) select 0) disableAI "PATH";   
//         _G deleteGroupWhenEmpty true;
//         _G = [selectRandom _allPositions, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup;     
//         _G deleteGroupWhenEmpty true;     
//     };

//     if (_AGGRSCORE > 10) then {
//         _G = [selectRandom _allPositions, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup;     
//         ((units _G) select 0) disableAI "PATH";
//         _G deleteGroupWhenEmpty true;
//         _G = [selectRandom _allPositions, East,(FLO_configCache get "units")] call BIS_fnc_spawnGroup;     
//         _G deleteGroupWhenEmpty true;
//     };
// };

// // Create Triggers for Capture Zone
// _trg = createTrigger ["EmptyDetector", getPos thisOutpostTrigger, false];  
// _trg setTriggerArea [1000, 1000, 0, false, 200];  
// _trg setTriggerTimeout [2, 2, 2, true];
// _trg setTriggerActivation ["WEST", "PRESENT", false];  
// _trg setTriggerStatements [  
// "this",  "[thisTrigger, 600] execVM 'Scripts\ZONEs.sqf';", ""]; 
  
  
// _trg = createTrigger ["EmptyDetector", getPos thisOutpostTrigger, false];  
// _trg setTriggerArea [120, 120, 0, false, 200];  
// _trg setTriggerTimeout [10, 10, 10, true];
// _trg setTriggerActivation ["WEST SEIZED", "PRESENT", true];  
// _trg setTriggerStatements [  
// "this",  "  

// [parseText '<t color=""#1AA3FF"" font=""PuristaBold"" align = ""right"" shadow = ""1"" size=""2"">SITREP</t><br /><t color=""#959393"" align = ""right"" shadow = ""1"" size=""0.8"">Friendly Forces Dominating the Battle,</t><br /><t color=""#959393"" align = ""right"" shadow = ""1"" size=""0.8"">Keep Up the Fight, We will Capture and Secure the Outpost,</t>', [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ['BIS_fnc_textTiles', 0];
// _allMarks = allMapMarkers select {markerType _x == 'o_support'};  
// _FOBMrk = [_allMarks,  thisTrigger] call BIS_fnc_nearestPosition;
//                     _FOBMrk setMarkerColor 'ColorGrey' ;    
//                                 _attackingAtGrid = mapGridPosition getMarkerPos _FOBMrk;
//                             [[west,'HQ'], 'Friendly Forces Dominating the Battle at grid ' + _attackingAtGrid] remoteExec ['sideChat', 0];

// [thisTrigger] execVM 'Scripts\Outpost_CSAT_CAPTURE_West.sqf';

// ", "


// _allMarks = allMapMarkers select {markerType _x == 'o_support'};  
// _FOBMrk = [_allMarks,  thisTrigger] call BIS_fnc_nearestPosition;
//                     _FOBMrk setMarkerColor 'colorOPFOR' ;    

// "]; 

// Create Intel
[thisOutpostTrigger, 200] execVM "Scripts\INTLitems.sqf";
// Sleep
sleep 2 ;
