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

FLO_fnc_airDrone = {
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
            ["weaponConfigs", createHashMapFromArray [
                ["Aegis_I_UAV_07_F", [
                    "PylonRack_3Rnd_ACE_Hellfire_AGM114K",
                    "PylonRack_3Rnd_ACE_Hellfire_AGM114N",
                    "PylonRack_3Rnd_ACE_Hellfire_AGM114L"
                ]],
                ["I_UAV_02_dynamicLoadout_F", [
                    "PylonRack_3Rnd_ACE_Hellfire_AGM114L",
                    "PylonRack_3Rnd_ACE_Hellfire_AGM114N",
                    "PylonRack_3Rnd_ACE_Hellfire_AGM114K"
                ]]
            ]],
            ["createDrone", {
                params ["_this", "_type", "_pos", "_alt"];
                private _drone = createVehicle [_type, _pos, [], 0, "FLY"];
                private _group = createGroup [east, true];
                createVehicleCrew _drone;
                (crew _drone) joinSilent _group;
                _drone
            }],
            ["getDroneById", {
                params ["_this", "_id"];
                _this get "activeUnits" get _id
            }]
        ]];
    };

    // Create drone object with methods
    private _droneObject = createHashMapObject [[
        ["vehicle", objNull],
        ["group", grpNull],
        ["type", ""],
        ["state", "READY"],
        ["lastEngaged", time],
        ["currentTarget", objNull],
        ["weaponLoadout", []],
        ["altitude", _altitude],
        ["patrolRadius", 2000],
        ["engagementRange", 2000],
        ["cooldownTime", 30],
        
        // Methods
        ["initialize", {
            params ["_this", "_type", "_pos", "_alt"];
            private _spawnPos = [_pos, 8000, 10000, 100, 0] call BIS_fnc_findSafePos;
            _spawnPos set [2, _alt];
            
            private _drone = [FLO_drones, _type, _spawnPos, _alt] call (FLO_drones get "createDrone");
            _this set ["vehicle", _drone];
            _this set ["group", group _drone];
            _this set ["type", _type];
            
            // Setup
            _drone flyInHeight _alt;
            
            // Configure weapons
            private _weapons = (FLO_drones get "weaponConfigs") get _type;
            {
                _drone setPylonLoadOut [_forEachIndex + 1, _x];
            } forEach _weapons;
            _this set ["weaponLoadout", _weapons];
            
            private _group = _this get "group";
            _group setBehaviour "COMBAT";
            _group setCombatMode "RED";
            
            _this
        }],
        
        ["startPatrol", {
            params ["_this", "_pos"];
            private _waypoints = [];
            private _group = _this get "group";
            private _alt = _this get "altitude";
            private _radius = _this get "patrolRadius";
            
            // Clear existing waypoints
            while {count waypoints _group > 0} do {
                deleteWaypoint [_group, 0];
            };
            
            // Create patrol pattern
            for "_i" from 0 to 3 do {
                private _wp = _pos getPos [_radius, _i * 90];
                _wp set [2, _alt];
                _waypoints pushBack _wp;
                
                private _wpObj = _group addWaypoint [_wp, 0];
                _wpObj setWaypointType "MOVE";
                _wpObj setWaypointBehaviour "COMBAT";
                _wpObj setWaypointCombatMode "RED";
            };
            
            private _wpCycle = _group addWaypoint [_waypoints select 0, 0];
            _wpCycle setWaypointType "CYCLE";
            
            _this set ["state", "PATROLLING"];
        }],
        
        ["engageTarget", {
            params ["_this", "_target"];
            private _drone = _this get "vehicle";
            
            _this set ["state", "ENGAGING"];
            _this set ["currentTarget", _target];
            
            // Create laser target
            private _laserTarget = createVehicle ["LaserTargetE", getPos _target, [], 0, "CAN_COLLIDE"];
            _laserTarget attachTo [_target, [0,0,1]];
            
            // Select weapon based on target type
            private _weapon = selectRandom (_this get "weaponLoadout");
            _drone selectWeapon _weapon;
            
            // Attack run
            _drone doTarget _target;
            _drone doWatch _laserTarget;
            _drone fireAtTarget [_target, _weapon];
            
            _this set ["lastEngaged", time];
            
            // Clean up laser target after engagement
            [_laserTarget] spawn {
                params ["_laser"];
                sleep 30;
                deleteVehicle _laser;
            };
        }],
        
        ["scanForTargets", {
            params ["_this"];
            private _drone = _this get "vehicle";
            private _range = _this get "engagementRange";
            
            private _nearTargets = _drone nearEntities ["CAManBase", _range];
            _nearTargets select {side _x != side _drone && !(isPlayer _x)}
        }],
        
        ["update", {
            params ["_this"];
            if (!alive (_this get "vehicle")) exitWith {false};
            
            if ((_this get "state") == "PATROLLING") then {
                private _targets = _this call (_this get "scanForTargets");
                if (count _targets > 0) then {
                    [_this, selectRandom _targets] call (_this get "engageTarget");
                    sleep (_this get "cooldownTime");
                    _this set ["state", "PATROLLING"];
                };
            };
            true
        }]
    ]];

    // Initialize drone
    private _droneType = if (_requestedType != "" && {_requestedType in (FLO_drones get "droneTypes")}) then {
        _requestedType
    } else {
        selectRandom (FLO_drones get "droneTypes")
    };
    
    [_droneObject, _droneType, _targetPos, _altitude] call (_droneObject get "initialize");
    [_droneObject, _targetPos] call (_droneObject get "startPatrol");
    
    // Start update loop
    [_droneObject] spawn {
        params ["_drone"];
        while {[_drone] call (_drone get "update")} do {
            sleep 5;
        };
    };
    
    // Add to active drones
    (FLO_drones get "activeUnits") set [netId (_droneObject get "vehicle"), _droneObject];
    
    // Return drone object
    _droneObject
};
