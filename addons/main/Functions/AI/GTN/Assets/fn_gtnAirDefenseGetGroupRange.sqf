/* Group composition owns which configured weapons can participate. */
params ["_groupData"];
if ((_groupData get "groupType") == "static_aa") then {
    [_groupData] call FLO_fnc_virtualizationResolveStaticAAComposition;
};
private _analyzer = call FLO_fnc_gtnCapabilityAnalyzer;
private _range = 0;
if (_groupData get "isActive") exitWith {
    private _vehicles = [_groupData, _groupData get "realGroup"] call FLO_fnc_virtualizationGetRealAssetVehicles;
    {
        if (!canFire _x) then {continue};
        private _magazines = (magazinesAllTurrets _x) select {(_x select 2) > 0};
        _range = _range max (_analyzer call ["_getAirDefenseRange", [typeOf _x, _magazines apply {_x select 0}]]);
    } forEach _vehicles;
    _range
};
{
    _range = _range max (_analyzer call ["_getAirDefenseRange", [_x]]);
} forEach (_groupData get "comp");
_range
