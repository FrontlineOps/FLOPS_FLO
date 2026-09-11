/* Current campaign restoration; called in Phase 5 ownership order. */
params ["_savedData"];

// Restore supply crates
private _crateHash = _savedData get "crates";
private _requiredCrateTypes = [
    ["type", ""], ["posASL", []], ["vectorDirAndUp", []],
    ["items", []], ["damage", 0], ["locked", 0]
];
private _shipmentRecordTypes = [
    ["logisticsShipment", true], ["logisticsDelivered", true],
    ["logisticsSideKey", ""], ["logisticsOriginNodeId", ""],
    ["logisticsThroughput", 0], ["logisticsContributorUID", ""],
    ["logisticsContributorName", ""], ["developmentTargetObjectiveId", ""]
];
private _loadedCrates = 0;
{
    private _crateId = _x;
    private _attr = _crateHash get _crateId;
    if !(_crateId isEqualType "" && {_crateId != ""}) then {
        throw format ["Current save has invalid crate key %1", _crateId];
    };
    if !(_attr isEqualType createHashMap) then {
        throw format ["Saved crate %1 has invalid record type %2", _crateId, typeName _attr];
    };
    {
        _x params ["_field", "_prototype"];
        if !(_field in _attr) then {
            throw format ["Saved crate %1 is missing required field %2", _crateId, _field];
        };
        private _value = _attr get _field;
        if !(_value isEqualType _prototype) then {
            throw format ["Saved crate %1 field %2 has invalid type %3", _crateId, _field, typeName _value];
        };
    } forEach _requiredCrateTypes;
    private _shipmentFieldCount = {_x # 0 in _attr} count _shipmentRecordTypes;
    if !(_shipmentFieldCount in [0, count _shipmentRecordTypes]) then {
        throw format ["Saved crate %1 has an incomplete logistics-shipment record", _crateId];
    };
    if (_shipmentFieldCount > 0) then {
        {
            _x params ["_field", "_prototype"];
            private _value = _attr get _field;
            if !(_value isEqualType _prototype) then {
                throw format ["Saved shipment %1 field %2 has invalid type %3", _crateId, _field, typeName _value];
            };
        } forEach _shipmentRecordTypes;
        if !(_attr get "logisticsShipment") then {
            throw format ["Saved crate %1 has a false logistics-shipment discriminator", _crateId];
        };
        if !((_attr get "logisticsSideKey") in ["EAST", "WEST"]) then {
            throw format ["Saved shipment %1 has invalid side key", _crateId];
        };
        if ((_attr get "logisticsOriginNodeId") == "" || {(_attr get "logisticsThroughput") <= 0}) then {
            throw format ["Saved logistics shipment %1 has invalid origin or throughput", _crateId];
        };
    };
    private _type = _attr get "type";
    private _pos = _attr get "posASL";
    private _vectorDirAndUp = _attr get "vectorDirAndUp";
    if (
        _type == ""
        || {!isClass (configFile >> "CfgVehicles" >> _type)}
        || {(count _pos) < 2}
        || {count _vectorDirAndUp != 2}
        || {{!(_x isEqualType []) || {count _x != 3}} count _vectorDirAndUp > 0}
    ) then {
        throw format ["Saved crate %1 has invalid spatial or class state", _crateId];
    };
    private _items = _attr get "items";
    {
        if !(
            _x isEqualType []
            && {count _x == 3}
            && {(_x # 0) isEqualType ""}
            && {(_x # 1) isEqualType 0}
            && {(_x # 1) > 0}
            && {(_x # 2) in ["weapon", "magazine", "item", "backpack"]}
        ) then {
            throw format ["Saved crate %1 has malformed cargo record %2", _crateId, _x];
        };
    } forEach _items;

    private _crate = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
    if (isNull _crate) then {
        throw format ["Failed to restore saved crate %1 of type %2", _crateId, _type];
    };
    [_crate, false, [[], [], [], []]] call BIS_fnc_initAmmoBox;
    _crate setVectorDirAndUp _vectorDirAndUp;
    _crate setPosASL _pos;
    _crate setDamage (_attr get "damage");
    _crate lock (_attr get "locked");
    _crate setVariable ["FLO_save_crate", true, true];
    _crate setVariable ["FLO_SaveID", _crateId, true];
    if (_shipmentFieldCount > 0) then {
        private _shipmentSideKey = _attr get "logisticsSideKey";
        _crate setVariable ["FLO_LogisticsShipment", true, true];
        _crate setVariable ["FLO_LogisticsDelivered", _attr get "logisticsDelivered", true];
        _crate setVariable ["FLO_LogisticsSide", [_shipmentSideKey] call FLO_fnc_campaignSideFromKey, true];
        _crate setVariable ["FLO_LogisticsOriginNodeId", _attr get "logisticsOriginNodeId", true];
        _crate setVariable ["FLO_LogisticsThroughput", _attr get "logisticsThroughput", true];
        _crate setVariable ["FLO_LogisticsContributorUID", _attr get "logisticsContributorUID", true];
        _crate setVariable ["FLO_LogisticsContributorName", _attr get "logisticsContributorName", true];
        _crate setVariable ["FLO_DevelopmentTargetObjectiveId", _attr get "developmentTargetObjectiveId", true];
    };
    {
        _x params ["_itemClass", "_count", "_itemType"];
        switch (_itemType) do {
            case "weapon": { _crate addWeaponCargoGlobal [_itemClass, _count]; };
            case "magazine": { _crate addMagazineCargoGlobal [_itemClass, _count]; };
            case "backpack": { _crate addBackpackCargoGlobal [_itemClass, _count]; };
            case "item": { _crate addItemCargoGlobal [_itemClass, _count]; };
        };
    } forEach _items;
    [_crate, true, [0,2,0], 0] remoteExec ["ace_dragging_fnc_setDraggable", 0, _crate];
    _loadedCrates = _loadedCrates + 1;
} forEach (keys _crateHash);
["INIT", 3, format ["Restored %1 supply crates from current save", _loadedCrates]] call FLO_fnc_log;

_loadedCrates
