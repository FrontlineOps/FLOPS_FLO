/* Captures one initialized base inside the campaign snapshot boundary. */
params ["_building", "_markerKey"];
private _marker = _building getVariable [_markerKey, ""];
private _baseSide = _building getVariable "FLO_BaseSide";
private _baseSaveId = _building getVariable "FLO_BaseSaveId";
private _logisticsNodeId = _building getVariable "FLO_LogisticsNodeId";
if (
    !(_baseSide in [east, west])
    || {!(_baseSaveId isEqualType "" && {_baseSaveId != ""})}
    || {!(_logisticsNodeId isEqualType "" && {_logisticsNodeId != ""})}
) then {
    throw format ["Base at %1 has invalid save identity", getPosASL _building];
};

private _nearContainer = _building getVariable "FLO_BaseTerminal";
if (isNil "_nearContainer" || {!(_nearContainer isEqualType objNull)}) then {
    throw format ["Base %1 has no initialized terminal ownership", _baseSaveId];
};
if (!isNull _nearContainer && {(_nearContainer getVariable ["FLO_BaseOwner", objNull]) isNotEqualTo _building}) then {
    throw format ["Base %1 terminal ownership is not reciprocal", _baseSaveId];
};

// Current building identity and reciprocal terminal ownership.
private _record = createHashMapFromArray [
    ["buildingType", typeOf _building],
    ["buildingPosASL", getPosASL _building],
    ["buildingDir", getDir _building],
    ["buildingVectorUp", vectorUp _building],
    ["markerName", _marker],
    ["baseSideKey", [_baseSide] call FLO_fnc_sideKey],
    ["baseSaveId", _baseSaveId],
    ["logisticsNodeId", _logisticsNodeId]
];

// Add container data if found
if (!isNull _nearContainer) then {
    _record set ["containerType", typeOf _nearContainer];
    _record set ["containerPosASL", getPosASL _nearContainer];
    _record set ["containerDir", getDir _nearContainer];
    _record set ["containerVectorUp", vectorUp _nearContainer];
};


_record
