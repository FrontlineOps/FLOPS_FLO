params ["_targetPos", "_intensity"];

private _artilleryTypes = selectRandom ((FLO_configCache get "vehicles") select 7);
private _artilleryCount = 1 + floor(_intensity/3);

// Get compatible magazines for artillery pieces
private _fnc_getArtilleryMags = {
    params ["_vehType"];
    private _config = configFile >> "CfgVehicles" >> _vehType;
    private _turret = [0];
    private _mags = getArray (_config >> "Turrets" >> "MainTurret" >> "magazines");
    private _shellTypes = [];
    
    {
        private _magConfig = configFile >> "CfgMagazines" >> _x;
        if (getNumber (_magConfig >> "type") in [256, 1]) then { // Artillery shell types
            _shellTypes pushBackUnique _x;
        };
    } forEach _mags;
    
    _shellTypes
};

for "_i" from 1 to _artilleryCount do {
    private _artPos = [_targetPos, 5000, 10000, 10, 0] call BIS_fnc_findSafePos;
    private _selectedType = _artilleryTypes;
    private _arty = createVehicle [_selectedType, _artPos, [], 0, "NONE"];
    createVehicleCrew _arty;
    
    // Get compatible shells for this specific artillery piece
    private _compatibleShells = [_selectedType] call _fnc_getArtilleryMags;
    
    if (count _compatibleShells > 0) then {
        for "_j" from 1 to (5 + random 5) do {
            _arty doArtilleryFire [
                _targetPos getPos [random 100, random 360],
                selectRandom _compatibleShells,
                1
            ];
            sleep (10 + random 10);
        };
    };
};
