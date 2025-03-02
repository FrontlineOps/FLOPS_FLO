params [["_thisCapitalTrigger", objNull, [objNull]]];

// Initialize variables
private _triggerPos = getPos _thisCapitalTrigger;
private _AGGRSCORE = parseNumber (markerText ((allMapMarkers select {markerColor _x == "Color6_FD_F"}) # 0));

// Supply crate types
private _CRT = [
    "Box_IND_WpsSpecial_F", "Box_IND_WpsSpecial_F",
    "Box_East_WpsSpecial_F", "Box_East_WpsSpecial_F",
    "Box_IND_Support_F", "Box_IND_Support_F", "Box_IND_Support_F",
    "Box_East_Support_F", "Box_East_Support_F", "Box_East_Support_F",
    "Box_CSAT_Equip_F", "Box_AAF_Equip_F",
    "Box_East_WpsLaunch_F", "Box_East_WpsLaunch_F",
    "Box_IND_WpsLaunch_F", "Box_IND_WpsLaunch_F",
    "Box_East_AmmoOrd_F", "Box_East_Ammo_F",
    "Box_IND_Ammo_F", "Box_IND_AmmoOrd_F",
    "Box_East_Wps_F", "Box_IND_Wps_F"
];

// Function to spawn resource boxes
private _fnc_spawnResourceBox = {
    params ["_triggerPos"];
    private _pos = _triggerPos getPos [10 + random 250, random 360];
    private _box = createVehicle ["CargoNet_01_box_F", [_pos # 0, _pos # 1, (_pos # 2) + 6], [], 2, "NONE"];
    _box allowDamage false;
};

// Function to spawn watch posts
private _fnc_spawnWatchPost = {
    params ["_road", "_dir"];
    if (!isNull _road) then {
        [_road, _dir] execVM "Scripts\Objectives\WatchPostBB.sqf";
    };
};

// Function to create patrol group
private _fnc_createPatrolGroup = {
    params ["_spawnPos", "_patrolPos", "_radius"];
    private _group = [_spawnPos, East, [selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units")]] call BIS_fnc_spawnGroup;
    [_group, _patrolPos, _radius] call BIS_fnc_taskPatrol;
    _group deleteGroupWhenEmpty true;
    
    private _leader = leader _group;
    _leader addEventHandler ["Killed", {
        params ["_unit"];
        private _QRF = selectRandom ["Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"];
        [_unit] execVM _QRF;
        private _flare = "F_20mm_Red" createVehicle [getPos _unit # 0, getPos _unit # 1, 120];
        _flare setVelocity [0,0,-0.1];
    }];
    
    _group
};

// Function to spawn vehicle patrol
private _fnc_spawnVehiclePatrol = {
    params ["_triggerPos", "_vehType"];
    
    private _nearRoad = selectRandom (_triggerPos nearRoads 150);
    if (isNull _nearRoad) exitWith {};
    
    private _veh = createVehicle [_vehType, (_nearRoad getRelPos [0, 0]), [], 2, "NONE"];
    private _crewGroup = createVehicleCrew _veh;
    private _vehGroup = createGroup East;
    {[_x] join _vehGroup} forEach units _crewGroup;
    
    sleep 3;
    
    private _wp0Pos = [_veh, 70, 300, 1, 0, 1, 0] call BIS_fnc_findSafePos;
    private _wp0Road = (_wp0Pos nearRoads 200) # 0;
    
    {
        private _wp = _vehGroup addWaypoint [getPos _x, 0];
        _wp setWaypointType "MOVE";
        _wp setWaypointBehaviour "SAFE";
        _wp setWaypointSpeed "LIMITED";
    } forEach [_wp0Road, _nearRoad];
    
    private _wpCycle = _vehGroup addWaypoint [getPos _nearRoad, 3];
    _wpCycle setWaypointType "CYCLE";
};

// Function to create garrison unit
private _fnc_createGarrisonUnit = {
    params ["_building"];
    private _posAGL = ASLToAGL getPosASL _building;
    private _group = [_posAGL, East, [selectRandom (FLO_configCache get "units")]] call BIS_fnc_spawnGroup;
    private _unit = (units _group) # 0;
    
    [_unit, 10, _posAGL, "ATL"] call BIS_fnc_setHeight;
    _unit setUnitPos "MIDDLE";
    _unit disableAI "PATH";
    _group deleteGroupWhenEmpty true;
    
    _group
};

// Function to setup single HQ
private _fnc_setupHQ = {
    params ["_building", "_CRT"];
    
    private _dir = getDirVisual _building;
    private _buildingPos = selectRandom (_building buildingPos -1);
    
    // Setup intel composition
    ["Intel_01", _buildingPos, [0,0,0], _dir, false, false, true] call LARs_fnc_spawnComp;
    
    // Create supply boxes
    for "_i" from 1 to 2 do {
        createVehicle [selectRandom _CRT, selectRandom (_building buildingPos -1), [], 0, "NONE"];
    };
    
    // Spawn garrison units
    for "_i" from 1 to 3 do {
        private _group = [selectRandom (_building buildingPos -1), East, [selectRandom (FLO_configCache get "units")]] call BIS_fnc_spawnGroup;
        private _unit = (units _group) # 0;
        _unit disableAI "PATH";
        _group deleteGroupWhenEmpty true;
    };
};

// Main execution
sleep 15;

// Spawn resource boxes
for "_i" from 1 to 5 do {
    private _pos = _triggerPos getPos [10 + random 250, random 360];
    private _box = createVehicle ["CargoNet_01_box_F", [_pos # 0, _pos # 1, (_pos # 2) + 6], [], 2, "NONE"];
    _box allowDamage false;
};

// Spawn watch posts if roads are available
if (count (_triggerPos nearRoads 300) > 0) then {
    // Initial watch posts
    {
        private _nearRoad = selectRandom (_triggerPos nearRoads _x);
        if (!isNull _nearRoad) then {
            private _nextRoad = (roadsConnectedTo _nearRoad) # 0;
            [_nearRoad, _nearRoad getDir _nextRoad] call _fnc_spawnWatchPost;
        };
    } forEach [150, 200];
    
    // Additional watch posts based on aggression
    if (_AGGRSCORE > 5) then {
        {
            private _nearRoad = selectRandom (_triggerPos nearRoads _x);
            if (!isNull _nearRoad) then {
                private _nextRoad = (roadsConnectedTo _nearRoad) # 0;
                [_nearRoad, _nearRoad getDir _nextRoad] call _fnc_spawnWatchPost;
            };
        } forEach [200, 300];
    };
    
    if (_AGGRSCORE > 10) then {
        private _nearRoad = selectRandom (_triggerPos nearRoads 300);
        if (!isNull _nearRoad) then {
            private _nextRoad = (roadsConnectedTo _nearRoad) # 0;
            [_nearRoad, _nearRoad getDir _nextRoad] call _fnc_spawnWatchPost;
        };
    };
};

// Spawn initial patrol groups
{
    private _spawnPos = _triggerPos getPos [10 + random 90, random 360];
    private _patrolPos = _triggerPos getPos [10 + random 90, random 360];
    [_spawnPos, _patrolPos, 300] call _fnc_createPatrolGroup;
} forEach [1,2];

// Spawn additional groups based on aggression
if (_AGGRSCORE > 5) then {
    private _spawnPos = _triggerPos getPos [10 + random 90, random 360];
    private _patrolPos = _triggerPos getPos [10 + random 90, random 360];
    [_spawnPos, _patrolPos, 400] call _fnc_createPatrolGroup;
};

if (_AGGRSCORE > 10) then {
    private _spawnPos = _triggerPos getPos [10 + random 90, random 360];
    private _patrolPos = _triggerPos getPos [10 + random 90, random 360];
    [_spawnPos, _patrolPos, 500] call _fnc_createPatrolGroup;
};

// Spawn vehicles if logistics are enabled
if (LOGDIS == 0 && {count (_triggerPos nearRoads 150) > 0}) then {
    private _fnc_createVehicle = {
        params ["_vehType"];
        private _nearRoad = selectRandom (_triggerPos nearRoads 150);
        private _veh = createVehicle [_vehType, (_nearRoad getRelPos [0, 0]), [], 2, "NONE"];
        
        private _crewGroup = createVehicleCrew _veh;
        private _vehGroup = createGroup East;
        {[_x] join _vehGroup} forEach units _crewGroup;
        
        sleep 3;
        
        private _wp0Pos = [_veh, 70, 300, 1, 0, 1, 0] call BIS_fnc_findSafePos;
        private _wp0Road = (_wp0Pos nearRoads 200) # 0;
        
        {
            private _wp = _vehGroup addWaypoint [getPos _x, 0];
            _wp setWaypointType "MOVE";
            _wp setWaypointBehaviour "SAFE";
            _wp setWaypointSpeed "LIMITED";
        } forEach [_wp0Road, _nearRoad];
        
        private _wpCycle = _vehGroup addWaypoint [getPos _nearRoad, 3];
        _wpCycle setWaypointType "CYCLE";
    };
    
    // Spawn initial vehicles
    [selectRandom (FLO_configCache get "vehicles" select 3)] call _fnc_createVehicle;
    [selectRandom (FLO_configCache get "vehicles" select 2)] call _fnc_createVehicle;
    
    // Additional vehicles based on aggression
    if (_AGGRSCORE > 5) then {
        [selectRandom (FLO_configCache get "vehicles" select 3)] call _fnc_createVehicle;
        [selectRandom (FLO_configCache get "vehicles" select 2)] call _fnc_createVehicle;
    };
    
    if (_AGGRSCORE > 10) then {
        [selectRandom (FLO_configCache get "vehicles" select 3)] call _fnc_createVehicle;
        [selectRandom (FLO_configCache get "vehicles" select 2)] call _fnc_createVehicle;
    };
};

// Get suitable buildings for HQ
private _hqBuildings = nearestObjects [_triggerPos, ["HOUSE"], 100] select {count (_x buildingPos -1) > 2};

// Setup initial HQs
for "_i" from 0 to 2 min ((count _hqBuildings) - 1) do {
    [_hqBuildings # _i, _CRT] call _fnc_setupHQ;
};

// Setup additional HQs based on aggression
if (_AGGRSCORE > 5 && {count _hqBuildings > 3}) then {
    [_hqBuildings # 3, _CRT] call _fnc_setupHQ;
};

if (_AGGRSCORE > 10 && {count _hqBuildings > 4}) then {
    [_hqBuildings # 4, _CRT] call _fnc_setupHQ;
};

// Function to setup avenger system
private _fnc_setupAvenger = {
    params ["_triggerPos"];
    
    private _avengerTrigger = createTrigger ["EmptyDetector", _triggerPos, false];
    _avengerTrigger setTriggerArea [400, 400, 0, false, 50];
    _avengerTrigger setTriggerTimeout [30, 30, 30, true];
    _avengerTrigger setTriggerActivation ["WEST", "PRESENT", true];
    _avengerTrigger setTriggerStatements [
        "this && AVENGLOCC == 1 && ({((side _x) == east) && (getPos _x distance thisTrigger < 200)} count allUnits < 25)",
        "
        AVENGLOCC = 0;
        publicVariable 'AVENGLOCC';
        
        if (({((side _x) == east) && (position _x inArea thisTrigger)} count allUnits < 25) && ({(getNumber (configfile >> 'CfgVehicles' >> typeOf _x >> 'side') == 0) && (getPos _x inArea thisTrigger)} count allDeadMen > 0)) then {
            private _allDEAD = allDeadMen select {(getNumber (configfile >> 'CfgVehicles' >> typeOf _x >> 'side') == 0) && (getPos _x inArea thisTrigger)};
            private _aDEAD = _allDEAD # 0;
            private _pos = getPos _aDEAD;
            private _buildings = nearestObjects [thisTrigger, ['HOUSE'], 60] select {count (_x buildingPos -1) > 1};
            private _HQ = selectRandom _buildings;
            private _avenger = [selectRandom (_HQ buildingPos -1), East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
            _avenger deleteGroupWhenEmpty true;
            
            private _wp = _avenger addWaypoint [_pos, 0];
            _wp setWaypointType 'SAD';
        };
        
        execVM 'Scripts\AVENGLOCCER.sqf';
        ",
        ""
    ];
};

// Setup avenger system
[_triggerPos] call _fnc_setupAvenger;

// Function to create trigger
private _fnc_createTrigger = {
    params ["_pos", "_area", "_timeout", "_activation", "_statements"];
    
    private _trigger = createTrigger ["EmptyDetector", _pos, false];
    _trigger setTriggerArea _area;
    _trigger setTriggerTimeout [_timeout, _timeout, _timeout, true];
    _trigger setTriggerActivation _activation;
    _trigger setTriggerStatements _statements;
    
    _trigger
};

// Create zone trigger
[
    _triggerPos,
    [1000, 1000, 0, false, 200],
    2,
    ["WEST", "PRESENT", false],
    ["this", "[thisTrigger, 2000] execVM 'Scripts\Objectives\ZONEs.sqf';", ""]
] call _fnc_createTrigger;

// Create CQB trigger
[
    _triggerPos,
    [300, 300, 0, false, 40],
    2,
    ["WEST", "PRESENT", false],
    ["this", "[thisTrigger] execVM 'Scripts\CQBURB.sqf';", ""]
] call _fnc_createTrigger;

// Create capture trigger
[
    _triggerPos,
    [220, 220, 0, false, 200],
    10,
    ["WEST SEIZED", "PRESENT", true],
    [
        "this",
        "
        [parseText '<t color=""#1AA3FF"" font=""PuristaBold"" align = ""right"" shadow = ""1"" size=""2"">SITREP</t><br /><t color=""#959393"" align = ""right"" shadow = ""1"" size=""0.8"">Friendly Forces Dominating the Battle,</t><br /><t color=""#959393"" align = ""right"" shadow = ""1"" size=""0.8"">Keep Up the Fight, We will Capture and Secure the Outpost,</t>', [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ['BIS_fnc_textTiles', 0];
        
        private _allMarks = allMapMarkers select {markerType _x == 'n_installation'};
        private _FOBMrk = [_allMarks, thisTrigger] call BIS_fnc_nearestPosition;
        _FOBMrk setMarkerColor 'ColorGrey';
        private _attackingAtGrid = mapGridPosition getMarkerPos _FOBMrk;
        [[west,'HQ'], 'Friendly Forces Dominating the Battle at grid ' + _attackingAtGrid] remoteExec ['sideChat', 0];
        
        [thisTrigger] execVM 'Scripts\City_CSAT_CAPTURE_West.sqf';
        ",
        "
        private _allMarks = allMapMarkers select {markerType _x == 'n_installation'};
        private _FOBMrk = [_allMarks, thisTrigger] call BIS_fnc_nearestPosition;
        _FOBMrk setMarkerColor 'colorOPFOR';
        "
    ]
] call _fnc_createTrigger;

// Remove units from Zeus
{
    if !((side _x) == west) then {
        ZEUS removeCuratorEditableObjects [[_x], true];
    };
} forEach allUnits;

// Initialize intel items
[_thisCapitalTrigger, 500] execVM "Scripts\INTLitems.sqf";

sleep 2;

