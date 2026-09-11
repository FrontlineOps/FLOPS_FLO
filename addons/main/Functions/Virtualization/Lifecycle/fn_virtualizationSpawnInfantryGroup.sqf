/*
 * Function: FLO_fnc_virtualizationSpawnInfantryGroup
 */

params ["_groupId", "_position", "_side", "_groupCfg", "_unitCount", "_unitPool", "_sideKey"];

private _realGroup = grpNull;
if (_unitCount <= 0 || {_unitCount != floor _unitCount}) then {
    throw format ["[VIRTUALIZATION] Invalid infantry spawn strength %1 for %2", _unitCount, _groupId];
};

private _selectedCfg = configNull;
if (_groupCfg isEqualType [] && {_groupCfg isNotEqualTo []}) then {
    _selectedCfg = selectRandom _groupCfg;
};
if (_groupCfg isEqualType configNull) then {
    _selectedCfg = _groupCfg;
};
if (isClass _selectedCfg) then {
    // Keep template roles/ranks, but never resurrect virtual casualties.
    _realGroup = [_position, _side, _selectedCfg, [], [], [], [], [_unitCount, 0]] call BIS_fnc_spawnGroup;
};

if (isNull _realGroup || {(units _realGroup) isEqualTo []}) then {
    if (!isNull _realGroup) then {
        deleteGroup _realGroup;
    };
    _realGroup = [_side, _groupId, "infantry"] call FLO_fnc_virtualizationCreateRealGroup;
};
if (isNull _realGroup) exitWith { grpNull };
_realGroup deleteGroupWhenEmpty true;

// Small templates and unconfigured groups still represent the exact strength.
if (count units _realGroup < _unitCount) then {
    [_unitPool, "units", _sideKey, "infantry"] call FLO_fnc_virtualizationRequirePoolEntries;
    private _spawnFailed = false;
    for "_i" from (count units _realGroup + 1) to _unitCount do {
        private _unitType = selectRandom _unitPool;
        private _spawnPos = [_position, 5, 20, 1, 0, 0.5, 0] call BIS_fnc_findSafePos;
        private _unit = _realGroup createUnit [_unitType, _spawnPos, [], 0, "NONE"];
        if (isNull _unit) exitWith {
            _spawnFailed = true;
        };
    };

    if (_spawnFailed) exitWith {
        { deleteVehicle _x; } forEach units _realGroup;
        deleteGroup _realGroup;
        _realGroup = grpNull;
    };
};

if (!isNull _realGroup && {(units _realGroup) isEqualTo []}) then {
    deleteGroup _realGroup;
    _realGroup = grpNull;
};

_realGroup
