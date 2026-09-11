/*
 * Function: FLO_fnc_gtnCapabilityAnalyzer
 * Author: Frontline Operations Development Group
 *
 * Description:
 * Config-Based Heavyweight Capability Analyzer for the GTN AI Commander.
 * All combat power, threat values, armor ratings, and weapon capabilities
 * are derived from actual Arma 3 config entries (CfgVehicles, CfgWeapons,
 * CfgMagazines, CfgAmmo) rather than hardcoded values.
 *
 * Key Config Values Used:
 * - CfgVehicles >> "cost" - AI value/combat power (already balanced by BI)
 * - CfgVehicles >> "threat" - [soft, armor, air] threat ratings 0-1
 * - CfgVehicles >> "armor" - overall armor protection value
 * - CfgAmmo >> "caliber" - armor penetration multiplier
 * - CfgAmmo >> "hit" - base damage value
 * - CfgWeapons >> "maxZeroing" - effective range indicator
 *
 * Return Value:
 * Capability Analyzer HashMap Object <HASHMAP>
 *
 * Example:
 * private _analyzer = call FLO_fnc_gtnCapabilityAnalyzer;
 * private _cost = _analyzer call ["_getConfigCost", ["B_MBT_01_cannon_F"]];
 */

if (!isNil "FLO_GTN_CapabilityAnalyzer") exitWith { FLO_GTN_CapabilityAnalyzer };

["GTN Capability Analyzer", 3, "Initializing Config-Based Capability Analyzer"] call FLO_fnc_log;

// ============================================================================
// CREATE ANALYZER OBJECT
// ============================================================================

FLO_GTN_CapabilityAnalyzer = createHashMapObject [[
    // Analysis cache to avoid repeated config lookups
    ["_configCache", createHashMap],  // Cache for config lookups

    // Caliber thresholds for capability classification (from Arma config values)
    // These are based on actual Arma 3 caliber values in CfgAmmo
    ["_caliberThresholds", createHashMapFromArray [
        ["AT_HEAVY", 40],    // ATGM, tank rounds (caliber 40-120+)
        ["AT_LIGHT", 15],    // RPG, LAW, recoilless (caliber 15-40)
        ["AUTOCANNON", 6],   // 20mm-40mm cannons (caliber 6-15)
        ["HMG", 2],          // .50 cal, 12.7mm (caliber 2-6)
        ["SMALL_ARMS", 0]    // Everything else
    ]],

    // Get cached config value (configs never change during mission)
    ["_getConfigCached", {
        params ["_key"];
        (_self get "_configCache") getOrDefault [_key, nil]
    }],

    // Store config value in permanent cache
    ["_setConfigCache", {
        params ["_key", "_value"];
        (_self get "_configCache") set [_key, _value];
    }],

    // ========================================================================
    // CONFIG READING METHODS
    // ========================================================================

    // Get combat power from CfgVehicles >> "cost"
    // This is the AI's assessment of unit value - already balanced by BI
    // Typical values: Rifleman ~30000, Tank ~500000, Attack Heli ~1000000
    ["_getConfigCost", {
        params ["_typeClass"];

        private _cacheKey = format["cost_%1", _typeClass];
        private _cached = _self call ["_getConfigCached", [_cacheKey]];
        if (!isNil "_cached") exitWith { _cached };

        private _cfg = configFile >> "CfgVehicles" >> _typeClass;
        private _cost = if (isClass _cfg) then {
            getNumber (_cfg >> "cost")
        } else { 10000 };

        // Normalize to a 0-1000 scale for easier comparison
        // Rifleman ~30, Tank ~500, Attack Heli ~1000
        private _normalized = (_cost / 1000) min 1500;

        _self call ["_setConfigCache", [_cacheKey, _normalized]];
        _normalized
    }],

    // Get threat profile from CfgVehicles >> "threat"
    // Returns [softTarget, armoredTarget, airTarget] each 0-1
    ["_getConfigThreat", {
        params ["_typeClass"];

        private _cacheKey = format["threat_%1", _typeClass];
        private _cached = _self call ["_getConfigCached", [_cacheKey]];
        if (!isNil "_cached") exitWith { _cached };

        private _cfg = configFile >> "CfgVehicles" >> _typeClass;
        private _threat = if (isClass _cfg) then {
            getArray (_cfg >> "threat")
        } else { [0.5, 0, 0] };

        // Ensure we have 3 elements
        if (count _threat < 3) then {
            _threat = [0.5, 0, 0];
        };

        _self call ["_setConfigCache", [_cacheKey, _threat]];
        _threat
    }],

    // Get armor value from CfgVehicles >> "armor"
    // Higher = more armored. Tanks ~500+, APCs ~100, cars ~30
    ["_getConfigArmor", {
        params ["_typeClass"];

        private _cacheKey = format["armor_%1", _typeClass];
        private _cached = _self call ["_getConfigCached", [_cacheKey]];
        if (!isNil "_cached") exitWith { _cached };

        private _cfg = configFile >> "CfgVehicles" >> _typeClass;
        private _armor = if (isClass _cfg) then {
            getNumber (_cfg >> "armor")
        } else { 1 };

        _self call ["_setConfigCache", [_cacheKey, _armor]];
        _armor
    }],

    // Get max speed from CfgVehicles >> "maxSpeed"
    ["_getConfigMaxSpeed", {
        params ["_typeClass"];

        private _cacheKey = format["speed_%1", _typeClass];
        private _cached = _self call ["_getConfigCached", [_cacheKey]];
        if (!isNil "_cached") exitWith { _cached };

        private _cfg = configFile >> "CfgVehicles" >> _typeClass;
        private _speed = if (isClass _cfg) then {
            getNumber (_cfg >> "maxSpeed")
        } else { 0 };

        _self call ["_setConfigCache", [_cacheKey, _speed]];
        _speed
    }],

    // Get passenger capacity from CfgVehicles >> "transportSoldier"
    ["_getConfigTransport", {
        params ["_typeClass"];

        private _cacheKey = format["transport_%1", _typeClass];
        private _cached = _self call ["_getConfigCached", [_cacheKey]];
        if (!isNil "_cached") exitWith { _cached };

        private _cfg = configFile >> "CfgVehicles" >> _typeClass;
        private _transport = if (isClass _cfg) then {
            getNumber (_cfg >> "transportSoldier")
        } else { 0 };

        _self call ["_setConfigCache", [_cacheKey, _transport]];
        _transport
    }],

    // ========================================================================
    // WEAPON AND AMMO CONFIG ANALYSIS
    // ========================================================================

    // Analyze a weapon's ammo to determine penetration and damage
    // Returns: [maxCaliber, maxHit, maxIndirectHit, effectiveRange, isAA]
    ["_analyzeWeaponAmmo", FLO_fnc_gtnAnalyzeWeaponAmmo],

    // Classify weapon capability based on ammo caliber
    // Returns: "AT_HEAVY", "AT_LIGHT", "AUTOCANNON", "HMG", "SMALL_ARMS"
    ["_classifyWeaponPenetration", {
        params ["_caliber"];

        private _thresholds = _self get "_caliberThresholds";

        if (_caliber >= (_thresholds get "AT_HEAVY")) exitWith { "AT_HEAVY" };
        if (_caliber >= (_thresholds get "AT_LIGHT")) exitWith { "AT_LIGHT" };
        if (_caliber >= (_thresholds get "AUTOCANNON")) exitWith { "AUTOCANNON" };
        if (_caliber >= (_thresholds get "HMG")) exitWith { "HMG" };
        "SMALL_ARMS"
    }],

    // Get all weapons from a vehicle's config (including turrets)
    ["_getVehicleWeapons", FLO_fnc_gtnGetVehicleWeapons],

    // ========================================================================
    // VEHICLE ANALYSIS METHODS
    // ========================================================================

    // Classify vehicle type
    ["_classifyVehicle", FLO_fnc_gtnClassifyVehicle],

    // Analyze a vehicle's capabilities using config values
    ["_analyzeVehicle", FLO_fnc_gtnAnalyzeVehicle],

    // Get artillery status across all artillery groups
    // Returns: [totalBatteries, availableBatteries, totalRounds, activeRounds]
    ["_getArtilleryStatus", FLO_fnc_gtnGetArtilleryStatus],

    // Get air asset status across all air groups
    // Returns HashMap with CAS/helo availability and ordnance status
    ["_getAirAssetStatus", FLO_fnc_gtnGetAirAssetStatus],

    // ========================================================================
    // INTEL-BASED REVEAL UTILITY
    // ========================================================================
    // Reveal enemies at a position to units (for CAS/attack/recon missions)
    // This ensures AI units can engage targets they have intel about
    // Reports target awareness to the receiving units.
    //
    // Parameters:
    // 0: Position <ARRAY> - Location to scan for enemies
    // 1: Radius <NUMBER> - Search radius (default 1500m)
    // 2: Units/Group <ARRAY or GROUP> - Units to reveal enemies to
    // 3: Enemy Side <SIDE> - Side of enemies to reveal (default: west for OPFOR commander)
    //
    // Returns: Number of enemies revealed
    ["_revealIntelToUnits", FLO_fnc_gtnRevealIntelToUnits]

]];

["GTN Capability Analyzer", 3, "Heavyweight Capability Analyzer initialized"] call FLO_fnc_log;

FLO_GTN_CapabilityAnalyzer
