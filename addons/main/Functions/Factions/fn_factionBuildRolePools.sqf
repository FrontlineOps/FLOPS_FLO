/* Builds ordered role pools once at faction creation. Missing roles stay empty. */
params ["_units"];
private _ranked = createHashMap;
{
    _ranked set [_x, []];
} forEach ["rifleman", "officer", "leader", "grenadier", "mg", "at", "aa", "medic", "engineer", "eod", "marksman", "sniper", "ammo", "uav", "crew", "pilot", "diver", "recon"];
{
    private _unit = _x;
    {
        (_ranked get _x) pushBack [-_y, toLower _unit, _unit];
    } forEach ([_unit] call FLO_fnc_factionClassifyUnit);
} forEach (_units arrayIntersect _units);
private _pools = createHashMap;
{
    _y sort true;
    _pools set [_x, _y apply { _x select 2 }];
} forEach _ranked;
_pools
