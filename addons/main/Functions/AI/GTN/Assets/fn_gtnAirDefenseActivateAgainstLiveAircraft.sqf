/* Activates virtual AA groups that can physically engage one live aircraft. */
params [
    ["_aircraft", objNull, [objNull]],
    ["_airSide", sideUnknown],
    ["_groups", createHashMap, [createHashMap]],
    ["_contactIndex", createHashMap, [createHashMap]]
];

if (isNull _aircraft || {!alive _aircraft}) exitWith { 0 };
if !(_airSide in [east, west]) exitWith { 0 };

private _state = call FLO_fnc_gtnAirDefenseGetState;
private _airPosASL = getPosASL _aircraft;
private _enemySide = [east, west] select (_airSide isEqualTo east);
private _enemySideKey = [_enemySide] call FLO_fnc_sideKey;
private _aaGroupIds = (_contactIndex get "aaGroupIdsBySide") get _enemySideKey;
private _activated = 0;

{
    private _aaId = _x;
    private _aaData = _groups get _aaId;
    private _engagementRange = [_aaData] call FLO_fnc_gtnAirDefenseGetGroupRange;
    if (_engagementRange <= 0) then { continue };
    private _aaPosASL = ATLToASL (_aaData get "position");
    if ((_aaPosASL distance _airPosASL) > _engagementRange) then { continue };
    // A physical aircraft must face physical defenses even without a nearby
    // player. Virtual AA cannot exchange engine fire with it.

    private _lock = _aaData get "missionLock";
    if (_lock != "" && {_lock != "AIR_DEFENSE"}) then { continue };

    if !(_aaData get "isActive") then {
        if !([_aaId] call FLO_fnc_virtualizationForceActivateGroup) then {
            ["GTN Air Defense", 2, format ["Unable to activate AA group %1 against live aircraft", _aaId]] call FLO_fnc_log;
            continue;
        };
        _activated = _activated + 1;
    };

    [_aaData, "AIR_DEFENSE", "LIVE_CONTACT"] call FLO_fnc_virtualizationSetMissionLock;
    (_state get "lastLiveContactAt") set [_aaId, diag_tickTime];

    // Proximity selects physical simulation; native sensors and reports own
    // target knowledge. Activation must not reveal an unseen aircraft.
} forEach _aaGroupIds;

_activated
