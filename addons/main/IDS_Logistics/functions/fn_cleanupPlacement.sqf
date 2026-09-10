/* Releases the current preview and exactly the handlers owned by placement. */
if (canSuspend) exitWith {
    private _released = false;
    isNil { _released = _this call IDS_Logistics_fnc_cleanupPlacement; };
    _released
};
params [["_restoreOriginal", true, [true]]];

private _entity = IDS_Logistics_currentEntity;
private _originalNetId = IDS_Logistics_originalNetId;
private _wasHolding = IDS_Logistics_isHolding;
IDS_Logistics_isHolding = false;
IDS_Logistics_currentEntity = objNull;
IDS_Logistics_originalNetId = "";

private _display = uiNamespace getVariable "IDS_Logistics_PlacementDisplay";
if (!isNull _display) then {
    {
        _x params ["_type", "_id"];
        if (_id >= 0) then { _display displayRemoveEventHandler [_type, _id]; };
    } forEach [
        ["MouseZChanged", IDS_Logistics_scrollHandler],
        ["KeyDown", IDS_Logistics_keyDownHandler],
        ["KeyUp", IDS_Logistics_keyUpHandler]
    ];
};
if (IDS_Logistics_dirUpdateEH >= 0) then {
    removeMissionEventHandler ["EachFrame", IDS_Logistics_dirUpdateEH];
};
IDS_Logistics_scrollHandler = -1;
IDS_Logistics_keyDownHandler = -1;
IDS_Logistics_keyUpHandler = -1;
IDS_Logistics_dirUpdateEH = -1;
uiNamespace setVariable ["IDS_Logistics_PlacementDisplay", displayNull];
uiNamespace setVariable ["IDS_Logistics_shiftPressed", false];
uiNamespace setVariable ["IDS_Logistics_ctrlPressed", false];
uiNamespace setVariable ["IDS_Logistics_altPressed", false];

// Keep the original identity independently of the preview, which can be deleted externally.
if (_restoreOriginal && {_originalNetId != ""}) then {
    if (isServer) then {
        [_originalNetId, false] call IDS_Logistics_fnc_toggleEntityVisibility;
    } else {
        [_originalNetId, false] remoteExecCall ["IDS_Logistics_fnc_toggleEntityVisibility", 2];
    };
};
if (!isNull _entity) then { deleteVehicle _entity; };
if (_restoreOriginal && {_wasHolding}) then {
    ["IDS_LOGISTICS", 3, format ["Placement cancelled reposition=%1", _originalNetId != ""]] call FLO_fnc_log;
};

_wasHolding
