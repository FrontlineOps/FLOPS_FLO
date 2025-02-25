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
        ["#create", {
            _self set ["resources", 0];
            _self set ["lastUpdate", time];
        }],
        ["resources", 0],
        ["lastUpdate", time],
        ["getResources", {
            _self getOrDefault ["resources", 0]
        }],
        ["addResources", {
            params ["_amount"];
            private _current = _self getOrDefault ["resources", 0];
            private _new = _current + _amount;
            _self set ["resources", _new];
            _self set ["lastUpdate", time];
            _new
        }],
        ["spendResources", {
            params ["_amount"];
            private _current = _self getOrDefault ["resources", 0];
            if (_current >= _amount) then {
                private _new = _current - _amount;
                _self set ["resources", _new];
                _self set ["lastUpdate", time];
                true
            } else {
                false
            }
        }],
        ["initResourceLoop", {
            // Resource generation values per installation type
            private _resourceValues = createHashMapFromArray [
                ["o_installation", 7],     // Military Outpost
                ["n_support", 5],          // Military Service Post
                ["o_support", 3],          // Military Road Post
                ["n_installation", 15]     // Military Headquarters
            ];

            [] spawn {
                while {true} do {
                    private _totalResources = 0;
                    
                    // Get all OPFOR installations
                    private _opforInstallations = allMapMarkers select {
                        markerColor _x in ["colorOPFOR", "ColorEAST"] && 
                        markerType _x in ["n_support", "o_support", "o_installation", "n_installation"]
                    };
                    
                    // Calculate resources from each installation
                    {
                        private _markerType = markerType _x;
                        private _baseValue = _resourceValues getOrDefault [_markerType, 0];
                        
                        // Check if installation is under attack or contested
                        private _pos = getMarkerPos _x;
                        private _nearbyUnits = _pos nearEntities [["Man", "Car", "Tank", "Ship", "LandVehicle"], 500];
                        private _isContested = false;
                        
                        {
                            if (side _x == west) exitWith {
                                _isContested = true;
                            };
                        } forEach _nearbyUnits;
                        
                        // Only add resources if not contested
                        if (!_isContested) then {
                            _totalResources = _totalResources + _baseValue;
                        };
                    } forEach _opforInstallations;
                    
                    // Update OPFOR resources
                    ["add", [_totalResources]] call FLO_fnc_opforResources;
                    
                    // Wait for next resource tick (5 minutes)
                    sleep 300;
                };
            };
        }]
    ];
    
    FLO_OPFOR_Resources = createHashMapObject [_resourceClass];
};

switch (_mode) do {
    case "init": {
        [FLO_OPFOR_Resources, "initResourceLoop"] call {};
    };
    
    case "get": {
        [FLO_OPFOR_Resources, "getResources"] call {}
    };
    
    case "add": {
        _params params [["_amount", 0, [0]]];
        [FLO_OPFOR_Resources, "addResources", [_amount]] call {}
    };
    
    case "spend": {
        _params params [["_amount", 0, [0]]];
        [FLO_OPFOR_Resources, "spendResources", [_amount]] call {}
    };
}; 