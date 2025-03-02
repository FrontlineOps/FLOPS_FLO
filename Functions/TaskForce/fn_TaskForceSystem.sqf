/*
    Function: FLO_fnc_TaskForceSystem
    
    Description:
    Manages OPFOR Task Forces that move across the map and appear when near BLUFOR.
    Fully compatible with CDVS Virtualization system.
    Allows creation of defensive lines with fortifications, infantry, and vehicles.
    
    Parameters:
    _mode - The function mode to execute ["init", "createTaskForce", "updateTaskForces", "getTaskForce", "deployTaskForce"] (String)
    _params - Parameters based on mode (Array)
        init: [] - Initialize the Task Force system
        createTaskForce: [_baseMarker, _taskForceType, _taskForceSize, _targetMarker] - Create a new Task Force
        updateTaskForces: [] - Update all Task Forces positions and statuses
        getTaskForce: [_taskForceId] - Get information about a specific Task Force
        deployTaskForce: [_taskForceId, _position, _defensive] - Deploy a Task Force at a specific position
    
    Returns:
    Based on mode:
        init: HashMapObject - The Task Force system object
        createTaskForce: String - The ID of the created Task Force
        updateTaskForces: Nothing
        getTaskForce: Array - Information about the Task Force
        deployTaskForce: Boolean - True if successfully deployed
*/

if (!isServer) exitWith {};

params [
    ["_mode", "", [""]],
    ["_params", [], [[]]]
];

private _result = false;

// Initialize the Task Force System object if it doesn't exist
if (isNil "FLO_TaskForce_System") then {
    // Define the Task Force System class with its methods and properties
    private _taskForceSystemClass = [
        // Class identifier
        ["#type", "TaskForceSystem"],
        
        // Properties
        ["taskForces", createHashMap],
        ["lastUpdate", time],
        ["lastTaskForceId", 0],
        ["lastTaskForceScan", time],
        
        // Constructor - Called when object is created
        ["#create", {
            _self set ["taskForces", createHashMap];
            _self set ["lastUpdate", time];
            _self set ["lastTaskForceId", 0];
            _self set ["lastTaskForceScan", time];
            diag_log "[FLO][TaskForce] System initialized";
        }],
        
        // Initialize Task Force system and start update loop
        ["initialize", {
            // Initialize the VS_VirtualizedTaskForces hashmap if it doesn't exist
            if (isNil "VS_VirtualizedTaskForces") then {
                VS_VirtualizedTaskForces = createHashMap;
            };
            
            // Start the update loop for Task Force movement
            [] spawn {
                while {true} do {
                    // Update Task Forces every 30 seconds
                    ["updateTaskForces", []] call FLO_fnc_TaskForceSystem;
                    sleep 30;
                };
            };
        }],
        
        // Create a new Task Force with specified parameters
        ["createTaskForce", {
            params [
                ["_baseMarker", "", [""]],
                ["_taskForceType", "infantry", [""]],
                ["_taskForceSize", "squad", [""]],
                ["_targetMarker", "", [""]]
            ];
            
            // Validate base marker
            if (_baseMarker == "") exitWith {
                diag_log "[FLO][TaskForce] Error: Empty base marker name";
                ""
            };
            
            private _basePos = getMarkerPos _baseMarker;
            if (_basePos isEqualTo [0,0,0]) exitWith {
                diag_log "[FLO][TaskForce] Error: Invalid base marker position";
                ""
            };
            
            // Get target position (can be empty for defensive Task Forces)
            private _targetPos = [0,0,0];
            if (_targetMarker != "") then {
                _targetPos = getMarkerPos _targetMarker;
            };
            
            // Generate a unique ID for this Task Force
            private _lastId = _self get "lastTaskForceId";
            private _taskForceId = format ["TF_%1_%2", _lastId + 1, floor random 10000];
            _self set ["lastTaskForceId", _lastId + 1];
            
            // Calculate resource cost based on type and size
            private _resourceCost = [_self, _taskForceType, _taskForceSize] call {
                params ["_self", "_type", "_size"];
                
                private _typeCost = switch (toLower _type) do {
                    case "infantry": {5};
                    case "mechanized": {15};
                    case "armored": {25};
                    case "fortification": {10};
                    default {5};
                };
                
                private _sizeCost = switch (toLower _size) do {
                    case "fireteam": {1};
                    case "squad": {2};
                    case "platoon": {3};
                    case "company": {5};
                    default {2};
                };
                
                _typeCost * _sizeCost
            };
            
            // Check if we have enough resources to create this Task Force
            private _currentResources = ["get", []] call FLO_fnc_opforResources;
            if (_currentResources < _resourceCost) exitWith {
                diag_log format ["[FLO][TaskForce] Error: Insufficient resources to create Task Force (needed %1, have %2)",
                    _resourceCost, _currentResources];
                ""
            };
            
            // Spend the resources
            ["spend", [_resourceCost]] call FLO_fnc_opforResources;
            
            // Define the Task Force composition based on type and size
            private _composition = [_taskForceType, _taskForceSize] call {
                params ["_type", "_size"];
                
                // Define size multipliers
                private _sizeMultiplier = switch (toLower _size) do {
                    case "fireteam": {1};
                    case "squad": {2};
                    case "platoon": {4};
                    case "company": {8};
                    default {2}; // Default to squad size
                };
                
                // Define base compositions per type
                private _baseComposition = switch (toLower _type) do {
                    case "infantry": {
                        [
                            ["infantry", East_Units, 6 * _sizeMultiplier]
                        ]
                    };
                    case "mechanized": {
                        [
                            ["infantry", East_Units, 6 * _sizeMultiplier],
                            ["vehicle", East_Ground_Vehicles_Light, 1 * ceil(_sizeMultiplier/2)]
                        ]
                    };
                    case "armored": {
                        [
                            ["infantry", East_Units, 3 * _sizeMultiplier],
                            ["vehicle", East_Ground_Vehicles_Heavy, 1 * ceil(_sizeMultiplier/2)]
                        ]
                    };
                    case "fortification": {
                        [
                            ["infantry", East_Units, 6 * _sizeMultiplier],
                            ["fortification", ["Land_BagBunker_Small_F", "Land_BagFence_Long_F", "Land_BagFence_Round_F"], 2 * _sizeMultiplier]
                        ]
                    };
                    default {
                        [
                            ["infantry", East_Units, 4 * _sizeMultiplier]
                        ]
                    };
                };
                
                _baseComposition
            };
            
            // Create the Task Force data structure
            private _taskForceData = [
                _taskForceId,
                _basePos,
                _targetPos,
                _taskForceType,
                _taskForceSize,
                _composition,
                false, // isDeployed
                [], // deployedUnits
                [], // waypoints
                time, // creationTime
                0, // virtualDistance
                0, // virtualDirection
                10, // movementSpeed (meters per second, adjusted for virtual movement)
                _resourceCost, // resourceValue
                false // isVirtualized (starts virtualized)
            ];
            
            // Store the Task Force
            private _taskForces = _self get "taskForces";
            _taskForces set [_taskForceId, _taskForceData];
            
            diag_log format ["[FLO][TaskForce] Created Task Force %1 of type %2 (size: %3) at %4",
                _taskForceId, _taskForceType, _taskForceSize, _baseMarker];
            
            // Return the Task Force ID
            _taskForceId
        }],
        
        // Update all Task Forces (position, virtualization status, etc.)
        ["updateTaskForces", {
            private _taskForces = _self get "taskForces";
            private _taskForceKeys = keys _taskForces;
            private _playersPos = allPlayers apply {getPosWorld _x};
            private _activationDistance = VSDistance - 500; // Use a buffer from the virtualization distance
            
            if (count _taskForceKeys == 0) exitWith {}; 
            
            {
                private _taskForceId = _x;
                private _taskForceData = _taskForces get _taskForceId;
                
                _taskForceData params [
                    "_id",
                    "_basePos",
                    "_targetPos",
                    "_type",
                    "_size",
                    "_composition",
                    "_isDeployed",
                    "_deployedUnits",
                    "_waypoints",
                    "_creationTime",
                    "_virtualDistance",
                    "_virtualDirection",
                    "_movementSpeed",
                    "_resourceValue",
                    "_isVirtualized"
                ];
                
                // If Task Force is deployed, check if it needs to be virtualized
                if (_isDeployed && !_isVirtualized) then {
                    // Check if Task Force should be virtualized (far from all players)
                    private _shouldVirtualize = true;
                    private _taskForcePos = _basePos; // Use last known position
                    
                    if (count _deployedUnits > 0) then {
                        // If units exist, use their average position
                        private _unitPositions = _deployedUnits apply {
                            if (!isNull _x) then {getPosWorld _x} else {[0,0,0]}
                        };
                        
                        // Filter out null positions
                        _unitPositions = _unitPositions select {!(_x isEqualTo [0,0,0])};
                        
                        if (count _unitPositions > 0) then {
                            // Calculate average position
                            private _totalPos = [0,0,0];
                            {_totalPos = _totalPos vectorAdd _x} forEach _unitPositions;
                            _taskForcePos = _totalPos vectorMultiply (1 / count _unitPositions);
                        };
                    };
                    
                    // Check distance from all players
                    {
                        if (_x distance _taskForcePos < VSDistance) exitWith {
                            _shouldVirtualize = false;
                        };
                    } forEach _playersPos;
                    
                    // Virtualize the Task Force if needed
                    if (_shouldVirtualize) then {
                        // Store Task Force data in VS_VirtualizedTaskForces
                        private _virtualTaskForceData = [
                            _taskForceId,
                            _taskForcePos,
                            _type,
                            _size,
                            _composition,
                            _deployedUnits apply {if (!isNull _x) then {typeOf _x} else {""}},
                            _resourceValue
                        ];
                        
                        // Store in virtualization system
                        private _key = format ["TF_%1_%2", _taskForcePos, floor random 999999];
                        VS_VirtualizedTaskForces set [_key, _virtualTaskForceData];
                        
                        // Delete units
                        {
                            if (!isNull _x) then {
                                if (_x isKindOf "Man") then {
                                    private _group = group _x;
                                    deleteVehicle _x;
                                    if (count units _group == 0) then {
                                        deleteGroup _group;
                                    };
                                } else {
                                    deleteVehicle _x;
                                };
                            };
                        } forEach _deployedUnits;
                        
                        // Update Task Force data
                        _taskForceData set [7, []]; // Clear deployed units
                        _taskForceData set [11, [_taskForcePos, _targetPos] call BIS_fnc_dirTo]; // Update direction
                        _taskForceData set [14, true]; // Mark as virtualized
                        
                        diag_log format ["[FLO][TaskForce] Virtualized Task Force %1 at position %2",
                            _taskForceId, _taskForcePos];
                    };
                }
                // If Task Force is virtualized but has target, continue virtual movement
                else if (_isVirtualized && !(_targetPos isEqualTo [0,0,0])) then {
                    // Calculate movement since last update
                    private _timeSinceLastUpdate = time - (_self get "lastUpdate");
                    private _distanceMoved = _movementSpeed * _timeSinceLastUpdate;
                    
                    // Update virtual distance moved
                    _virtualDistance = _virtualDistance + _distanceMoved;
                    _taskForceData set [10, _virtualDistance];
                    
                    // Calculate new position based on movement
                    private _totalDistance = _basePos distance _targetPos;
                    
                    // If Task Force has reached target, deploy it
                    if (_virtualDistance >= _totalDistance) then {
                        _taskForceData set [1, _targetPos]; // Update position to target
                        _taskForceData set [10, 0]; // Reset virtual distance
                        
                        // Check if it's near any players
                        private _shouldDeploy = false;
                        {
                            if (_x distance _targetPos < _activationDistance) exitWith {
                                _shouldDeploy = true;
                            };
                        } forEach _playersPos;
                        
                        if (_shouldDeploy) then {
                            // Deploy the Task Force at target
                            [_self, _taskForceId, _targetPos, true] call ["deployTaskForce", [_taskForceId, _targetPos, true]];
                        };
                    } else {
                        // Calculate new virtual position (for tracking purposes)
                        private _dirVector = _targetPos vectorDiff _basePos;
                        _dirVector = _dirVector vectorMultiply (1 / (_basePos distance _targetPos));
                        private _movementVector = _dirVector vectorMultiply _virtualDistance;
                        private _newVirtualPos = _basePos vectorAdd _movementVector;
                        
                        // Update the base position to track progress
                        _taskForceData set [1, _newVirtualPos];
                        
                        // Check if any players are near this virtual position
                        private _shouldDeploy = false;
                        {
                            if (_x distance _newVirtualPos < _activationDistance) exitWith {
                                _shouldDeploy = true;
                            };
                        } forEach _playersPos;
                        
                        if (_shouldDeploy) then {
                            // Deploy the Task Force at current virtual position
                            [_self, _taskForceId, _newVirtualPos, false] call ["deployTaskForce", [_taskForceId, _newVirtualPos, false]];
                        };
                    };
                };
                
                // Update the Task Force data
                _taskForces set [_taskForceId, _taskForceData];
            } forEach _taskForceKeys;
            
            // Update last update timestamp
            _self set ["lastUpdate", time];
        }],
        
        // Deploy a Task Force at a specific position
        ["deployTaskForce", {
            params ["_taskForceId", "_position", "_defensive"];
            
            // Get the Task Force data
            private _taskForces = _self get "taskForces";
            if (!(_taskForceId in keys _taskForces)) exitWith {
                diag_log format ["[FLO][TaskForce] Error: Task Force %1 not found", _taskForceId];
                false
            };
            
            private _taskForceData = _taskForces get _taskForceId;
            
            _taskForceData params [
                "_id",
                "_basePos",
                "_targetPos",
                "_type",
                "_size",
                "_composition",
                "_isDeployed",
                "_deployedUnits",
                "_waypoints",
                "_creationTime",
                "_virtualDistance",
                "_virtualDirection",
                "_movementSpeed",
                "_resourceValue",
                "_isVirtualized"
            ];
            
            // If already deployed, exit
            if (_isDeployed && !_isVirtualized) exitWith {
                diag_log format ["[FLO][TaskForce] Task Force %1 is already deployed", _taskForceId];
                false
            };
            
            // Create units based on composition
            private _allCreatedUnits = [];
            private _allCreatedGroups = [];
            
            // Create infantry units
            private _infantryGroup = createGroup east;
            _infantryGroup deleteGroupWhenEmpty true;
            
            {
                _x params ["_unitType", "_unitClasses", "_unitCount"];
                
                if (_unitType in ["infantry", "at", "mg"]) then {
                    for "_i" from 1 to _unitCount do {
                        private _unitClass = selectRandom _unitClasses;
                        private _unit = _infantryGroup createUnit [_unitClass, _position, [], 20, "NONE"];
                        _allCreatedUnits pushBack _unit;
                    };
                };
                
                if (_unitType == "vehicle") then {
                    for "_i" from 1 to _unitCount do {
                        private _vehicleClass = selectRandom _unitClasses;
                        
                        // Find suitable position for vehicle
                        private _vehiclePos = [_position, 10, 50, 10, 0, 0.5, 0] call BIS_fnc_findSafePos;
                        
                        // Create vehicle
                        private _vehicle = createVehicle [_vehicleClass, _vehiclePos, [], 0, "NONE"];
                        
                        // Create crew
                        private _vehicleGroup = createGroup east;
                        _vehicleGroup deleteGroupWhenEmpty true;
                        
                        // Create crew based on vehicle type
                        [_vehicle, _vehicleGroup] call BIS_fnc_spawnCrew;
                        
                        // Add vehicle and crew to created units
                        _allCreatedUnits pushBack _vehicle;
                        _allCreatedUnits append (crew _vehicle);
                        _allCreatedGroups pushBack _vehicleGroup;
                    };
                };
                
                if (_unitType == "fortification") then {
                    for "_i" from 1 to _unitCount do {
                        private _fortClass = selectRandom _unitClasses;
                        
                        // Find suitable position
                        private _fortPos = [_position, 10, 30, 5, 0, 0.5, 0] call BIS_fnc_findSafePos;
                        
                        // Create fortification
                        private _fortification = createVehicle [_fortClass, _fortPos, [], 0, "NONE"];
                        
                        // Set random direction
                        _fortification setDir (random 360);
                        
                        _allCreatedUnits pushBack _fortification;
                    };
                };
            } forEach _composition;
            
            // Set up behavior based on deployment type
            if (_defensive) then {
                // Defensive deployment (fortify position)
                [_infantryGroup, _position, 100] call BIS_fnc_taskDefend;
                
                // Make vehicles defend as well
                {
                    if (_x isKindOf "Group") then {
                        [_x, _position, 150] call BIS_fnc_taskDefend;
                    };
                } forEach _allCreatedGroups;
                
                // Create a small marker to show defensive position
                private _markerName = format ["tf_def_%1", _taskForceId];
                createMarker [_markerName, _position];
                _markerName setMarkerType "mil_triangle";
                _markerName setMarkerColor "ColorEAST";
                _markerName setMarkerAlpha 0.6;
                _markerName setMarkerSize [0.6, 0.6];
                _markerName setMarkerText format ["TF %1", _type];
            } else {
                // Offensive deployment (patrol if has target, defend if not)
                if (!(_targetPos isEqualTo [0,0,0])) then {
                    // Task Force has a target, move towards it
                    [_infantryGroup, _targetPos, 200] call BIS_fnc_taskPatrol;
                    
                    // Make vehicles patrol as well
                    {
                        if (_x isKindOf "Group") then {
                            [_x, _targetPos, 250] call BIS_fnc_taskPatrol;
                        };
                    } forEach _allCreatedGroups;
                } else {
                    // No target, just patrol around current position
                    [_infantryGroup, _position, 150] call BIS_fnc_taskPatrol;
                    
                    {
                        if (_x isKindOf "Group") then {
                            [_x, _position, 200] call BIS_fnc_taskPatrol;
                        };
                    } forEach _allCreatedGroups;
                };
            };
            
            // Update Task Force data
            _taskForceData set [1, _position]; // Update position
            _taskForceData set [6, true]; // Mark as deployed
            _taskForceData set [7, _allCreatedUnits]; // Store deployed units
            _taskForceData set [14, false]; // Mark as not virtualized
            
            // Store updated Task Force data
            _taskForces set [_taskForceId, _taskForceData];
            
            diag_log format ["[FLO][TaskForce] Deployed Task Force %1 at position %2 with %3 units",
                _taskForceId, _position, count _allCreatedUnits];
            
            true
        }],
        
        // Get information about a specific Task Force
        ["getTaskForce", {
            params ["_taskForceId"];
            
            private _taskForces = _self get "taskForces";
            if (!(_taskForceId in keys _taskForces)) exitWith {
                []
            };
            
            _taskForces get _taskForceId
        }],
        
        // Strengthen a deployed defensive line
        ["reinforceDefensiveLine", {
            params ["_position", "_radius"];
            
            private _taskForces = _self get "taskForces";
            private _nearbyTaskForces = [];
            
            // Find Task Forces near the position
            {
                private _taskForceData = _taskForces get _x;
                private _taskForcePos = _taskForceData select 1;
                
                if (_taskForcePos distance _position <= _radius) then {
                    _nearbyTaskForces pushBack _x;
                };
            } forEach keys _taskForces;
            
            if (count _nearbyTaskForces == 0) exitWith {
                diag_log format ["[FLO][TaskForce] No Task Forces found near position %1", _position];
                false
            };
            
            // Create a fortification Task Force to strengthen the line
            _self call ["createTaskForce", ["", "fortification", "squad", ""]];
            
            // Deploy the Task Force at the position
            _self call ["deployTaskForce", [_taskForceId, _position, true]];
            
            diag_log format ["[FLO][TaskForce] Reinforced defensive line at %1", _position];
            true
        }]
    ];
    
    // Create the TaskForceSystem with specified parameters
    FLO_TaskForce_System = createHashMapObject [_taskForceSystemClass];
};

// Handle different operation modes
switch (_mode) do {
    // Initialize the Task Force system and start background processes
    case "init": {
        private _self = FLO_TaskForce_System;
        _self call ["initialize", []];
        _result = FLO_TaskForce_System;
    };
    
    // Create a new Task Force with specified parameters
    case "createTaskForce": {
        _params params [
            ["_baseMarker", "", [""]],
            ["_taskForceType", "infantry", [""]],
            ["_taskForceSize", "squad", [""]],
            ["_targetMarker", "", [""]]
        ];
        
        private _self = FLO_TaskForce_System;
        _result = _self call ["createTaskForce", [_baseMarker, _taskForceType, _taskForceSize, _targetMarker]];
    };
    
    // Update all Task Force positions and statuses
    case "updateTaskForces": {
        private _self = FLO_TaskForce_System;
        _self call ["updateTaskForces", []];
    };
    
    // Get information about a specific Task Force
    case "getTaskForce": {
        _params params [["_taskForceId", "", [""]]];
        
        private _self = FLO_TaskForce_System;
        _result = _self call ["getTaskForce", [_taskForceId]];
    };
    
    // Deploy a Task Force at a specific position
    case "deployTaskForce": {
        _params params [
            ["_taskForceId", "", [""]],
            ["_position", [0,0,0], [[]]],
            ["_defensive", false, [false]]
        ];
        
        private _self = FLO_TaskForce_System;
        _result = _self call ["deployTaskForce", [_taskForceId, _position, _defensive]];
    };
};

_result 