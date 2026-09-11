/* Selects exact infantry strength from one auto faction, retaining native group
 * roles when a template exists and assigning explicit roles to missing slots.
 * Called when virtual personnel are created, so their equipment is represented
 * before activation and their chosen classes survive normal persistence.
 */
params ["_catalog", "_count", ["_groupCfg", configNull, [configNull, []]]];
if (_count < 0 || {_count != floor _count}) then { throw format ["[FACTIONS] Invalid infantry strength %1", _count]; };
if (_count == 0) exitWith { [] };

// A merged selection supplies separate source catalogs to keep each generated
// squad coherent. Explicit group configs already identify their source faction.
if ((_catalog get "source") == "auto_multi") exitWith {
    private _sources = _catalog get "infantrySources";
    private _selectedCfg = if (_groupCfg isEqualType [] && {_groupCfg isNotEqualTo []}) then {selectRandom _groupCfg} else {_groupCfg};
    private _eligible = if (_selectedCfg isEqualType configNull && {isClass _selectedCfg}) then {
        _sources select {_selectedCfg in (_x get "groundInfantryGroups")}
    } else { _sources };
    if (_eligible isEqualTo []) then { throw "[FACTIONS] Infantry template does not belong to merged faction sources"; };
    [selectRandom _eligible, _count, _selectedCfg] call FLO_fnc_factionBuildInfantryComposition
};

private _roles = _catalog get "infantryRoles";
private _units = _catalog get "groundInfantryUnits";
if (_units isEqualTo []) then { throw "[FACTIONS] Cannot generate infantry from an empty faction"; };
private _selectedCfg = if (_groupCfg isEqualType [] && {_groupCfg isNotEqualTo []}) then {selectRandom _groupCfg} else {_groupCfg};
private _composition = [];
if (_selectedCfg isEqualType configNull && {isClass _selectedCfg}) then {
    {
        private _class = getText (_x >> "vehicle");
        _class = configName (configFile >> "CfgVehicles" >> _class);
        if !(_class in _units) then { throw format ["[FACTIONS] Infantry template contains ineligible class %1", _class]; };
        _composition pushBack _class;
    } forEach ("true" configClasses _selectedCfg);
    _composition resize (_count min count _composition);
};

private _ordinary = _roles get "rifleman";
if (_ordinary isEqualTo []) then {
    // A sparse faction may consist entirely of specialists. Use its own eligible
    // infantry explicitly, without claiming those replacements supply a role.
    _ordinary = _units;
};
private _neededRoles = ["leader", "mg", "at", "medic", "grenadier", "marksman"] select {
    private _rolePool = _roles get _x;
    _rolePool isNotEqualTo [] && {(_composition findIf {_x in _rolePool}) < 0}
};
private _remaining = _count - count _composition;
for "_i" from 0 to (_remaining - 1) do {
    private _role = if (_i < count _neededRoles) then {_neededRoles select _i} else {"rifleman"};
    private _candidates = _roles get _role;
    if (_candidates isEqualTo []) then { _candidates = _ordinary; };
    _composition pushBack selectRandom _candidates;
};
_composition
