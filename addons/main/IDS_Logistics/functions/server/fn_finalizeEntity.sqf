/**
 * @name IDS_Logistics_fnc_finalizeEntity
 * @category Logistics_Core
 * 
 * @author IDSolutions
 * @version 1.0
 * @date 2025-03-10
 * 
 * @description
 * Finalizes entity placement on the server. Handles both new entity creation
 * and updating existing entities that have been repositioned.
 *
 * @param {String} _originalNetId - NetId of the original entity (empty if new)
 * @param {String} _className - Class name of the entity
 * @param {Array} _finalPos - Final position as ASL coordinates
 * @param {Number} _finalDir - Final direction/rotation 
 * @param {Array} _vectorUp - Vector up for non-standard orientation
 * @param {Object} _player - Player who placed the entity
 * @param {Number} _centerHeight - Center height of the object to prevent sinking
 *
 * @return {Nothing}
 *
 * @example
 * [_netId, _className, _finalPos, _finalDir, _vectorUp, player, _centerHeight] remoteExec ["IDS_Logistics_fnc_finalizeEntity", 2]
 */

// This function should run on the server only
if (!isServer) exitWith {
    ["IDS_LOGISTICS", 2, "Rejected placement outside server"] call FLO_fnc_log;
};

params [
    ["_originalNetId", "", [""]],
    ["_className", "", [""]],
    ["_finalPos", [0,0,0], [[]]],
    ["_finalDir", 0, [0]],
    ["_vectorUp", [0,0,1], [[]]],
    ["_player", objNull, [objNull]],
    ["_centerHeight", 0, [0]]
];

// Check if this is a reposition of an existing entity
if (_originalNetId != "") then {
    private _existingEntity = objectFromNetId _originalNetId;
    
    if (!isNull _existingEntity) then {
        private _visibilityState = _existingEntity getVariable ["IDS_Logistics_VisibilityState", []];
        private _requestOwner = if (isRemoteExecuted) then { remoteExecutedOwner } else { clientOwner };
        if (_visibilityState isNotEqualTo [] && {(_visibilityState select 0) != _requestOwner}) exitWith {
            ["IDS_LOGISTICS", 2, "Rejected reposition: another client owns the placement"] call FLO_fnc_log;
        };
        // Set new position - use setPosASL for precise positioning
        _existingEntity setPosASL _finalPos;
        _existingEntity setDir _finalDir;
        _existingEntity setVectorUp _vectorUp;
        
        // Pickup disables collision only on the local preview. Restore the original's
        // visibility/simulation snapshot without changing its locality or registration.
        [_originalNetId, false] call IDS_Logistics_fnc_toggleEntityVisibility;
        [_existingEntity] call IDS_Logistics_fnc_registerEntity;
        ["IDS_LOGISTICS", 3, "Existing structure repositioned"] call FLO_fnc_log;
    } else {
        ["IDS_LOGISTICS", 2, "Rejected reposition: original structure no longer exists"] call FLO_fnc_log;
    };
} else {
    // Create a new entity
    private _entity = createVehicle [_className, [0,0,0], [], 0, "CAN_COLLIDE"];
    
    // Use setPosASL to maintain exact coordinates
    _entity setPosASL _finalPos;
    _entity setDir _finalDir;
    _entity setVectorUp _vectorUp;
    
    [_entity] call IDS_Logistics_fnc_registerEntity;

    // Get entity configuration and set variable
    private _entityConfig = [_className] call IDS_Logistics_fnc_getEntityConfig;
    _entityConfig params ["_entityClassName", "_entityCategory", "_entityCost"];
    _entity setVariable ["IDS_Logistics_EntityCost", _entityCost, true];
    _entity setVariable ["IDS_Logistics_isPlacedEntity", true, true];
    ["IDS_LOGISTICS", 3, format ["Structure placed class=%1 registered=%2", _className, count IDS_Logistics_PlacedEntities]] call FLO_fnc_log;
};
