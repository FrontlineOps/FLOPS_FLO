/* Validates the current campaign container before save commit or restore. */
params ["_data"];
if !(_data isEqualType createHashMap) then { throw "[SAVE] Campaign root must be a HashMap" };
private _requiredRootTypes = [
    ["time", []],
    ["markers", createHashMap],
    ["vehicles", createHashMap],
    ["objects", createHashMap],
    ["crates", createHashMap],
    ["minefields", []],
    ["minefieldObjectiveCooldowns", createHashMap],
    ["fobs", []],
    ["ops", []],
    ["config", createHashMap],
    ["objectives", createHashMap],
    ["virtualGroups", createHashMap],
    ["aiCommanders", createHashMap],
    ["sideResources", createHashMap],
    ["logisticsNetworkBySide", createHashMap],
    ["baseDeploymentState", createHashMap],
    ["idsLogisticsEntities", []]
];
{
    _x params ["_key", "_prototype"];
    if !(_key in _data) then { throw format ["[SAVE] Current campaign is missing root field %1", _key] };
    private _value = _data get _key;
    if !(_value isEqualType _prototype) then {
        throw format ["[SAVE] Current campaign field %1 has type %2, expected %3", _key, typeName _value, typeName _prototype];
    };
} forEach _requiredRootTypes;
true
