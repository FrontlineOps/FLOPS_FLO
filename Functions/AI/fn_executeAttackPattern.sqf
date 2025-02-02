/*
    Function: FLO_fnc_executeAttackPattern
    
    Description:
    Manages the execution of attack patterns for OPFOR units.
    
    Parameters:
    _targetPos - Target position for attack pattern [Array]
    _sourcePos - Source position for attack pattern [Array]
    _pattern - Type of attack pattern ("PINCER", "FRONTAL", "INFILTRATION") [String]
    _strength - Strength of the attack pattern [Number]
    
    Returns:
    HashMap - Tracking object for attack pattern
*/

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

// Function to find safe position in a specific direction
private _fnc_findDirectionalSafePos = {
    params ["_center", "_distance", "_direction"];
    
    // Calculate target point in desired direction
    private _targetPoint = _center getPos [_distance, _direction];
    
    // Search for safe position with better parameters
    // Start with a wider search radius and gradually reduce if needed
    private _searchRadius = _distance * 0.3; // 30% of desired distance
    private _minDist = 10; // Minimum 10m from target point
    private _attempts = 0;
    private _maxAttempts = 5;
    private _safePos = [];
    
    while {_attempts < _maxAttempts} do {
        _safePos = [_targetPoint, _minDist, _searchRadius, 5, 0, 0.5, 0] call BIS_fnc_findSafePos;
        
        // If position found and it's in roughly the right direction (+/- 30 degrees)
        if (count _safePos > 0 && {
            private _actualDir = _center getDir _safePos;
            private _dirDiff = abs ((_direction - _actualDir + 180) % 360 - 180);
            _dirDiff < 30
        }) exitWith {};
        
        _searchRadius = _searchRadius * 1.5;
        _attempts = _attempts + 1;
    };
    
    // If no good position found, return the target point
    if (count _safePos == 0) then {
        _safePos = _targetPoint;
    };
    
    _safePos
};

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
            private _baseDir = _spawnPos getDir _targetPos;
            private _leftPos = [_targetPos, 1000, _baseDir - 45] call _fnc_findDirectionalSafePos;
            private _rightPos = [_targetPos, 1000, _baseDir + 45] call _fnc_findDirectionalSafePos;
            
            private _groupLeft = [_spawnPos, _strength] call _fnc_spawnGroup;
            private _groupRight = [_spawnPos, _strength] call _fnc_spawnGroup;
            
            // Initial flanking movement
            [_groupLeft, _leftPos, 100] call BIS_fnc_taskAttack;
            [_groupRight, _rightPos, 100] call BIS_fnc_taskAttack;
            
            // Wait for groups to reach their positions then converge
            [_groupLeft, _groupRight, _targetPos] spawn {
                params ["_groupLeft", "_groupRight", "_targetPos"];
                
                // Wait for groups to reach their flanking positions
                waitUntil {
                    sleep 5;
                    private _leftReady = (leader _groupLeft) distance (getWPPos [_groupLeft, 0]) < 150;
                    private _rightReady = (leader _groupRight) distance (getWPPos [_groupRight, 0]) < 150;
                    _leftReady && _rightReady
                };
                
                // Clear waypoints and attack target
                {
                    while {count waypoints _x > 0} do {
                        deleteWaypoint [_x, 0];
                    };
                    [_x, _targetPos, 50] call BIS_fnc_taskAttack;
                } forEach [_groupLeft, _groupRight];
            };
        };
        
        case "FRONTAL": {
            private _mainPos = [_targetPos, 800, _spawnPos getDir _targetPos] call _fnc_findDirectionalSafePos;
            
            for "_i" from -3 to 3 do {
                private _smokePos = _targetPos getPos [400, (_spawnPos getDir _targetPos) + (_i * 15)];
                "SmokeShellArty" createVehicle _smokePos; //Replace this with a call to FLO_fnc_artilleryPrep for Smoke Shells in the future
            };
            
            private _mainGroup = [_spawnPos, _strength * 2] call _fnc_spawnGroup;
            [_mainGroup, _mainPos, 50] call BIS_fnc_taskAttack;
        };
        
        case "INFILTRATION": {
            {
                private _infiltPos = [_targetPos, 600, (_spawnPos getDir _targetPos) + (_x * 90)] call _fnc_findDirectionalSafePos;
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
