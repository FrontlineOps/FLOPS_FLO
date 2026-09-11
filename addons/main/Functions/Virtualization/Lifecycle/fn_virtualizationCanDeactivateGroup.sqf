/* Return whether all entities being removed belong to this virtual force. */
params ["_groupData", "_realGroup", ["_includeMountedPassengers", true, [true]]];

private _ownedUnits = units _realGroup;
if (_includeMountedPassengers) then {
    private _carrierId = _groupData get "id";
    {
        private _passenger = [_x] call FLO_fnc_virtualizationRequireGroup;
        if ((_passenger get "mountedIn") == _carrierId) then {
            _ownedUnits append (units (_passenger get "realGroup"));
        };
    } forEach (_groupData get "attachedGroups");
};
if (_ownedUnits findIf { isPlayer _x } >= 0) exitWith { false };

private _vehicles = +(_groupData get "realVehicles");
_vehicles append ([_realGroup] call FLO_fnc_virtualizationCollectRealGroupVehicles);
_vehicles = _vehicles arrayIntersect _vehicles;
_vehicles findIf {
    (crew _x) findIf { isPlayer _x || {!(_x in _ownedUnits)} } >= 0
} < 0
