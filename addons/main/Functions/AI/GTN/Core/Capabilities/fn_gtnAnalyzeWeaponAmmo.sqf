#pragma hemtt ignore_variables ["_self"]
/* _analyzeWeaponAmmo implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
params ["_weaponClass"];

private _cacheKey = format["weaponAmmo_%1", _weaponClass];
private _cached = _self call ["_getConfigCached", [_cacheKey]];
if (!isNil "_cached") exitWith { _cached };

private _maxCaliber = 0;
private _maxHit = 0;
private _maxIndirectHit = 0;
private _effectiveRange = 300;  // Default
private _isAA = false;

private _cfgWeapon = configFile >> "CfgWeapons" >> _weaponClass;
if (!isClass _cfgWeapon) exitWith {
    _self call ["_setConfigCache", [_cacheKey, [0, 10, 0, 300, false]]];
    [0, 10, 0, 300, false]
};

// Get effective range from maxZeroing
private _maxZeroing = getNumber (_cfgWeapon >> "maxZeroing");
if (_maxZeroing > 0) then { _effectiveRange = _maxZeroing };

// Check if this is a launcher (type 4 = secondary weapon)
private _weaponType = getNumber (_cfgWeapon >> "type");

// Get magazines this weapon uses
private _magazines = getArray (_cfgWeapon >> "magazines");

// Also check muzzles for weapons with multiple muzzles (like GL combos)
private _muzzles = getArray (_cfgWeapon >> "muzzles");
{
    if (_x != "this") then {
        private _muzzleMags = getArray (_cfgWeapon >> _x >> "magazines");
        _magazines append _muzzleMags;
    };
} forEach _muzzles;

// Analyze each magazine's ammo
{
    private _magClass = _x;
    private _cfgMag = configFile >> "CfgMagazines" >> _magClass;
    if (!isClass _cfgMag) then { continue };

    private _ammoClass = getText (_cfgMag >> "ammo");
    private _cfgAmmo = configFile >> "CfgAmmo" >> _ammoClass;
    if (!isClass _cfgAmmo) then { continue };

    // Get ammo properties
    private _caliber = getNumber (_cfgAmmo >> "caliber");
    private _hit = getNumber (_cfgAmmo >> "hit");
    private _indirectHit = getNumber (_cfgAmmo >> "indirectHit");
    private _indirectRange = getNumber (_cfgAmmo >> "indirectHitRange");

    // Track maximums
    if (_caliber > _maxCaliber) then { _maxCaliber = _caliber };
    if (_hit > _maxHit) then { _maxHit = _hit };
    if (_indirectHit > _maxIndirectHit) then { _maxIndirectHit = _indirectHit };

    // IR guidance alone also describes anti-tank missiles.
    if ([_cfgAmmo] call FLO_fnc_factionAmmoIsAntiAir) then { _isAA = true };

    // Estimate range from ammo physics if not set by zeroing
    if (_maxZeroing == 0) then {
        private _initSpeed = getNumber (_cfgAmmo >> "typicalSpeed");
        private _airFriction = getNumber (_cfgAmmo >> "airFriction");
        if (_initSpeed > 0) then {
            // Rough estimate: faster projectile = longer range
            _effectiveRange = _effectiveRange max (_initSpeed * 2);
        };
    };
} forEach _magazines;

private _result = [_maxCaliber, _maxHit, _maxIndirectHit, _effectiveRange, _isAA];
_self call ["_setConfigCache", [_cacheKey, _result]];
_result
