/*
    Author: [FLO]
    Description: Creates a watchpost at a road position with AI defenders
    
    Parameter(s):
        _this select 0: OBJECT - Road object
        _this select 1: NUMBER - Direction
    
    Returns: HASHMAP - Watchpost data structure
*/

params [
    ["_nearRoad", objNull, [objNull]],
    ["_dir", 0, [0]]
];

if (isNull _nearRoad) exitWith {
    diag_log "[FLO] Error: Invalid road object passed to WatchPostBB.sqf";
    objNull
};

// Initialize watchpost data structure
private _watchpostData = createHashMapObject [[
    ["position", getPos _nearRoad],
    ["direction", _dir],
    ["units", []],
    ["groups", []]
]];

// Define available watchpost compositions
private _watchpostTypes = [
    "Watchpost_1", "Watchpost_2", "Watchpost_3", "Watchpost_4", 
    "Watchpost_5", "Watchpost_6", "Watchpost_7", "Watchpost_8",
    "Watchpost_9", "Watchpost_10"
];

// Clear terrain objects
private _terrainObjects = nearestTerrainObjects [_watchpostData get "position", ["House", "TREE", "SMALL TREE", "BUSH", "ROCK", "ROCKS"], 15];
{_x hideObjectGlobal true} forEach _terrainObjects;

// Spawn composition
private _composition = [
    selectRandom _watchpostTypes,
    _watchpostData get "position",
    [0,0,0],
    random 350,
    false,
    false,
    true
] call LARs_fnc_spawnComp;

// Spawn patrol groups
private _spawnPatrolGroup = {
    params ["_pos", "_radius"];
    private _group = [
        _pos getPos [10 + random 20, random 360],
        East,
        [selectRandom East_Units, selectRandom East_Units]
    ] call BIS_fnc_spawnGroup;
    
    [_group, _pos, _radius] call BIS_fnc_taskPatrol;
    _group deleteGroupWhenEmpty true;
    (_watchpostData get "groups") pushBack _group;
    _group
};

[_watchpostData get "position", 50] call _spawnPatrolGroup;

// Initialize building positions
private _buildings = nearestObjects [_watchpostData get "position", ["HOUSE", "Strategic"], 20];
private _positions = [];
{
    _positions append (_x buildingPos -1);
} forEach _buildings;

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

// Spawn building defenders
for "_i" from 1 to 3 do {
    if !(_positions isEqualTo []) then {
        [selectRandom _positions, true] call _spawnStaticDefender;
    };
};

// Spawn perimeter defenders
for "_i" from 1 to 5 do {
    private _pos = (_watchpostData get "position") getPos [15 + random 15, random 360];
    [_pos, true] call _spawnStaticDefender;
};

[(_watchpostData get "position") getPos [15 + random 15, random 360], false] call _spawnStaticDefender;

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
    private _heavyGun = _heavyWeapons select 0;
    if (!isNil "_heavyGun") then {
        private _crew = createVehicleCrew _heavyGun;
        (_watchpostData get "groups") pushBack (group _crew);
    };
};

// Return the watchpost data
_watchpostData
