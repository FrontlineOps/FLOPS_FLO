#pragma hemtt ignore_variables ["_self"]
/* Configured AI firing range for the class's actual anti-air payload.
 * Cache belongs to Capability Analyzer; installed mod configs are immutable.
 */
params ["_className", ["_availableMagazines", nil]];
private _key = "airDefenseRange_" + _className;
if (!isNil "_availableMagazines") then {
    _availableMagazines = _availableMagazines arrayIntersect _availableMagazines;
    _availableMagazines sort true;
    _key = _key + "_" + str _availableMagazines;
};
private _cached = _self call ["_getConfigCached", [_key]];
if (!isNil "_cached") exitWith { _cached };

if (!isClass (configFile >> "CfgVehicles" >> _className)) then {
    private _message = format ["Air-defense capability requires an installed vehicle class: %1", _className];
    ["GTN Capability Analyzer", 1, _message] call FLO_fnc_log;
    throw _message;
};

private _payload = [_className] call FLO_fnc_factionGetVehicleCapabilities;
private _roles = [_className] call FLO_fnc_factionClassifyVehicle;
private _dedicatedAA = (_roles arrayIntersect ["staticAA", "mobileAA"]) isNotEqualTo [];
private _loadedMagazines = if (isNil "_availableMagazines") then {_payload get "magazines"} else {_availableMagazines};
if (!isNil "_availableMagazines" && {_loadedMagazines isEqualTo []}) exitWith {0};
private _range = 0;
{
    private _weapon = configFile >> "CfgWeapons" >> _x;
    private _magazines = [_weapon] call FLO_fnc_factionGetWeaponMagazines;
    if (_loadedMagazines isNotEqualTo []) then {
        _magazines = _magazines arrayIntersect _loadedMagazines;
    };
    private _weaponRange = 0;
    private _modes = getArray (_weapon >> "modes");
    if (_modes isEqualTo []) then { _modes = ["this"] };
    {
        private _mode = if (_x == "this") then { _weapon } else { _weapon >> _x };
        _weaponRange = _weaponRange max getNumber (_mode >> "maxRange");
    } forEach _modes;
    if (_weaponRange <= 0) then { continue };
    {
        private _ammo = configFile >> "CfgAmmo" >> getText (configFile >> "CfgMagazines" >> _x >> "ammo");
        private _simulation = toLower getText (_ammo >> "simulation");
        if (getNumber (_ammo >> "hit") <= 0 && {getNumber (_ammo >> "indirectHit") <= 0}) then { continue };
        private _missile = [_ammo] call FLO_fnc_factionAmmoIsAntiAir;
        private _gun = _dedicatedAA && {_simulation in ["shotbullet", "shotshell"]};
        if (!_missile && {!_gun}) then { continue };
        private _ammoRange = _weaponRange;
        if (_missile) then {
            private _lockRange = getNumber (_ammo >> "missileLockMaxDistance");
            if (_lockRange > 0) then { _ammoRange = _ammoRange min _lockRange };
        };
        _range = _range max _ammoRange;
    } forEach _magazines;
} forEach (_payload get "weapons");

_self call ["_setConfigCache", [_key, _range]];
_range
