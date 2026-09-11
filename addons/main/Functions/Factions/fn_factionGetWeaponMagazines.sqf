/* Uses CBA's magazine/well resolver and public disposable-launcher registry.
 * Loaded tubes inherit placeholder ammo; CBA actually issues the normal
 * launcher's first magazine. Spent/unsupported placeholders supply no role.
 */
params ["_weaponCfg"];
private _magazines = [_weaponCfg] call CBA_fnc_compatibleMagazines;
if !("CBA_FakeLauncherMagazine" in _magazines) exitWith { _magazines };
_magazines = _magazines - ["CBA_FakeLauncherMagazine"];
private _weaponClass = toLower configName _weaponCfg;
{
    private _variants = getArray _x;
    if (count _variants >= 1 && {(_variants select 0) isEqualType ""} && {toLower (_variants select 0) == _weaponClass}) exitWith {
        _magazines = ([configFile >> "CfgWeapons" >> configName _x] call CBA_fnc_compatibleMagazines) select [0, 1];
    };
} forEach configProperties [configFile >> "CBA_DisposableLaunchers", "isArray _x", true];
_magazines
