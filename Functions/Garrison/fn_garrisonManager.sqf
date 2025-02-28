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
    ["_mode", "init", [""]],
    ["_params", [], [[]]]
];

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
                !((_garrisons) getOrDefault [_x, false])
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
                    _composition = [
                        [selectRandom _officerUnits, 1],
                        [selectRandom _availableUnits, 3]
                    ];
                };
                case (_size <= 8): {
                    _composition = [
                        [selectRandom _officerUnits, 1],
                        [selectRandom _availableUnits, 7]
                    ];
                };
                default {
                    _composition = [
                        [selectRandom _officerUnits, 2],
                        [selectRandom _availableUnits, 12]
                    ];
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
            
            // Set up garrison behavior
            [_group, _marker] call BIS_fnc_taskDefend;
            
            // Store in garrisons hashmap
            private _garrisons = _self get "garrisons";
            _garrisons set [_marker, [_spawnedUnits, _spawnedVehicles, _group, time]];
            
            // Update total units count
            _self set ["totalUnits", (_self get "totalUnits") + count _spawnedUnits];
            
            // Return spawned units
            _spawnedUnits
        }],
        
        // Reinforce an existing garrison
        ["reinforceGarrison", {
            params ["_marker", "_amount"];
            
            private _garrisons = _self get "garrisons";
            if (!((_garrisons) getOrDefault [_marker, false])) exitWith {
                diag_log format ["[FLO][Garrison] Error: No garrison at %1 to reinforce", _marker];
                false
            };
            
            private _garrisonData = _garrisons get _marker;
            _garrisonData params ["_units", "_vehicles", "_group", "_timestamp"];
            
            // Check if we need to reinforce dead units
            private _aliveUnits = _units select {alive _x};
            private _deadCount = count _units - count _aliveUnits;
            
            // Calculate how many units to add
            private _toAdd = _amount max _deadCount;
            if (_toAdd <= 0) exitWith {
                diag_log format ["[FLO][Garrison] No reinforcement needed for %1", _marker];
                true
            };
            
            // Add reinforcements
            private _pos = getMarkerPos _marker;
            private _newUnits = [];
            
            // Get available unit types from global variables
            private _availableUnits = East_Units;
            
            // Simply create the requested number of units
            for "_i" from 1 to _toAdd do {
                private _type = selectRandom _availableUnits;
                private _unit = _group createUnit [_type, _pos, [], 50, "NONE"];
                _newUnits pushBack _unit;
            };
            
            // Update garrison data
            _garrisons set [_marker, [_aliveUnits + _newUnits, _vehicles, _group, time]];
            
            // Update total units count
            _self set ["totalUnits", (_self get "totalUnits") + count _newUnits - _deadCount];
            
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
                
                // Check for alive units
                private _aliveUnits = _units select {alive _x};
                private _aliveVehicles = _vehicles select {alive _x};
                
                if (count _aliveUnits == 0) then {
                    // All units dead, clean up
                    {deleteVehicle _x} forEach _vehicles;
                    _garrisons deleteAt _marker;
                    diag_log format ["[FLO][Garrison] Garrison at %1 wiped out, removed", _marker];
                } else {
                    // Update garrison data with alive units only
                    _garrisons set [_marker, [_aliveUnits, _aliveVehicles, _group, _timestamp]];
                    _totalCount = _totalCount + count _aliveUnits;
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
            if (!((_garrisons) getOrDefault [_marker, false])) exitWith {
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
private _result = switch (_mode) do {
    // Initialize the garrison system
    case "init": {
        FLO_Garrison_Manager call ["initialize", []];
        FLO_Garrison_Manager
    };
    
    // Spawn a new garrison
    case "spawn": {
        _params params [
            ["_marker", "", [""]],
            ["_size", 8, [0]],
            ["_withVehicles", false, [false]]
        ];
        
        FLO_Garrison_Manager call ["spawnGarrison", [_marker, _size, _withVehicles]]
    };
    
    // Reinforce an existing garrison
    case "reinforce": {
        _params params [
            ["_marker", "", [""]],
            ["_amount", 4, [0]]
        ];
        
        FLO_Garrison_Manager call ["reinforceGarrison", [_marker, _amount]]
    };
    
    // Maintain all garrisons
    case "maintain": {
        FLO_Garrison_Manager call ["maintainGarrisons", []]
    };
    
    // Check markers near players and spawn garrisons if needed
    case "checkAndSpawn": {
        _params params [
            ["_activationDistance", 1500, [0]]
        ];
        
        FLO_Garrison_Manager call ["checkNearbyGarrisons", [_activationDistance]]
    };
};

_result 