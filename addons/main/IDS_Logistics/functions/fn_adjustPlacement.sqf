/* Shared MouseZChanged callback for new and repositioned previews. */
params ["_display", "_scroll"];

if (!IDS_Logistics_isHolding || isNull IDS_Logistics_currentEntity) exitWith {};

private _shift = uiNamespace getVariable ["IDS_Logistics_shiftPressed", false];
private _ctrl = uiNamespace getVariable ["IDS_Logistics_ctrlPressed", false];
private _alt = uiNamespace getVariable ["IDS_Logistics_altPressed", false];

if (_shift) then {
    // Shift + Scroll = Rotation
    IDS_Logistics_entityRotation = IDS_Logistics_entityRotation + (_scroll * 5);

    if (IDS_Logistics_entityRotation < 0) then { IDS_Logistics_entityRotation = IDS_Logistics_entityRotation + 360; };
    if (IDS_Logistics_entityRotation >= 360) then { IDS_Logistics_entityRotation = IDS_Logistics_entityRotation - 360; };

    // Get reference direction (camera or player)
    private _refDir = 0;

    if (!isNil "IDS_Logistics_Camera" && {!isNull IDS_Logistics_Camera}) then {
        private _camDir = getCameraViewDirection IDS_Logistics_Camera;
        _refDir = (_camDir select 0) atan2 (_camDir select 1);

        if (_refDir < 0) then { _refDir = _refDir + 360; };

    } else {
        _refDir = getDir player;
    };

    private _finalDir = (_refDir + IDS_Logistics_entityRotation) % 360;
    private _message = format ["<t color='#44AAFF' size='1.0'>ROTATION</t><br/><t align='left'>Camera Direction: <t color='#FFFFFF'>%1°</t><br/>Rotation Offset: <t color='#FFFFFF'>%2°</t><br/>Final Direction: <t color='#FFFFFF'>%3°</t></t>",
                        round _refDir, round IDS_Logistics_entityRotation, round _finalDir];

    [_message, 1] call IDS_Logistics_fnc_cameraHint;
} else {
    if (_ctrl) then {
        // Ctrl + Scroll = Height
        IDS_Logistics_entityHeight = IDS_Logistics_entityHeight + (_scroll * 0.1);

        // Update UI
        private _message = format ["<t color='#44FF44' size='1.0'>HEIGHT</t><br/><t align='left'>Current Value: <t color='#FFFFFF'>%1m</t></t>",
                            (round(IDS_Logistics_entityHeight * 10))/10];
        [_message, 1] call IDS_Logistics_fnc_cameraHint;
    } else {
        if (_alt) then {
            // Alt + Scroll = Distance
            IDS_Logistics_entityDistance = IDS_Logistics_entityDistance + (_scroll * 0.5);
            IDS_Logistics_entityDistance = (IDS_Logistics_entityDistance max 1) min 20;

            // Update UI
            private _message = format ["<t color='#FFAA44' size='1.0'>DISTANCE</t><br/><t align='left'>Current Value: <t color='#FFFFFF'>%1m</t></t>",
                                (round(IDS_Logistics_entityDistance * 10))/10];
            [_message, 1] call IDS_Logistics_fnc_cameraHint;
        };
    };
};
