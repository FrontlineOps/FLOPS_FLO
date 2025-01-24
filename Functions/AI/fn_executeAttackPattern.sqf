params ["_targetPos", "_sourcePos", "_pattern", "_strength"];

// Find nearest valid OPFOR outpost for spawning
private _opforOutpostMarkers = allMapMarkers select {
    markerType _x in ["o_installation", "o_service", "o_support"]
};

private _nearestOutpost = "";
private _nearestDistance = 1e10;

{
    private _markerPos = getMarkerPos _x;
    private _distance = _markerPos distance _targetPos;
    
    // Check if there are any players near this outpost
    private _noPlayersNear = {
        if (side _x isEqualTo west && alive _x) exitWith {1};
    } count (_markerPos nearEntities [["Man", "Car", "Tank", "Ship", "LandVehicle"], 1000]) isEqualTo 0;
    
    if (_distance < _nearestDistance && _noPlayersNear) then {
        _nearestDistance = _distance;
        _nearestOutpost = _x;
    };
} forEach _opforOutpostMarkers;

// Only proceed if we found a valid outpost
if (_nearestOutpost != "") then {
    private _spawnPos = getMarkerPos _nearestOutpost;
    
    private _fnc_spawnGroup = {
        params ["_pos", "_size"];
        private _group = [_pos, EAST, [
            selectRandom (FLO_configCache get "units"),
            selectRandom (FLO_configCache get "units"),
            selectRandom (FLO_configCache get "units"),
            selectRandom (FLO_configCache get "units")
        ]] call BIS_fnc_spawnGroup;
        _group
    };
    
    switch (_pattern) do {
        case "PINCER": {
            private _leftPos = _targetPos getPos [1000, (_spawnPos getDir _targetPos) - 45];
            private _rightPos = _targetPos getPos [1000, (_spawnPos getDir _targetPos) + 45];
            
            private _groupLeft = [_spawnPos, _strength] call _fnc_spawnGroup;
            private _groupRight = [_spawnPos, _strength] call _fnc_spawnGroup;
            
            [_groupLeft, _leftPos, 100] call BIS_fnc_taskAttack;
            [_groupRight, _rightPos, 100] call BIS_fnc_taskAttack;
        };
        
        case "FRONTAL": {
            private _mainPos = _targetPos getPos [800, _spawnPos getDir _targetPos];
            
            for "_i" from -3 to 3 do {
                private _smokePos = _targetPos getPos [400, (_spawnPos getDir _targetPos) + (_i * 15)];
                "SmokeShellArty" createVehicle _smokePos;
            };
            
            private _mainGroup = [_spawnPos, _strength * 2] call _fnc_spawnGroup;
            [_mainGroup, _mainPos, 50] call BIS_fnc_taskAttack;
        };
        
        case "INFILTRATION": {
            {
                private _infiltPos = _targetPos getPos [600, (_spawnPos getDir _targetPos) + (_x * 90)];
                private _group = [_spawnPos, _strength] call _fnc_spawnGroup;
                
                _group setBehaviour "STEALTH";
                _group setCombatMode "GREEN";
                
                [_group, _infiltPos, 20] call BIS_fnc_taskAttack;
            } forEach [0,1,2,3];
        };
    };
} else {
    diag_log "No valid OPFOR outpost found for attack pattern deployment.";
};
