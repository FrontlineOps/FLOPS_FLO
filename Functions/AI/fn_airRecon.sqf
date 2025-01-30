/*
    Function: FLO_fnc_airRecon
    
    Description:
    Manages the execution of air reconnaissance missions.
    
    Parameters:
    _targetPos - Target position for air reconnaissance [Array]
    
    Returns:
    HashMap - Tracking object for air reconnaissance
*/

params ["_targetPos"];

private _droneType = selectRandom ((FLO_configCache get "vehicles") select 8); 

// Find nearest valid OPFOR outpost for spawning
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

// Only proceed if we found a valid outpost
if (_nearestOutpost != "") then {
    private _spawnPos = getMarkerPos _nearestOutpost;
    private _drone = createVehicle [_droneType, _spawnPos, [], 100, "FLY"];

    // Create and setup crew
    private _crew = units (east createVehicleCrew _drone);
    _crew joinSilent _droneGroup;
    
    private _wp1 = group _drone addWaypoint [_targetPos getPos [500, 0], 0];
    private _wp2 = group _drone addWaypoint [_targetPos getPos [500, 120], 0];
    private _wp3 = group _drone addWaypoint [_targetPos getPos [500, 240], 0];
    private _wp4 = group _drone addWaypoint [_targetPos getPos [500, 0], 0];
    _wp4 setWaypointType "CYCLE";
    
    [_drone] spawn {
        params ["_drone"];
        sleep 600;
        {deleteVehicle _x} forEach crew _drone;
        deleteVehicle _drone;
    };
} else {
    diag_log "No valid OPFOR outpost found for drone deployment.";
};
