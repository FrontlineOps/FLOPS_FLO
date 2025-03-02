/*
    Function: FLO_fnc_garrisonManager
    
    Description:
    Manages garrison spawning and maintenance for objectives.
    Uses OOP approach with HashMapObject for better organization and state management.
    
    Parameters:
    _mode - The function mode to execute ["init", "spawn", "reinforce", "maintain", "checkAndSpawn"] (String)
    _params - Parameters based on mode (Array)
        init: [] - No parameters needed
        spawn: [_marker, _size, _withVehicles] - Create a new garrison at marker
        reinforce: [_marker, _amount] - Add units to existing garrison
        maintain: [] - Run maintenance on all garrisons
        checkAndSpawn: [_activationDistance] - Check all markers and spawn garrisons near players
    
    Returns:
    Based on mode:
        init: HashMapObject - The garrison manager object
        spawn: Array - The spawned garrison units
        reinforce: Boolean - Success of reinforcement
        maintain: Nothing
        checkAndSpawn: Number - Count of newly spawned garrisons
*/

if (!isServer) exitWith {};

params [
    ["_mode", "", [""]],
    ["_params", [], [[]]]
];

private _result = false;

// Initialize the Garrison Manager object if it doesn't exist
if (isNil "FLO_Garrison_Manager") then {
    // Define the Garrison Manager class with its methods and properties
    private _garrisonManagerClass = [
        // Class identifier
        ["#type", "GarrisonManager"],
        
        // Properties
        ["garrisons", createHashMap],
        ["lastUpdate", time],
        ["totalUnits", 0],
        ["processedMarkers", []],
        
        // Constructor - Called when object is created
        ["#create", {
            _self set ["garrisons", createHashMap];
            _self set ["lastUpdate", time];
            _self set ["totalUnits", 0];
            _self set ["processedMarkers", []];
            diag_log "[FLO][Garrison] Manager initialized";
        }],
        
        // Initialize garrison system and start maintenance loop
        ["initialize", {
            // Start the maintenance loop
            [] spawn {
                while {true} do {
                    // Run maintenance every 5 minutes
                    ["maintain", []] call FLO_fnc_garrisonManager;
                    sleep 300;
                    
                    // Check for new garrisons to spawn every 30 seconds
                    ["checkAndSpawn", [1500]] call FLO_fnc_garrisonManager;
                    sleep 30;
                };
            };
        }],
        
        // Check for markers near players and spawn garrisons if needed
        ["checkNearbyGarrisons", {
            params ["_activationDistance"];
            
            private _spawnCount = 0;
            private _processedMarkers = _self get "processedMarkers";
            private _garrisons = _self get "garrisons";
            
            // Get all players (except headless clients)
            private _allPlayers = allPlayers - entities "HeadlessClient_F";
            if (count _allPlayers == 0) exitWith {0}; // No players, exit
            
            // Get all OPFOR markers that aren't already processed
            private _opforMarkers = allMapMarkers select {
                markerColor _x in ["colorOPFOR", "ColorEAST"] && 
                markerType _x in ["o_support", "n_support", "n_installation", "o_installation", "loc_Ruin", "loc_Power", "o_recon", "o_service", "o_antiair"] &&
                !(_x in _processedMarkers) &&
                !(_x in keys _garrisons)
            };
            
            {
                private _marker = _x;
                private _markerPos = getMarkerPos _marker;
                private _markerType = markerType _marker;
                private _nearPlayers = false;
                
                // Check if any player is near this marker
                {
                    if (_x distance _markerPos < _activationDistance) exitWith {
                        _nearPlayers = true;
                    };
                } forEach _allPlayers;
                
                // If players are nearby and marker not already processed, spawn garrison
                if (_nearPlayers) then {
                    // Check if there's an unactivated garrison with queued reinforcements
                    private _queuedGarrison = false;
                    private _additionalUnits = 0;
                    
                    if (_marker in keys _garrisons) then {
                        private _garrisonData = _garrisons get _marker;
                        
                        // Check if this garrison has no active units but queued reinforcements
                        if (count (_garrisonData select 0) == 0) then {
                            _queuedGarrison = true;
                            
                            // Get any queued reinforcements to include in spawn
                            _additionalUnits = _garrisonData param [5, 0];
                            
                            // Remove the inactive garrison entry
                            _garrisons deleteAt _marker;
                            
                            diag_log format ["[FLO][Garrison] Found queued garrison at %1 with %2 additional units", _marker, _additionalUnits];
                        };
                    };
                    
                    // Determine garrison size and vehicle presence based on marker type
                    private _size = 0;
                    private _withVehicles = false;
                    
                    switch (_markerType) do {
                        case "n_installation": {
                            _size = 12;
                            _withVehicles = true;
                        };
                        case "o_installation": {
                            _size = 8;
                            _withVehicles = true;
                        };
                        case "n_support": {
                            _size = 6;
                            _withVehicles = false;
                        };
                        case "o_support": {
                            _size = 4;
                            _withVehicles = false;
                        };
                        case "loc_Power": {
                            _size = 6;
                            _withVehicles = true;
                        };
                        case "o_recon": {
                            _size = 4;
                            _withVehicles = false;
                        };
                        case "o_service": {
                            _size = 6;
                            _withVehicles = true;
                        };
                        case "o_antiair": {
                            _size = 8;
                            _withVehicles = true;
                        };
                        case "loc_Ruin": {
                            _size = 3;
                            _withVehicles = false;
                        };
                        default {
                            _size = 4;
                            _withVehicles = false;
                        };
                    };
                    
                    // Add any queued reinforcements to the size
                    if (_additionalUnits > 0) then {
                        _size = _size + _additionalUnits;
                        diag_log format ["[FLO][Garrison] Adjusted garrison size at %1 from standard to %2 including reinforcements", _marker, _size];
                    };
                    
                    if (_size > 0) then {
                        // Spawn garrison
                        _self call ["spawnGarrison", [_marker, _size, _withVehicles]];
                        
                        // Add defensive vehicle at installations with vehicles
                        if (_withVehicles) then {
                            private _defenseVehicle = "";
                            
                            // Defense vehicle selection - simplified
                            if (count East_Ground_Vehicles_Heavy > 0) then {
                                _defenseVehicle = selectRandom East_Ground_Vehicles_Heavy;
                            } else {
                                _defenseVehicle = selectRandom East_Ground_Vehicles_Light;
                            };
                            
                            ["defend", [_marker, _defenseVehicle]] call FLO_fnc_vehicleGarrison;
                            
                            // Add patrol for larger installations
                            if (_markerType in ["n_installation", "o_installation"]) then {
                                ["patrol", [_marker, 800, selectRandom East_Ground_Vehicles_Light]] call FLO_fnc_vehicleGarrison;
                            };
                        };
                        
                        diag_log format ["[FLO][Garrison] Created garrison at %1 near players (Type: %2, Size: %3, Vehicles: %4)", _marker, _markerType, _size, _withVehicles];
                        
                        // Mark as processed and increment count
                        _processedMarkers pushBack _marker;
                        _spawnCount = _spawnCount + 1;
                    };
                };
            } forEach _opforMarkers;
            
            // Update processed markers
            _self set ["processedMarkers", _processedMarkers];
            
            // Return count of spawned garrisons
            _spawnCount
        }],
        
        // Create a new garrison at a marker
        ["spawnGarrison", {
            params ["_marker", "_size", "_withVehicles"];
            
            if (_marker == "") exitWith {
                diag_log "[FLO][Garrison] Error: Empty marker name";
                []
            };
            
            private _pos = getMarkerPos _marker;
            if (_pos isEqualTo [0,0,0]) exitWith {
                diag_log format ["[FLO][Garrison] Error: Invalid marker position for %1", _marker];
                []
            };
            
            // Default composition based on size using East_Units
            private _composition = [];
            
            // Get available unit types from global variables
            private _availableUnits = East_Units;
            private _officerUnits = East_Units_Officers;
            
            // Generate compositions based on size
            switch (true) do {
                case (_size <= 4): { 
                    for "_i" from 1 to 4 do {
                        _composition pushBack [selectRandom _availableUnits, 1];
                    };
                };
                case (_size <= 8): {
                    for "_i" from 1 to 8 do {
                        _composition pushBack [selectRandom _availableUnits, 1];
                    };
                };
                default {
                    for "_i" from 1 to 13 do {
                        _composition pushBack [selectRandom _availableUnits, 1];
                    };
                };
            };
            
            // Add vehicles if requested
            private _vehicles = [];
            if (_withVehicles) then {
                // Use vehicle types from global variables
                private _lightVehicles = East_Ground_Vehicles_Light;
                private _heavyVehicles = East_Ground_Vehicles_Heavy;
                
                _vehicles = switch (true) do {
                    case (_size <= 4): { 
                        [
                            [selectRandom _lightVehicles, 1]
                        ]
                    };
                    case (_size <= 8): {
                        [
                            [selectRandom _lightVehicles, 1],
                            [selectRandom _lightVehicles, 1]
                        ]
                    };
                    default {
                        [
                            [selectRandom _lightVehicles, 1],
                            [selectRandom _lightVehicles, 1],
                            [selectRandom _heavyVehicles, 1]
                        ]
                    };
                };
            };
            
            // Spawn units
            private _spawnedUnits = [];
            private _group = createGroup [east, true];
            
            {
                _x params ["_type", "_count"];
                for "_i" from 1 to _count do {
                    private _unit = _group createUnit [_type, _pos, [], 50, "NONE"];
                    _spawnedUnits pushBack _unit;
                };
            } forEach _composition;
            
            // Ensure group is properly set to EAST
            if (side _group != east) then {
                private _eastGroup = createGroup [east, true];
                {
                    [_x] joinSilent _eastGroup;
                } forEach units _group;
                _group = _eastGroup;
            };
            
            // Spawn vehicles
            private _spawnedVehicles = [];
            {
                _x params ["_type", "_count"];
                for "_i" from 1 to _count do {
                    private _vehPos = [_pos, 10, 100, 5, 0, 0.5, 0, [], [_pos, _pos]] call BIS_fnc_findSafePos;
                    private _veh = createVehicle [_type, _vehPos, [], 0, "NONE"];
                    createVehicleCrew _veh;
                    (crew _veh) joinSilent _group;
                    _spawnedUnits append (crew _veh);
                    _spawnedVehicles pushBack _veh;
                };
            } forEach _vehicles;
            
            // Enhanced garrison behavior - find buildings and suitable positions
            private _nearBuildings = _pos nearObjects ["Building", 150];
            private _buildingPositions = [];
            
            // Collect all valid building positions
            {
                private _positions = _x buildingPos -1;
                if (count _positions > 0) then {
                    _buildingPositions append _positions;
                };
            } forEach _nearBuildings;
            
            // Only keep a reasonable number of positions
            if (count _buildingPositions > 30) then {
                _buildingPositions resize 30;
            };
            
            // Split the group based on buildings available and garrison size
            if (count _buildingPositions > 3 && count _spawnedUnits > 3) then {
                // Garrison units - 2/3 of units go to buildings
                private _garrisonUnits = floor ((count _spawnedUnits) * 0.6);
                private _garrisonGroup = createGroup [east, true];
                
                for "_i" from 1 to (_garrisonUnits min count _buildingPositions) do {
                    if (count _spawnedUnits > 0) then {
                        private _unit = _spawnedUnits deleteAt 0;
                        [_unit] joinSilent _garrisonGroup;
                        
                        // Move to building position
                        private _bPos = selectRandom _buildingPositions;
                        _buildingPositions = _buildingPositions - [_bPos];
                        _unit doMove _bPos;
                        _unit setPos _bPos;
                        
                        // Set unit behavior for garrison
                        _unit disableAI "PATH";
                        _unit setUnitPos (selectRandom ["UP", "MIDDLE"]);
                    };
                };
                
                // Set garrison group behavior
                _garrisonGroup setCombatMode "RED";
                _garrisonGroup setBehaviour "AWARE";
                
                // Create patrol group with remaining units
                if (count _spawnedUnits > 0) then {
                    private _patrolGroup = createGroup [east, true];
                    
                    {
                        [_x] joinSilent _patrolGroup;
                    } forEach _spawnedUnits;
                    
                    // Set patrol path
                    [_patrolGroup, _pos, 150] call BIS_fnc_taskPatrol;
                    
                    // Set patrol behavior
                    _patrolGroup setCombatMode "RED";
                    _patrolGroup setBehaviour "AWARE";
                    _patrolGroup setSpeedMode "LIMITED";
                };
            } else {
                // Fall back to standard defensive behavior if not enough buildings
                [_group, _pos, 100, 2, 0.2, 0.3] call BIS_fnc_taskDefend;
            };
            
            // Store in garrisons hashmap
            private _garrisons = _self get "garrisons";
            
            // Extended garrison data structure:
            // [units, vehicles, group, timestamp, virtualStrength, queuedReinforcements, originalSize]
            _garrisons set [_marker, [
                _spawnedUnits,                // Actual spawned units
                _spawnedVehicles,             // Spawned vehicles
                _group,                       // Main group
                time,                         // Creation timestamp
                0,                            // Virtual strength (reinforcements available but not yet spawned)
                0,                            // Queued reinforcements (for inactive garrisons)
                _size                         // Original intended size
            ]];
            
            // Update total units count
            _self set ["totalUnits", (_self get "totalUnits") + count _spawnedUnits];
            
            diag_log format ["[FLO][Garrison] Created garrison at %1 with %2 units and %3 vehicles", _marker, count _spawnedUnits, count _spawnedVehicles];
            
            // Return spawned units
            _spawnedUnits
        }],
        
        // Reinforce an existing garrison - ONLY UPDATES TRACKED COUNT, NEVER SPAWNS UNITS
        ["reinforceGarrison", {
            params ["_marker", "_amount"];
            
            private _garrisons = _self get "garrisons";
            if (!(_marker in keys _garrisons)) exitWith {
                diag_log format ["[FLO][Garrison] Error: No garrison at %1 to reinforce", _marker];
                false
            };
            
            private _garrisonData = _garrisons get _marker;
            _garrisonData params ["_units", "_vehicles", "_group", "_timestamp"];
            
            // Check if this garrison is active (has spawned units)
            private _isActive = count (_units select {alive _x}) > 0;
            
            // Calculate reinforcement data - never spawn actual units
            private _reinforcementCount = _amount;
            
            // Update the tracked count only - NO ACTUAL UNIT SPAWNING
            if (_isActive) then {
                // Garrison is active - we're just tracking that reinforcements are available
                diag_log format ["[FLO][Garrison] Reinforcement available for active garrison at %1: +%2 units (tracked only)", _marker, _reinforcementCount];
                
                // Update the "virtual strength" of the garrison (used to decide when/if to generate physical units)
                private _virtualStrength = _garrisonData param [4, 0]; // Get virtual strength, default 0
                _virtualStrength = _virtualStrength + _reinforcementCount;
                
                // Update garrison data with new virtual strength
                _garrisonData set [4, _virtualStrength];
                _garrisons set [_marker, _garrisonData];
            } else {
                // Garrison is not active - just update the data structure for later spawning
                diag_log format ["[FLO][Garrison] Reinforcement queued for inactive garrison at %1: +%2 units", _marker, _reinforcementCount];
                
                // Store reinforcement count for when garrison activates
                private _queuedReinforcements = _garrisonData param [5, 0]; // Get queued reinforcements, default 0
                _queuedReinforcements = _queuedReinforcements + _reinforcementCount;
                
                // Update garrison data with new queued reinforcements
                _garrisonData set [5, _queuedReinforcements];
                _garrisons set [_marker, _garrisonData];
            };
            
            // Update total units count (only for tracking purposes)
            _self set ["totalUnits", (_self get "totalUnits") + _reinforcementCount];
            
            true
        }],
        
        // Maintain all garrisons
        ["maintainGarrisons", {
            private _garrisons = _self get "garrisons";
            private _totalCount = 0;
            
            // Process each garrison
            {
                private _marker = _x;
                private _data = _garrisons get _marker;
                _data params ["_units", "_vehicles", "_group", "_timestamp"];
                
                // Get virtual strength and queued reinforcements (if any)
                private _virtualStrength = _data param [4, 0];
                private _queuedReinforcements = _data param [5, 0];
                
                // Check for alive units
                private _aliveUnits = _units select {alive _x};
                private _aliveVehicles = _vehicles select {alive _x};
                
                if (count _aliveUnits == 0 && _virtualStrength == 0 && _queuedReinforcements == 0) then {
                    // All units dead and no reinforcements queued, clean up
                    {deleteVehicle _x} forEach _vehicles;
                    _garrisons deleteAt _marker;
                    diag_log format ["[FLO][Garrison] Garrison at %1 wiped out, removed", _marker];
                } else {
                    // Update garrison data with alive units only
                    _data set [0, _aliveUnits];
                    _data set [1, _aliveVehicles];
                    _data set [3, time]; // Update timestamp
                    _garrisons set [_marker, _data];
                    
                    // Count both physical and virtual units for total
                    _totalCount = _totalCount + count _aliveUnits + _virtualStrength + _queuedReinforcements;
                    
                    // Log info if garrison has virtual/queued reinforcements
                    if (_virtualStrength > 0 || _queuedReinforcements > 0) then {
                        diag_log format ["[FLO][Garrison] Garrison at %1: %2 active units, %3 virtual strength, %4 queued", 
                            _marker, count _aliveUnits, _virtualStrength, _queuedReinforcements];
                    };
                };
            } forEach keys _garrisons;
            
            // Update total count
            _self set ["totalUnits", _totalCount];
            _self set ["lastUpdate", time];
            
            diag_log format ["[FLO][Garrison] Maintenance complete. Total units: %1", _totalCount];
        }],
        
        // Get garrison info for a marker
        ["getGarrisonInfo", {
            params ["_marker"];
            
            private _garrisons = _self get "garrisons";
            if (!(_marker in keys _garrisons)) exitWith {
                []
            };
            
            private _data = _garrisons get _marker;
            _data params ["_units", "_vehicles", "_group", "_timestamp"];
            
            private _aliveUnits = _units select {alive _x};
            private _aliveVehicles = _vehicles select {alive _x};
            
            [count _aliveUnits, count _aliveVehicles, _timestamp]
        }]
    ];
    
    // Create the garrison manager object
    FLO_Garrison_Manager = createHashMapObject [_garrisonManagerClass];
};

// Execute the requested mode
switch (_mode) do {
    // Initialize the garrison system
    case "init": {
        FLO_Garrison_Manager call ["initialize", []];
        _result = FLO_Garrison_Manager;
    };
    
    // Spawn a new garrison
    case "spawn": {
        _params params [
            ["_marker", "", [""]],
            ["_size", 8, [0]],
            ["_withVehicles", false, [false]]
        ];
        
        _result = FLO_Garrison_Manager call ["spawnGarrison", [_marker, _size, _withVehicles]];
    };
    
    // Reinforce an existing garrison
    case "reinforce": {
        _params params [
            ["_marker", "", [""]],
            ["_amount", 4, [0]]
        ];
        
        _result = FLO_Garrison_Manager call ["reinforceGarrison", [_marker, _amount]];
    };
    
    // Maintain all garrisons
    case "maintain": {
        FLO_Garrison_Manager call ["maintainGarrisons", []];
        _result = true;
    };
    
    // Check markers near players and spawn garrisons if needed
    case "checkAndSpawn": {
        _params params [
            ["_activationDistance", 1500, [0]]
        ];
        
        _result = FLO_Garrison_Manager call ["checkNearbyGarrisons", [_activationDistance]];
    };
    
    default {
        diag_log format ["[FLO][Garrison] Error: Unknown mode '%1'", _mode];
        _result = false;
    };
};

_result 