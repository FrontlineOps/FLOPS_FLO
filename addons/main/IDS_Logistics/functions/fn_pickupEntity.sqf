/**
 * @name IDS_Logistics_fnc_pickupEntity
 * @category Logistics_Core
 * 
 * @author IDSolutions
 * @version 1.0
 * @date 2025-03-10
 * 
 * @description
 * Handles entity pickup with improved network handling.
 * Camera-based building system only - player-based functionality removed.
 * Creates a local preview for manipulation before finalizing on the server.
 *
 * @param {Object} _entity - The server-side entity to pick up
 *
 * @return {Nothing}
 *
 * @example
 * [cursorObject] call IDS_Logistics_fnc_pickupEntity
 */

params [["_entity", objNull, [objNull]]];

if (isNull _entity) exitWith {};
if (IDS_Logistics_isHolding) exitWith { ["You are already holding an entity.", 2] call IDS_Logistics_fnc_cameraHint; };

// Ensure camera mode is active
if (isNil "IDS_Logistics_Camera" || { isNull IDS_Logistics_Camera }) exitWith { ["Camera mode is not active.", 2] call IDS_Logistics_fnc_cameraHint; };

// Store entity information before deletion
private _className = typeOf _entity;
private _netId = netId _entity;
private _originalPos = getPosASL _entity;
private _originalDir = getDir _entity;
private _originalVectorUp = vectorUp _entity;

// The server retains registry ownership while the client manipulates a preview.
IDS_Logistics_originalNetId = _netId;
uiNamespace setVariable ["IDS_Logistics_PlacementDisplay", findDisplay 46];
[_netId, true, player] remoteExecCall ["IDS_Logistics_fnc_toggleEntityVisibility", 2];

// Create local preview entity for manipulation
private _localEntity = createVehicleLocal [_className, [0,0,0], [], 0, "CAN_COLLIDE"];
_localEntity setPosASL _originalPos;
_localEntity setDir _originalDir;
_localEntity setVectorUp _originalVectorUp;

// Store the original information for later restoration
_localEntity setVariable ["IDS_Logistics_OriginalNetId", _netId];
_localEntity setVariable ["IDS_Logistics_originalPos", _originalPos];
_localEntity setVariable ["IDS_Logistics_originalDir", _originalDir];
_localEntity setVariable ["IDS_Logistics_originalVectorUp", _originalVectorUp];
_localEntity setVariable ["IDS_Logistics_isPickedUp", true];

// Disable simulation and collision
_localEntity enableSimulationGlobal false;
player disableCollisionWith _localEntity;

// Setup holding state
IDS_Logistics_isHolding = true;
IDS_Logistics_currentEntity = _localEntity;

["Entity picked up: " + _className, 2] call IDS_Logistics_fnc_cameraHint;

// Check if using camera mode or player mode
private _useCameraMode = !isNil "IDS_Logistics_Camera" && { !isNull IDS_Logistics_Camera };

// Calculate initial placement variables
if (_useCameraMode) then {
    // Get camera view direction
    private _camDir = getCameraViewDirection IDS_Logistics_Camera;
    private _cameraDir = (_camDir select 0) atan2 (_camDir select 1);

    if (_cameraDir < 0) then { _cameraDir = _cameraDir + 360; };

    // Calculate rotation offset from camera direction
    IDS_Logistics_entityRotation = (_originalDir - _cameraDir) % 360;
    if (IDS_Logistics_entityRotation < 0) then { IDS_Logistics_entityRotation = IDS_Logistics_entityRotation + 360; };

    // Calculate distance from camera to entity
    private _cameraPos = getPosASL IDS_Logistics_Camera;
    private _distanceVector = [
        (_originalPos select 0) - (_cameraPos select 0),
        (_originalPos select 1) - (_cameraPos select 1),
        0 // Ignore vertical distance
    ];
    IDS_Logistics_entityDistance = vectorMagnitude _distanceVector;
    IDS_Logistics_entityDistance = (IDS_Logistics_entityDistance max 1) min 25; // Ensure within valid range

    // Calculate height offset
    private _groundLevel = getTerrainHeightASL [_originalPos select 0, _originalPos select 1];
    IDS_Logistics_entityHeight = (_originalPos select 2) - _groundLevel;
};

[] call IDS_Logistics_fnc_installPlacementHandlers;
