/*
    Function: FLO_fnc_requestOffensiveOps
    
    Description:
    Requests and executes a full-scale offensive operation against a BLUFOR installation.
    Uses OPFOR resources to fund the operation and coordinates multiple attack elements.
    
    Parameters:
    _aggressionScore - Current aggression score [Number]
    
    Returns:
    Boolean - True if operation was launched successfully
*/

params [
    ["_aggressionScore", 0, [0]]
];

// Check if an offensive operation is already underway
if (OffensiveOperationUnderway && !isNil "OffensiveOperationUnderway") exitWith {
    diag_log "[FLO][OffensiveOps] Another offensive operation is already underway";
    false
};

// Resource cost for offensive operations
private _operationCost = 100 + (_aggressionScore * 10);

// Try to spend resources for offensive operation
if !(["spend", [_operationCost]] call FLO_fnc_opforResources) exitWith {
    diag_log "[FLO][OffensiveOps] Insufficient resources for offensive operation";
    // Reset the flag if we can't afford the operation
    OffensiveOperationUnderway = false;
    false
};

// Find suitable OPFOR and BLUFOR installations
private _opforInstallations = allMapMarkers select {
    markerType _x in ["loc_Power", "o_support", "n_support", "loc_Ruin", "n_installation", "o_installation"]
};

private _bluforInstallations = allMapMarkers select {
    markerType _x == "b_installation" &&
    (markerColor _x == "ColorYellow" || markerColor _x == "colorBLUFOR" || markerColor _x == "colorWEST")
};

// Exit if no valid installations found
if (_opforInstallations isEqualTo [] || _bluforInstallations isEqualTo []) exitWith {
    diag_log "[FLO][OffensiveOps] No valid installations found for offensive operation";
    false
};

// Find closest OPFOR installation to a BLUFOR installation
private _distanceMap = [];

{
    private _opforPos = getMarkerPos _x;
    
    {
        private _bluforPos = getMarkerPos _x;
        private _distance = _opforPos distanceSqr _bluforPos;
        _distanceMap pushBack [_distance, _x, _foreachindex];
    } forEach _bluforInstallations;
} forEach _opforInstallations;

_distanceMap sort true;
private _closestPair = _distanceMap select 0;
private _targetBluforMarker = _closestPair select 1;

// Find the OPFOR installation that's closest to this BLUFOR target
private _opforDistances = [];
{
    private _opforPos = getMarkerPos _x;
    private _bluforPos = getMarkerPos _targetBluforMarker;
    private _distance = _opforPos distanceSqr _bluforPos;
    _opforDistances pushBack [_distance, _x];
} forEach _opforInstallations;

_opforDistances sort true;
private _sourceOpforMarker = (_opforDistances select 0) select 1;

// Find the target building (HQ or similar structure)
private _targetBuilding = (nearestObjects [
    getMarkerPos _targetBluforMarker,
    FLO_configCache get "HQbuildings",
    300
]) select 0;

// Create assault marker
private _assaultMarkerName = "AssltDest" + (str ([0, 0, 0] getPos [(10 + (random 150)), (0 + (random 360))]));
publicVariable "_assaultMarkerName";

createMarker [_assaultMarkerName, getPos _targetBuilding];
_assaultMarkerName setMarkerType "mil_marker_noShadow";
_assaultMarkerName setMarkerColor "colorOPFOR";
_assaultMarkerName setMarkerSize [2.5, 2.5];
_assaultMarkerName setMarkerAlpha 0.5;

// Notify players
["showNotification", ["! CRITICAL WARNING !", "Friendly Objective is Under Attack!", "warning"]] call FLO_fnc_intelSystem;
private _attackingAtGrid = mapGridPosition getMarkerPos _assaultMarkerName;
[[west,"HQ"], "ALERT: Friendly Location Under Enemy attack at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];

// Calculate attack direction
private _assaultAzimuth = (getMarkerPos _targetBluforMarker) getDir (getMarkerPos _sourceOpforMarker);

// Start with recon if aggression is high enough
if (_aggressionScore > 3) then {
    ["showNotification", ["! INTELLIGENCE !", "Enemy reconnaissance aircraft spotted!", "info"]] call FLO_fnc_intelSystem;
    [getPos _targetBuilding] call FLO_fnc_airRecon;
    sleep 300;
};

// Artillery prep based on aggression
if (_aggressionScore > 5) then {
    ["showNotification", ["! WARNING !", "Enemy artillery fire incoming!", "warning"]] call FLO_fnc_intelSystem;
    [getPos _targetBuilding, _aggressionScore] call FLO_fnc_artilleryPrep;
    sleep 180;
};

// Select attack pattern based on terrain and situation
private _pattern = selectRandom ["PINCER", "FRONTAL", "INFILTRATION"];
if (_aggressionScore > 10) then {
    _pattern = "FRONTAL"; // More aggressive at high aggression
};

// Execute the attack with combined arms
[getPos _targetBuilding, getMarkerPos _sourceOpforMarker, _pattern, _aggressionScore] call FLO_fnc_executeAttackPattern;

// Original QRF and vehicle insertions follow
private _qrfScript = selectRandom ["Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"];
[_targetBuilding] execVM _qrfScript;

// Create patrol group
private _patrolGroup = [
    (getMarkerPos _targetBluforMarker) getPos [(500 + (random 100)), (_assaultAzimuth + (random 20))], 
    East, 
    [
        selectRandom (FLO_configCache get "units"), 
        selectRandom (FLO_configCache get "units"), 
        selectRandom (FLO_configCache get "units"),
        selectRandom (FLO_configCache get "units"), 
        selectRandom (FLO_configCache get "units"), 
        selectRandom (FLO_configCache get "units")
    ]
] call BIS_fnc_spawnGroup;

private _waypoint = _patrolGroup addWaypoint [getMarkerPos _targetBluforMarker, 0];
_waypoint setWaypointType "MOVE";

sleep 10;

// Additional forces based on aggression level
if (_aggressionScore > 5) then {
    private _qrfScript2 = selectRandom ["Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"];
    [_targetBuilding] execVM _qrfScript2;
    
    private _patrolGroup2 = [
        (getMarkerPos _targetBluforMarker) getPos [(500 + (random 100)), (_assaultAzimuth + (random 20))], 
        East, 
        [
            selectRandom (FLO_configCache get "units"), 
            selectRandom (FLO_configCache get "units"), 
            selectRandom (FLO_configCache get "units"),
            selectRandom (FLO_configCache get "units"), 
            selectRandom (FLO_configCache get "units"), 
            selectRandom (FLO_configCache get "units")
        ]
    ] call BIS_fnc_spawnGroup;
    
    private _waypoint2 = _patrolGroup2 addWaypoint [getMarkerPos _targetBluforMarker, 0];
    _waypoint2 setWaypointType "MOVE";
};

sleep 10;

// Heavy reinforcements for high aggression
if (_aggressionScore > 10) then {
    ["showNotification", ["! WARNING !", "Enemy heavy reinforcements detected!", "warning"]] call FLO_fnc_intelSystem;
    [_targetBuilding] execVM "Scripts\VehiInsert_CSAT_3.sqf";
    
    private _patrolGroup3 = [
        (getMarkerPos _targetBluforMarker) getPos [(500 + (random 100)), (_assaultAzimuth - (random 20))], 
        East, 
        [
            selectRandom (FLO_configCache get "units"), 
            selectRandom (FLO_configCache get "units"), 
            selectRandom (FLO_configCache get "units"),
            selectRandom (FLO_configCache get "units"), 
            selectRandom (FLO_configCache get "units"), 
            selectRandom (FLO_configCache get "units")
        ]
    ] call BIS_fnc_spawnGroup;
    
    private _waypoint3 = _patrolGroup3 addWaypoint [getMarkerPos _targetBluforMarker, 0];
    _waypoint3 setWaypointType "MOVE";
};

// Schedule the reset of the offensive operation flag after a delay
[{
    OffensiveOperationUnderway = false;
    diag_log "[FLO][OffensiveOps] Offensive operation complete, flag reset";
}, [], 1800] call CBA_fnc_waitAndExecute; // Reset after 30 minutes

true 