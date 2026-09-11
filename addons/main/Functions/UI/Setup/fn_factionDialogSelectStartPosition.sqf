/* Scheduled map selection; the click callback owns the selected position. */
// Prompt for starting location with the map visible.
titleText ["", "BLACK IN", 1, true, true];

FLO_StartingLocationComplete = 0;
publicVariable "FLO_StartingLocationComplete";
private _startLocationPrompt = "<t size='1.35' color='#ff3b3b' font='PuristaBold'>SELECT STARTING FOB LOCATION</t><br/><t size='0.9' color='#ffffff'>Left-click the map to place your starting FOB and begin the campaign.</t>";
hint "Select your starting FOB location on the map.";
[_startLocationPrompt, 0, 0.18, 9999, 0, 0, 9010] spawn BIS_fnc_dynamicText;
openMap [true, true];

// Add map click handler for starting location
FLO_mapClickDFD = addMissionEventHandler ["MapSingleClick", {
    params ["_control", "_pos", "_alt", "_shift"];

    removeMissionEventHandler ["MapSingleClick", FLO_mapClickDFD];

    player setPos _pos;
    ["", 0, 0.18, 0.1, 0, 0, 9010] spawn BIS_fnc_dynamicText;
    hintSilent "LOADING...";
    FLO_StartingLocationComplete = 1;
    publicVariable "FLO_StartingLocationComplete";

    // Store the selected position
    missionNamespace setVariable ["FLO_StartPosition", _pos, true];

    titleText ["Initializing Frontline Operations...", "BLACK FADED", 0.1, true, true];
}];

waitUntil {FLO_StartingLocationComplete == 1};
openMap [true, false];
openMap [false, false];

// Get final start position
missionNamespace getVariable "FLO_StartPosition"
