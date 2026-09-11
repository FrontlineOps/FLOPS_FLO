/* Current campaign restoration; called in Phase 5 ownership order. */
params ["_savedData", "_trackedCrewTypes"];

// Restore objects
private _objHash = _savedData get "objects";
private _requiredObjectTypes = [
    ["type", ""], ["posASL", []], ["vectorDirAndUp", []],
    ["damage", 0], ["hadAICrew", true]
];
private _loadedObjects = 0;
{
    private _objId = _x;
    private _attr = _objHash get _objId;
    if !(_objId isEqualType "" && {_objId != ""}) then {
        throw format ["Current save has invalid object key %1", _objId];
    };
    if !(_attr isEqualType createHashMap) then {
        throw format ["Saved object %1 has invalid record type %2", _objId, typeName _attr];
    };
    {
        _x params ["_field", "_prototype"];
        if !(_field in _attr) then {
            throw format ["Saved object %1 is missing required field %2", _objId, _field];
        };
        private _value = _attr get _field;
        if !(_value isEqualType _prototype) then {
            throw format ["Saved object %1 field %2 has invalid type %3", _objId, _field, typeName _value];
        };
    } forEach _requiredObjectTypes;

    private _type = _attr get "type";
    private _posASL = _attr get "posASL";
    private _vectorDirAndUp = _attr get "vectorDirAndUp";
    if (
        _type == ""
        || {!isClass (configFile >> "CfgVehicles" >> _type)}
        || {(count _posASL) < 2}
        || {count _vectorDirAndUp != 2}
        || {{!(_x isEqualType []) || {count _x != 3}} count _vectorDirAndUp > 0}
    ) then {
        throw format ["Saved object %1 has invalid spatial or class state", _objId];
    };

    if ([_type] call FLO_fnc_saveIsWeaponHolderClass) then {
        throw format ["Current save cannot contain transient weapon holder %1", _objId];
    };

    private _obj = createVehicle [_type, [0,0,0], [], 0, "CAN_COLLIDE"];
    if (isNull _obj) then {
        throw format ["Failed to restore saved object %1 of type %2", _objId, _type];
    };
    _obj setVectorDirAndUp _vectorDirAndUp;
    _obj setPosASL _posASL;
    _obj setDamage (_attr get "damage");
    _obj setVariable ["FLO_SaveID", _objId, true];
    [_obj, _type, _attr, _trackedCrewTypes] call FLO_fnc_initRestoreTrackedCrew;
    _loadedObjects = _loadedObjects + 1;
} forEach (keys _objHash);
["INIT", 3, format ["Restored %1 objects from current save", _loadedObjects]] call FLO_fnc_log;

_loadedObjects
