/* Capability Analyzer's normalized ground power, based on current composition. */
params ["_analyzer", "_group"];
private _count = _group get "unitCount";
private _rifleman = _analyzer call ["_getConfigCost", ["B_Soldier_F"]];
private _power = _count;
private _armor = false;
private _antiArmor = false;
private _type = _group get "groupType";
private _composition = _group get "comp";
if ([_type] call FLO_fnc_virtualizationUsesAssetStrength) then {
    _power = 0;
    {
        _power = _power + ((_analyzer call ["_getConfigCost", [_x]]) / _rifleman);
        private _threat = _analyzer call ["_getConfigThreat", [_x]];
        _antiArmor = _antiArmor || {(_threat select 1) > 0.3};
    } forEach (_composition select [0, _count]);
    _armor = _type in ["armor", "mechanized"];
} else {
    {
        private _threat = _analyzer call ["_getConfigThreat", [_x]];
        _antiArmor = _antiArmor || {(_threat select 1) > 0.3};
    } forEach _composition;
};
createHashMapFromArray [["power", _power], ["hasArmor", _armor], ["antiArmor", _antiArmor], ["unitCount", _count]]
