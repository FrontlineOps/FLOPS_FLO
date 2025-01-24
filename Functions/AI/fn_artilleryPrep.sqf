params ["_targetPos", "_intensity"];

// Initialize global artillery tracking if not exists
if (isNil "FLO_artilleryBatteries") then {
    FLO_artilleryBatteries = createHashMap;
};

private _artilleryTypes = selectRandom ((FLO_configCache get "vehicles") select 7);
private _maxBatteries = 4 + (floor random 6); // Random between 4 and 10 batteries
private _currentBatteries = count FLO_artilleryBatteries;
private _newBatteriesCount = (1 + floor(_intensity/3)) min (_maxBatteries - _currentBatteries);

// Get compatible magazines for artillery pieces
private _fnc_getArtilleryMags = {
    params ["_vehType"];
    private _config = configFile >> "CfgVehicles" >> _vehType;
    private _mags = getArray (_config >> "Turrets" >> "MainTurret" >> "magazines");
    private _shellTypes = [];
    
    {
        private _magConfig = configFile >> "CfgMagazines" >> _x;
        if (getNumber (_magConfig >> "type") in [256, 1]) then {
            _shellTypes pushBackUnique _x;
        };
    } forEach _mags;
    
    _shellTypes
};

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
        
        // Create fortifications around battery
        private _fortTypes = ["Land_BagBunker_Small_F", "Land_BagFence_Long_F", "Land_BagFence_Round_F"];
        private _forts = [];
        for "_j" from 0 to 5 do {
            private _fortPos = _arty getPos [10, _j * 60];
            private _fort = createVehicle [selectRandom _fortTypes, _fortPos, [], 0, "NONE"];
            _fort setDir (_fort getDir _arty);
            _forts pushBack _fort;
        };
        
        // Add to hashMap with battery info
        FLO_artilleryBatteries set [
            netId _arty, 
            createHashMapFromArray [
                ["vehicle", _arty],
                ["group", _artGroup],
                ["forts", _forts],
                ["lastFired", time],
                ["position", getPosASL _arty]
            ]
        ];
    };
};

// Use all available batteries within range for the fire mission
{
    private _batteryInfo = _y;
    private _arty = _batteryInfo get "vehicle";
    
    if (alive _arty && _arty distance _targetPos < 12000) then {
        private _compatibleShells = [typeOf _arty] call _fnc_getArtilleryMags;
        
        if (count _compatibleShells > 0) then {
            for "_j" from 1 to (3 + random 3) do {
                _arty doArtilleryFire [
                    _targetPos getPos [random 100, random 360],
                    selectRandom _compatibleShells,
                    1
                ];
                sleep (10 + random 10);
            };
            _batteryInfo set ["lastFired", time];
        };
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
