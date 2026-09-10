/*
 * Function: FLO_fnc_virtualizationValidateRegistry
 * Description:
 *   Validates cross-record ownership and transport relationships.
 */

private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _orphanedActiveGroups = [];
{
    if ((_y get "isActive") && {isNull (_y get "realGroup")}) then {
        _orphanedActiveGroups pushBack _x;
    };
} forEach _groups;

if (_orphanedActiveGroups isNotEqualTo []) then {
    ["VIRTUALIZATION", 2, format [
        "Repairing %1 orphaned active group(s) before registry validation: %2",
        count _orphanedActiveGroups,
        _orphanedActiveGroups
    ]] call FLO_fnc_log;

    {
        [_x] call FLO_fnc_virtualizationRepairOrphanedActiveGroup;
    } forEach _orphanedActiveGroups;

    _groups = call FLO_fnc_virtualizationGetGroupMap;
};

private _realGroups = createHashMap;
private _spatial = call FLO_fnc_virtualizationGetSpatialState;
private _spatialGrid = _spatial get "grid";
private _spatialGridBySide = _spatial get "gridBySide";
private _spatialMeta = _spatial get "groupMeta";

if ((count _spatialMeta) != (count _groups)) then {
    throw format [
        "Virtual registry/spatial count mismatch: groups=%1 metadata=%2",
        count _groups,
        count _spatialMeta
    ];
};

{
    private _groupId = _x;
    private _groupData = _y;
    [_groupData, _groupId] call FLO_fnc_virtualizationValidateGroup;

    if (_groupData get "isActive") then {
        private _realGroupKey = str (_groupData get "realGroup");
        if (_realGroupKey in _realGroups) then {
            throw format [
                "Virtual groups %1 and %2 share real group %3",
                _realGroups get _realGroupKey,
                _groupId,
                _realGroupKey
            ];
        };
        _realGroups set [_realGroupKey, _groupId];
    };

    private _meta = _spatialMeta get _groupId;
    if (isNil "_meta") then {
        throw format ["Virtual group %1 is missing spatial metadata", _groupId];
    };
    private _expectedCellKey = [_groupData get "position"] call FLO_fnc_virtualizationSpatialGetCellKey;
    private _expectedSideKey = [_groupData get "side"] call FLO_fnc_virtualizationSpatialGetSideKey;
    if (_meta isNotEqualTo [_expectedCellKey, _expectedSideKey]) then {
        throw format [
            "Virtual group %1 spatial metadata mismatch: actual=%2 expected=%3",
            _groupId,
            _meta,
            [_expectedCellKey, _expectedSideKey]
        ];
    };

    private _cell = _spatialGrid get _expectedCellKey;
    if (isNil "_cell" || {!(_groupId in _cell)}) then {
        throw format ["Virtual group %1 is absent from spatial cell %2", _groupId, _expectedCellKey];
    };
    private _sideGrid = _spatialGridBySide get _expectedSideKey;
    private _sideCell = _sideGrid get _expectedCellKey;
    if (isNil "_sideCell" || {!(_groupId in _sideCell)}) then {
        throw format [
            "Virtual group %1 is absent from %2 spatial cell %3",
            _groupId,
            _expectedSideKey,
            _expectedCellKey
        ];
    };
} forEach _groups;

[_groups] call FLO_fnc_virtualizationValidateTransportGraph;

true
