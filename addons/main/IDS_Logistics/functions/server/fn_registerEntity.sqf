/* Registers a live or restored structure without changing its object identity. */
params ["_entity"];
IDS_Logistics_PlacedEntities pushBackUnique _entity;
if (isNil { _entity getVariable "IDS_Logistics_KilledEH" }) then {
    private _handler = _entity addEventHandler ["Killed", {
        params ["_unit"];
        [_unit] call IDS_Logistics_fnc_onEntityKilled;
    }];
    _entity setVariable ["IDS_Logistics_KilledEH", _handler];
};
