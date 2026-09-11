/* Begin bounded search with an explicit network so backtracking crosses siblings. */
params ["_planner", "_taskId", "_params", "_state", "_bindings", ["_depth", 0]];
[_planner, [[_taskId, _params, _depth, false, ""]], _state, _bindings] call FLO_fnc_gtnPlanSearch
