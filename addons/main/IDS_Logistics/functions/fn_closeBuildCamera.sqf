/* Session ownership prevents a delayed old camera worker from closing a new camera. */
if (canSuspend) exitWith {
    private _closed = false;
    isNil { _closed = _this call IDS_Logistics_fnc_closeBuildCamera; };
    _closed
};
params [["_session", -1, [0]]];
if (!IDS_Logistics_CameraActive || {_session != IDS_Logistics_CameraSession}) exitWith { false };
IDS_Logistics_CameraActive = false;

[true] call IDS_Logistics_fnc_cleanupPlacement;
private _camera = IDS_Logistics_Camera;
if (!isNull _camera) then { IDS_Logistics_CameraLastPos = position _camera; };

private _display = uiNamespace getVariable "IDS_Logistics_CameraDisplay";
if (!isNull _display) then {
    _display displayRemoveEventHandler ["KeyDown", IDS_Logistics_cameraKeyDownHandler];
    { _display displayRemoveEventHandler ["MouseButtonDown", _x]; } forEach IDS_Logistics_MouseClicks;
};
uiNamespace setVariable ["IDS_Logistics_CameraDisplay", displayNull];
IDS_Logistics_MouseClicks = [];
IDS_Logistics_cameraKeyDownHandler = -1;

removeMissionEventHandler ["EachFrame", IDS_Logistics_DistanceCheckEH];
removeMissionEventHandler ["EachFrame", IDS_Logistics_BoundaryEH];
IDS_Logistics_DistanceCheckEH = -1;
IDS_Logistics_BoundaryEH = -1;

if (!isNil "IDS_Logistics_CursorArrow") then {
    deleteVehicle IDS_Logistics_CursorArrow;
    IDS_Logistics_CursorArrow = nil;
};
{
    private _key = format ["IDS_Logistics_BoundaryArrow_%1", _x];
    private _arrow = missionNamespace getVariable [_key, objNull];
    if (!isNull _arrow) then { deleteVehicle _arrow; };
    missionNamespace setVariable [_key, nil];
} forEach [0, 90, 180, 270];

if (hasInterface) then { player cameraEffect ["TERMINATE", "BACK"]; };
ppEffectDestroy IDS_Logistics_CameraColorEffect;
IDS_Logistics_CameraColorEffect = nil;
camDestroy _camera;
IDS_Logistics_Camera = nil;
IDS_Logistics_CameraVision = nil;
IDS_Logistics_HintVisible = nil;
IDS_Logistics_lastViewDir = nil;
IDS_Logistics_ShowCenterCursor = nil;
IDS_Logistics_CameraTerrainSnap = nil;
IDS_Logistics_BuildMenuDisabled = nil;
["", 0, true] call IDS_Logistics_fnc_cameraHint;
["IDS_LOGISTICS", 3, "Build camera closed; placement released"] call FLO_fnc_log;
true
