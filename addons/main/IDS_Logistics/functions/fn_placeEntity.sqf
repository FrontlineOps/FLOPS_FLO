/**
 * @name IDS_Logistics_fnc_placeEntity
 * @category Logistics_Core
 * 
 * @author IDSolutions
 * @version 1.0
 * @date 2025-03-10
 * 
 * @description
 * Finalizes the placement of the currently held entity.
 * Camera-based building system only - player-based functionality removed.
 * Handles cleanup of temporary objects and event handlers.
 *
 * @param {None} - Uses globally stored IDS_Logistics_currentEntity
 *
 * @return {Nothing}
 *
 * @example
 * [] call IDS_Logistics_fnc_placeEntity
 */

// Validate current holding state
if (!IDS_Logistics_isHolding || isNull IDS_Logistics_currentEntity) exitWith { ["No entity to place.", 2] call IDS_Logistics_fnc_cameraHint; };

// Ensure camera mode is active
if (isNil "IDS_Logistics_Camera" || { isNull IDS_Logistics_Camera }) exitWith { ["Camera mode is not active.", 2] call IDS_Logistics_fnc_cameraHint; };

// Extract entity properties before deletion
private _entity = IDS_Logistics_currentEntity;
private _className = typeOf _entity;
private _finalPos = getPosASL _entity;
private _finalDir = getDir _entity;
private _vectorUp = vectorUp _entity;

// Get the center height stored on the entity
private _centerHeight = _entity getVariable ["IDS_Logistics_CenterHeight", 0];

// Get original netId if this was a picked-up entity
private _originalNetId = IDS_Logistics_originalNetId;

// Submit the exact preview geometry, then release only local placement resources.
[_originalNetId, _className, _finalPos, _finalDir, _vectorUp, player, _centerHeight] remoteExecCall ["IDS_Logistics_fnc_finalizeEntity", 2];
[false] call IDS_Logistics_fnc_cleanupPlacement;

// Provide user feedback
["Entity placed: " + _className, 2] call IDS_Logistics_fnc_cameraHint;
