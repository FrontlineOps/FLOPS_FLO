/**
 * @name IDS_Logistics_fnc_startPlacement
 * @category Logistics_Core
 * 
 * @author IDSolutions
 * @version 1.0
 * @date 2025-03-10
 * 
 * @description
 * Initiates the placement process for a new entity.
 * Camera-based building system only - player-based functionality removed.
 * The entity follows the camera view for positioning.
 *
 * @param {String} _className - The class name of the entity to place
 *
 * @return {Nothing}
 *
 * @example
 * ["Land_BagFence_Long_F"] call IDS_Logistics_fnc_startPlacement
 */

params [["_className", "", [""]]];

// Validate inputs and state
if (_className == "") exitWith { ["<t color='#FF4444'>ERROR</t><br/>No entity class specified.", 2] call IDS_Logistics_fnc_cameraHint; };
if (IDS_Logistics_isHolding) exitWith { ["<t color='#FFAA44'>NOTICE</t><br/>You are already placing an entity.", 2] call IDS_Logistics_fnc_cameraHint; };

// Ensure camera mode is active
if (isNil "IDS_Logistics_Camera" || { isNull IDS_Logistics_Camera }) exitWith { ["Camera mode is not active.", 2] call IDS_Logistics_fnc_cameraHint; };

// Get entity configuration
private _entityConfig = [_className] call IDS_Logistics_fnc_getEntityConfig;
if (_entityConfig isEqualTo []) exitWith { ["<t color='#FF4444'>ERROR</t><br/>Entity '" + _className + "' not found in configuration.", 2] call IDS_Logistics_fnc_cameraHint; };

// Create the entity locally (preview only)
uiNamespace setVariable ["IDS_Logistics_PlacementDisplay", findDisplay 46];
IDS_Logistics_originalNetId = "";
private _entity = createVehicleLocal [_className, [0,0,0], [], 0, "CAN_COLLIDE"];

// Disable simulation and collision
_entity enableSimulationGlobal false;
player disableCollisionWith _entity;

// Set holding state
IDS_Logistics_isHolding = true;
IDS_Logistics_currentEntity = _entity;

// Initialize placement variables
IDS_Logistics_entityHeight = 0; // Initial height offset
IDS_Logistics_entityRotation = 0; // Additional rotation offset from reference direction
IDS_Logistics_entityDistance = 5; // Initial distance from reference (in meters)

// Initial placement using the update function
[] call IDS_Logistics_fnc_updateEntityPlacement;

[] call IDS_Logistics_fnc_installPlacementHandlers;
