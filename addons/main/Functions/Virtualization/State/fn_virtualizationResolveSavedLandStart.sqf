/* Resolves restore terrain validation without treating cargo as ground travel. */
params ["_savedData", "_groupId"];

private _position = _savedData get "position";
private _waypoints = _savedData get "waypoints";
if (_waypoints isEqualTo []) exitWith { +_position };

if ((_savedData get "attachedTo") != "") exitWith {
    // The carrier owns position and ingress. Validate the deferred route itself;
    // transportApplyPostDismountWaypoint resolves its ingress after detachment.
    +((_waypoints select (_savedData get "currentWaypointIndex")) select 0)
};
if !(surfaceIsWater _position) exitWith { +_position };

// Physical movement and old coastal dismount offsets can leave a LAND group
// just offshore. Recover only to nearby terrain; never to a distant objective.
private _safePosition = [_position, 500] call FLO_fnc_getSafeLandPos;
if (surfaceIsWater _safePosition || {_safePosition distance2D _position > 500}) then {
    private _error = format ["Saved LAND group %1 has no shore within 500m of %2", _groupId, _position];
    ["VIRTUALIZATION", 1, _error] call FLO_fnc_log;
    throw _error;
};
_safePosition = [_safePosition select 0, _safePosition select 1, 0];
_savedData set ["position", _safePosition];
["VIRTUALIZATION", 2, format ["Recovered saved LAND start group=%1 reason=START_IN_WATER distance=%2", _groupId, _position distance2D _safePosition]] call FLO_fnc_log;
+_safePosition
