/*
 * Function: FLO_fnc_initPhase5_MissionSystems
 * Author: Frontline Operations Development Group
 * Description:
 *   Phase 5: Start all active mission systems (AI commander, startup systems, etc.)
 *   This runs AFTER objectives are indexed and virtualization is complete.
 *   Also handles MissionStartup (FOBs, OPs, etc.) and entity restoration from saves.
 *
 * Arguments: None
 * Returns: Boolean - True if systems started successfully
 */

if (!isServer) exitWith { false };

["INIT", 3, "Starting mission systems..."] call FLO_fnc_log;

// Verify prerequisites
if (isNil "FLO_Objectives" || {FLO_Objectives isEqualTo []}) exitWith {
    FLO_InitError = "Cannot start mission systems - no objectives";
    publicVariable "FLO_InitError";
    ["INIT", 1, format ["ERROR: %1", FLO_InitError]] call FLO_fnc_log;
    false
};

if (isNil "InitializationOG" || {!InitializationOG}) exitWith {
    FLO_InitError = "Cannot start mission systems - virtualization not complete";
    publicVariable "FLO_InitError";
    ["INIT", 1, format ["ERROR: %1", FLO_InitError]] call FLO_fnc_log;
    false
};

// The configured campaign side is authoritative for runtime human groups.
if !(FLO_ActivePlayerSide in [east, west]) exitWith {
    FLO_InitError = "Cannot start mission systems without a configured player side";
    publicVariable "FLO_InitError";
    ["INIT", 1, FLO_InitError] call FLO_fnc_log;
    false
};

["INIT", 3, format ["Human lobby slots target campaign side %1", [FLO_ActivePlayerSide] call FLO_fnc_sideKey]] call FLO_fnc_log;

// Initialize side resources early so restored/started systems can consume them.
if ([] call FLO_fnc_initSideResourcesUninitialized) then {
    [] call FLO_fnc_sideResources;
};

// ============================================
// RESTORE FOBs AND OPs FROM SAVE
// ============================================
if (FLO_IsLoadedSave) then {
    [FLO_SavedGameData get "fobs", "FOB"] call FLO_fnc_baseRestoreRecords;
    [FLO_SavedGameData get "ops", "COP"] call FLO_fnc_baseRestoreRecords;
};

// ============================================
// MISSION STARTUP (FOBs, OPs, Actions)
// ============================================
// This runs AFTER factions are loaded and FOBs/OPs are restored
["INIT", 3, "Running MissionStartup..."] call FLO_fnc_log;
[] call FLO_fnc_MissionStartup;
["INIT", 3, "MissionStartup complete"] call FLO_fnc_log;

[] call FLO_fnc_baseDeployInitializeState;
["INIT", 3, "Base deployment state initialized"] call FLO_fnc_log;

// ============================================
// ENTITY RESTORATION FROM SAVE
// ============================================
if (FLO_IsLoadedSave) then {
    ["INIT", 3, "Restoring entities from save..."] call FLO_fnc_log;

    private _savedData = FLO_SavedGameData;
    [_savedData] call FLO_fnc_saveRestoreMarkers;

    // Restore date/time
    private _date = _savedData get "time";
    if (count _date != 5 || {{!(_x isEqualType 0)} count _date > 0}) then {
        throw format ["Current save has malformed mission time %1", _date];
    };
    setDate _date;
    ["INIT", 3, format ["Restored mission time %1", _date]] call FLO_fnc_log;

    call FLO_fnc_operationalClockReset;

    private _trackedCrewTypes = createHashMap;
    private _playerCatalog = FLO_FactionCatalog get ([FLO_ActivePlayerSide] call FLO_fnc_sideKey);
    {
        _trackedCrewTypes set [_x, true];
    } forEach ((_playerCatalog get "staticAA") + (_playerCatalog get "radar"));

    [_savedData, _trackedCrewTypes] call FLO_fnc_saveRestoreVehicles;

    [_savedData, _trackedCrewTypes] call FLO_fnc_saveRestoreObjects;

    [_savedData] call FLO_fnc_saveRestoreCrates;

    [_savedData] call FLO_fnc_saveRestoreCommanders;

    [_savedData] call FLO_fnc_saveRestorePlacedEntities;

    // Trigger load completion event
    ["flo_mission_load_completed", [true, _savedData]] call CBA_fnc_globalEvent;

    ["INIT", 3, "Current entity restoration complete"] call FLO_fnc_log;
};

// ============================================
// Side Resource System
// ============================================
["INIT", 3, "Starting side resource system..."] call FLO_fnc_log;
if ([] call FLO_fnc_initSideResourcesUninitialized) then {
    [] call FLO_fnc_sideResources;
};
["INIT", 3, "Side resources started"] call FLO_fnc_log;

// ============================================
// Logistics Network
// ============================================
["INIT", 3, "Starting logistics network..."] call FLO_fnc_log;
[] call FLO_fnc_logisticsNetwork;
["INIT", 3, "Logistics network started"] call FLO_fnc_log;

[] call FLO_fnc_sideResourcesStartMainLoop;

[] call FLO_fnc_objectiveDevelopmentStart;
["INIT", 3, "Objective development started"] call FLO_fnc_log;

if (!FLO_IsLoadedSave) then {
    private _missionSides = missionNamespace getVariable ["FLO_MissionSides", [east, west]];
    {
        [_x] call FLO_fnc_initializeTransportReserveGroups;
    } forEach _missionSides;
    ["INIT", 3, "Transport reserve carriers seeded from staging objectives"] call FLO_fnc_log;
};

// ============================================
// GTN Resource Manager
// ============================================
if (isNil "FLO_GTN_CombatEvents") then {
    FLO_GTN_CombatEvents = [];
};
if (isNil "FLO_GTN_CombatLastByObjective") then {
    FLO_GTN_CombatLastByObjective = createHashMap;
};

["INIT", 3, "Starting GTN Resource Manager..."] call FLO_fnc_log;
private _liveGtnManager = call FLO_fnc_gtnGetResourceManager;
if (isNil "_liveGtnManager") then {
    FLO_GTN_ResourceManager = [] call FLO_fnc_gtnResourceManager;
} else {
    FLO_GTN_ResourceManager = call FLO_fnc_gtnResourceManagerProxy;
    FLO_GTN_ResourceManager call ["_initializeGTN", []];
};
["INIT", 3, "GTN Resource Manager started"] call FLO_fnc_log;

// ============================================
// GTN Minefield System
// ============================================
["INIT", 3, "Initializing GTN minefield system..."] call FLO_fnc_log;
[] call FLO_fnc_gtnMinefieldSystemInit;
["INIT", 3, "GTN minefield system initialized"] call FLO_fnc_log;

// ============================================
// GTN Virtual Combat Resolver
// ============================================
["INIT", 3, "Starting GTN virtual combat resolver..."] call FLO_fnc_log;
[] spawn FLO_fnc_gtnVirtualCombatResolver;
["INIT", 3, "GTN virtual combat resolver started"] call FLO_fnc_log;

// ============================================
// GTN Player Task Bridge
// ============================================
["INIT", 3, "Evaluating GTN player task bridge..."] call FLO_fnc_log;
if (FLO_GTN_EnablePlayerTaskBridge) then {
    [] spawn FLO_fnc_gtnPlayerTaskBridge;
    ["INIT", 3, "GTN player task bridge started (enabled)"] call FLO_fnc_log;
} else {
    ["INIT", 3, "GTN player task bridge disabled (FLO_GTN_EnablePlayerTaskBridge=false)"] call FLO_fnc_log;
};

// ============================================
// GTN Player Support Events
// ============================================
["INIT", 3, "Registering GTN player support events..."] call FLO_fnc_log;
[] call FLO_fnc_gtnRegisterPlayerSupportEvents;
["INIT", 3, "GTN player support events registered"] call FLO_fnc_log;

// ============================================
// GTN Commander Visual Debug
// ============================================
["INIT", 3, "Evaluating GTN commander visual debug..."] call FLO_fnc_log;
if (FLO_GTN_CommanderDebugEnabled) then {
    [] spawn FLO_fnc_gtnCommanderVisualDebug;
    ["INIT", 3, "GTN commander visual debug started"] call FLO_fnc_log;
} else {
    ["INIT", 3, "GTN commander visual debug disabled (FLO_GTN_CommanderDebugEnabled=false)"] call FLO_fnc_log;
};

// ============================================
// Aftermath Cleanup
// ============================================
["INIT", 3, "Starting aftermath cleanup..."] call FLO_fnc_log;
["start"] call FLO_fnc_aftermathCleanupManager;
["INIT", 3, "Aftermath cleanup started"] call FLO_fnc_log;

// ============================================
// Abandoned Vehicle Cleanup
// ============================================
["INIT", 3, "Starting abandoned vehicle cleanup..."] call FLO_fnc_log;
["start"] call FLO_fnc_vehicleCleanupManager;
["INIT", 3, "Abandoned vehicle cleanup started"] call FLO_fnc_log;

// ============================================
// Civilian System (Config + Manager)
// ============================================
["INIT", 3, "Initializing civilian system..."] call FLO_fnc_log;
[] call FLO_fnc_civilianConfig;
["INIT", 3, "Civilian config loaded"] call FLO_fnc_log;
[] call FLO_fnc_civilianManager;
["INIT", 3, "Civilian manager initialized"] call FLO_fnc_log;

// ============================================
// Civilian Mission System
// ============================================
["INIT", 3, "Initializing civilian mission system..."] call FLO_fnc_log;
["INIT"] call FLO_fnc_civilianMissionManager;
["INIT", 3, "Civilian mission manager initialized"] call FLO_fnc_log;

// ============================================
// Config Cache (if not already initialized)
// ============================================
if (isNil "FLO_ConfigCache") then {
    ["INIT", 3, "Initializing config cache..."] call FLO_fnc_log;
    ["init"] call FLO_fnc_objectiveConfig;
    ["INIT", 3, "Config cache initialized"] call FLO_fnc_log;
};

if (FLO_IsLoadedSave) then {
    private _resumedRoutes = [] call FLO_fnc_virtualizationResumeSavedRoutes;
    if (_resumedRoutes > 0) then {
        ["INIT", 3, format ["Reissued %1 saved virtual routes after load", _resumedRoutes]] call FLO_fnc_log;
    };
};

["INIT", 3, "Starting virtualization PFH..."] call FLO_fnc_log;
["start"] call FLO_fnc_virtualizationUpdatePFH;
["INIT", 3, "Virtualization PFH started"] call FLO_fnc_log;

["INIT", 3, "Mission systems phase complete"] call FLO_fnc_log;
true
