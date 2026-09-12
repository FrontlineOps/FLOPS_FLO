#pragma hemtt ignore_variables ["_self"]
/* _classifyVehicle implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
params ["_vehicle"];
if (isNull _vehicle) exitWith { "UNKNOWN" };

private _type = typeOf _vehicle;
if (getNumber (configFile >> "CfgVehicles" >> _type >> "isUav") > 0 && {!(_vehicle isKindOf "StaticWeapon")}) exitWith {
    ["UGAV", "UAV"] select (_vehicle isKindOf "Air")
};

// Check inheritance chain for vehicle type
if (_vehicle isKindOf "Tank") exitWith {
    // Distinguish MBT from IFV/APC
    private _cfgVeh = configFile >> "CfgVehicles" >> _type;
    private _armor = getNumber (_cfgVeh >> "armor");
    if (_armor > 400) then { "MBT" } else {
        // Check for troop transport capability
        private _cargo = getNumber (_cfgVeh >> "transportSoldier");
        ["IFV", "APC"] select (_cargo >= 6)
    }
};

if (_vehicle isKindOf "Wheeled_APC_F") exitWith { "APC" };
if (_vehicle isKindOf "MRAP_01_base_F" || _vehicle isKindOf "MRAP_02_base_F" ||
    _vehicle isKindOf "MRAP_03_base_F") exitWith { "MRAP" };

if (_vehicle isKindOf "Helicopter") exitWith {
    // Check for weapons to distinguish attack from transport
    private _weapons = weapons _vehicle;
    private _hasHeavyWeapons = (_weapons findIf {
        (_x find "cannon" >= 0) || (_x find "missiles" >= 0) ||
        (_x find "rockets" >= 0) || (_x find "Gatling" >= 0)
    }) isNotEqualTo -1;
    ["TRANSPORT_HELI", "ATTACK_HELI"] select (_hasHeavyWeapons)
};

if (_vehicle isKindOf "Plane") exitWith {
    private _weapons = weapons _vehicle;
    private _hasAG = (_weapons findIf { (_x find "Bomb" >= 0) || (_x find "AGM" >= 0) }) isNotEqualTo -1;
    ["FIGHTER_JET", "CAS_JET"] select (_hasAG)
};

if (_vehicle isKindOf "Ship") exitWith { "BOAT" };

if (_vehicle isKindOf "StaticWeapon") exitWith {
    if ((_self call ["_getAirDefenseRange", [_type]]) > 0) exitWith { "STATIC_AA" };
    private _weapons = weapons _vehicle;
    if ((_weapons findIf { _x find "AT" >= 0 || {_x find "Titan" >= 0} }) isNotEqualTo -1) exitWith { "STATIC_AT" };
    "STATIC_MG"
};

if (_vehicle isKindOf "Truck_F") exitWith { "TRUCK" };
if (_vehicle isKindOf "Car") exitWith { "CAR" };

"UNKNOWN"
