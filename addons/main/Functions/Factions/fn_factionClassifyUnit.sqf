/* Scores infantry roles from config traits and issued weapons. Names only supply
 * weaker hints; they cannot turn an AA launcher or an assistant into an AT gunner.
 * Empty scores mean an unavailable role, not permission to select any soldier.
 */
params [["_unitClass", "", [""]]];

private _scores = createHashMap;
private _cfg = configFile >> "CfgVehicles" >> _unitClass;
if !(isClass _cfg && {_unitClass isKindOf "CAManBase"} && {getNumber (_cfg >> "scope") == 2}) exitWith { _scores };

private _role = toLower getText (_cfg >> "role");
private _tokens = (toLower format ["%1 %2 %3 %4", _unitClass, getText (_cfg >> "displayName"), getText (_cfg >> "vehicleClass"), getText (_cfg >> "editorSubcategory")]) splitString " _-/().,[]";
{
    _x params ["_key", "_roles", "_hints"];
    if (_role in _roles) then {
        _scores set [_key, 100];
    } else {
        if ((_tokens arrayIntersect _hints) isNotEqualTo []) then { _scores set [_key, 40]; };
    };
} forEach [
    ["officer", ["officer"], ["officer", "commander"]],
    ["leader", ["squadleader", "teamleader"], ["sl", "tl", "leader", "squadleader", "teamleader", "sergeant"]],
    ["rifleman", ["rifleman"], ["rifleman"]],
    ["grenadier", ["grenadier"], ["grenadier", "gl"]],
    ["mg", ["machinegunner"], ["autorifleman", "machinegunner", "mg", "ar"]],
    ["medic", ["combatlifesaver", "medic"], ["medic", "corpsman"]],
    ["engineer", ["engineer"], ["engineer", "repair"]],
    ["eod", ["sapper", "explosivespecialist"], ["exp", "explosive", "explosives", "demo", "sapper", "eod"]],
    ["marksman", ["marksman"], ["marksman", "sharpshooter", "designatedmarksman"]],
    ["sniper", ["sniper"], ["sniper"]],
    ["ammo", ["assistant"], ["ammo", "assistant", "aar", "aat", "aaa", "asst", "asstmg", "asstat"]],
    ["uav", ["uavoperator"], ["uav", "drone"]],
    ["crew", ["crewman"], ["crew", "crewman"]],
    ["pilot", ["pilot", "helicopterpilot"], ["pilot", "helipilot", "helicrew"]],
    ["diver", ["diver"], ["diver", "divers"]],
    ["recon", [], ["recon", "reconnaissance", "sf", "specops", "specialforces"]]
];
if (getNumber (_cfg >> "attendant") > 0) then { _scores set ["medic", 120]; };
if (getNumber (_cfg >> "engineer") > 0) then { _scores set ["engineer", 120]; };
if (getNumber (_cfg >> "canDeactivateMines") > 0) then { _scores set ["eod", 120]; };
if (getNumber (_cfg >> "uavHacker") > 0) then { _scores set ["uav", 120]; };

private _hasPrimary = false;
private _hasMachineGun = false;
private _hasAT = false;
private _hasAA = false;
private _issuedMagazines = getArray (_cfg >> "magazines");
private _backpack = configFile >> "CfgVehicles" >> getText (_cfg >> "backpack");
{
    if (getNumber (_x >> "count") > 0) then { _issuedMagazines pushBack getText (_x >> "magazine"); };
} forEach configProperties [_backpack >> "TransportMagazines", "isClass _x", true];
_issuedMagazines = _issuedMagazines apply {toLower _x};
{
    private _weaponCfg = configFile >> "CfgWeapons" >> _x;
    private _type = getNumber (_weaponCfg >> "type");
    if (_type == 1) then {
        _hasPrimary = true;
        if (toLower getText (_weaponCfg >> "cursor") == "mg") then { _scores set ["mg", 120]; _hasMachineGun = true; };
        {
            if (toLower _x != "this") then {
                private _mags = [_weaponCfg >> _x] call FLO_fnc_factionGetWeaponMagazines;
                if ((_mags findIf {
                    private _ammo = configFile >> "CfgAmmo" >> getText (configFile >> "CfgMagazines" >> _x >> "ammo");
                    toLower getText (_ammo >> "simulation") in ["shotshell", "shotgrenade"] && {getNumber (_ammo >> "indirectHit") > 0}
                }) >= 0) then { _scores set ["grenadier", 120]; };
            };
        } forEach getArray (_weaponCfg >> "muzzles");
    };
    if (_type == 4) then {
        private _magazines = [_weaponCfg] call FLO_fnc_factionGetWeaponMagazines;
        // Magazine wells describe possible rearming, not the unit's loadout.
        // CBA disposable tubes carry their resolved magazine inside the weapon.
        if !("CBA_FakeLauncherMagazine" in getArray (_weaponCfg >> "magazines")) then {
            _magazines = _magazines select {toLower _x in _issuedMagazines};
        };
        {
            private _ammo = configFile >> "CfgAmmo" >> getText (configFile >> "CfgMagazines" >> _x >> "ammo");
            private _aaHint = (_tokens arrayIntersect ["aa", "antiair", "stinger", "igla", "strela"]) isNotEqualTo [];
            if ([_ammo] call FLO_fnc_factionAmmoIsAntiAir || {_aaHint && {getNumber (_ammo >> "airLock") > 0}}) then {
                _hasAA = true;
            } else {
                if (getNumber (_ammo >> "hit") > 0 && {toLower getText (_ammo >> "simulation") in ["shotrocket", "shotmissile", "shotshell"]}) then {
                    _hasAT = true;
                };
            };
        } forEach _magazines;
    };
} forEach getArray (_cfg >> "weapons");
if (_hasAA) then { _scores set ["aa", 120]; };
if (_hasAT) then { _scores set ["at", 120]; };
if ("ammo" in _scores && {!_hasMachineGun}) then { _scores deleteAt "mg"; };
if (_hasPrimary && {count _scores == 0}) then { _scores set ["rifleman", 20]; };
// Inherited Rifleman role is common on mod specialists. Do not give those units
// every ordinary rifle slot just because their parent omitted a role override.
if (count _scores > 1) then { _scores deleteAt "rifleman"; };
_scores
