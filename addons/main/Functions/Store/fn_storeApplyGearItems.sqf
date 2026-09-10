/* Applies validated Store lines on the unit owner; returns every undelivered item. */
params ["_unit", "_gearEntries"];

private _overflow = [];
private _filledSlots = createHashMap;
private _equipment = [];
private _cargo = [];

{
    if ((_x get "container") == "auto") then {
        _equipment pushBack _x;
    } else {
        _cargo pushBack _x;
    };
} forEach _gearEntries;

{
    private _targetCategory = _x;
    {
        private _category = _x get "category";
        if (_category != _targetCategory) then { continue };
        private _className = _x get "className";
        private _quantity = _x get "quantity";
        private _slot = _x get "slot";
        private _slotKey = _category;

        switch (_category) do {
            case "ammo";
            case "mines": { _slotKey = ""; };
            case "attachments": {
                _slotKey = if (_slot in ["primary", "handgun", "secondary"]) then {
                    format ["%1:%2", _slot, getNumber (configFile >> "CfgWeapons" >> _className >> "ItemInfo" >> "type")]
                } else { "" };
            };
            case "misc": {
                private _itemType = _className call BIS_fnc_itemType;
                _itemType params ["_group", "_kind"];
                _slotKey = "";
                if (_slot == "binocular" || {_group == "Weapon" && {_kind in ["Binocular", "LaserDesignator"]}}) then {
                    _slotKey = "binocular";
                } else {
                    if (_slot == "assigned" || {_kind in ["GPS", "Map", "Compass", "Watch", "Radio", "NVGoggles", "Terminal"]}) then {
                        _slotKey = "assigned:" + ([_kind, "GPS"] select (_kind == "Terminal"));
                    };
                };
            };
        };

        if (_slotKey == "") then {
            _cargo pushBack _x;
            continue;
        };

        private _equipped = false;
        if !(_slotKey in _filledSlots) then {
            switch (_category) do {
                case "uniforms": {
                    removeUniform _unit;
                    _unit forceAddUniform _className;
                    _equipped = uniform _unit == _className;
                    if (_equipped) then { [uniformContainer _unit] call FLO_fnc_storeClearCargo; };
                };
                case "vests": {
                    removeVest _unit;
                    _unit addVest _className;
                    _equipped = vest _unit == _className;
                    if (_equipped) then { [vestContainer _unit] call FLO_fnc_storeClearCargo; };
                };
                case "backpacks": {
                    removeBackpack _unit;
                    _unit addBackpack _className;
                    _equipped = backpack _unit == _className;
                    if (_equipped) then { [backpackContainer _unit] call FLO_fnc_storeClearCargo; };
                };
                case "headgear": {
                    removeHeadgear _unit;
                    _unit addHeadgear _className;
                    _equipped = headgear _unit == _className;
                };
                case "facewear": {
                    removeGoggles _unit;
                    _unit addGoggles _className;
                    _equipped = goggles _unit == _className;
                };
                case "primary";
                case "handgun";
                case "secondary": {
                    _equipped = ([_unit, _className, _category, 1] call FLO_fnc_storeApplyWeaponLine) isEqualTo [];
                };
                case "attachments": {
                    private _installed = switch (_slot) do {
                        case "primary": { _unit addPrimaryWeaponItem _className; primaryWeaponItems _unit };
                        case "handgun": { _unit addHandgunItem _className; handgunItems _unit };
                        case "secondary": { _unit addSecondaryWeaponItem _className; secondaryWeaponItems _unit };
                    };
                    _equipped = _className in _installed;
                };
                case "misc": {
                    if (_slotKey == "binocular") then {
                        if (binocular _unit != "") then { _unit removeWeapon (binocular _unit); };
                        _unit addWeapon _className;
                        _equipped = binocular _unit == _className;
                    } else {
                        _unit linkItem _className;
                        _equipped = _className in assignedItems _unit;
                    };
                };
            };
        };

        if (_equipped) then {
            _filledSlots set [_slotKey, true];
            _quantity = _quantity - 1;
        };
        for "_i" from 1 to _quantity do { _overflow pushBack _className; };
    } forEach _equipment;
} forEach ["uniforms", "vests", "backpacks", "headgear", "facewear", "primary", "handgun", "secondary", "attachments", "misc", "ammo", "mines"];

// Containers must be equipped and cleared before any purchased cargo is packed.
{
    private _className = _x get "className";
    private _container = _x get "container";
    for "_i" from 1 to (_x get "quantity") do {
        if !([_unit, _className, _container] call FLO_fnc_storeAddInventoryItem) then {
            _overflow pushBack _className;
        };
    };
} forEach _cargo;

_overflow
