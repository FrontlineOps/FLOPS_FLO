/*
    Function: FLO_fnc_flipObjective
    
    Description:
    Handles the initial phase of flipping objectives (outposts or cities) between BLUFOR and OPFOR control.
    This function marks an objective as "in progress" (gray marker) and sets up a timeout to finalize the capture.
    
    Parameters:
    _trigger - The trigger that activated the flip [Object]
    _objectiveType - Type of objective ("outpost" or "city") [String]
    _capturingSide - Side capturing the objective ("west" or "east") [String]
    
    Returns:
    Boolean - True if objective flip was initiated successfully
    
    Example:
    [_trigger, "outpost", "west"] call FLO_fnc_flipObjective;
*/

params [
    ["_trigger", objNull, [objNull]],
    ["_objectiveType", "outpost", [""]],
    ["_capturingSide", "west", [""]]
];

if (isNull _trigger) exitWith {
    diag_log "[FLO][Outpost] Error: Invalid trigger for objective flipping";
    false
};

private _position = getPos _trigger;

// Check if objective is in cooldown period
if (!isNil "FLO_Objective_Cooldowns") then {
    private _objectiveKey = format ["%1_%2", _objectiveType, _position];
    private _lastCaptureTime = FLO_Objective_Cooldowns getOrDefault [_objectiveKey, 0];
    
    if (time - _lastCaptureTime < 300) exitWith {
        diag_log format ["[FLO][Outpost] Objective at %1 is in cooldown period, cannot be flipped yet", _position];
        false
    };
};

// Get relevant marker types based on objective type
private _markerType = switch (_objectiveType) do {
    case "outpost": { "o_support" };
    case "city": { "o_installation" };
    default { "o_support" };
};

private _bluforMarkerType = "b_installation";

// Handle different capturing sides
if (_capturingSide == "west") then {
    // BLUFOR is capturing
    
    // Find nearest matching marker
    private _allMarkers = allMapMarkers select {markerType _x == _markerType};
    private _objectiveMarker = [_allMarkers, _position] call FLO_fnc_findNearestMarker;
    
    if (_objectiveMarker == "") exitWith {
        diag_log format ["[FLO][Outpost] Error: Could not find marker for %1 at %2", _objectiveType, _position];
        false
    };
    
    // Send notification
    [parseText format [
        '<t color="#1AA3FF" font="PuristaBold" align = "right" shadow = "1" size="2">SITREP</t><br />' +
        '<t color="#959393" align = "right" shadow = "1" size="0.8">Friendly Forces Dominating the Battle,</t><br />' +
        '<t color="#959393" align = "right" shadow = "1" size="0.8">Keep Up the Fight, We will Capture and Secure the %1,</t>', 
        _objectiveType
    ], [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];
    
    // Change marker color to neutral (in progress)
    _objectiveMarker setMarkerColor "ColorGrey";
    
    // Send radio message
    private _attackingAtGrid = mapGridPosition getMarkerPos _objectiveMarker;
    [[west, "HQ"], format ["Friendly Forces Dominating the Battle at grid %1", _attackingAtGrid]] remoteExec ["sideChat", 0];
    
    // Set timeout to finalize capture if still in control
    [_trigger, _objectiveType, _capturingSide] spawn {
        params ["_trigger", "_objectiveType", "_capturingSide"];
        sleep 120;
        
        if (!isNull _trigger && triggerActivated _trigger) then {
            [_trigger, _objectiveType, _capturingSide] call FLO_fnc_finalizeObjectiveFlip;
        };
    };
    
} else {
    // OPFOR is capturing
    
    // Find nearest matching marker
    private _allMarkers = allMapMarkers select {markerType _x == _bluforMarkerType};
    private _objectiveMarker = [_allMarkers, _position] call FLO_fnc_findNearestMarker;
    
    if (_objectiveMarker == "") exitWith {
        diag_log format ["[FLO][Outpost] Error: Could not find marker for %1 at %2", _objectiveType, _position];
        false
    };
    
    // Send notification
    [parseText format [
        '<t color="#FF3619" font="PuristaBold" align = "right" shadow = "1" size="2">SITREP</t><br />' +
        '<t color="#7c7c7c" align = "right" shadow = "1" size="0.8">Enemy Forces Dominating the Battle,</t><br />' +
        '<t color="#7c7c7c" align = "right" shadow = "1" size="0.8">Keep Up the Fight, We Must Defend and Take Back the %1,</t>',
        _objectiveType
    ], [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];
    
    // Change marker color to neutral (in progress)
    _objectiveMarker setMarkerColor "ColorGrey";
    
    // Send radio message
    private _attackingAtGrid = mapGridPosition getMarkerPos _objectiveMarker;
    [[west, "HQ"], format ["Enemy Forces Dominating the Battle at grid %1", _attackingAtGrid]] remoteExec ["sideChat", 0];
    
    // Set timeout to finalize capture if still in control
    [_trigger, _objectiveType, _capturingSide] spawn {
        params ["_trigger", "_objectiveType", "_capturingSide"];
        sleep 120;
        
        if (!isNull _trigger && triggerActivated _trigger) then {
            [_trigger, _objectiveType, _capturingSide] call FLO_fnc_finalizeObjectiveFlip;
        };
    };
};

// Return success
true 