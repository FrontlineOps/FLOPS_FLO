/*
    Function: FLO_fnc_airDrone
    
    Description:
    Manages high-altitude armed drone operations for battlefield reconnaissance and strike missions.
    Uses OOP-like approach with hashMapObjects for advanced drone behavior and state management.
    
    Parameters:
    _targetPos - Target position for drone operations [Array]
    _requestedType - Optional specific drone type to spawn [String]
    _altitude - Optional altitude for drone operations [Number]
    
    Returns:
    HashMap - Drone object with methods and state
*/

params [
    ["_targetPos", [0,0,0], [[]], [3]],
    ["_requestedType", "", [""]],
    ["_altitude", 5000, [0]]
];

// Initialize drone system if not exists
if (isNil "FLO_drones") then {
    FLO_drones = createHashMapObject [ [
        ["activeUnits", createHashMap],
        ["droneTypes", [
            "Aegis_I_UAV_07_F",
            "I_UAV_02_dynamicLoadout_F"
        ]],
        ["createDrone", {
            params ["_type", "_pos", "_alt"];
            private _drone = createVehicle [_type, _pos, [], 0, "FLY"];
            private _group = createGroup [east, true];
            createVehicleCrew _drone;
            (crew _drone) joinSilent _group;
            _drone
        }],
        ["getDroneById", {
            params ["_id"];
            _self get "activeUnits" get _id
        }]
    ]];
};

// Create drone object type definition (an array) with methods
private _droneObjectTypeDDef = [
    ["vehicle", objNull],
    ["group", grpNull],
    ["type", ""],
    ["state", "READY"],
    ["lastEngaged", time],
    ["currentTarget", objNull],
    ["weaponLoadout", []],
    ["altitude", _altitude],
    ["patrolRadius", 1500],
    ["engagementRange", 3500],
    ["cooldownTime", 30],
    ["currentLaser", objNull],
    
    // Methods
    ["#create", {
        params ["_type", "_pos", "_alt"];
        private _spawnPos = [_pos, 8000, 10000, 100, 0] call BIS_fnc_findSafePos;
        _spawnPos set [2, _alt];
        
        private _drone = FLO_drones call ["createDrone", [_type, _spawnPos, _alt]];
        _self set ["vehicle", _drone];
        _self set ["group", group _drone];
        _self set ["type", _type];
        
        // Setup
        _drone flyInHeight _alt;
        
        // Get actual pylon magazines from the vehicle
        private _pylonMags = getPylonMagazines _drone;
        _self set ["weaponLoadout", _pylonMags];
        
        private _group = _self get "group";
        _group setCombatBehaviour "COMBAT";
        _group setCombatMode "GREEN";
        // Set behavior for all units in group
        {
            _x setBehaviour "COMBAT";
            _x setUnitCombatMode "GREEN";
        } forEach units _group;
        
        _self call ["startPatrol", [_pos]]
    }],
    
    ["startPatrol", {
        params ["_pos"];
        private _group = _self get "group";
        private _alt = _self get "altitude";
        private _radius = _self get "patrolRadius";
        private _drone = _self get "vehicle";
        
        // Clear existing waypoints
        while {count waypoints _group > 0} do {
            deleteWaypoint [_group, 0];
        };
        
        // Create loiter waypoint
        private _wp = _group addWaypoint [_pos, 0];
        _wp setWaypointType "LOITER";
        _wp setWaypointBehaviour "COMBAT";
        _wp setWaypointCombatMode "GREEN";
        
        // Set loiter parameters for optimal drone behavior
        _wp setWaypointLoiterType "CIRCLE_L";  // Counter-clockwise circle
        _wp setWaypointLoiterRadius _radius;
        _wp setWaypointTimeout [0, 0, 0];      // No timeout
        _wp setWaypointSpeed "LIMITED";        // Maintain steady speed
        _wp setWaypointCompletionRadius 50;    // Smaller completion radius for tighter circles
        
        // Set altitude
        _wp setWaypointPosition [_pos vectorAdd [0,0,_alt], -1];
        
        _self set ["state", "PATROLLING"];
    }],
    
    ["engageTarget", {
        params ["_target"];
        private _drone = _self get "vehicle";
        private _gunner = gunner _drone;
        
        if (!alive _drone || !alive _target || isNull _gunner) exitWith {false};
        
        // Check if we're already engaging or in cooldown
        if ((_self get "state") == "ENGAGING" || 
            (time - (_self get "lastEngaged")) < (_self get "cooldownTime")) exitWith {false};
        
        _self set ["state", "ENGAGING"];
        _self set ["currentTarget", _target];
        
        // Create laser target
        private _laserTarget = createVehicle ["LaserTargetE", getPos _target, [], 0, "CAN_COLLIDE"];
        _laserTarget attachTo [_target, [0,0,1]];
        _self set ["currentLaser", _laserTarget];
        
        // Select weapon and engage using gunner
        private _weapon = selectRandom (_self get "weaponLoadout");
        _gunner selectWeapon _weapon;
        _gunner doTarget _target;
        _gunner doWatch _laserTarget;
        
        // Use reveal to ensure gunner has good target knowledge
        _gunner reveal [_target, 4];
        
        // Fire the weapon
        _gunner fireAtTarget [_target, _weapon];
        
        _self set ["lastEngaged", time];
        true
    }],
    
    ["cleanupLaser", {
        private _laser = _self get "currentLaser";
        if (!isNil "_laser") then {
            deleteVehicle _laser;
            _self set ["currentLaser", nil];
        };
    }],
    
    ["scanForTargets", {
        private _drone = _self get "vehicle";
        if (!alive _drone) exitWith {[]};
        
        // Get all targets the drone can detect
        private _allTargets = _drone targets [true, 0, [], _self get "engagementRange"];
        _allTargets select {side _x != side _drone && !(isPlayer _x)}
    }],
    
    ["update", {
        private _drone = _self get "vehicle";
        if (!alive _drone) exitWith {
            _self call ["cleanupLaser"];
            false
        };
        
        private _state = _self get "state";
        
        // Debug info
        if (isServer) then {
            diag_log format ["Drone Update: %1, State: %2", _drone, _state];
        };
        
        switch (_state) do {
            case "PATROLLING": {
                private _targets = _self call ["scanForTargets"];
                if (count _targets > 0) then {
                    private _target = selectRandom _targets;
                    if (_self call ["engageTarget", [_target]]) then {
                        _self set ["state", "ENGAGING"];
                    };
                };
            };
            case "ENGAGING": {
                private _currentTarget = _self get "currentTarget";
                if (!alive _currentTarget || 
                    {_currentTarget distance _drone > (_self get "engagementRange")}) then {
                    _self call ["cleanupLaser"];
                    _self set ["state", "PATROLLING"];
                };
            };
        };
        true
    }]
];

// Initialize drone
private _droneType = if (_requestedType != "" && {_requestedType in (FLO_drones get "droneTypes")}) then {
    _requestedType
} else {
    selectRandom (FLO_drones get "droneTypes")
};

//Create new droneObject - automatically starts patrol
private _droneObject = createHashMapObject [_droneObjectTypeDDef , [_droneType, _targetPos, _altitude] ];

// Start update loop with proper cleanup
[_droneObject] spawn {
    params ["_drone"];
    
    while {alive (_drone get "vehicle")} do {
        if (!(_drone call ["update"])) exitWith {};
        sleep 5;
    };
    
    // Final cleanup
    _drone call ["cleanupLaser"];
};

// Add to active drones
(FLO_drones get "activeUnits") set [netId (_droneObject get "vehicle"), _droneObject];

// Return drone object
_droneObject