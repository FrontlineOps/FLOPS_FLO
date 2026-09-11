/* Installs the input session released by cleanupPlacement. */
private _display = uiNamespace getVariable "IDS_Logistics_PlacementDisplay";
IDS_Logistics_dirUpdateEH = addMissionEventHandler ["EachFrame", {
    if (IDS_Logistics_isHolding && {!isNull IDS_Logistics_currentEntity}) then {
        [] call IDS_Logistics_fnc_updateEntityPlacement;
    };
}];
IDS_Logistics_scrollHandler = _display displayAddEventHandler ["MouseZChanged", IDS_Logistics_fnc_adjustPlacement];
// Track key states
IDS_Logistics_keyDownHandler = _display displayAddEventHandler ["KeyDown", {
    params ["_display", "_key", "_shift", "_ctrl", "_alt"];
    if (_key == 42 || _key == 54) then { uiNamespace setVariable ["IDS_Logistics_shiftPressed", true]; };
    if (_key == 29 || _key == 157) then { uiNamespace setVariable ["IDS_Logistics_ctrlPressed", true]; };
    if (_key == 56 || _key == 184) then { uiNamespace setVariable ["IDS_Logistics_altPressed", true]; };

    false
}];

IDS_Logistics_keyUpHandler = _display displayAddEventHandler ["KeyUp", {
    params ["_display", "_key", "_shift", "_ctrl", "_alt"];

    if (_key == 42 || _key == 54) then { uiNamespace setVariable ["IDS_Logistics_shiftPressed", false]; };
    if (_key == 29 || _key == 157) then { uiNamespace setVariable ["IDS_Logistics_ctrlPressed", false]; };
    if (_key == 56 || _key == 184) then { uiNamespace setVariable ["IDS_Logistics_altPressed", false]; };

    false
}];
