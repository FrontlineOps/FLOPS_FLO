#pragma hemtt ignore_variables ["_self"]
/* _analyzeVehicle implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
params ["_vehicle"];
if (isNull _vehicle) exitWith { nil };

private _typeClass = typeOf _vehicle;
private _type = _self call ["_classifyVehicle", [_vehicle]];
private _cfgVeh = configFile >> "CfgVehicles" >> _typeClass;

// Get config-based combat power from cost
private _configCost = _self call ["_getConfigCost", [_typeClass]];

// Get threat profile from config [soft, armor, air]
private _threatProfile = _self call ["_getConfigThreat", [_typeClass]];

// Get armor from config
private _configArmor = _self call ["_getConfigArmor", [_typeClass]];

// Get transport capacity
private _configTransport = _self call ["_getConfigTransport", [_typeClass]];

// Get max speed
private _configSpeed = _self call ["_getConfigMaxSpeed", [_typeClass]];

private _analysis = createHashMapFromArray [
    ["vehicle", _vehicle],
    ["typeClass", _typeClass],
    ["vehicleType", _type],
    ["combatPower", _configCost],
    ["threatVsSoft", _threatProfile select 0],
    ["threatVsArmor", _threatProfile select 1],
    ["threatVsAir", _threatProfile select 2],
    ["weapons", []],
    ["capabilities", []],
    ["maxPenetration", 0],
    ["maxDamage", 0],
    ["effectiveRange", 500],
    ["armor", createHashMap],
    ["sensors", []],
    ["mobility", createHashMap],
    ["crew", []],
    ["passengers", _configTransport],
    ["damageStatus", 1 - (damage _vehicle)],
    ["fuelStatus", fuel _vehicle],
    ["ammoStatus", 1.0],  // Will be calculated below
    ["artilleryAmmo", 0]  // Specific artillery round count
];

// Calculate ammo status - ratio of current ammo to max capacity
private _magsAmmo = magazinesAmmo _vehicle;
private _totalCurrent = 0;
private _totalMax = 0;
private _artilleryRounds = 0;

// Check if vehicle is artillery capable
private _isArtillery = _vehicle getVariable ["ace_artillerytables_firedEH", false] ||
                      ((getArtilleryAmmo [_vehicle]) isNotEqualTo []) ||
                      (_type == "SPG");

{
    _x params ["_magClass", "_ammoCount"];
    private _cfgMag = configFile >> "CfgMagazines" >> _magClass;
    if (isClass _cfgMag) then {
        private _magSize = getNumber (_cfgMag >> "count");
        _totalCurrent = _totalCurrent + _ammoCount;
        _totalMax = _totalMax + _magSize;

        // Count artillery-specific ammo
        if (_isArtillery) then {
            // Check if this magazine is artillery compatible
            private _ammoClass = getText (_cfgMag >> "ammo");
            private _cfgAmmo = configFile >> "CfgAmmo" >> _ammoClass;
            if (isClass _cfgAmmo) then {
                private _indirectHit = getNumber (_cfgAmmo >> "indirectHit");
                private _indirectRange = getNumber (_cfgAmmo >> "indirectHitRange");
                // Artillery ammo typically has high indirect damage
                if (_indirectHit > 50 || _indirectRange > 10) then {
                    _artilleryRounds = _artilleryRounds + _ammoCount;
                };
            };
        };
    };
} forEach _magsAmmo;

if (_totalMax > 0) then {
    _analysis set ["ammoStatus", _totalCurrent / _totalMax];
};
_analysis set ["artilleryAmmo", _artilleryRounds];

// Analyze all vehicle weapons using config
private _allWeapons = _self call ["_getVehicleWeapons", [_typeClass]];
private _maxPen = 0;
private _maxDmg = 0;
private _maxRange = 500;
private _hasAT = false;
private _hasAA = false;

{
    private _weaponClass = _x;
    private _ammoAnalysis = _self call ["_analyzeWeaponAmmo", [_weaponClass]];
    _ammoAnalysis params ["_caliber", "_hit", "_indirectHit", "_range", "_isAA"];

    // Track best stats
    if (_caliber > _maxPen) then { _maxPen = _caliber };
    if (_hit > _maxDmg) then { _maxDmg = _hit };
    if (_range > _maxRange) then { _maxRange = _range };
    if (_isAA) then { _hasAA = true };

    // Classify weapon penetration
    private _penClass = _self call ["_classifyWeaponPenetration", [_caliber]];

    (_analysis get "weapons") pushBack [_weaponClass, _penClass, _caliber, _hit, _range];

    // Add capabilities based on config-derived penetration
    switch (_penClass) do {
        case "AT_HEAVY": {
            _hasAT = true;
            (_analysis get "capabilities") pushBackUnique "AT_HEAVY";
            (_analysis get "capabilities") pushBackUnique "AT";
        };
        case "AT_LIGHT": {
            _hasAT = true;
            (_analysis get "capabilities") pushBackUnique "AT_LIGHT";
            (_analysis get "capabilities") pushBackUnique "AT";
        };
        case "AUTOCANNON": {
            (_analysis get "capabilities") pushBackUnique "AUTOCANNON";
            (_analysis get "capabilities") pushBackUnique "ARMOR_PIERCING";
        };
        case "HMG": {
            (_analysis get "capabilities") pushBackUnique "HMG";
            (_analysis get "capabilities") pushBackUnique "SUPPRESS";
        };
    };

    // Check for area effect weapons (indirect hit)
    if (_indirectHit > 20) then {
        (_analysis get "capabilities") pushBackUnique "AREA_ATTACK";
    };
} forEach _allWeapons;

// Set AA capability from config threat value or weapon analysis
if (_hasAA || (_threatProfile select 2) > 0.3) then {
    (_analysis get "capabilities") pushBackUnique "AA";
};

_analysis set ["maxPenetration", _maxPen];
_analysis set ["maxDamage", _maxDmg];
_analysis set ["effectiveRange", _maxRange];
_analysis set ["canEngageArmor", _hasAT || _maxPen >= 15];
_analysis set ["canEngageAir", _hasAA || (_threatProfile select 2) > 0.3];

// Armor analysis from config
(_analysis get "armor") set ["value", _configArmor];
(_analysis get "armor") set ["class",
    if (_configArmor > 400) then { "HEAVY" } else {
        [["NONE", "LIGHT"] select (_configArmor > 30), "MEDIUM"] select (_configArmor > 100)
    }
];

// Sensor analysis from config
private _hasRadar = getNumber (_cfgVeh >> "receiveRemoteTargets") > 0;
private _hasThermal = false;
private _hasNV = false;

// Check turrets for thermal/NV capability
private _turrets = configProperties [_cfgVeh >> "Turrets", "isClass _x"];
{
    // Check for thermal imaging
    private _thermalMode = getNumber (_x >> "turretInfoType") > 0;
    private _opticsConfig = _x >> "OpticsIn";
    if (isClass _opticsConfig) then {
        private _opticsModes = configProperties [_opticsConfig, "isClass _x"];
        {
            private _visionMode = getArray (_x >> "visionMode");
            if ("Ti" in _visionMode) then { _hasThermal = true };
            if ("NVG" in _visionMode) then { _hasNV = true };
        } forEach _opticsModes;
    };
} forEach _turrets;

if (_hasRadar) then { (_analysis get "sensors") pushBack "RADAR" };
if (_hasThermal) then { (_analysis get "sensors") pushBack "THERMAL" };
if (_hasNV) then { (_analysis get "sensors") pushBack "NV" };

// Mobility analysis from config
(_analysis get "mobility") set ["maxSpeed", _configSpeed];
(_analysis get "mobility") set ["isAmphibious",
    _vehicle isKindOf "Ship" || getNumber (_cfgVeh >> "canFloat") > 0];
(_analysis get "mobility") set ["isAir", _vehicle isKindOf "Air"];

// Crew
_analysis set ["crew", crew _vehicle];

_analysis
