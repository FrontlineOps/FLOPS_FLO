/* Reads configured payload, including inherited/nested turrets and default
 * pylons. Operational combat ratings remain owned by Capability Analyzer.
 */
params ["_className"];
private _cfg = configFile >> "CfgVehicles" >> _className;
private _analyzer = call FLO_fnc_gtnCapabilityAnalyzer;
private _weapons = _analyzer call ["_getVehicleWeapons", [_className]];
private _magazines = getArray (_cfg >> "magazines");
private _turrets = configProperties [_cfg >> "Turrets", "isClass _x", true];
while {_turrets isNotEqualTo []} do {
    private _turret = _turrets deleteAt (count _turrets - 1);
    _magazines append getArray (_turret >> "magazines");
    _turrets append configProperties [_turret >> "Turrets", "isClass _x", true];
};
{
    private _magazine = getText (_x >> "attachment");
    if (_magazine != "") then { _magazines pushBackUnique _magazine; };
} forEach configProperties [_cfg >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x", true];

private _armed = false;
private _aa = false;
private _tankCannon = false;
{
    // Engine radar placeholders carry a synthetic FakeWeapon magazine.
    if (toLower _x == "fakeweapon") then { continue };
    private _ammo = configFile >> "CfgAmmo" >> getText (configFile >> "CfgMagazines" >> _x >> "ammo");
    private _simulation = toLower getText (_ammo >> "simulation");
    if (_simulation in ["shotbullet", "shotshell", "shotrocket", "shotmissile", "shotbomb", "shotgrenade"] && {getNumber (_ammo >> "hit") > 0 || {getNumber (_ammo >> "indirectHit") > 0}}) then {
        _armed = true;
        if (_simulation == "shotshell" && {getNumber (_ammo >> "caliber") >= 20}) then { _tankCannon = true; };
        if ([_ammo] call FLO_fnc_factionAmmoIsAntiAir) then { _aa = true; };
    };
} forEach (_magazines arrayIntersect _magazines);
// Weapon-only configs occur in older mods. Laser designators, horns and
// countermeasure launchers do not imply a combat payload.
if (!_armed && {_magazines isEqualTo []}) then {
    {
        if (toLower _x == "fakeweapon") then { continue };
        private _weaponCfg = configFile >> "CfgWeapons" >> _x;
        {
            private _ammo = configFile >> "CfgAmmo" >> getText (configFile >> "CfgMagazines" >> _x >> "ammo");
            if (toLower getText (_ammo >> "simulation") in ["shotbullet", "shotshell", "shotrocket", "shotmissile", "shotbomb"] && {getNumber (_ammo >> "hit") > 0}) then {
                _armed = true;
                if ([_ammo] call FLO_fnc_factionAmmoIsAntiAir) then { _aa = true; };
            };
        } forEach ([_weaponCfg] call FLO_fnc_factionGetWeaponMagazines);
    } forEach _weapons;
};
createHashMapFromArray [["armed", _armed], ["antiAir", _aa], ["tankCannon", _tankCannon]]
