/* Owns the repair mission hold action and its machine-local action ID. */
params ["_vehicle", "_enabled"];
if (!hasInterface || {isNull _vehicle}) exitWith {};

private _previousId = _vehicle getVariable ["FLO_CivilianRepairActionId", -1];
if (_previousId >= 0) then {
    [_vehicle, _previousId] call BIS_fnc_holdActionRemove;
    _vehicle setVariable ["FLO_CivilianRepairActionId", -1];
};
if (!_enabled || {!alive _vehicle} || {_vehicle getVariable ["FLO_CivilianMissionResolved", false]}) exitWith {};

private _actionId = [
    _vehicle,
    "Repair Civilian Vehicle",
    "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa",
    "alive _target && {!(_target getVariable ['FLO_CivilianMissionResolved', false])} && {_this distance _target < 7}",
    "alive _target && {!(_target getVariable ['FLO_CivilianMissionResolved', false])} && {_caller distance _target < 7}",
    {},
    {},
    {
        params ["_target"];
        ["REPAIR_COMPLETE", [_target]] remoteExecCall ["FLO_fnc_civilianMissionResolveAction", 2, false];
    },
    {},
    [],
    10,
    0,
    false,
    false
] call BIS_fnc_holdActionAdd;
_vehicle setVariable ["FLO_CivilianRepairActionId", _actionId];
