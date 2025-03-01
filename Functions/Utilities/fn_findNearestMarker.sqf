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

params [
    ["_markers", [], [[]]],
    ["_position", [0,0,0], [[]]],
    ["_maxDistance", 10000, [0]]
];

if (_markers isEqualTo [] || _position isEqualTo [0,0,0]) exitWith {
    diag_log "[FLO][Outpost] Error: Invalid parameters for finding nearest marker";
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