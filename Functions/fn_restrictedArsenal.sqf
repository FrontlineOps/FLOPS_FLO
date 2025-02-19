/*
    Author: [Your Name]
    Description: Sets up global arsenal restrictions that apply to any arsenal opened in the mission
    
    Parameter(s):
        None
        
    Returns:
        None
*/

if (isNil "FLO_arsenal_initialized") then {
    FLO_arsenal_initialized = false;
};

if (FLO_arsenal_initialized) exitWith {};

// Weapons and attachments
private _rifles = [
    "arifle_MX_F",
    "arifle_MXC_F",
    "arifle_MX_GL_F",
    "arifle_MX_SW_F",
    "arifle_MXM_F"
];

private _launchers = [
    "launch_NLAW_F",
    "launch_RPG32_F"
];

private _attachments = [
    "optic_Hamr",
    "optic_Aco",
    "acc_flashlight",
    "acc_pointer_IR"
];

// Uniforms, vests, and headgear
private _uniforms = [
    "U_B_CombatUniform_mcam",
    "U_B_CombatUniform_mcam_tshirt",
    "U_B_CombatUniform_mcam_vest"
];

private _vests = [
    "V_PlateCarrier1_rgr",
    "V_PlateCarrier2_rgr",
    "V_PlateCarrierGL_rgr"
];

private _headgear = [
    "H_HelmetB",
    "H_HelmetB_light",
    "H_HelmetSpecB"
];

// Equipment and items
private _medicalItems = [
    "ACE_fieldDressing",
    "ACE_packingBandage",
    "ACE_elasticBandage",
    "ACE_tourniquet",
    "ACE_splint",
    "ACE_morphine",
    "ACE_epinephrine",
    "ACE_bloodIV",
    "ACE_bloodIV_500",
    "ACE_bloodIV_250",
    "ACE_personalAidKit",
    "ACE_surgicalKit"
];

private _toolItems = [
    "ACE_CableTie",
    "ACE_EntrenchingTool",
    "ACE_Flashlight_XL50",
    "ACE_MapTools",
    "ACE_EarPlugs",
    "ACE_wirecutter",
    "ACE_DefusalKit",
    "ACE_Clacker",
    "ToolKit"
];

private _navigationItems = [
    "ItemMap",
    "ItemCompass",
    "ItemWatch",
    "ItemRadio",
    "ItemGPS",
    "NVGoggles",
    "Binocular",
    "ACE_Vector"
];

private _backpacks = [
    "B_AssaultPack_mcamo",
    "B_Kitbag_mcamo",
    "B_TacticalPack_mcamo"
];

// Magazines and throwables
private _magazines = [
    "30Rnd_65x39_caseless_mag",
    "30Rnd_65x39_caseless_mag_Tracer",
    "100Rnd_65x39_caseless_mag",
    "100Rnd_65x39_caseless_mag_Tracer"
];

private _grenades = [
    "HandGrenade",
    "SmokeShell",
    "SmokeShellGreen",
    "SmokeShellRed",
    "1Rnd_HE_Grenade_shell",
    "ACE_M84",
    "ACE_Chemlight_HiRed",
    "ACE_Chemlight_HiGreen"
];

// Create global arrays for each category
FLO_arsenal_allowedItems = [];
FLO_arsenal_allowedItems append _rifles;
FLO_arsenal_allowedItems append _launchers;
FLO_arsenal_allowedItems append _attachments;
FLO_arsenal_allowedItems append _uniforms;
FLO_arsenal_allowedItems append _vests;
FLO_arsenal_allowedItems append _headgear;
FLO_arsenal_allowedItems append _navigationItems;
FLO_arsenal_allowedItems append _backpacks;
FLO_arsenal_allowedItems append _magazines;
FLO_arsenal_allowedItems append _grenades;
FLO_arsenal_allowedItems append _medicalItems;
FLO_arsenal_allowedItems append _toolItems;

// Add event handler for ANY arsenal opening to ensure items stay restricted
["ace_arsenal_displayOpened", {
    params ["_display"];
    private _box = ace_arsenal_currentBox;
    
    // Remove all virtual items first
    [_box, true] call ace_arsenal_fnc_removeVirtualItems;
    
    // Add only our allowed items
    [_box, FLO_arsenal_allowedItems] call ace_arsenal_fnc_addVirtualItems;
}] call CBA_fnc_addEventHandler;

// Mark as initialized to prevent multiple executions
FLO_arsenal_initialized = true; 