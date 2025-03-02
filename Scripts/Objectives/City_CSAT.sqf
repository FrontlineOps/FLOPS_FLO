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