/*
    Function: FLO_fnc_opforResources
    
    Description:
    Manages resource generation for OPFOR installations.
    Similar to Antistasi's resource system but adapted for FLO.
    
    Resources are generated from:
    - Military Service Posts (n_support): 5 resources
    - Military Road Posts (o_support): 3 resources
    - Military Outpost (o_installation): 7 resources
    - Military Headquarters (n_installation): 15 resources
    
    Parameter(s):
    _mode - The function mode to execute ["init", "get", "add", "spend"] (String)
    _params - Parameters based on mode (Array)
        init: [] - No parameters needed
        get: [] - No parameters needed
        add: [_amount] - Amount to add
        spend: [_amount] - Amount to spend
    
    Returns:
    Based on mode:
        init: Nothing
        get: Number - Current resources
        add: Number - New resource total
        spend: Boolean - True if successfully spent, false if insufficient resources
*/

params [
    ["_mode", "init", [""]],
    ["_params", [], [[]]]
];

if (!isServer) exitWith {};

// Debug logging
diag_log format ["[FLO][Resources] Function called with mode: %1, params: %2", _mode, _params];
diag_log format ["[FLO][Resources] FLO_OPFOR_Resources exists: %1", !isNil "FLO_OPFOR_Resources"];

if (!isNil "FLO_OPFOR_Resources") then {
    diag_log format ["[FLO][Resources] Current resources value: %1", FLO_OPFOR_Resources getOrDefault ["resources", "NOT_FOUND"]];
};

// Initialize OPFOR resources object if it doesn't exist
if (isNil "FLO_OPFOR_Resources") then {
    diag_log "[FLO][Resources] Creating new OPFOR Resources object";
    
    private _resourceClass = [
        ["#type", "OPFORResources"],
        ["resources", 0],
        ["lastUpdate", time],
        ["#create", {
            params ["_initialResources"];
            _self set ["resources", _initialResources];
            _self set ["lastUpdate", time];
            diag_log format ["[FLO][Resources] Created new OPFOR Resources object with initial resources: %1", _initialResources];
        }],
        ["getResources", {
            private _val = _self get "resources";
            diag_log format ["[FLO][Resources] getResources called, returning: %1", _val];
            _val
        }],
        ["addResources", {
            params ["_amount"];
            private _current = _self get "resources";
            private _new = _current + _amount;
            _self set ["resources", _new];
            _self set ["lastUpdate", time];
            diag_log format ["[FLO][Resources] addResources: current(%1) + amount(%2) = new(%3)", _current, _amount, _new];
            _new
        }],
        ["spendResources", {
            params ["_amount"];
            private _current = _self get "resources";
            diag_log format ["[FLO][Resources] spendResources: attempting to spend %1 from current %2", _amount, _current];
            if (_current >= _amount) then {
                private _new = _current - _amount;
                _self set ["resources", _new];
                _self set ["lastUpdate", time];
                diag_log format ["[FLO][Resources] spendResources: spent %1, new total: %2", _amount, _new];
                true
            } else {
                diag_log format ["[FLO][Resources] spendResources: failed to spend %1, insufficient funds (%2)", _amount, _current];
                false
            }
        }],
        ["initResourceLoop", {
            private _resourceValues = createHashMapFromArray [
                ["o_installation", 7],
                ["n_support", 5],
                ["o_support", 3],
                ["n_installation", 15]
            ];

            [] spawn {
                while {true} do {
                    private _totalResources = 0;
                    private _opforInstallations = allMapMarkers select {
                        markerColor _x in ["colorOPFOR", "ColorEAST"] && 
                        markerType _x in ["n_support", "o_support", "o_installation", "n_installation"]
                    };
                    
                    {
                        private _markerType = markerType _x;
                        private _baseValue = _resourceValues getOrDefault [_markerType, 0];
                        private _pos = getMarkerPos _x;
                        private _nearbyUnits = _pos nearEntities [["Man", "Car", "Tank", "Ship", "LandVehicle"], 500];
                        private _isContested = false;
                        
                        {
                            if (side _x == west) exitWith {
                                _isContested = true;
                            };
                        } forEach _nearbyUnits;
                        
                        if (!_isContested) then {
                            _totalResources = _totalResources + _baseValue;
                        };
                    } forEach _opforInstallations;
                    
                    FLO_OPFOR_Resources call ["addResources", [_totalResources]];
                    diag_log format ["[FLO][Resources] Resource loop added %1 resources", _totalResources];
                    sleep 300;
                };
            };
        }]
    ];
    
    FLO_OPFOR_Resources = createHashMapObject [_resourceClass, 0];
    diag_log format ["[FLO][Resources] Created OPFOR Resources HashMapObject: %1", FLO_OPFOR_Resources];
};

// Debug log the current state
diag_log format ["[FLO][Resources] Pre-switch state - Mode: %1, Resources: %2", 
    _mode, 
    if (!isNil "FLO_OPFOR_Resources") then { FLO_OPFOR_Resources getOrDefault ["resources", "NOT_FOUND"] } else { "OBJECT_NOT_FOUND" }
];

private _result = switch (_mode) do {
    case "init": {
        diag_log "[FLO][Resources] Initializing resource loop";
        _self = FLO_OPFOR_Resources;
        _self call ["initResourceLoop", []];
        0
    };
    
    case "get": {
        _self = FLO_OPFOR_Resources;
        private _resources = _self call ["getResources", []];
        diag_log format ["[FLO][Resources] Get command returning: %1", _resources];
        _resources
    };
    
    case "add": {
        _params params [["_amount", 0, [0]]];
        _self = FLO_OPFOR_Resources;
        private _newTotal = _self call ["addResources", [_amount]];
        diag_log format ["[FLO][Resources] Add command returning: %1", _newTotal];
        _newTotal
    };
    
    case "spend": {
        _params params [["_amount", 0, [0]]];
        _self = FLO_OPFOR_Resources;
        private _success = _self call ["spendResources", [_amount]];
        diag_log format ["[FLO][Resources] Spend command returning: %1", _success];
        _success
    };
};

diag_log format ["[FLO][Resources] Function returning: %1", _result];
_result 