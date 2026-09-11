/*
 * Function: FLO_fnc_virtualizationBuildGroupData
 */

params [
    ["_position", [0,0,0], [[]]],
    ["_groupType", "infantry", [""]],
    ["_groupCfg", configNull, [configNull, []]],
    ["_homeObjective", "", [""]],
    ["_unitCount", -1, [0]],
    ["_side", east, [east]],
    ["_spawnClass", "", [""]],
    ["_groupId", "", [""]],
    ["_selectedComposition", [], [[]]],
    ["_transportRole", false, [false]]
];

if (_groupId == "") then {
    throw "FLO_fnc_virtualizationBuildGroupData: empty group id";
};

_position = [_position] call FLO_fnc_virtualizationNormalizePosition;
private _archetype = [_groupType] call FLO_fnc_virtualizationGetArchetype;

if (_transportRole && {_selectedComposition isEqualTo []}) then {
    throw format ["Transport group %1 requires its selected carrier composition", _groupId];
};
if (_selectedComposition isNotEqualTo []) then {
    if !((_archetype get "compositionPreemptsSpawn") || {_archetype get "initialGroundComposition"}) then {
        throw format ["Archetype %1 does not support selected composition for %2", _groupType, _groupId];
    };
    {
        if !(_x isEqualType "" && {isClass (configFile >> "CfgVehicles" >> _x)}) then {
            throw format ["Invalid selected composition class %1 for %2", _x, _groupId];
        };
        if (_transportRole && {([_x] call FLO_fnc_transportGetCapacity) <= 0}) then {
            throw format ["Selected carrier %1 for %2 has no passenger capacity", _x, _groupId];
        };
    } forEach _selectedComposition;
};

private _resolvedUnitCount = _unitCount;
if (_selectedComposition isNotEqualTo []) then {
    if (_resolvedUnitCount >= 0 && {_resolvedUnitCount != count _selectedComposition}) then {
        throw format ["Selected composition/count mismatch for %1: %2 classes, count %3", _groupId, count _selectedComposition, _resolvedUnitCount];
    };
    _resolvedUnitCount = count _selectedComposition;
};
if (_resolvedUnitCount < 0) then {
    switch (_archetype get "countMode") do {
        case "RANDOM_CIV": { _resolvedUnitCount = 1 + floor random 3; };
        case "FIXED_ONE": { _resolvedUnitCount = 1; };
        case "FACTION": { _resolvedUnitCount = [_groupType, _side] call FLO_fnc_getGroupTypeCount; };
        default {
            throw format ["Unsupported count mode for virtual-group archetype %1", _groupType];
        };
    };
};

private _groupData = call FLO_fnc_virtualizationCreateGroupRecordDefaults;
_groupData set ["id", _groupId];
_groupData set ["position", +_position];
_groupData set ["spawnPosition", +_position];
_groupData set ["groupType", _groupType];
_groupData set ["groupCfg", _groupCfg];
_groupData set ["spawnClass", _spawnClass];
_groupData set ["homeObjective", _homeObjective];
_groupData set ["unitCount", _resolvedUnitCount];
_groupData set ["side", _side];
_groupData set ["transportRole", _transportRole];
_groupData set ["garrisonPosition", +_position];
_groupData set ["civilianObjective", _homeObjective];
_groupData set ["civilianAnchorPos", +_position];
_groupData set ["civilianHomeAnchorPos", +_position];
_groupData set ["civilianRoutineAnchorPos", +_position];

private _initialAssetComposition = if (_selectedComposition isNotEqualTo []) then {
    +_selectedComposition
} else {
    [_groupType, _resolvedUnitCount, _side] call FLO_fnc_virtualizationSelectInitialAssetComposition
};
if (_groupType == "infantry" && {_initialAssetComposition isEqualTo []}) then {
    private _catalog = FLO_FactionCatalog get ([_side] call FLO_fnc_sideKey);
    // Auto catalogs opt into config-derived roles; custom definitions keep their
    // authored spawning contract. An explicit caller composition always wins.
    if ("infantryRoles" in _catalog) then {
        if (_groupCfg isEqualType [] && {_groupCfg isNotEqualTo []}) then {
            _groupCfg = selectRandom _groupCfg;
            _groupData set ["groupCfg", _groupCfg];
        };
        _initialAssetComposition = [_catalog, _resolvedUnitCount, _groupCfg] call FLO_fnc_factionBuildInfantryComposition;
    };
};
if (_initialAssetComposition isNotEqualTo []) then {
    [_groupData, _initialAssetComposition] call FLO_fnc_virtualizationSetAssetComposition;
};

_groupData
