if (!isServer) exitWith {};
if (VS_IsWorking || {VSCurrentTime + VSTimeDelay > diag_tickTime}) exitwith {};

// Update FPS tracking using circular buffer
if (isNil "VS_FPS") then { VS_FPS = [] };
VS_FPS = [round diag_fps] + VS_FPS;
if (count VS_FPS > 30) then { VS_FPS resize 30 };

// Dynamic distance scaling based on server performance
if ((diag_tickTime - VSCurrentTime) > VSTimeDelay) then {
    private _serverFPS = VS_FPS call BIS_fnc_arithmeticMean;
    VSDistance = switch (true) do {
        case (_serverFPS < 15): {1000};
        case (_serverFPS < 20): {1500};
        case (_serverFPS < 25): {1750};
        default {2000};
    };
    VSCurrentTime = diag_tickTime;
};

VS_IsWorking = true;

// Initialize or get virtualization hashmap
if (isNil "VS_VirtualizedObjects") then {
    VS_VirtualizedObjects = createHashMap;
};

// Efficient static object handling
private _excludedTypes = FLO_configCache get "SOVbuildings";

// Get all static objects
private _filteredStaticObjs = (entities [ ["NonStrategic", "Static", "Thing"], _excludedTypes, false, false]);
//COMMENT ABOVE LINE AND UNCOMMENT BELOW TO VIRTUALIZE MORE STATIC OBJECTS
// private _all = (8 allObjects 0) select {_x isKindof "NonStrategic" || {_x isKindOf "Static" || {_x isKindof "Thing"}}};
// private _filteredStaticObjs = (_all select {
//     private _obj = _x;
//     private _result = true;
//     {
//         if (_obj isKindOf _x) exitwith {_result = false};
//     } foreach _excludedTypes;
//     _result;
// });


private _players = allPlayers - entities "HeadlessClient_F";

// Get objects to virtualize and restore using efficient filtering
private _checkPos = [0,0,0];
private _mustVirtualize = false;
private _objsToVirtualize = [];
private _keysToRemove = [];

// Check for objects to virtualize (but hold off on virtualization)
{
    private _pos = getPosWorld _x;
    if (_checkPos distance2d _pos > VSDistance) then {
        _mustVirtualize = false;
        _checkPos = _pos;
        {
            if (_x distance2d _pos > VSDistance) exitwith {_mustVirtualize = true};
        } foreach _players;
    };
    if (_mustVirtualize) then { 
        _objsToVirtualize pushback _x; 
    };
} forEach _filteredStaticObjs;

//check for objects to restore and restore them
_checkPos = [0,0,0];
private _mustRestore = false;
{
    private _key = _x;
    private _objData = VS_VirtualizedObjects get _key;
    
    if (isNil "_objData") then {
        _keysToRemove pushBack _key;
        continue;
    };
    
    private _pos = _objData select 1;
    if (_checkPos distance2d _pos > VSDistance) then {
        _mustRestore = false;
        _checkPos = _pos;
        {
            if (_x distance2d _pos < VSDistance) exitwith {_mustRestore = true};
        } foreach _players;
    };

    if (_mustRestore) then { 
        
        private _objType = _objData select 0;
        
        try {
            private _obj = createVehicle [_objType, [0,0,0], [], 0, "CAN_COLLIDE"];
            if (!isNull _obj) then {
                _obj setPosWorld _pos;
                _obj setVectorDirAndUp (_objData select 2);
                _keysToRemove pushBack _key;
            } else {
                diag_log format ["[CDVS] ERROR: Failed to create object of type %1", _objType];
            };
        } catch {
            diag_log format ["[CDVS] ERROR: Exception while restoring object: %1", _exception];
        };
    };
} foreach keys VS_VirtualizedObjects;

// Clean up restored objects keys from hashmap
{
    if (_x in VS_VirtualizedObjects) then {
        VS_VirtualizedObjects deleteAt _x;
    } else {
        diag_log format ["[CDVS] WARNING: Attempted to remove non-existent key: %1", _x];
    };
} forEach _keysToRemove;

// Store and remove objects (increases keys in hashmap so done AFTER restoration)
{
    private _obj = _x;
    if (isNull _obj) then {
        continue;
    };
    
    private _objType = typeOf _obj;
    private _pos = getPosWorld _obj;
    private _objData = [
        _objType,
        _pos,
        [vectorDir _obj, vectorUp _obj]
    ];
    
    private _key = format ["%1_%2_%3", _pos select 0, _pos select 1, random 999999];
    
    // Store object data before deletion
    VS_VirtualizedObjects set [_key, _objData];
    
    // Delete the object
    if (!isNull _obj) then {
        hideObject _obj;
        _obj enableSimulation false;
        deleteVehicle _obj;
        
        if (!isNull _obj) then {
            _obj setPos [0,0,0];
            deleteVehicle _obj;
        } else {
            diag_log format ["[CDVS] Successfully virtualized: Type=%1, Pos=%2, Key=%3", _objType, _pos, _key];
        };
    };
} forEach _objsToVirtualize;

// Initialize or get AI groups hashmap
if (isNil "VS_VirtualizedGroups") then {
    VS_VirtualizedGroups = createHashMap;
};

// Handle enemy groups virtualization
private _enemyGroups = allGroups select {
    private _leader = leader _x;
    ( 
        !(_leader isKindOf "B_Pilot_F") && 
        {isNull objectParent _leader && 
        {side _x in [independent, east] }}
    )
};

// Check for objects to virtualize (but hold off on virtualization)
_checkPos = [0,0,0];
_mustVirtualize = false;
private _enemyGroupsToVirtualize = [];
private _bufferDist = VSDistance + 500;
_keysToRemove = [];
{
    private _pos = getPosWorld leader _x;
    if (_checkPos distance2d _pos > _bufferDist) then {
        _mustVirtualize = false;
        _checkPos = _pos;
        {
            if (_x distance2d _pos > _bufferDist) exitwith {_mustVirtualize = true};
        } foreach _players;
    };
    if (_mustVirtualize) then { 
        _enemyGroupsToVirtualize pushback _x ;
    };
} forEach _enemyGroups;

//check for groups to restore and restore them
_checkPos = [0,0,0];
_mustRestore = false;
{
    private _key = _x;
    private _grpData = VS_VirtualizedGroups get _key;
    
    if (isNil "_grpData") then {
        _keysToRemove pushBack _key;
        continue;
    };
    
    private _pos = _grpData select 1;
    if (_checkPos distance2d _pos > VSDistance) then {
        _mustRestore = false;
        _checkPos = _pos;
        {
            if (_x distance2d _pos < VSDistance) exitwith {_mustRestore = true};
        } foreach _players;
    };

    if (_mustRestore) then { 
        private _side = _grpData select 0;
        private _types = _grpData select 2;
        private _isPatrol = _grpData select 3;
        
        private _grp = [_pos, _side, _types] call BIS_fnc_spawnGroup;
        _grp deleteGroupWhenEmpty true;
        
        if (_side isEqualto independent) then {
            [_grp] execVM "Scripts\Civ_Relations_Ind.sqf";
        };
        
        if (_isPatrol) then {
            [_grp, _pos, 50 + random 200] call BIS_fnc_taskPatrol;
        } else {
            private _buildings = nearestObjects [_pos, ["House", "Strategic"], 20];
            private _positions = [];
            {_positions append (_x buildingPos -1)} forEach _buildings;
            if (count _positions > 0) then {
                (units _grp select 0) setPos (selectRandom _positions);
            };
        };
        
        [_pos, 20] execVM "Scripts\INTLitems.sqf";
        _keysToRemove pushBack _key;    
    };
} forEach keys VS_VirtualizedGroups;

// Clean up restored groups from hashmap
{VS_VirtualizedGroups deleteAt _x} forEach _keysToRemove;

// Store and remove enemy groups (increases keys in hashmap so done AFTER restoration)
{
    private _grp = _x;
    private _units = units _grp;
    if (count _units > 0) then {
        private _key = format ["ENM_%1", getPosATL leader _grp];
        VS_VirtualizedGroups set [_key, [
            side _grp,
            getPosATL leader _grp,
            _units apply {typeOf _x},
            count _units > 1
        ]];
        
        {deleteVehicle _x} forEach _units;
        deleteGroup _grp;
    };
} forEach _enemyGroupsToVirtualize;

// Optimize trigger handling
private _allTriggers = entities "EmptyDetector";
{
    private _isActive = {if (side _x isEqualto west && alive _x) exitwith {1};} count (getPosATL _x nearEntities [["Man", "Car", "Tank", "Ship", "LandVehicle", "Air"], 3000]) isNotEqualTo 0;
    if (triggerInterval _x isNotEqualTo 2) then {
        _x hideObjectGlobal !_isActive;
        _x enableSimulationGlobal _isActive;
    };
} forEach _allTriggers;

VSCurrentTime = diag_tickTime;
VS_IsWorking = false;