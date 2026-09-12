/* Resolve the battery's deferred weapon selection once, before range queries or spawning. */
params ["_groupData"];
if ((_groupData get "comp") isNotEqualTo [] || {(_groupData get "unitCount") <= 0}) exitWith {};

private _pools = [_groupData get "side"] call FLO_fnc_virtualizationGetSpawnPools;
private _pool = _pools get "staticAA";
[_pool, "staticAA", _pools get "sideKey", "static_aa"] call FLO_fnc_virtualizationRequirePoolEntries;
private _composition = [];
for "_i" from 1 to (_groupData get "unitCount") do {
    _composition pushBack (selectRandom _pool);
};
[_groupData, _composition] call FLO_fnc_virtualizationSetAssetComposition;
private _radars = (_pools get "radar") select {
    !(_x isKindOf "Air") && {!(_x isKindOf "Ship")}
    && {(_x isKindOf "LandVehicle") || {_x isKindOf "StaticWeapon"}}
};
if (_radars isNotEqualTo []) then {
    _groupData set ["supportComp", [selectRandom _radars]];
};
