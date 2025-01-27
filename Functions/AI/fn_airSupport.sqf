/*
    Function: FLO_fnc_airSupport
    
    Description:
    Manages air support operations including CAS and strike missions.
    Uses OOP-like approach with hashMapObjects for advanced aircraft behavior and mission execution.
    
    Parameters:
    _targetPos - Target position for air support [Array]
    _missionType - Type of mission ("CAS" or "STRIKE") [String]
    _aircraftType - Optional specific aircraft type to spawn [String]
    _altitude - Optional operating altitude [Number]
    
    Returns:
    HashMap - Air support object with methods and state
*/

params [
    ["_targetPos", [0,0,0], [[]], [3]],
    ["_missionType", "CAS", [""]],
    ["_aircraftType", "", [""]],
    ["_altitude", 1000, [0]]
];

// Initialize air support system if not exists
if (isNil "FLO_airSupport") then {
    FLO_airSupport = createHashMapObject [[
        ["activeUnits", createHashMap],
        ["getHeliStandoffRange", {
            params ["_heliType"];
            // Default standoff ranges for helicopters
            private _ranges = switch (_heliType) do {
                case "I_Heli_Attack_03_F": {[3000, 6000]};
                case "I_Heli_Light_01_dynamicLoadout_F": {[800, 1500]};
                case "I_Heli_light_03_dynamicLoadout_F": {[1000, 2500]};
                case "Aegis_I_Raven_Heli_Attack_04_F": {[1500, 4000]};
                default {[2000, 5000]};
            };
            _ranges
        }],
        ["createAircraft", {
            params ["_type", "_pos", "_alt"];
            private _spawnPos = [_pos, 8000, 10000, 100, 0] call BIS_fnc_findSafePos;
            _spawnPos set [2, _alt];
            
            private _aircraft = createVehicle [_type, _spawnPos, [], 0, "FLY"];
            private _group = createGroup [east, true];
            createVehicleCrew _aircraft;
            (crew _aircraft) joinSilent _group;
            _aircraft
        }],
        ["getAircraftById", {
            params ["_id"];
            _self get "activeUnits" get _id
        }]
    ]];
};

// Create air support object type definition with methods
private _airSupportTypeDef = [
    ["vehicle", objNull],
    ["group", grpNull],
    ["type", ""],
    ["missionType", ""],
    ["state", "READY"],
    ["lastEngaged", time],
    ["currentTarget", objNull],
    ["weaponLoadout", []],
    ["altitude", _altitude],
    ["approachRadius", 3000],
    ["engagementRange", 2000],
    ["cooldownTime", 45],
    ["currentLaser", objNull],
    ["standoffRange", []],
    
    // Methods
    ["#create", {
        params ["_type", "_pos", "_alt", "_missionType", "_standoffRange"];
        private _aircraft = FLO_airSupport call ["createAircraft", [_type, _pos, _alt]];
        _self set ["vehicle", _aircraft];
        _self set ["group", group _aircraft];
        _self set ["type", _type];
        _self set ["missionType", _missionType];
        _self set ["standoffRange", _standoffRange];
        
        // Setup
        _aircraft flyInHeight _alt;
        
        private _pylonMags = getPylonMagazines _aircraft;
        _self set ["weaponLoadout", _pylonMags];
        
        private _group = _self get "group";
        _group setCombatBehaviour "COMBAT";
        _group setCombatMode "GREEN";
        {
            _x setBehaviour "COMBAT";
            _x setUnitCombatMode "GREEN";
        } forEach units _group;
        
        _self call ["setupApproach", [_pos]]
    }],
    
    ["setupApproach", {
        params ["_pos"];
        private _group = _self get "group";
        private _alt = _self get "altitude";
        private _radius = _self get "approachRadius";
        private _aircraft = _self get "vehicle";
        private _missionType = _self get "missionType";
        private _standoffRange = _self get "standoffRange";
        
        while {count waypoints _group > 0} do {
            deleteWaypoint [_group, 0];
        };
        
        // Different approach patterns for CAS vs STRIKE
        switch (_missionType) do {
            case "CAS": {
                private _holdPos = _pos;
                if (_aircraft isKindOf "Helicopter" && {count _standoffRange > 1}) then {
                    // Helicopter with standoff position
                    private _minRange = _standoffRange select 0;
                    private _maxRange = _standoffRange select 1;
                    _holdPos = _pos getPos [_maxRange - (random (_maxRange * 0.2)), random 90];
                };
                _holdPos set [2, _alt];
                    
                private _wp = _group addWaypoint [_holdPos, 0];
                _wp setWaypointType "HOLD";
                _wp setWaypointBehaviour "COMBAT";
                _wp setWaypointCombatMode "GREEN";
                
                if (_aircraft isKindOf "Helicopter") then {
                    _wp setWaypointSpeed "LIMITED";
                };
            };
            case "STRIKE": {
                // Strike uses attack run pattern
                private _dir = random 360;
                private _attackPos = _pos getPos [_radius, _dir];
                _attackPos set [2, _alt];
                
                private _wp1 = _group addWaypoint [_attackPos, 0];
                _wp1 setWaypointType "MOVE";
                _wp1 setWaypointBehaviour "COMBAT";
                _wp1 setWaypointCombatMode "GREEN";
                
                private _wp2 = _group addWaypoint [_pos, 0];
                _wp2 setWaypointType "DESTROY";
                _wp2 setWaypointBehaviour "COMBAT";
                _wp2 setWaypointCombatMode "GREEN";
            };
        };
        
        _self set ["state", "APPROACHING"];
    }],
    
    ["executeStrike", {
        params ["_target"];
        private _aircraft = _self get "vehicle";
        private _pilot = driver _aircraft;
        private _gunner = gunner _aircraft;
        
        if (!alive _aircraft || !alive _target) exitWith {false};
        
        if ((_self get "state") == "ENGAGING" || 
            (time - (_self get "lastEngaged")) < (_self get "cooldownTime")) exitWith {false};
        
        _self set ["state", "ENGAGING"];
        _self set ["currentTarget", _target];
        
        // Create laser designation
        private _laserTarget = createVehicle ["LaserTargetW", getPos _target, [], 0, "CAN_COLLIDE"];
        _laserTarget attachTo [_target, [0,0,1]];
        _self set ["currentLaser", _laserTarget];
        
        // Select weapon and engage
        private _weapon = selectRandom (_self get "weaponLoadout");
        if (!isNull _gunner) then {
            _gunner selectWeapon _weapon;
            _gunner doTarget _target;
            _gunner doWatch _laserTarget;
            _gunner reveal [_target, 4];
            _gunner fireAtTarget [_target, _weapon];
        } else {
            _pilot selectWeapon _weapon;
            _pilot doTarget _target;
            _pilot doWatch _laserTarget;
            _pilot reveal [_target, 4];
            _pilot fireAtTarget [_target, _weapon];
        };
        
        _self set ["lastEngaged", time];
        true
    }],
    
    ["cleanupLaser", {
        private _laser = _self get "currentLaser";
        if (!isNull _laser) then {
            deleteVehicle _laser;
            _self set ["currentLaser", objNull];
        };
    }],
    
    ["scanForTargets", {
        private _aircraft = _self get "vehicle";
        if (!alive _aircraft) exitWith {[]};
        
        private _range = _self get "engagementRange";
        private _targets = _aircraft targets [true, _range];
        _targets select {side _x != side _aircraft && alive _x}
    }],
    
    ["update", {
        private _aircraft = _self get "vehicle";
        if (!alive _aircraft) exitWith {
            _self call ["cleanupLaser"];
            false
        };
        
        private _state = _self get "state";
        private _missionType = _self get "missionType";
        
        switch (_state) do {
            case "APPROACHING": {
                if (_missionType == "CAS") then {
                    private _targets = _self call ["scanForTargets"];
                    if (count _targets > 0) then {
                        private _target = selectRandom _targets;
                        if (_self call ["executeStrike", [_target]]) then {
                            _self set ["state", "ENGAGING"];
                        };
                    };
                };
            };
            case "ENGAGING": {
                private _currentTarget = _self get "currentTarget";
                if (!alive _currentTarget || 
                    (time - (_self get "lastEngaged")) > (_self get "cooldownTime")) then {
                    _self call ["cleanupLaser"];
                    _self set ["state", "APPROACHING"];
                    _self set ["currentTarget", objNull];
                };
            };
        };
        true
    }]
];

// Initialize air support
private _aircraftType = if (_aircraftType != "") then {
    _aircraftType
} else {
    if (_missionType == "CAS") then {
        selectRandom East_Air_Heli
    } else {
        selectRandom East_Air_Jet
    };
};

// Get standoff range if it's a helicopter
private _standoffRange = [];
if (_aircraftType isKindOf "Helicopter") then {
    _standoffRange = FLO_airSupport call ["getHeliStandoffRange", [_aircraftType]];
};

// Create the air support object with proper parameter array syntax
private _airSupport = createHashMapObject [_airSupportTypeDef, [_aircraftType, _targetPos, _altitude, _missionType, _standoffRange]];

// Add to active units
FLO_airSupport get "activeUnits" set [str _airSupport, _airSupport];

_airSupport