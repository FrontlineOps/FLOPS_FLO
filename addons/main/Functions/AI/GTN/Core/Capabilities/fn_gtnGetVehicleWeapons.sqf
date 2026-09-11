#pragma hemtt ignore_variables ["_self"]
/* _getVehicleWeapons implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
params ["_typeClass"];

private _cacheKey = format["vehWeapons_%1", _typeClass];
private _cached = _self call ["_getConfigCached", [_cacheKey]];
if (!isNil "_cached") exitWith { _cached };

private _weapons = [];
private _cfg = configFile >> "CfgVehicles" >> _typeClass;

if (!isClass _cfg) exitWith {
    _self call ["_setConfigCache", [_cacheKey, []]];
    []
};

// Get main weapons
private _mainWeapons = getArray (_cfg >> "weapons");
_weapons append _mainWeapons;

private _turrets = configProperties [_cfg >> "Turrets", "isClass _x"];
{
    _weapons append ([_x] call FLO_fnc_gtnCollectTurretWeapons);
} forEach _turrets;

// Remove empty and horn entries
_weapons = _weapons select {_x != "" && {(_x find "Horn") < 0}};

_self call ["_setConfigCache", [_cacheKey, _weapons]];
_weapons
