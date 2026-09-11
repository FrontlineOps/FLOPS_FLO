/* Current campaign restoration; called in Phase 5 ownership order. */
params ["_savedData", "_trackedCrewTypes"];

// Restore vehicles
private _vehHash = _savedData get "vehicles";
private _requiredVehicleTypes = [
    ["type", ""], ["posATL", []], ["fuel", 0], ["damage", 0],
    ["damagedHitpoints", []], ["vectorDirAndUp", []], ["locked", 0],
    ["engineOn", true], ["hadAICrew", true], ["storeVehicle", true],
    ["mobileRespawnVehicle", true], ["supportVehicleRoles", []]
];
private _loadedVehicles = 0;
{
    private _vehId = _x;
    private _attr = _vehHash get _vehId;
    if !(_vehId isEqualType "" && {_vehId != ""}) then {
        throw format ["Current save has invalid vehicle key %1", _vehId];
    };
    if !(_attr isEqualType createHashMap) then {
        throw format ["Saved vehicle %1 has invalid record type %2", _vehId, typeName _attr];
    };
    {
        _x params ["_field", "_prototype"];
        if !(_field in _attr) then {
            throw format ["Saved vehicle %1 is missing required field %2", _vehId, _field];
        };
        private _value = _attr get _field;
        if !(_value isEqualType _prototype) then {
            throw format ["Saved vehicle %1 field %2 has invalid type %3", _vehId, _field, typeName _value];
        };
    } forEach _requiredVehicleTypes;

    private _type = _attr get "type";
    private _posATL = _attr get "posATL";
    private _vectorDirAndUp = _attr get "vectorDirAndUp";
    if (
        _type == ""
        || {!isClass (configFile >> "CfgVehicles" >> _type)}
        || {(count _posATL) < 2}
        || {count _vectorDirAndUp != 2}
        || {{!(_x isEqualType []) || {count _x != 3}} count _vectorDirAndUp > 0}
    ) then {
        throw format ["Saved vehicle %1 has invalid spatial or class state", _vehId];
    };
    private _damagedHitpoints = _attr get "damagedHitpoints";
    {
        if !(
            _x isEqualType []
            && {count _x == 2}
            && {(_x # 0) isEqualType ""}
            && {(_x # 1) isEqualType 0}
        ) then {
            throw format ["Saved vehicle %1 has malformed hitpoint record %2", _vehId, _x];
        };
    } forEach _damagedHitpoints;

    private _veh = createVehicle [_type, [0,0,0], [], 0, "CAN_COLLIDE"];
    if (isNull _veh) then {
        throw format ["Failed to restore saved vehicle %1 of type %2", _vehId, _type];
    };
    _veh setVectorDirAndUp _vectorDirAndUp;
    _veh setPosATL _posATL;
    _veh setFuel (_attr get "fuel");
    _veh setDamage (_attr get "damage");
    _veh lock (_attr get "locked");
    _veh setVariable ["FLO_SaveID", _vehId, true];
    if (_attr get "storeVehicle") then {
        _veh setVariable ["FLO_StoreVehicle", true, true];
    };
    if (_attr get "mobileRespawnVehicle") then {
        _veh setVariable ["FLO_MobileRespawnVehicle", true, true];
    };
    private _supportVehicleRoles = _attr get "supportVehicleRoles";
    if (_supportVehicleRoles isNotEqualTo []) then {
        _veh setVariable ["FLO_SupportVehicleRoles", _supportVehicleRoles, true];
    };
    { _x params ["_hp", "_dmg"]; _veh setHitPointDamage [_hp, _dmg]; } forEach _damagedHitpoints;
    if (_attr get "engineOn") then { _veh engineOn true; };
    [_veh, _type, _attr, _trackedCrewTypes] call FLO_fnc_initRestoreTrackedCrew;
    if (_attr get "storeVehicle") then {
        [_veh, _type] call FLO_fnc_vehicleConfigureRequestedVehicle;
    };
    _loadedVehicles = _loadedVehicles + 1;
} forEach (keys _vehHash);
["INIT", 3, format ["Restored %1 vehicles from current save", _loadedVehicles]] call FLO_fnc_log;

_loadedVehicles
