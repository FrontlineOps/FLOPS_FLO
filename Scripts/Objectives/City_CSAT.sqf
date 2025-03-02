// City Hostile Forces System
params ["_thisCityTrigger"];

// Initialize variables
private _triggerPos = getPos _thisCityTrigger;
private _aggrScore = parseNumber (markerText ((allMapMarkers select {markerColor _x == "Color6_FD_F"}) select 0));

// Supply box spawn function
private _fnc_spawnSupplyBox = {
    params ["_pos"];
    private _spawnPos = _pos getPos [10 + random 150, random 360];
    private _box = createVehicle ["CargoNet_01_box_F", 
        [_spawnPos select 0, _spawnPos select 1, (_spawnPos select 2) + 6], 
        [], 2, "NONE"];
    _box allowDamage false;
    _box
};

// Spawn patrol group function
private _fnc_spawnPatrol = {
    params ["_pos", "_radius"];
    private _patrolPos = _pos getPos [10 + random 90, random 360];
    private _group = [_patrolPos, East, [
        selectRandom East_Units,
        selectRandom East_Units,
        selectRandom East_Units,
        selectRandom East_Units
    ]] call BIS_fnc_spawnGroup;
    
    [_group, _patrolPos, _radius] call BIS_fnc_taskPatrol;
    _group deleteGroupWhenEmpty true;
    
    private _leader = leader _group;
    _leader removeAllEventHandlers "Killed";
    _leader addEventHandler ["Killed", {
        params ["_unit"];
        private _qrf = selectRandom ["Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"];
        [_unit] execVM _qrf;
        private _flare = createVehicle ["F_20mm_Red", 
            [getPos _unit select 0, getPos _unit select 1, 120],
            [], 0, "NONE"];
        _flare setVelocity [0,0,-0.1];
    }];
    _group
};

// Vehicle patrol function
private _fnc_spawnVehiclePatrol = {
    params ["_pos"];
    private _roads = _pos nearRoads 150;
    if (count _roads == 0) exitWith {};
    
    private _spawnRoad = selectRandom _roads;
    private _veh = createVehicle [selectRandom East_Ground_Vehicles_Light, 
        (_spawnRoad getRelPos [0, 0]), [], 2, "NONE"];
    
    private _crew = createVehicleCrew _veh;
    private _group = createGroup East;
    {[_x] join _group} forEach units _crew;
    
    private _patrolRoads = (_pos nearRoads 1500) - (_pos nearRoads 800);
    if (count _patrolRoads > 0) then {
        private _destRoad = selectRandom _patrolRoads;
        {
            private _wp = _group addWaypoint [getPos _x, 0];
            _wp setWaypointType "MOVE";
            _wp setWaypointBehaviour "SAFE";
            _wp setWaypointSpeed "LIMITED";
        } forEach [_destRoad, _spawnRoad];
        
        private _cycle = _group addWaypoint [getPos _spawnRoad, 3];
        _cycle setWaypointType "CYCLE";
        _cycle setWaypointBehaviour "SAFE";
        _cycle setWaypointSpeed "LIMITED";
    };
    [_veh, _group]
};

// Spawn supply boxes
for "_i" from 1 to 3 do {
    [_triggerPos] call _fnc_spawnSupplyBox;
};

// Spawn watch posts based on aggression
if (count (_triggerPos nearRoads 150) > 0) then {
    private _fnc_createWatchPost = {
        params ["_pos"];
        private _road = selectRandom (_pos nearRoads 150);
        private _connectedRoad = (roadsConnectedTo _road) select 0;
        if (!isNil "_connectedRoad") then {
            private _dir = _road getDir _connectedRoad;
            [_road, _dir] execVM "Scripts\Objectives\WatchPostBB.sqf";
        };
    };
    
    [_triggerPos] call _fnc_createWatchPost;
    if (_aggrScore > 5) then { [_triggerPos] call _fnc_createWatchPost; };
    if (_aggrScore > 10) then { [_triggerPos] call _fnc_createWatchPost; };
};

// Launch assault on nearest installation
private _assaultTargets = allMapMarkers select {
    markerType _x == "b_installation" && 
    (markerColor _x in ["ColorYellow", "colorBLUFOR", "colorWEST"])
};
if (count _assaultTargets > 0) then {
    private _target = [_assaultTargets, _thisCityTrigger] call BIS_fnc_nearestPosition;
    [_thisCityTrigger, _target] execVM "Scripts\VehiInsert_CSAT_2.sqf";
    
    if (_aggrScore > 10) then {
        [_thisCityTrigger, _target] execVM "Scripts\VehiInsert_CSAT_2.sqf";
    };
};

// Spawn infantry patrols
[_triggerPos, 50] call _fnc_spawnPatrol;
if (_aggrScore > 5) then { [_triggerPos, 100] call _fnc_spawnPatrol; };
if (_aggrScore > 10) then { [_triggerPos, 200] call _fnc_spawnPatrol; };

// Spawn vehicle patrols if enabled
if (LOGDIS == 0) then {
    [_triggerPos] call _fnc_spawnVehiclePatrol;
    if (_aggrScore > 5) then { [_triggerPos] call _fnc_spawnVehiclePatrol; };
    if (_aggrScore > 10) then { [_triggerPos] call _fnc_spawnVehiclePatrol; };
};

// Spawn garrison in HQ building
private _hqBuildings = nearestObjects [_triggerPos, ["Land_Cargo_HQ_V1_F", "Land_Cargo_HQ_V2_F", "Land_Cargo_HQ_V3_F"], 150];
if (count _hqBuildings > 0) then {
    private _hq = _hqBuildings select 0;
    private _positions = _hq buildingPos -1;
    
    if (count _positions > 0) then {
        {
            private _group = [selectRandom _positions, East, [selectRandom East_Units]] call BIS_fnc_spawnGroup;
            _group deleteGroupWhenEmpty true;
            {
                _x disableAI "PATH";
                _x setUnitPos "UP";
            } forEach units _group;
        } forEach [1,2,3];
        
        if (_aggrScore > 5) then {
            for "_i" from 1 to 2 do {
                private _group = [selectRandom _positions, East, [selectRandom East_Units]] call BIS_fnc_spawnGroup;
                _group deleteGroupWhenEmpty true;
            };
        };
    };
};

// Setup reinforcement trigger
private _trgINT = createTrigger ["EmptyDetector", _triggerPos, false];
_trgINT setTriggerArea [200, 200, 0, false, 20];
_trgINT setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_trgINT setTriggerTimeout [10, 10, 10, true];
_trgINT setTriggerStatements [
    "this && AVENGLOCC == 1 && ({((side _x) == east) && (getPos _x distance thisTrigger < 200)} count allUnits < 25)",
    "
    AVENGLOCC = 0;
    publicVariable 'AVENGLOCC';
    [thisTrigger, 200] call FLO_fnc_requestQRF;
    ",
    ""
];

// Setup capture trigger
private _trg = createTrigger ["EmptyDetector", _triggerPos, false];
_trg setTriggerArea [220, 220, 0, false, 200];
_trg setTriggerActivation ["WEST SEIZED", "PRESENT", true];
_trg setTriggerTimeout [10, 10, 10, true];
_trg setTriggerStatements [
    "this",
    "
    [parseText '<t color=""#1AA3FF"" font=""PuristaBold"" align = ""right"" shadow = ""1"" size=""2"">SITREP</t><br /><t color=""#959393"" align = ""right"" shadow = ""1"" size=""0.8"">Friendly Forces Dominating the Battle,</t><br /><t color=""#959393"" align = ""right"" shadow = ""1"" size=""0.8"">Keep Up the Fight, We will Capture and Secure the Outpost,</t>', [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ['BIS_fnc_textTiles', 0];
    _allMarks = allMapMarkers select {markerType _x == 'o_installation'};
    _FOBMrk = [_allMarks, thisTrigger] call BIS_fnc_nearestPosition;
    _FOBMrk setMarkerColor 'ColorGrey';
    _attackingAtGrid = mapGridPosition getMarkerPos _FOBMrk;
    [[west,'HQ'], 'Friendly Forces Dominating the Battle at grid ' + _attackingAtGrid] remoteExec ['sideChat', 0];
    [thisTrigger] execVM 'Scripts\Objectives\City_CSAT_CAPTURE_West.sqf';
    ",
    ""
];

// Setup CQB trigger
private _trgCQB = createTrigger ["EmptyDetector", _triggerPos, false];
_trgCQB setTriggerArea [200, 200, 0, false, 40];
_trgCQB setTriggerActivation ["WEST", "PRESENT", false];
_trgCQB setTriggerTimeout [10, 10, 10, true];
_trgCQB setTriggerStatements [
    "this",
    "[thisTrigger] execVM 'Scripts\CQBURB.sqf';",
    ""
];

// Setup item spawn trigger
[_thisCityTrigger, 300] execVM "Scripts\INTLitems.sqf";