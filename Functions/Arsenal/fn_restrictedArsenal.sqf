/*
    Function: FLO_fnc_restrictedArsenal
    
    Description: Sets up global arsenal restrictions that apply to any arsenal opened in the mission
                Handles both ACE and vanilla arsenals, including FOBs and OPs
                Supports role-based restrictions
    
    Parameter(s):
        None
        
    Returns:
        None
*/

if (isNil "FLO_arsenal_initialized") then {
    FLO_arsenal_initialized = false;
};

if (FLO_arsenal_initialized) exitWith {};

// Check if ACE Arsenal is available
FLO_hasAceArsenal = isClass (configFile >> "ace_arsenal_loadoutsDisplay");

// Define default items that every role should have access to
FLO_arsenal_defaultItems = [
    // Basic Uniforms
    "U_B_CombatUniform_mcam",
    "U_B_CombatUniform_mcam_tshirt",
    "U_B_CombatUniform_mcam_vest",
    
    // Basic Vests
    "V_PlateCarrier1_rgr",
    "V_PlateCarrier2_rgr",
    "V_PlateCarrierGL_rgr",
    
    // Basic Headgear
    "H_HelmetB",
    "H_HelmetB_light",
    "H_HelmetSpecB",
    "ACE_EarPlugs",
    
    // Basic Weapons
    "arifle_MX_F",
    "arifle_MXC_F",
    "hgun_P07_F",
    
    // Basic Attachments
    "optic_Aco",
    "optic_Holosight",
    "acc_flashlight",
    "acc_pointer_IR",
    
    // Basic Ammo
    "30Rnd_65x39_caseless_mag",
    "30Rnd_65x39_caseless_mag_Tracer",
    "16Rnd_9x21_Mag",
    
    // Basic Medical
    "FirstAidKit",
    "kat_IFAK",
    
    // Basic Items
    "ItemMap",
    "ItemCompass",
    "ItemWatch",
    "ItemRadio",
    "ItemGPS",
    "Binocular",
    "NVGoggles",
    
    // Basic Grenades
    "HandGrenade",
    "SmokeShell",
    "SmokeShellGreen",
    "SmokeShellRed",
    
    // Basic Backpacks
    "B_AssaultPack_mcamo",
    "B_Kitbag_mcamo",
    
    // Basic Tools
    "ACE_CableTie",
    "ACE_Flashlight_XL50",
    "ACE_MapTools",
    "ACE_IR_Strobe_Item"
];

// Define role-specific items
FLO_arsenal_roles = [
    // Default role - only default items
    ["DEFAULT", []],
    
    // Medic role - medical equipment
    ["MEDIC", [
        // Medical gear
        "kat_AFAK",
        "kat_MFAK",
        "ace_personalAidKit",
        "ace_surgicalKit",
        // KAT Medical Items
        "kat_accuvac",
        "kat_guedel",
        "kat_larynx",
        "kat_aatKit",
        "kat_chestSeal",
        "kat_Pulseoximeter",
        "kat_stethoscope",
        "kat_bloodIV_A",
        "kat_bloodIV_A_250",
        "kat_bloodIV_A_500",
        "kat_bloodIV_B",
        "kat_bloodIV_B_250",
        "kat_bloodIV_B_500",
        "kat_bloodIV_AB",
        "kat_bloodIV_AB_250",
        "kat_bloodIV_AB_500",
        "kat_bloodIV_O",
        "kat_bloodIV_O_250",
        "kat_bloodIV_O_500",
        "kat_AED",
        "kat_X_AED",
        // Medic-specific backpacks
        "B_AssaultPack_rgr_Medic",
        "B_Patrol_Medic_bag_F"
    ]],
    
    // Engineer role - repair and explosives
    ["ENGINEER", [
        // Engineer tools
        "ToolKit",
        "MineDetector",
        "ACE_DefusalKit",
        "ACE_Clacker",
        "ACE_wirecutter",
        // Explosives
        "DemoCharge_Remote_Mag",
        "SatchelCharge_Remote_Mag",
        "APERSMine_Range_Mag",
        "APERSBoundingMine_Range_Mag",
        "ClaymoreDirectionalMine_Remote_Mag",
        "SLAMDirectionalMine_Wire_Mag",
        // Engineer backpacks
        "B_Kitbag_mcamo_Eng",
        "B_AssaultPack_rgr_Repair"
    ]],
    
    // Marksman role - precision weapons
    ["MARKSMAN", [
        // Marksman weapons
        "arifle_MXM_F",
        "srifle_DMR_03_tan_AMS_LP_F",
        "srifle_LRR_camo_LRPS_F",
        // Ammunition
        "20Rnd_762x51_Mag",
        "7Rnd_408_Mag",
        // Special optics
        "optic_SOS",
        "optic_LRPS",
        "optic_AMS_snd",
        "optic_DMS",
        "ACE_Vector",
        "Rangefinder",
        // Attachments
        "bipod_01_F_snd",
        "muzzle_snds_338_sand"
    ]],
    
    // Autorifleman role
    ["AUTORIFLEMAN", [
        // Weapons
        "arifle_MX_SW_F",
        "LMG_Mk200_plain_RCO_LP_F",
        "MMG_02_sand_RCO_LP_F",
        // Ammunition
        "100Rnd_65x39_caseless_mag",
        "100Rnd_65x39_caseless_mag_Tracer",
        "150Rnd_762x54_Box",
        "130Rnd_338_Mag",
        // Attachments
        "optic_Hamr",
        "bipod_01_F_snd",
        // Specific gear
        "B_Kitbag_rgr_AAR"
    ]],
    
    // Anti-Tank role
    ["AT", [
        // Launchers
        "launch_B_Titan_short_F",
        "launch_MRAWS_sand_F",
        "ACE_launch_NLAW_ready_F",
        // Missiles
        "Titan_AT",
        "Titan_AP",
        "NLAW_F",
        "MRAWS_HEAT_F",
        "MRAWS_HE_F",
        // Specific gear
        "B_AssaultPack_rgr_LAT2"
    ]],
    
    // Anti-Air role
    ["AA", [
        // Launchers
        "launch_B_Titan_F",
        // Missiles
        "Titan_AA",
        // Specific gear
        "B_AssaultPack_mcamo_AA"
    ]],
    
    // Commander role - full access
    ["COMMANDER", FLO_arsenal_allowedItems]
];

// Function to get allowed items for a role
FLO_fnc_getRoleItems = {
    params ["_unit"];
    private _roleVar = _unit getVariable ["FLO_PlayerRole", "DEFAULT"];
    private _roleIndex = (FLO_arsenal_roles apply {_x select 0}) findIf {_x == _roleVar};
    
    if (_roleIndex == -1) then {
        // Return default items if role not found
        _roleIndex = 0;
    };
    
    // Combine default items with role-specific items
    private _roleItems = (FLO_arsenal_roles select _roleIndex) select 1;
    private _combinedItems = FLO_arsenal_defaultItems + _roleItems;
    
    // Remove duplicates
    _combinedItems arrayIntersect _combinedItems
};

// Function to restrict an arsenal box
FLO_fnc_restrictArsenalBox = {
    params ["_box", ["_unit", player]];
    
    private _allowedItems = [_unit] call FLO_fnc_getRoleItems;
    
    if (FLO_hasAceArsenal) then {
        // Initialize ACE Arsenal first
        [_box, true] remoteExec ["ace_arsenal_fnc_initBox", 0];
        
        // Wait a frame to ensure initialization is complete
        [{
            params ["_box", "_allowedItems"];
            // Clear everything first
            [_box, true] call ace_arsenal_fnc_removeVirtualItems;
            // Add only allowed items for the role
            [_box, _allowedItems] call ace_arsenal_fnc_addVirtualItems;
        }, [_box, _allowedItems], 0.1] call CBA_fnc_waitAndExecute;
    } else {
        // Clear and set up vanilla arsenal
        ["AmmoboxInit", [_box, false]] call BIS_fnc_arsenal;
        
        // Split items by type for vanilla arsenal
        private _weapons = _allowedItems select {_x isKindOf ["Rifle", configFile >> "CfgWeapons"] || 
                                              _x isKindOf ["Launcher", configFile >> "CfgWeapons"] ||
                                              _x isKindOf ["Pistol", configFile >> "CfgWeapons"]};
        private _items = _allowedItems select {_x isKindOf ["ItemCore", configFile >> "CfgWeapons"] ||
                                            _x isKindOf ["Equipment", configFile >> "CfgWeapons"] ||
                                            _x isKindOf ["Uniform_Base", configFile >> "CfgWeapons"] ||
                                            _x isKindOf ["VestItem", configFile >> "CfgWeapons"] ||
                                            _x isKindOf ["HeadgearItem", configFile >> "CfgWeapons"]};
        private _magazines = _allowedItems select {_x isKindOf ["CA_Magazine", configFile >> "CfgMagazines"]};
        private _backpacks = _allowedItems select {_x isKindOf ["Bag_Base", configFile >> "CfgVehicles"]};
        
        [_box, _weapons] call BIS_fnc_addVirtualWeaponCargo;
        [_box, _items] call BIS_fnc_addVirtualItemCargo;
        [_box, _magazines] call BIS_fnc_addVirtualMagazineCargo;
        [_box, _backpacks] call BIS_fnc_addVirtualBackpackCargo;
    };
};

// Add event handlers based on which arsenal system is available
if (FLO_hasAceArsenal) then {
    // ACE Arsenal event handler
    ["ace_arsenal_displayOpened", {
        params ["_display"];
        private _box = ace_arsenal_currentBox;
        [_box, player] call FLO_fnc_restrictArsenalBox;
    }] call CBA_fnc_addEventHandler;
} else {
    // Vanilla Arsenal event handler
    ["arsenalOpened", {
        params ["_display", "_box"];
        [_box, player] call FLO_fnc_restrictArsenalBox;
    }] call CBA_fnc_addEventHandler;
};

// Add event handler for object initialization to catch FOBs and OPs
addMissionEventHandler ["EntityCreated", {
    params ["_entity"];
    
    // Check if it's a FOB or OP
    if ((typeOf _entity) in [F_HQ_01, F_OP_01]) then {
        // Wait a frame to let the object initialize
        [{
            params ["_box"];
            [_box, player] call FLO_fnc_restrictArsenalBox;
        }, [_entity], 0.1] call CBA_fnc_waitAndExecute;
    };
}];

// Initialize restrictions on any existing FOBs/OPs
{
    if ((typeOf _x) in [F_HQ_01, F_OP_01]) then {
        [_x, player] call FLO_fnc_restrictArsenalBox;
    };
} forEach (entities "All");

// Mark as initialized to prevent multiple executions
FLO_arsenal_initialized = true; 