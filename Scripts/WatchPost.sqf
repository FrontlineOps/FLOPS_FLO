/*
    Author: [FLO]
    Description: Creates a watchpost at specified location with AI defenders
    
    Parameter(s):
        _this select 0: LOCATION - Mount selection location
        _this select 1: STRING - Watchpost composition name
    
    Returns: OBJECT - Watchpost composition object
*/

params [
    ["_mountSel", locationNull, [locationNull]],
    ["_watchpostComp", "", [""]]
];

if (isNull _mountSel || _watchpostComp == "") exitWith {
    diag_log "[FLO] Error: Invalid parameters passed to WatchPost.sqf";
    objNull
};

// Initialize watchpost data structure
private _watchpostData = createHashMapObject [[
    ["position", locationPosition _mountSel],
    ["composition", _watchpostComp],
    ["units", []],
    ["groups", []]
]];

// Get aggression score from marker
private _aggrScore = 0;
private _markers = allMapMarkers select {markerColor _x == "Color6_FD_F"};
if (count _markers > 0) then {
    _aggrScore = parseNumber (markerText (_markers select 0));
};

// Clear terrain objects
private _terrainObjects = nearestTerrainObjects [_watchpostData get "position", ["House", "TREE", "SMALL TREE", "BUSH", "ROCK", "ROCKS"], 15];
{_x hideObjectGlobal true} forEach _terrainObjects;

// Calculate watchpost direction
private _wpDir = 0;
private _nearbyHouses = nearestObjects [_watchpostData get "position", ["House"], 200];
if !(_nearbyHouses isEqualTo []) then {
    _wpDir = getDirVisual (_nearbyHouses select 0);
} else {
    _wpDir = random 360;
};

// Spawn composition
private _composition = [
    _watchpostData get "composition",
    _watchpostData get "position",
    [0,0,0],
    _wpDir,
    true
] call LARs_fnc_spawnComp;

// Adjust composition objects
{
    _x setVectorUp [0,0,1];
} forEach ([_composition] call LARs_fnc_getCompObjects);

// Initialize building positions
private _buildings = nearestObjects [_watchpostData get "position", ["HOUSE", "Strategic"], 20];
private _positions = [];
{
    _positions append (_x buildingPos -1);
} forEach _buildings;

// Spawn patrol groups
private _spawnPatrolGroup = {
    params ["_pos", "_radius"];
    private _group = [
        _pos getPos [10 + random 10, random 360],
        East,
        [selectRandom East_Units, selectRandom East_Units]
    ] call BIS_fnc_spawnGroup;
    
    [_group, _pos, _radius] call BIS_fnc_taskPatrol;
    _group deleteGroupWhenEmpty true;
    (_watchpostData get "groups") pushBack _group;
    _group
};

[_watchpostData get "position", 50] call _spawnPatrolGroup;

if (_aggrScore > 5) then {
    [_watchpostData get "position", 100] call _spawnPatrolGroup;
};

// Spawn static defenders
private _spawnStaticDefender = {
    params ["_pos", "_disablePath"];
    private _group = [_pos, East, [selectRandom East_Units]] call BIS_fnc_spawnGroup;
    if (_disablePath) then {
        (units _group select 0) disableAI "PATH";
    };
    _group deleteGroupWhenEmpty true;
    (_watchpostData get "groups") pushBack _group;
    _group
};

// Spawn initial defenders
for "_i" from 1 to 3 do {
    if !(_positions isEqualTo []) then {
        [selectRandom _positions, true] call _spawnStaticDefender;
    };
};

// Spawn additional defenders based on aggression score
if (_aggrScore > 5) then {
    for "_i" from 1 to 3 do {
        private _pos = if (_positions isEqualTo []) then {
            _watchpostData get "position" getPos [10 + random 10, random 360]
        } else {
            selectRandom _positions
        };
        [_pos, true] call _spawnStaticDefender;
    };
};

// Setup heavy weapons
private _weaponSetup = {
    {
        [_x, 3, position _x, "ATL"] call BIS_fnc_setHeight;
        _x setVectorUp [0,0,1];
    } forEach _this;
};

private _heavyWeapons = nearestObjects [_watchpostData get "position", ["O_G_HMG_02_high_F", "O_G_Mortar_01_F"], 100];
_heavyWeapons call _weaponSetup;

if !(_heavyWeapons isEqualTo []) then {
    {
        private _crewGroup = createVehicleCrew _x;
        if (!isNull _crewGroup) then {
            _crewGroup deleteGroupWhenEmpty true;
            (_watchpostData get "groups") pushBack _crewGroup;
            
            // Add crew members to units array
            {
                (_watchpostData get "units") pushBack _x;
            } forEach (units _crewGroup);
        };
    } forEach _heavyWeapons;
};

// Return the watchpost data
_watchpostData
