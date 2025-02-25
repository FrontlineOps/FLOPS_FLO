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

// Constants
private _INTEL_DECAY_RATE = 0.1;        // Intel points lost per minute
private _RADIO_TOWER_BONUS = 0.2;       // Multiplier for intel gain per radio tower
private _MAX_INTEL_LEVEL = 100;         // Maximum intel level
private _MIN_INTEL_LEVEL = 0;           // Minimum intel level
private _DECAY_INTERVAL = 60;           // Seconds between decay checks

// Initialize intel system if it doesn't exist
if (isNil "FLO_Intel_System") then {
    private _intelClass = [
        ["#type", "IntelSystem"],
        ["#create", {
            _self set ["intelLevel", 0];
            _self set ["lastUpdate", time];
            _self set ["radioTowers", []];
        }],
        ["intelLevel", 0],
        ["lastUpdate", time],
        ["radioTowers", []],
        ["getIntelLevel", {
            _self getOrDefault ["intelLevel", 0]
        }],
        ["getRadioTowers", {
            _self getOrDefault ["radioTowers", 0]
        }],
        ["updateRadioTowers", {
            private _towers = count (allMapMarkers select { 
                markerType _x == "loc_Transmitter" && 
                markerColor _x == "colorBLUFOR" 
            });
            _self set ["radioTowers", _towers];
            _towers
        }],
        ["addIntel", {
            params ["_amount", "_source"];
            
            private _radioTowers = _self call ["updateRadioTowers", []];
            private _bonus = 1 + (_radioTowers * _RADIO_TOWER_BONUS);
            
            if (_source == "intel_item") then {
                _amount = 0.005;
                _bonus = 1;
            };
            
            private _adjustedAmount = _amount * _bonus;
            private _current = _self call ["getIntelLevel", []];
            private _new = ((_current + _adjustedAmount) min _MAX_INTEL_LEVEL) max _MIN_INTEL_LEVEL;
            
            _self set ["intelLevel", _new];
            _self set ["lastUpdate", time];
            
            if (_adjustedAmount >= 10) then {
                private _msg = format ["Significant intelligence gained from %1", _source];
                _self call ["notify", [_msg, 2]];
            };
            
            _new
        }],
        ["initDecayLoop", {
            [] spawn {
                while {true} do {
                    private _currentLevel = FLO_Intel_System call ["getIntelLevel", []];
                    private _lastUpdate = FLO_Intel_System get "lastUpdate";
                    private _timePassed = (time - _lastUpdate) / 60;
                    
                    FLO_Intel_System call ["updateRadioTowers", []];
                    
                    private _decay = _INTEL_DECAY_RATE * _timePassed;
                    private _newLevel = (_currentLevel - _decay) max _MIN_INTEL_LEVEL;
                    
                    FLO_Intel_System set ["intelLevel", _newLevel];
                    FLO_Intel_System set ["lastUpdate", time];
                    
                    private _intelText = switch (true) do {
                        case (_newLevel >= 75): {"High Intelligence Coverage"};
                        case (_newLevel >= 50): {"Moderate Intelligence Coverage"};
                        case (_newLevel >= 25): {"Limited Intelligence Coverage"};
                        default {"Minimal Intelligence Coverage"};
                    };
                    
                    [_intelText, _newLevel] remoteExec ["hint", 0];
                    
                    sleep _DECAY_INTERVAL;
                };
            };
        }],
        ["notify", {
            params ["_message", "_importance"];
            
            private _intelLevel = _self call ["getIntelLevel", []];
            private _radioTowers = _self call ["getRadioTowers", []];
            
            private _canBroadcast = switch (_importance) do {
                case 3: { _intelLevel >= 75 || _radioTowers >= 3 };
                case 2: { _intelLevel >= 50 || _radioTowers >= 2 };
                default { _intelLevel >= 25 || _radioTowers >= 1 };
            };
            
            if (_canBroadcast) then {
                private _color = switch (_importance) do {
                    case 3: { "#FF0000" };
                    case 2: { "#FFA500" };
                    default { "#00FF00" };
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
            }
        }],
        ["showNotification", {
            params ["_title", "_message", "_type"];
            
            private _intelLevel = _self call ["getIntelLevel", []];
            private _radioTowers = _self call ["getRadioTowers", []];
            
            private _requirements = switch (_type) do {
                case "warning": { [50, 2] };
                case "intel": { [25, 1] };
                case "success": { [0, 0] };
                case "info": { [0, 0] };
                default { [25, 1] };
            };
            
            _requirements params ["_requiredIntel", "_requiredTowers"];
            
            if (_intelLevel >= _requiredIntel || _radioTowers >= _requiredTowers) then {
                private _color = switch (_type) do {
                    case "warning": { "#FF3619" };
                    case "intel": { "#FACE00" };
                    case "success": { "#00DB07" };
                    case "info": { "#1AA3FF" };
                    default { "#FFFFFF" };
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
            }
        }]
    ];
    
    FLO_Intel_System = createHashMapObject [_intelClass, 0];
};

switch (_mode) do {
    case "init": {
        _self = FLO_Intel_System;
        _self call ["initDecayLoop", []];
    };
    
    case "get": {
        _self = FLO_Intel_System;
        _self call ["getIntelLevel", []]
    };
    
    case "add": {
        _params params [
            ["_amount", 0, [0]],
            ["_source", "", [""]]
        ];
        _self = FLO_Intel_System;
        _self call ["addIntel", [_amount, _source]]
    };
    
    case "notify": {
        _params params [
            ["_message", "", [""]],
            ["_importance", 1, [0]]
        ];
        _self = FLO_Intel_System;
        _self call ["notify", [_message, _importance]]
    };
    
    case "showNotification": {
        _params params [
            ["_title", "", [""]],
            ["_message", "", [""]],
            ["_type", "info", [""]]
        ];
        _self = FLO_Intel_System;
        _self call ["showNotification", [_title, _message, _type]]
    };
}; 