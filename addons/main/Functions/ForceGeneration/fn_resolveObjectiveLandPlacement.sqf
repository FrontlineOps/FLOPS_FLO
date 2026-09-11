/* Validate generated positions against their objective's land access before
 * creating a group. Dry coastal rocks can be isolated despite surfaceIsWater.
 * This boundary chooses a reachable local spawn; it never moves existing groups.
 */
params ["_candidate", "_objectivePosition", "_searchRadius"];
private _anchor = [_objectivePosition, _searchRadius] call FLO_fnc_getSafeLandPos;
if (surfaceIsWater _anchor) exitWith { [] };
private _candidates = [+_candidate];
// Bounded alternatives stay near the same objective, on its accessible ground.
for "_bearing" from 0 to 270 step 90 do {
    _candidates pushBack (_anchor getPos [30 min _searchRadius, _bearing]);
};
private _result = [];
{
    if (surfaceIsWater _x) then { continue };
    if (([_x, _anchor, true, "FORCE_PLACEMENT"] call FLO_fnc_findRoadPath) select 0) exitWith {
        _result = +_x;
    };
} forEach _candidates;
_result
