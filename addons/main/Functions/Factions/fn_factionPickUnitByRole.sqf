/* Returns the strongest config-backed role match, or empty text when absent. */
params [["_units", [], [[]]], ["_role", "rifleman", [""]]];
private _pools = [_units] call FLO_fnc_factionBuildRolePools;
_role = toLower _role;
if !(_role in _pools) then { throw format ["[FACTIONS] Unsupported infantry role %1", _role]; };
private _matches = _pools get _role;
if (_matches isEqualTo []) exitWith { "" };
_matches select 0
