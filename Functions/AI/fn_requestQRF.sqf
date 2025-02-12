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
private _spawnCount = switch (true) do {
    case (_AGGRSCORE >= 15): { 18 };  // Maximum aggression - full BTG-sized response
    case (_AGGRSCORE >= 13): { 15 };  // Very high aggression - reinforced battalion
    case (_AGGRSCORE >= 11): { 12 };  // High aggression - battalion-sized
    case (_AGGRSCORE >= 9): { 9 };    // Medium-high aggression - reinforced company
    case (_AGGRSCORE >= 7): { 6 };    // Medium aggression - company-sized
    case (_AGGRSCORE >= 5): { 4 };    // Low-medium aggression - reinforced platoon
    case (_AGGRSCORE >= 3): { 2 };    // Low aggression - platoon-sized
    default { 1 };                    // Minimal aggression - squad-sized
};

// Calculate spawn positions in a circular pattern
private _spawnPositions = [];
private _baseAngle = 360 / _spawnCount;
{
    private _angle = _baseAngle * _forEachIndex;
    private _distance = _approachDistance + (random 500 - random 500); // Varied distances
    private _pos = _targetPos getPos [_distance, (_dir - 180) + _angle];
    _pos = [_pos, 0, 200, 10, 0, 0.2, 0, [], [_pos, _pos]] call BIS_fnc_findSafePos;
    _spawnPositions pushBack _pos;
} forEach ([] call {private _arr = []; for "_i" from 1 to _spawnCount do {_arr pushBack _i}; _arr});

for "_spawnIndex" from 1 to _spawnCount do {
    // Adjust tier based on spawn index and total count
    private _adjustedTier = switch (true) do {
        case (_spawnIndex <= (_spawnCount * 0.2)): { 
            // First 20% are highest tier
            if (_AGGRSCORE >= 13) then { "Tier4" } else { "Tier3" };
        };
        case (_spawnIndex <= (_spawnCount * 0.5)): { 
            // Next 30% are medium-high tier
            if (_AGGRSCORE >= 11) then { "Tier3" } else { "Tier2" };
        };
        case (_spawnIndex <= (_spawnCount * 0.8)): { 
            // Next 30% are medium tier
            "Tier2"
        };
        default { 
            // Last 20% are support/reserve elements
            "Tier1"
        };
    };

    // Get spawn position for this element
    private _elementApproachPos = _spawnPositions select (_spawnIndex - 1);

    switch (_adjustedTier) do {
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
            
            // Add air support if first spawn
            if (_spawnIndex == 1) then {
                [_targetPos, "CAS"] spawn FLO_fnc_airSupport;
            };
            
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
            
            // Add air support if first spawn and aggression is high
            if (_spawnIndex == 1 && _AGGRSCORE > 5) then {
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
            
            // Add light armor support if first spawn and aggression is high
            if (_spawnIndex == 1 && _AGGRSCORE > 7) then {
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
            
            // Add mrap support if first spawn and aggression is high
            if (_spawnIndex == 1 && _AGGRSCORE > 3) then {
                private _mrapType = selectRandom (FLO_configCache get "vehicles" select 2);
                _result = [_mrapType, _spawnPos] call _fnc_createVehicleWithCrew;
                private _mrapVeh = _result select 0;
                private _mrapGroup = _result select 1;
                private _mrapMaxCargo = _result select 2;
                _groups pushBack _mrapGroup;
            };
        };
    };
};

// Modify group behavior setup to handle larger numbers
{
    _x setBehaviour "AWARE";
    _x setCombatMode "RED";
    
    // Calculate unique approach position in a more distributed pattern
    private _groupIndex = _forEachIndex;
    private _totalGroups = count _groups;
    private _sectorSize = 360 / _totalGroups;
    private _groupAngle = _sectorSize * _groupIndex;
    private _groupDistance = _approachDistance + (random 300 - random 300); // Varied distances
    private _groupApproachPos = _targetPos getPos [_groupDistance, (_dir - 180) + _groupAngle];
    _groupApproachPos = [_groupApproachPos, 0, 200, 10, 0, 0.2, 0, [], [_groupApproachPos, _groupApproachPos]] call BIS_fnc_findSafePos;
    
    // First move to approach position, then to target
    private _wp = _x addWaypoint [_groupApproachPos, 50];
    _wp setWaypointType "MOVE";
    _wp setWaypointSpeed (if (_groupIndex < (_totalGroups * 0.3)) then {"NORMAL"} else {"LIMITED"}); // Slower for rear elements
    _wp setWaypointBehaviour "AWARE";
    
    // After reaching approach position, move to actual target with coordinated timing
    [_x, _targetPos, _groupApproachPos, _groupIndex, _totalGroups] spawn {
        params ["_group", "_targetPos", "_approachPos", "_index", "_total"];
        
        waitUntil {
            sleep 5;
            leader _group distance _approachPos < 100
        };
        
        // Coordinate attack timing based on group position
        private _delay = if (_index < (_total * 0.3)) then {
            5 // First wave
        } else {
            if (_index < (_total * 0.6)) then {
                15 // Second wave
            } else {
                30 // Reserve/support elements
            };
        };
        sleep _delay;
        
        // Delete the approach waypoint
        deleteWaypoint [_group, currentWaypoint _group];
        
        // Add new attack waypoint to target
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