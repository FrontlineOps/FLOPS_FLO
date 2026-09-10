/* Disconnect teardown only touches entities whose manipulation belongs to this player. */
params ["_player"];
if (!isServer || {isRemoteExecuted} || {isNull _player}) exitWith { 0 };
private _released = 0;
{
    private _state = _x getVariable ["IDS_Logistics_VisibilityState", []];
    if (_state isNotEqualTo [] && {(_state select 3) isEqualTo _player}) then {
        if ([_x] call IDS_Logistics_fnc_releaseEntity) then { _released = _released + 1; };
    };
} forEach (+IDS_Logistics_ManipulatedEntities);
if (_released > 0) then {
    ["IDS_LOGISTICS", 3, format ["Disconnected builder released %1 placements", _released]] call FLO_fnc_log;
};
_released
