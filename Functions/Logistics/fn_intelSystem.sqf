/*
    Function: FLO_fnc_intelSystem
    
    Description:
    Manages BLUFOR's intelligence level based on collected intel and radio tower control.
    Intel decays over time but can be increased through intel collection and radio tower control.
    
    Parameter(s):
    _mode - The function mode to execute ["init", "get", "add", "notify", "showNotification"] (String)
    _params - Parameters based on mode (Array)
        init: [] - No parameters needed
        get: [] - No parameters needed
        add: [_amount, _source] - Amount to add and source of intel
        notify: [_message, _importance] - Message to broadcast and its importance (1-3)
        showNotification: [_title, _message, _type] - Title, message and type ("warning", "intel", "success", "info")
    
    Returns:
    Based on mode:
        init: Nothing
        get: Number - Current intel level
        add: Number - New intel level
        notify: Boolean - True if message was broadcast
        showNotification: Boolean - True if notification was shown
*/

params [
    ["_mode", "init", [""]],
    ["_params", [], [[]]]
];

if (!isServer) exitWith {};

// Initialize intel system if it doesn't exist
if (isNil "FLO_Intel_System") then {
    FLO_Intel_System = createHashMap;
    FLO_Intel_System set ["intelLevel", 0];
    FLO_Intel_System set ["lastUpdate", time];
    FLO_Intel_System set ["radioTowers", []];
};

// Constants
private _INTEL_DECAY_RATE = 0.1;        // Intel points lost per minute
private _RADIO_TOWER_BONUS = 0.2;       // Multiplier for intel gain per radio tower
private _MAX_INTEL_LEVEL = 100;         // Maximum intel level
private _MIN_INTEL_LEVEL = 0;           // Minimum intel level
private _DECAY_INTERVAL = 60;           // Seconds between decay checks

switch (_mode) do {
    case "init": {
        // Start the intel decay loop
        [] spawn {
            private _INTEL_DECAY_RATE = 0.1;
            private _MIN_INTEL_LEVEL = 0;
            private _DECAY_INTERVAL = 60;
            
            while {true} do {
                private _currentLevel = FLO_Intel_System getOrDefault ["intelLevel", 0];
                private _lastUpdate = FLO_Intel_System getOrDefault ["lastUpdate", time];
                private _timePassed = (time - _lastUpdate) / 60; // Convert to minutes
                
                // Calculate radio tower bonus
                private _radioTowers = count (allMapMarkers select { 
                    markerType _x == "loc_Transmitter" && 
                    markerColor _x == "colorBLUFOR" 
                });
                FLO_Intel_System set ["radioTowers", _radioTowers];
                
                // Calculate decay
                private _decay = _INTEL_DECAY_RATE * _timePassed;
                private _newLevel = (_currentLevel - _decay) max _MIN_INTEL_LEVEL;
                
                FLO_Intel_System set ["intelLevel", _newLevel];
                FLO_Intel_System set ["lastUpdate", time];
                
                // Visual feedback based on intel level
                private _intelText = switch (true) do {
                    case (_newLevel >= 75): {"High Intelligence Coverage"};
                    case (_newLevel >= 50): {"Moderate Intelligence Coverage"};
                    case (_newLevel >= 25): {"Limited Intelligence Coverage"};
                    default {"Minimal Intelligence Coverage"};
                };
                
                // Update intel status for all players
                [_intelText, _newLevel] remoteExec ["hint", 0];
                
                sleep _DECAY_INTERVAL;
            };
        };
    };
    
    case "get": {
        FLO_Intel_System getOrDefault ["intelLevel", 0]
    };
    
    case "add": {
        _params params [
            ["_amount", 0, [0]],
            ["_source", "", [""]]
        ];
        
        // Apply radio tower bonus if any exist
        private _radioTowers = FLO_Intel_System getOrDefault ["radioTowers", 0];
        private _bonus = 1 + (_radioTowers * _RADIO_TOWER_BONUS);
        
        // Add small intel gain for intel items
        if (_source == "intel_item") then {
            _amount = 0.005;
            _bonus = 1; // No radio tower bonus for intel items
        };
        
        private _adjustedAmount = _amount * _bonus;
        private _current = FLO_Intel_System getOrDefault ["intelLevel", 0];
        private _new = ((_current + _adjustedAmount) min _MAX_INTEL_LEVEL) max _MIN_INTEL_LEVEL;
        
        FLO_Intel_System set ["intelLevel", _new];
        FLO_Intel_System set ["lastUpdate", time];
        
        // Notify players of significant intel gains
        if (_adjustedAmount >= 10) then {
            private _msg = format ["Significant intelligence gained from %1", _source];
            ["notify", [_msg, 2]] call FLO_fnc_intelSystem;
        };
        
        _new
    };
    
    case "notify": {
        _params params [
            ["_message", "", [""]],
            ["_importance", 1, [0]]
        ];
        
        // Get current intel level
        private _intelLevel = FLO_Intel_System getOrDefault ["intelLevel", 0];
        private _radioTowers = FLO_Intel_System getOrDefault ["radioTowers", 0];
        
        // Only broadcast if we have enough intel/radio coverage
        private _canBroadcast = switch (_importance) do {
            case 3: { _intelLevel >= 75 || _radioTowers >= 3 }; // Critical intel
            case 2: { _intelLevel >= 50 || _radioTowers >= 2 }; // Important intel
            default { _intelLevel >= 25 || _radioTowers >= 1 }; // Regular intel
        };
        
        if (_canBroadcast) then {
            private _color = switch (_importance) do {
                case 3: { "#FF0000" }; // Red for critical
                case 2: { "#FFA500" }; // Orange for important
                default { "#00FF00" }; // Green for regular
            };
            
            private _formattedMsg = format [
                "<t color='%1' font='PuristaBold' align='right' shadow='1' size='1.2'>INTELLIGENCE UPDATE</t><br/><t align='right' shadow='1' size='1'>%2</t>",
                _color,
                _message
            ];
            
            [parseText _formattedMsg, [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];
            true
        } else {
            false
        };
    };
    
    case "showNotification": {
        _params params [
            ["_title", "", [""]],
            ["_message", "", [""]],
            ["_type", "info", [""]]
        ];
        
        // Get current intel level
        private _intelLevel = FLO_Intel_System getOrDefault ["intelLevel", 0];
        private _radioTowers = FLO_Intel_System getOrDefault ["radioTowers", 0];
        
        // Define notification requirements based on type
        private _requirements = switch (_type) do {
            case "warning": { [50, 2] }; // Requires 50 intel or 2 radio towers
            case "intel": { [25, 1] };   // Requires 25 intel or 1 radio tower
            case "success": { [0, 0] };  // Always shown
            case "info": { [0, 0] };     // Always shown
            default { [25, 1] };         // Default to intel requirements
        };
        
        _requirements params ["_requiredIntel", "_requiredTowers"];
        
        // Check if we meet requirements
        if (_intelLevel >= _requiredIntel || _radioTowers >= _requiredTowers) then {
            private _color = switch (_type) do {
                case "warning": { "#FF3619" };  // Red
                case "intel": { "#FACE00" };    // Yellow
                case "success": { "#00DB07" };  // Green
                case "info": { "#1AA3FF" };     // Blue
                default { "#FFFFFF" };          // White
            };
            
            private _formattedMsg = format [
                "<t color='%1' font='PuristaBold' align='right' shadow='1' size='2'>%2</t><br/><t align='right' shadow='1' size='1'>%3</t>",
                _color,
                _title,
                _message
            ];
            
            [parseText _formattedMsg, [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];
            true
        } else {
            false
        };
    };
}; 