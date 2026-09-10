/**
 * @name IDS_Logistics_fnc_initLogistics
 * @category Logistics_Core
 * 
 * @author IDSolutions
 * @version 1.0
 * @date 2025-03-10
 * 
 * @description
 * Initializes the IDS Logistics system.
 * Sets up global variables used throughout the logistics framework
 * and prepares the system for operation.
 *
 * @param {None}
 *
 * @return {Nothing}
 *
 * @example
 * [] call IDS_Logistics_fnc_initLogistics
 */

IDS_Logistics_PlacedEntities = [];
IDS_Logistics_ManipulatedEntities = [];
IDS_Logistics_isHolding = false;
IDS_Logistics_currentEntity = objNull;
IDS_Logistics_originalNetId = "";
IDS_Logistics_scrollHandler = -1;
IDS_Logistics_keyDownHandler = -1;
IDS_Logistics_keyUpHandler = -1;
IDS_Logistics_dirUpdateEH = -1;
IDS_Logistics_CameraSession = 0;
IDS_Logistics_CameraActive = false;
uiNamespace setVariable ["IDS_Logistics_PlacementDisplay", displayNull];
uiNamespace setVariable ["IDS_Logistics_CameraDisplay", displayNull];

// Initialize UI variables
uiNamespace setVariable ["IDS_Logistics_shiftPressed", false];
uiNamespace setVariable ["IDS_Logistics_ctrlPressed", false];
uiNamespace setVariable ["IDS_Logistics_altPressed", false];

// Initialize entities array from config
IDS_Logistics_Entities = [];
private _entitiesConfig = configFile >> "CfgLogistics" >> "Entities";
if !(isClass _entitiesConfig) then {
    private _message = "Addon CfgLogistics/Entities is unavailable";
    ["IDS_LOGISTICS", 1, _message] call FLO_fnc_log;
    throw _message;
};

// Iterate through all entity classes in the config
for "_i" from 0 to (count _entitiesConfig - 1) do {
    private _entityClass = _entitiesConfig select _i;
    
    if (isClass _entityClass) then {
        private _className = configName _entityClass;
        private _category = getText (_entityClass >> "category");
        private _cost = getNumber (_entityClass >> "cost");
        
        // Add to entities array in the same format as before: [className, category, cost]
        IDS_Logistics_Entities pushBack [_className, _category, _cost];
    };
};

if (IDS_Logistics_Entities isEqualTo []) then {
    private _message = "Addon CfgLogistics/Entities contains no buildable entities";
    ["IDS_LOGISTICS", 1, _message] call FLO_fnc_log;
    throw _message;
};

if (isServer) then {
    IDS_Logistics_DisconnectEH = addMissionEventHandler ["HandleDisconnect", {
        params ["_unit"];
        [_unit] call IDS_Logistics_fnc_releasePlayerPlacements;
        false
    }];
};

["IDS_LOGISTICS", 3, format [
    "IDS Logistics initialized with %1 buildable entities",
    count IDS_Logistics_Entities
]] call FLO_fnc_log;
