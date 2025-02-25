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

// Initialize OPFOR resources object if it doesn't exist
if (isNil "FLO_OPFOR_Resources") then {
    private _resourceClass = [
        ["#type", "OPFORResources"],
        ["resources", 0],
        ["lastUpdate", time],
        ["#create", {
            params ["_initialResources"];
            _self set ["resources", _initialResources];
            _self set ["lastUpdate", time];
        }],
        ["getResources", {
            _self get "resources"
        }],
        ["addResources", {
            params ["_amount"];
            private _current = _self get "resources";
            private _new = _current + _amount;
            _self set ["resources", _new];
            _self set ["lastUpdate", time];
            _new
        }],
        ["spendResources", {
            params ["_amount"];
            private _current = _self get "resources";
            if (_current >= _amount) then {
                private _new = _current - _amount;
                _self set ["resources", _new];
                _self set ["lastUpdate", time];
                true
            } else {
                diag_log format ["[FLO][Resources] Failed to spend %1 resources (current: %2)", _amount, _current];
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
                    sleep 300;
                };
            };
        }]
    ];
    
    FLO_OPFOR_Resources = createHashMapObject [_resourceClass, 0];
};

private _result = switch (_mode) do {
    case "init": {
        _self = FLO_OPFOR_Resources;
        _self call ["initResourceLoop", []];
        0
    };
    
    case "get": {
        _self = FLO_OPFOR_Resources;
        _self call ["getResources", []]
    };
    
    case "add": {
        _params params [["_amount", 0, [0]]];
        _self = FLO_OPFOR_Resources;
        _self call ["addResources", [_amount]]
    };
    
    case "spend": {
        _params params [["_amount", 0, [0]]];
        _self = FLO_OPFOR_Resources;
        _self call ["spendResources", [_amount]]
    };
};

_result 