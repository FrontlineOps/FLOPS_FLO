/*
    Function: FLO_fnc_airDrone
    
    Description:
    Manages high-altitude armed drone operations for battlefield reconnaissance and strike missions.
    Handles drone spawning, patrol patterns, and autonomous target engagement.
    
    Parameters:
    _targetPos - Target position for drone operations [Array]
    _requestedType - Optional specific drone type to spawn [String]
    _altitude - Optional altitude for drone operations [Number]
    
    Returns:
    HashMap - Drone information including vehicle, state, and loadout
*/

FLO_fnc_airDrone = {
    params [
        ["_targetPos", [0,0,0], [[]], [3]],
        ["_requestedType", "", [""]],
        ["_altitude", 5000, [0]]
    ];

    // Initialize drone tracking if not exists
    if (isNil "FLO_drones") then {
        FLO_drones = createHashMap;
    };

    // Drone configurations
    private _droneTypes = [
        "B_UAV_02_dynamicLoadout_F",    // Armed MALE UAV
        "B_UAV_05_F"                     // UCAV
    ];

    private _weaponConfigs = createHashMapFromArray [
        ["B_UAV_02_dynamicLoadout_F", [
            "PylonRack_3Rnd_LG_scalpel",     // Laser-guided missiles
            "PylonRack_1Rnd_Bomb_SDB_F",     // Small Diameter Bomb
            "PylonMissile_1Rnd_Bomb_04_F"    // Mk82 Bomb
        ]],
        ["B_UAV_05_F", [
            "PylonMissile_Bomb_GBU12_x1",    // Laser-guided bomb
            "PylonRack_Missile_AGM_02_x1",    // Macer ATGM
            "PylonMissile_1Rnd_BombCluster_01_F" // Cluster bomb
        ]]
    ];

    // Select drone type
    private _droneType = if (_requestedType != "" && {_requestedType in _droneTypes}) then {
        _requestedType
    } else {
        selectRandom _droneTypes
    };

    // Create new drone
    private _spawnPos = [_targetPos, 8000, 10000, 100, 0] call BIS_fnc_findSafePos;
    _spawnPos set [2, _altitude];

    private _drone = createVehicle [_droneType, _spawnPos, [], 0, "FLY"];
    createVehicleCrew _drone;

    // Setup drone
    _drone flyInHeight _altitude;

    // Set loadout
    private _availableWeapons = _weaponConfigs get _droneType;
    {
        _drone setPylonLoadOut [_forEachIndex + 1, _x];
    } forEach _availableWeapons;

    private _droneGroup = group _drone;
    _droneGroup setBehaviour "COMBAT";
    _droneGroup setCombatMode "RED";

    // Create drone info
    private _droneInfo = createHashMapFromArray [
        ["vehicle", _drone],
        ["group", _droneGroup],
        ["type", _droneType],
        ["state", "READY"],
        ["lastEngaged", time],
        ["currentTarget", objNull],
        ["weaponLoadout", _availableWeapons],
        ["altitude", _altitude]
    ];

    // Add to tracking
    FLO_drones set [netId _drone, _droneInfo];

    // Start patrol and engagement logic
    [_drone, _targetPos, _droneInfo] spawn {
        params ["_drone", "_targetPos", "_droneInfo"];

        // Set patrol pattern
        private _patrolRadius = 2000;
        private _waypoints = [];
        private _altitude = _droneInfo get "altitude";

        for "_i" from 0 to 3 do {
            private _wp = _targetPos getPos [_patrolRadius, _i * 90];
            _wp set [2, _altitude];
            _waypoints pushBack _wp;
        };

        _droneInfo set ["state", "PATROLLING"];

        // Create patrol pattern
        private _group = group _drone;
        {
            private _wp = _group addWaypoint [_x, 0];
            _wp setWaypointType "MOVE";
            _wp setWaypointBehaviour "COMBAT";
            _wp setWaypointCombatMode "RED";
        } forEach _waypoints;

        private _wpCycle = _group addWaypoint [_waypoints select 0, 0];
        _wpCycle setWaypointType "CYCLE";

        // Engage targets when found
        while {alive _drone} do {
            private _nearTargets = _drone nearEntities ["CAManBase", 2000];
            _nearTargets = _nearTargets select {side _x != side _drone && !(isPlayer _x)};

            if (count _nearTargets > 0) then {
                private _target = selectRandom _nearTargets;
                _droneInfo set ["state", "ENGAGING"];
                _droneInfo set ["currentTarget", _target];

                // Select weapon based on target type
                private _weapon = selectRandom (_droneInfo get "weaponLoadout");
                _drone selectWeapon _weapon;

                // Attack run
                _drone doTarget _target;
                _drone fireAtTarget [_target];

                sleep 30;  // Cool down between attacks

                _droneInfo set ["lastEngaged", time];
                _droneInfo set ["state", "PATROLLING"];
            };
            sleep 5;
        };
    };

    // Return drone info
    _droneInfo
};