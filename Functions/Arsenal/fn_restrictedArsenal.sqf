/*
    Function: FLO_fnc_restrictedArsenal
    
    Description: Sets up global arsenal restrictions that apply to any arsenal opened in the mission
                Handles both ACE and vanilla arsenals, including FOBs and OPs
    
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

// Function to restrict an arsenal box
FLO_fnc_restrictArsenalBox = {
    params ["_box"];
    
    if (FLO_hasAceArsenal) then {
        // Initialize ACE Arsenal first (this is key for FOBs/OPs)
        [_box, true] remoteExec ["ace_arsenal_fnc_initBox", 0];
        
        // Wait a frame to ensure initialization is complete
        [{
            params ["_box"];
            // Clear everything first
            [_box, true] call ace_arsenal_fnc_removeVirtualItems;
            // Add only our allowed items
            [_box, FLO_arsenal_allowedItems] call ace_arsenal_fnc_addVirtualItems;
        }, [_box], 0.1] call CBA_fnc_waitAndExecute;
    } else {
        // Clear and set up vanilla arsenal
        ["AmmoboxInit", [_box, false]] call BIS_fnc_arsenal;
        
        // Split items by type for vanilla arsenal
        private _weapons = FLO_arsenal_allowedItems select {_x isKindOf ["Rifle", configFile >> "CfgWeapons"] || 
                                                         _x isKindOf ["Launcher", configFile >> "CfgWeapons"] ||
                                                         _x isKindOf ["Pistol", configFile >> "CfgWeapons"]};
        private _items = FLO_arsenal_allowedItems select {_x isKindOf ["ItemCore", configFile >> "CfgWeapons"] ||
                                                        _x isKindOf ["Equipment", configFile >> "CfgWeapons"] ||
                                                        _x isKindOf ["Uniform_Base", configFile >> "CfgWeapons"] ||
                                                        _x isKindOf ["VestItem", configFile >> "CfgWeapons"] ||
                                                        _x isKindOf ["HeadgearItem", configFile >> "CfgWeapons"]};
        private _magazines = FLO_arsenal_allowedItems select {_x isKindOf ["CA_Magazine", configFile >> "CfgMagazines"]};
        private _backpacks = FLO_arsenal_allowedItems select {_x isKindOf ["Bag_Base", configFile >> "CfgVehicles"]};
        
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
        [_box] call FLO_fnc_restrictArsenalBox;
    }] call CBA_fnc_addEventHandler;
} else {
    // Vanilla Arsenal event handler
    ["arsenalOpened", {
        params ["_display", "_box"];
        [_box] call FLO_fnc_restrictArsenalBox;
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
            [_box] call FLO_fnc_restrictArsenalBox;
        }, [_entity], 0.1] call CBA_fnc_waitAndExecute;
    };
}];

// Initialize restrictions on any existing FOBs/OPs
{
    if ((typeOf _x) in [F_HQ_01, F_OP_01]) then {
        [_x] call FLO_fnc_restrictArsenalBox;
    };
} forEach (entities "All");

// Mark as initialized to prevent multiple executions
FLO_arsenal_initialized = true; 