/* Restores current FOB/COP records before MissionStartup claims their terminals. */
params ["_records", "_kind"];
if !(_kind in ["FOB", "COP"]) then { throw format ["[BASE] Unsupported restore kind %1", _kind] };
private _markerKey = ["fobMarkerName", "opMarkerName"] select (_kind == "COP");
private _restoredKey = ["FLO_FOB_MarkersRestored", "FLO_OP_MarkersRestored"] select (_kind == "COP");
private _requiredBaseRecordTypes = [
    ["buildingType", ""],
    ["buildingPosASL", []],
    ["buildingDir", 0],
    ["buildingVectorUp", []],
    ["markerName", ""],
    ["baseSideKey", ""],
    ["baseSaveId", ""],
    ["logisticsNodeId", ""]
];
private _containerRecordTypes = [
    ["containerType", ""],
    ["containerPosASL", []],
    ["containerDir", 0],
    ["containerVectorUp", []]
];
{
    private _record = _x;
    private _recordIndex = _forEachIndex;
    if !(_record isEqualType createHashMap) then {
        throw format ["Saved base %1 has invalid record type %2", _recordIndex, typeName _record];
    };
    {
        _x params ["_field", "_prototype"];
        if !(_field in _record) then {
            throw format ["Saved base %1 is missing required field %2", _recordIndex, _field];
        };
        private _value = _record get _field;
        if !(_value isEqualType _prototype) then {
            throw format ["Saved base %1 field %2 has invalid type %3", _recordIndex, _field, typeName _value];
        };
    } forEach _requiredBaseRecordTypes;
    private _containerFieldCount = {_x # 0 in _record} count _containerRecordTypes;
    if !(_containerFieldCount in [0, count _containerRecordTypes]) then {
        throw format ["Saved base %1 has an incomplete container record", _recordIndex];
    };
    if (_containerFieldCount > 0) then {
        {
            _x params ["_field", "_prototype"];
            private _value = _record get _field;
            if !(_value isEqualType _prototype) then {
                throw format ["Saved base %1 field %2 has invalid type %3", _recordIndex, _field, typeName _value];
            };
        } forEach _containerRecordTypes;
    };
    private _buildingType = _record get "buildingType";
    private _buildingPos = _record get "buildingPosASL";
    private _baseSideKey = _record get "baseSideKey";
    private _baseSaveId = _record get "baseSaveId";
    private _logisticsNodeId = _record get "logisticsNodeId";
    if (
        _buildingType == ""
        || {!isClass (configFile >> "CfgVehicles" >> _buildingType)}
        || {(count _buildingPos) < 2}
        || {!(_baseSideKey in ["EAST", "WEST"])}
        || {_baseSaveId == ""}
        || {_logisticsNodeId == ""}
    ) then {
        throw format ["Saved base %1 has invalid required values", _recordIndex];
    };

    private _building = createVehicle [_buildingType, [0,0,0], [], 0, "CAN_COLLIDE"];
    if (isNull _building) then {
        throw format ["Failed to restore saved base %1 of type %2", _recordIndex, _buildingType];
    };
    _building setPosASL _buildingPos;
    _building setDir (_record get "buildingDir");
    _building setVectorUp (_record get "buildingVectorUp");
    _building setVariable ["FLO_BaseSide", [_baseSideKey] call FLO_fnc_campaignSideFromKey, true];
    _building setVariable ["FLO_BaseType", _kind, true];
    _building setVariable ["FLO_BaseSaveId", _baseSaveId, true];
    _building setVariable ["FLO_LogisticsNodeId", _logisticsNodeId, true];

    private _markerName = _record get "markerName";
    if (_markerName != "") then {
        _building setVariable [_markerKey, _markerName, true];
        _building setVariable [_restoredKey, true, true];
    };

    if (_containerFieldCount > 0) then {
        private _containerType = _record get "containerType";
        if (_containerType == "" || {!isClass (configFile >> "CfgVehicles" >> _containerType)}) then {
            throw format ["Saved base %1 has invalid container type %2", _recordIndex, _containerType];
        };
        private _container = createVehicle [_containerType, [0,0,0], [], 0, "CAN_COLLIDE"];
        if (isNull _container) then {
            throw format ["Failed to restore saved base %1 container type %2", _recordIndex, _containerType];
        };
        _container setPosASL (_record get "containerPosASL");
        _container setDir (_record get "containerDir");
        _container setVectorUp (_record get "containerVectorUp");
    };
} forEach _records;
["INIT", 3, format ["Restored %1 %2 bases from current save", count _records, _kind]] call FLO_fnc_log;
count _records
