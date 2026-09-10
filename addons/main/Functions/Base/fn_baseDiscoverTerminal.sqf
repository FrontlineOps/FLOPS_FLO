/* One-time pairing for editor-placed bases. Deployed/restored bases pass explicit references. */
params ["_building", "_config"];
if (isNil { _building getVariable "FLO_BaseTerminal" }) then {
    private _containerType = missionNamespace getVariable (_config get "containerTypeVariable");
    private _candidates = nearestObjects [_building, [_containerType], _config get "containerSearchRadius"];
    private _index = _candidates findIf { isNull (_x getVariable ["FLO_BaseOwner", objNull]) };
    private _terminal = if (_index < 0) then { objNull } else { _candidates select _index };
    [_building, _terminal] call FLO_fnc_baseBindTerminal;
};
_building getVariable "FLO_BaseTerminal"
