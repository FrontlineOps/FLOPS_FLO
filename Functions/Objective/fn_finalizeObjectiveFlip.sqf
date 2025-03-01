/*
    Function: FLO_fnc_finalizeObjectiveFlip
    
    Description:
    Finalizes the flipping of an objective to a new controlling side.
    Creates or updates markers and respawn points based on the capturing side.
    
    Parameters:
    _trigger - The trigger that activated the finalization [Object]
    _objectiveType - Type of objective ("outpost" or "city") [String]
    _capturingSide - Side capturing the objective ("west" or "east") [String]
    
    Returns:
    Boolean - True if objective was finalized successfully
    
    Example:
    [_trigger, "outpost", "west"] call FLO_fnc_finalizeObjectiveFlip;
*/

params [
    ["_trigger", objNull, [objNull]],
    ["_objectiveType", "outpost", [""]],
    ["_capturingSide", "west", [""]]
];

if (isNull _trigger) exitWith {
    diag_log "[FLO][Outpost] Error: Invalid trigger for objective finalization";
    false
};

private _position = getPos _trigger;

// Get current markers that might need to be deleted/updated
private _currentMarkerType = if (_capturingSide == "west") then {
    // If BLUFOR is capturing, we need to find OPFOR markers
    switch (_objectiveType) do {
        case "outpost": { "o_support" };
        case "city": { "o_installation" };
        default { "o_support" };
    }
} else {
    // If OPFOR is capturing, we need to find BLUFOR markers
    "b_installation"
};

// Find current marker
private _allCurrentMarkers = allMapMarkers select {markerType _x == _currentMarkerType};
private _currentMarker = [_allCurrentMarkers, _position] call FLO_fnc_findNearestMarker;

// Delete old triggers in the area
private _allTriggers = allMissionObjects "EmptyDetector";
private _nearbyTriggers = _allTriggers select {getPos _x distance _position < 20};
{
    deleteVehicle _x;
} forEach _nearbyTriggers;

// Check if marker was found
if (_currentMarker != "") then {
    // Delete the current marker
    deleteMarker _currentMarker;
};

// Create new marker based on capturing side
private _newMarkerName = format ["%1_%2", _objectiveType, str _position];
private _newMarker = createMarker [_newMarkerName, _position];

if (_capturingSide == "west") then {
    // BLUFOR captured
    _newMarker setMarkerType "b_installation";
    _newMarker setMarkerColor "colorBLUFOR";
    _newMarker setMarkerSize [1.3, 1.3];
    
    // Create respawn position for BLUFOR
    private _respawnMarkerName = format ["respawn_west_%1", str _position];
    private _respawnMarker = createMarker [_respawnMarkerName, _position];
    _respawnMarker setMarkerType "respawn_inf";
    _respawnMarker setMarkerColor "colorBLUFOR";
    _respawnMarker setMarkerText "FOB";
    
    // Update objective count for mission completion if needed
    if (!isNil "BIS_WL_oneMoreObjectiveCaptured" && !isNil "BIS_WL_objectivesToCapture") then {
        BIS_WL_oneMoreObjectiveCaptured = BIS_WL_oneMoreObjectiveCaptured + 1;
        publicVariable "BIS_WL_oneMoreObjectiveCaptured";
        
        // Check for mission completion
        if (BIS_WL_oneMoreObjectiveCaptured >= BIS_WL_objectivesToCapture) then {
            ["END1", true] call BIS_fnc_endMission;
        };
    };
    
    // Add to captured objectives list
    if (!isNil "FLO_capturedOutposts") then {
        FLO_capturedOutposts set [_newMarkerName, 1];
    };
    
    // Show notification
    ["TaskSucceeded", ["", format ["%1 Captured", _objectiveType]]] call BIS_fnc_showNotification;
    
    // Set up QRF trigger for OPFOR counter-attack
    private _qrfTrigger = createTrigger ["EmptyDetector", _position, false];
    _qrfTrigger setTriggerArea [1000, 1000, 0, false, 200];
    _qrfTrigger setTriggerTimeout [7, 7, 7, true];
    _qrfTrigger setTriggerActivation ["WEST", "PRESENT", false];
    _qrfTrigger setTriggerStatements [
        "this && (({_x isKindOf 'Man'} count thisList > 0) or ({_x isKindOf 'LandVehicle'} count thisList > 0))",
        format [
            "[thisTrigger, '%1', 'east'] call FLO_fnc_flipObjective;",
            _objectiveType
        ],
        ""
    ];
    
} else {
    // OPFOR captured
    _newMarker setMarkerType (switch (_objectiveType) do {
        case "outpost": { "o_support" };
        case "city": { "o_installation" };
        default { "o_support" };
    });
    _newMarker setMarkerColor "colorOPFOR";
    _newMarker setMarkerSize [1.2, 1.2];
    
    // Notify players
    [playerSide, "HQ"] commandChat format ["All Forces Fall Back. We Lost the %1", toUpper _objectiveType];
    
    // Set up trigger for BLUFOR counter-attack
    private _counterTrigger = createTrigger ["EmptyDetector", _position, false];
    _counterTrigger setTriggerArea [1000, 1000, 0, false, 200];
    _counterTrigger setTriggerTimeout [7, 7, 7, true];
    _counterTrigger setTriggerActivation ["WEST", "PRESENT", false];
    _counterTrigger setTriggerStatements [
        "this && (({_x isKindOf 'Man'} count thisList > 0) or ({_x isKindOf 'LandVehicle'} count thisList > 0))",
        format [
            "[thisTrigger, '%1', 'west'] call FLO_fnc_flipObjective;",
            _objectiveType
        ],
        ""
    ];
};

// Return success
true 