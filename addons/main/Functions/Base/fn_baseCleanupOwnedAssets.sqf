/* Destruction and siege loss remove only assets registered to this base. */
params ["_building", "_markerVariable"];
if (!isServer || {isNull _building}) exitWith { false };

private _terminal = _building getVariable "FLO_BaseTerminal";
if (!isNull _terminal) then {
    if ((_terminal getVariable "FLO_BaseOwner") isNotEqualTo _building) then {
        ["BASE", 1, format ["Base %1 terminal ownership is inconsistent", _building]] call FLO_fnc_log;
        throw "Cannot clean up a terminal owned by another base";
    };
    deleteVehicle _terminal;
};
_building setVariable ["FLO_BaseTerminal", objNull, true];

private _triggers = _building getVariable "FLO_BaseTriggers";
{
    if (!isNull _x) then { deleteVehicle _x };
} forEach _triggers;
_building setVariable ["FLO_BaseTriggers", []];

private _markerName = _building getVariable [_markerVariable, ""];
if (_markerName != "") then { deleteMarker _markerName };
true
