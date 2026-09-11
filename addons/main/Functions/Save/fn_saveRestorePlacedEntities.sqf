/* Current campaign restoration; called in Phase 5 ownership order. */
params ["_savedData"];

// Restore IDS Logistics placed entities
if !(IDS_Logistics_PlacedEntities isEqualType []) then {
    throw format ["IDS Logistics runtime registry has invalid type %1", typeName IDS_Logistics_PlacedEntities];
};
private _idsEntities = _savedData get "idsLogisticsEntities";
private _requiredIdsTypes = [
    ["class", ""], ["posASL", []], ["direction", 0], ["vectorUp", []], ["damage", 0]
];
private _loadedIDS = 0;
{
    private _entityData = _x;
    if !(_entityData isEqualType createHashMap) then {
        throw format ["Saved IDS entity %1 has invalid record type %2", _forEachIndex, typeName _entityData];
    };
    {
        _x params ["_field", "_prototype"];
        if !(_field in _entityData) then {
            throw format ["Saved IDS entity %1 is missing required field %2", _forEachIndex, _field];
        };
        private _value = _entityData get _field;
        if !(_value isEqualType _prototype) then {
            throw format ["Saved IDS entity %1 field %2 has invalid type %3", _forEachIndex, _field, typeName _value];
        };
    } forEach _requiredIdsTypes;

    private _className = _entityData get "class";
    if (_className == "" || {!isClass (configFile >> "CfgVehicles" >> _className)}) then {
        throw format ["Saved IDS entity %1 has invalid class %2", _forEachIndex, _className];
    };
    private _entity = createVehicle [_className, [0,0,0], [], 0, "CAN_COLLIDE"];
    if (isNull _entity) then {
        throw format ["Failed to restore saved IDS entity %1 of type %2", _forEachIndex, _className];
    };
    _entity setPosASL (_entityData get "posASL");
    _entity setDir (_entityData get "direction");
    _entity setVectorUp (_entityData get "vectorUp");
    _entity setDamage (_entityData get "damage");
    _entity setVariable ["IDS_Logistics_isPlacedEntity", true, true];
    IDS_Logistics_PlacedEntities pushBack _entity;
    _loadedIDS = _loadedIDS + 1;
} forEach _idsEntities;
["INIT", 3, format ["Restored %1 IDS Logistics entities from current save", _loadedIDS]] call FLO_fnc_log;

_loadedIDS
