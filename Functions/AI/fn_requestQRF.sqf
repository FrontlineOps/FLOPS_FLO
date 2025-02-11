/*
    Function: FLO_fnc_requestQRF
    
    Description:
    Requests and spawns a Quick Reaction Force based on threat level and location.
    
    Parameters:
    _targetPos - Position to respond to [Array]
    _radius - Radius of the area to consider for threat calculation [Number]
    
    Returns:
    Array - [success (Boolean), spawnedGroups (Array)]
*/

params [
    ["_targetPos", [0,0,0], [[]], [3]],
    ["_radius", 500, [0]]
];

// Find nearest valid OPFOR outpost
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

if (_nearestOutpost == "") exitWith {
    ["No valid OPFOR outpost found for QRF deployment"] remoteExec ["hint", remoteExecutedOwner];
    [false, []]
};

// Get aggression score
private _AGGRSCORE = parseNumber (markerText ((allMapMarkers select {markerColor _x == "Color6_FD_F"}) select 0));

// Calculate threat level based on radius and player presence
private _threatLevel = linearConversion [500, 2500, _radius, 0, 1, true];
private _responseParams = [_threatLevel, _AGGRSCORE] call FLO_fnc_calculateQRFResponse;
_responseParams params ["_tier", "_type"];

// Get spawn position
private _spawnPos = getMarkerPos _nearestOutpost;

// Select appropriate insertion method
private _insertionTypes = switch (_tier) do {
    case "Tier4": {
        selectRandom [
            ["HeliInsert", 1200],
            ["ArmorInsert", 1000],
            ["MechInsert", 800]
        ]
    };
    case "Tier3": {
        selectRandom [
            ["HeliInsert", 1000],
            ["MechInsert", 800],
            ["MotorizedInsert", 600]
        ]
    };
    case "Tier2": {
        selectRandom [
            ["MotorizedInsert", 800],
            ["HeliInsert", 600]
        ]
    };
    default {
        ["MotorizedInsert", 600]
    };
};

_insertionTypes params ["_insertType", "_approachDistance"];

// Calculate approach position
private _dir = _spawnPos getDir _targetPos;
private _approachPos = _targetPos getPos [_approachDistance, _dir - 180];
_approachPos = [_approachPos, 0, 200, 10, 0, 0.2, 0, [], [_approachPos, _approachPos]] call BIS_fnc_findSafePos;

// Helper function for vehicle and crew creation
private _fnc_createVehicleWithCrew = {
    params ["_vehType", "_spawnPos"];
    
    // Find nearest road
    private _nearRoads = _spawnPos nearRoads 1500;
    private _spawnPosRoad = if (count _nearRoads > 0) then {
        getPos (_nearRoads select 0)
    } else {
        _spawnPos
    };
    
    private _veh = createVehicle [_vehType, _spawnPosRoad, [], 0, "NONE"];
    private _group = createGroup [EAST, true];
    createVehicleCrew _veh;
    
    // Move crew to EAST side
    {
        [_x] joinSilent _group;
    } forEach (crew _veh);
    
    // Calculate cargo capacity (total seats minus crew seats)
    private _totalSeats = [typeOf _veh, true] call BIS_fnc_crewCount;  // Get total seats including cargo
    private _crewSeats = [typeOf _veh, false] call BIS_fnc_crewCount;  // Get crew seats only
    private _maxCargo = _totalSeats - _crewSeats;  // Calculate actual cargo capacity
    
    // Add intel to crew
    private _intelItems = ["FlashDisk", "FilesSecret", "SmartPhone", "MobilePhone", "DocumentsSecret"];
    private _crewUnits = crew _veh;
    private _selectedCrew = ((_crewUnits call BIS_fnc_arrayShuffle) select [0, floor(count _crewUnits / 2)]);
    
    {
        _x addItem selectRandom _intelItems;
    } forEach _selectedCrew;
    
    [_veh, _group, _maxCargo]
};

// Helper function to distribute intel to infantry group
private _fnc_addIntelToGroup = {
    params ["_group"];
    private _intelItems = ["FlashDisk", "FilesSecret", "SmartPhone", "MobilePhone", "DocumentsSecret"];
    private _groupUnits = units _group;
    private _selectedUnits = ((_groupUnits call BIS_fnc_arrayShuffle) select [0, floor(count _groupUnits / 2)]);
    
    {
        _x addItem selectRandom _intelItems;
    } forEach _selectedUnits;
};

// Spawn appropriate QRF based on tier
private _groups = [];
switch (_tier) do {
    case "Tier4": {
        // Combined Arms Response - Armor + Mechanized + Air Support
        
        // Spawn armor element
        private _armorVehType = selectRandom (FLO_configCache get "vehicles" select 3); // MBT
        private _result = [_armorVehType, _spawnPos] call _fnc_createVehicleWithCrew;
        private _armorVeh = _result select 0;
        private _armorGroup = _result select 1;
        private _armorMaxCargo = _result select 2;
        _groups pushBack _armorGroup;
        
        // Spawn mechanized infantry with APC
        private _mechVehType = selectRandom (FLO_configCache get "vehicles" select 2); // APC
        _result = [_mechVehType, _spawnPos] call _fnc_createVehicleWithCrew;
        private _mechVeh = _result select 0;
        private _mechGroup = _result select 1;
        private _mechMaxCargo = _result select 2;
        
        // Create and add infantry to APC
        private _mechInfGroup = createGroup EAST;
        for "_i" from 1 to _mechMaxCargo do {
            private _unitType = selectRandom (FLO_configCache get "units");
            private _unit = _mechInfGroup createUnit [_unitType, _spawnPos, [], 0, "NONE"];
            if (_unitType == "I_RadioOperator_F") then {
                [_unit, EAST] call FLO_fnc_fireObserver;
            };
            _unit assignAsCargo _mechVeh;
            _unit moveInCargo _mechVeh;
        };
        
        // Add intel to infantry group
        [_mechInfGroup] call _fnc_addIntelToGroup;
        
        // Join the infantry group to the vehicle group
        (units _mechInfGroup) joinSilent _mechGroup;
        _groups pushBack _mechGroup;
        
        // Add air support
        [_targetPos, "CAS"] spawn FLO_fnc_airSupport;
        
        // Add transport helicopter if using heli insert
        if (_insertType == "HeliInsert") then {
            [_thisHeliInsertTrigger, _targetPos, _spawnPos] call FLO_fnc_heliInsert;
        };
    };
    
    case "Tier3": {
        // Heavy response - mechanized infantry + air support
        private _mechVehType = selectRandom (FLO_configCache get "vehicles" select 2);
        private _result = [_mechVehType, _spawnPos] call _fnc_createVehicleWithCrew;
        private _mechVeh = _result select 0;
        private _mechGroup = _result select 1;
        private _mechMaxCargo = _result select 2;
        
        // Create and add infantry to APC
        private _mechInfGroup = createGroup EAST;
        for "_i" from 1 to _mechMaxCargo do {
            private _unitType = selectRandom (FLO_configCache get "units");
            private _unit = _mechInfGroup createUnit [_unitType, _spawnPos, [], 0, "NONE"];
            if (_unitType == "I_RadioOperator_F") then {
                [_unit, EAST] call FLO_fnc_fireObserver;
            };
            _unit assignAsCargo _mechVeh;
            _unit moveInCargo _mechVeh;
        };
        
        // Add intel to infantry group
        [_mechInfGroup] call _fnc_addIntelToGroup;
        
        // Join the infantry group to the vehicle group
        (units _mechInfGroup) joinSilent _mechGroup;
        _groups pushBack _mechGroup;
        
        if (_insertType == "HeliInsert") then {
            [_thisHeliInsertTrigger, _targetPos, _spawnPos] call FLO_fnc_heliInsert;
        };
        
        // Add air support based on aggression
        if (_AGGRSCORE > 5) then {
            [_targetPos, "CAS"] spawn FLO_fnc_airSupport;
        };
    };
    
    case "Tier2": {
        // Medium response - mechanized infantry
        private _vehType = selectRandom (FLO_configCache get "vehicles" select 2);
        private _result = [_vehType, _spawnPos] call _fnc_createVehicleWithCrew;
        private _veh = _result select 0;
        private _motorGroup = _result select 1;
        private _maxCargo = _result select 2;
        
        // Create and add infantry
        private _infGroup = createGroup EAST;
        for "_i" from 1 to _maxCargo do {
            private _unitType = selectRandom (FLO_configCache get "units");
            private _unit = _infGroup createUnit [_unitType, _spawnPos, [], 0, "NONE"];
            if (_unitType == "I_RadioOperator_F") then {
                [_unit, EAST] call FLO_fnc_fireObserver;
            };
            _unit assignAsCargo _veh;
            _unit moveInCargo _veh;
        };
        
        // Add intel to infantry group
        [_infGroup] call _fnc_addIntelToGroup;
        
        // Join the infantry group to the vehicle group
        (units _infGroup) joinSilent _motorGroup;
        _groups pushBack _motorGroup;
        
        // Add light armor support if aggression is high
        if (_AGGRSCORE > 7) then {
            private _lightArmorType = selectRandom (FLO_configCache get "vehicles" select 2);
            _result = [_lightArmorType, _spawnPos] call _fnc_createVehicleWithCrew;
            private _lightVeh = _result select 0;
            private _lightGroup = _result select 1;
            private _lightMaxCargo = _result select 2;
            _groups pushBack _lightGroup;
        };
    };
    
    default {
        // Light response - motorized style
        private _vehType = selectRandom (FLO_configCache get "vehicles" select 1);
        private _result = [_vehType, _spawnPos] call _fnc_createVehicleWithCrew;
        private _veh = _result select 0;
        private _lightGroup = _result select 1;
        private _maxCargo = _result select 2;
        
        // Create and add infantry
        private _infGroup = createGroup EAST;
        for "_i" from 1 to _maxCargo do {
            private _unitType = selectRandom (FLO_configCache get "units");
            private _unit = _infGroup createUnit [_unitType, _spawnPos, [], 0, "NONE"];
            if (_unitType == "I_RadioOperator_F") then {
                [_unit, EAST] call FLO_fnc_fireObserver;
            };
            _unit assignAsCargo _veh;
            _unit moveInCargo _veh;
        };
        
        // Add intel to infantry group
        [_infGroup] call _fnc_addIntelToGroup;
        
        // Join the infantry group to the vehicle group
        (units _infGroup) joinSilent _lightGroup;
        _groups pushBack _lightGroup;
        
        // Add mrap support if aggression is high
        if (_AGGRSCORE > 3) then {
            private _mrapType = selectRandom (FLO_configCache get "vehicles" select 2);
            _result = [_mrapType, _spawnPos] call _fnc_createVehicleWithCrew;
            private _mrapVeh = _result select 0;
            private _mrapGroup = _result select 1;
            private _mrapMaxCargo = _result select 2;
            _groups pushBack _mrapGroup;
        };
    };
};

// Set group behavior
{
    _x setBehaviour "AWARE";
    _x setCombatMode "RED";
    
    // First move to approach position, then to target
    private _wp = [_x, _approachPos, 50] call BIS_fnc_taskAttack;
    
    // After reaching approach position, move to actual target
    [_x, _targetPos, _approachPos, _wp] spawn {
        params ["_group", "_targetPos", "_approachPos", "_wp"];
        waitUntil {
            sleep 5;
            leader _group distance _approachPos < 100
        };
        _group deleteWaypoint _wp;
        [_group, _targetPos, 50] call BIS_fnc_taskAttack;
    };
    
    // Add killed event handler to each unit
    {
        _x addEventHandler ["Killed", {
            params ["_unit"];
            private _nearVeh = nearestObjects [_unit, ["LandVehicle"], 50] select 0;
            {
                if !(_x in [driver _nearVeh, gunner _nearVeh, commander _nearVeh]) then {
                    [_x] orderGetIn false;
                    [_x] allowGetIn false;
                    unassignVehicle _x;
                    doGetOut _x;
                };
            } forEach crew _nearVeh;
        }];
    } forEach units _x;
    
    // Get the vehicle the group is using
    private _groupVeh = vehicle leader _x;
    if (_groupVeh != leader _x) then {
        // Create and setup dismount trigger
        private _dismountTrigger = createTrigger ["EmptyDetector", getPos _groupVeh, false];
        _dismountTrigger setTriggerArea [750, 750, 0, false, 100];
        _dismountTrigger setTriggerActivation ["WEST", "PRESENT", false];
        _dismountTrigger setTriggerStatements [
            "this",
            "
            private _veh = nearestObjects [thisTrigger, ['LandVehicle'], 50] select 0;
            {
                if !(_x in [driver _veh, gunner _veh, commander _veh]) then {
                    [_x] orderGetIn false;
                    [_x] allowGetIn false;
                    unassignVehicle _x;
                    doGetOut _x;
                };
            } forEach crew _veh;
            ",
            ""
        ];
        _dismountTrigger attachTo [_groupVeh, [0,0,0]];
    };
} forEach _groups;

// Return success and spawned groups
[true, _groups] 