/*
    Function: FLO_fnc_findNearestMarker
    
    Description:
    Finds the nearest marker to a given position based on specific criteria.
    
    Parameters:
    _markers - Array of markers to search through [Array]
    _position - Position to find nearest marker to [Position3D]
    _maxDistance - Maximum distance to search (optional) [Number] (default: 10000)
    
    Returns:
    String - The nearest marker name, or empty string if none found
    
    Example:
    [allMapMarkers select {markerType _x == "o_support"}, getPos player, 500] call FLO_fnc_findNearestMarker;
*/

// Make sure we're called with proper parameters
if (_this isEqualType objNull) exitWith {
    diag_log "[FLO][Utilities] Error: fn_findNearestMarker called with object instead of array";
    ""
};

if (!(_this isEqualType [])) exitWith {
    diag_log format ["[FLO][Utilities] Error: fn_findNearestMarker called with incorrect parameter type: %1", typeName _this];
    ""
};

params [
    ["_markers", [], [[]]],
    ["_position", [0,0,0], [[], objNull]],
    ["_maxDistance", 10000, [0]]
];

// Handle if position is an object
if (_position isEqualType objNull) then {
    _position = getPos _position;
};

if (_markers isEqualTo [] || _position isEqualTo [0,0,0]) exitWith {
    diag_log "[FLO][Utilities] Error: Invalid parameters for finding nearest marker";
    ""
};

private _nearestMarker = "";
private _minDistance = _maxDistance;

{
    private _markerPos = getMarkerPos _x;
    private _distance = _position distance _markerPos;
    
    if (_distance < _minDistance) then {
        _minDistance = _distance;
        _nearestMarker = _x;
    };
} forEach _markers;

// Return the nearest marker name or empty string if none found
_nearestMarker 