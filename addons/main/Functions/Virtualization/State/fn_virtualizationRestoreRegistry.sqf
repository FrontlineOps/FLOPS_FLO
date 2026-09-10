/*
 * Function: FLO_fnc_virtualizationRestoreRegistry
 * Description:
 *   Restores all groups under their exact saved IDs before applying any state
 *   containing cross-group references.
 */

params [["_savedGroups", createHashMap, [createHashMap]]];

private _groups = call FLO_fnc_virtualizationGetGroupMap;
if ((keys _groups) isNotEqualTo []) then {
    throw "Virtual-force restore requires an empty registry";
};

private _validatedGroups = createHashMap;
{
    private _groupId = _x;
    private _savedData = [_y] call FLO_fnc_virtualizationCloneValue;
    try {
        [_savedData, _groupId] call FLO_fnc_virtualizationValidateSavedGroup;
    } catch {
        ["VIRTUALIZATION", 1, format ["Rejected saved virtual group=%1 reason=%2", _groupId, _exception]] call FLO_fnc_log;
        throw format ["Virtual-force restore rejected group %1: %2", _groupId, _exception];
    };
    _validatedGroups set [_groupId, _savedData];
} forEach _savedGroups;

// Establish ownership before deciding which records own LAND movement.
try {
    [_validatedGroups] call FLO_fnc_virtualizationNormalizeSavedTransport;
} catch {
    ["VIRTUALIZATION", 1, format ["Rejected saved transport graph: %1", _exception]] call FLO_fnc_log;
    throw _exception;
};
{
    private _groupId = _x;
    private _savedData = _y;
    try {
        private _archetype = [_savedData get "groupType"] call FLO_fnc_virtualizationGetArchetype;
        if ((_archetype get "movementDomain") == "LAND") then {
            private _routeStartPos = [_savedData, _groupId] call FLO_fnc_virtualizationResolveSavedLandStart;
            private _routeValidation = [
                _groupId,
                _routeStartPos,
                _savedData get "waypoints",
                _savedData get "currentWaypointIndex",
                _savedData get "autoPatrol",
                _savedData get "patrolConfig"
            ] call FLO_fnc_virtualizationValidateLandRoute;
            if !(_routeValidation select 0) then {
                private _normalized = [
                    _savedData,
                    _groupId,
                    _routeValidation select 1,
                    _routeStartPos
                ] call FLO_fnc_virtualizationNormalizeSavedLandRoute;
                if (!_normalized) then {
                    throw format ["Unsafe saved LAND route: %1", _routeValidation select 1];
                };
            };
        };
    } catch {
        ["VIRTUALIZATION", 1, format [
            "Rejected current virtual-group record group=%1 reason=%2",
            _groupId,
            _exception
        ]] call FLO_fnc_log;
        throw format ["Virtual-force restore rejected group %1: %2", _groupId, _exception];
    };
} forEach _validatedGroups;

private _builtGroups = createHashMap;
{
    private _groupId = _x;
    private _savedData = _y;
    private _assetStrength = ([_savedData get "groupType"] call FLO_fnc_virtualizationGetArchetype) get "assetStrength";
    // A saved asset selection is authoritative, including transport-only catalogs.
    // Personnel compositions may retain pre-casualty slots in supported saves.
    private _selectedComposition = if (_assetStrength) then { _savedData get "comp" } else { [] };
    private _groupData = [
        _savedData get "position",
        _savedData get "groupType",
        configNull,
        _savedData get "homeObjective",
        _savedData get "unitCount",
        _savedData get "side",
        _savedData get "spawnClass",
        _groupId,
        _selectedComposition,
        _savedData get "transportRole"
    ] call FLO_fnc_virtualizationBuildGroupData;

    _builtGroups set [_groupId, _groupData];
} forEach _validatedGroups;

{
    [_x, _y, false] call FLO_fnc_virtualizationAddGroup;
} forEach _builtGroups;

{
    [_x, _y] call FLO_fnc_virtualizationRestoreSavedGroup;
} forEach _validatedGroups;

// Reject malformed cross-record state before derived-state reconciliation.
call FLO_fnc_virtualizationValidateRegistry;
call FLO_fnc_virtualizationRebuildDerivedState;
call FLO_fnc_virtualizationValidateRegistry;

["VIRTUALIZATION", 3, format ["Restored virtual-force registry groups=%1", count _validatedGroups]] call FLO_fnc_log;
count _validatedGroups
