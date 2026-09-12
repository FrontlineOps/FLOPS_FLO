/* Incoming-aircraft alerts require knowledge held by a friendly observer. */
params [["_aircraft", objNull, [objNull]], ["_targetPos", [0, 0, 0], [[]], [3]], ["_detectingSide", sideUnknown]];
if (isNull _aircraft || {!alive _aircraft} || {!(_detectingSide in [east, west])}) exitWith { false };
private _detected = false;
{
    if ((_y get "side") != _detectingSide || {!(_y get "isActive")}) then {continue};
    private _leader = leader (_y get "realGroup");
    if (!isNull _leader && {alive _leader} && {_leader knowsAbout _aircraft > 0}) exitWith {_detected = true};
} forEach (call FLO_fnc_virtualizationGetGroupMap);
if (_detected) exitWith {true};
([] call FLO_fnc_getConnectedHumanPlayers) findIf {
    alive _x && {side group _x == _detectingSide} && {(leader group _x) knowsAbout _aircraft > 0}
} >= 0
