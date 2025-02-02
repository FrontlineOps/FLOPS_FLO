// Debug script for testing FLO_fnc_executeAttackPattern
if (!isServer) exitWith {};

// Clear any existing debug markers
{
    if (_x find "DBG_" == 0) then {
        deleteMarker _x;
    };
} forEach allMapMarkers;

// Function to create debug marker
private _fnc_createDebugMarker = {
    params ["_pos", "_type", "_color", "_text"];
    private _marker = createMarker ["DBG_" + str floor random 999999, _pos];
    _marker setMarkerType _type;
    _marker setMarkerColor _color;
    _marker setMarkerText _text;
    _marker setMarkerSize [1, 1];
    _marker
};

// Get player position as target if not specified
private _targetPos = if (!isNil "DEBUG_TARGET_POS") then {
    DEBUG_TARGET_POS
} else {
    getPos player
};

// Create target marker
[_targetPos, "mil_objective", "ColorRed", "Target"] call _fnc_createDebugMarker;

// Test each attack pattern
{
    private _pattern = _x;
    
    // Log test start
    diag_log format ["Testing attack pattern: %1", _pattern];
    systemChat format ["Testing attack pattern: %1", _pattern];
    
    // Execute attack pattern
    [_targetPos, [0,0,0], _pattern, 1] call FLO_fnc_executeAttackPattern;
    
    // Add delay between patterns
    sleep 5;
    
} forEach ["PINCER", "FRONTAL", "INFILTRATION"];

// Instructions for manual testing
hint parseText "Debug markers created.<br/><br/>To test a specific pattern:<br/><br/>
1. Set target position:<br/>
DEBUG_TARGET_POS = getPos player;<br/><br/>
2. Run pattern:<br/>
[DEBUG_TARGET_POS, [0,0,0], ""PINCER"", 1] call FLO_fnc_executeAttackPattern;";

// Return success
true 