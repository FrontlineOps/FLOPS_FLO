params ["_targetPos", "_intensity"];

// Initialize global artillery tracking if not exists
if (isNil "FLO_artilleryBatteries") then {
    FLO_artilleryBatteries = createHashMap;
};

private _artilleryTypes = selectRandom ((FLO_configCache get "vehicles") select 7);
private _maxBatteries = 4 + (floor random 6); // Random between 4 and 10 batteries
private _currentBatteries = count FLO_artilleryBatteries;
private _newBatteriesCount = (1 + floor(_intensity/3)) min (_maxBatteries - _currentBatteries);

// Define artillery magazines
private _artilleryMagazines = [
    "32Rnd_155mm_Mo_shells_O",
    "6Rnd_155mm_Mo_smoke_O",
    "2Rnd_155mm_Mo_Cluster_O"
];

// Create new batteries if under cap
if (_newBatteriesCount > 0) then {
    for "_i" from 1 to _newBatteriesCount do {
        // Find position far from target but with good firing position
        private _artPos = [_targetPos, 5000, 10000, 10, 0] call BIS_fnc_findSafePos;
        private _arty = createVehicle [_artilleryTypes, _artPos, [], 0, "NONE"];
        createVehicleCrew _arty;
        
        // Set group behavior
        private _artGroup = group _arty;
        _artGroup setBehaviour "COMBAT";
        _artGroup setCombatMode "RED";
        _artGroup enableDynamicSimulation true;
        _artGroup enableAttack false;
        {
            _x disableAI "PATH";
            _x disableAI "MOVE";
        } forEach units _artGroup;
        
        // Create fortifications around battery
        private _fortTypes = ["Land_BagBunker_Small_F", "Land_BagFence_Long_F", "Land_BagFence_Round_F"];
        private _forts = [];
        for "_j" from 0 to 5 do {
            private _fortPos = _arty getPos [10, _j * 60];
            private _fort = createVehicle [selectRandom _fortTypes, _fortPos, [], 0, "NONE"];
            _fort setDir (_fort getDir _arty);
            _forts pushBack _fort;
        };
        
        // Add to tracking
        FLO_artilleryBatteries set [netId _arty, createHashMapFromArray [
            ["vehicle", _arty],
            ["group", _artGroup],
            ["forts", _forts],
            ["lastFired", time],
            ["position", getPosASL _arty]
        ]];
    };
};

// Execute fire mission for each battery
{
    private _batteryInfo = _y;
    private _arty = _batteryInfo get "vehicle";
    private _selectedMagazine = selectRandom _artilleryMagazines;
    
    if (alive _arty && _targetPos inRangeOfArtillery [[_arty], _selectedMagazine]) then {
        for "_j" from 1 to (3 + random 3) do {
            _arty doArtilleryFire [
                _targetPos getPos [random 100, random 360],
                _selectedMagazine,
                1
            ];
        };
        _batteryInfo set ["lastFired", time];
    };
} forEach FLO_artilleryBatteries;

// Clean up destroyed batteries from tracking
private _toRemove = [];
{
    private _batteryInfo = _y;
    private _arty = _batteryInfo get "vehicle";
    private _group = _batteryInfo get "group";
    private _forts = _batteryInfo get "forts";
    
    if (!alive _arty) then {
        if (!isNull _group) then {
            {deleteVehicle _x} forEach units _group;
            deleteGroup _group;
        };
        {deleteVehicle _x} forEach _forts;
        _toRemove pushBack _x;
    };
} forEach FLO_artilleryBatteries;

{FLO_artilleryBatteries deleteAt _x} forEach _toRemove;
