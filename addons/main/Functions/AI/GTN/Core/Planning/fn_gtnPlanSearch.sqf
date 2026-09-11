/* Search a complete ordered task network, including each method's continuation. */
params ["_planner", "_pending", "_state", "_bindings"];
if (_pending isEqualTo []) exitWith { [[], _state, _bindings] };
_planner set ["_searchSteps", (_planner get "_searchSteps") + 1];
(_pending select 0) params ["_taskId", "_params", "_depth", "_checkpoint", "_methodUsed"];
if (_depth > (_planner get "_maxDepth") || {(_planner get "_searchSteps") > (_planner get "_maxSearchSteps")}) exitWith {
    _planner set ["_failureReason", "SEARCH_LIMIT"];
    nil
};
private _remaining = _pending select [1];
private _library = _planner get "_goalLibrary";
private _resolved = [_params, [], _bindings] call FLO_fnc_gtnResolvePlanParams;
if (isNil "_resolved") exitWith { _planner set ["_failureReason", "UNBOUND_PARAMETER"]; nil };
private _primitive = _library call ["_isPrimitive", [_taskId]];
private _definition = if (_primitive) then { _library call ["_getPrimitive", [_taskId]] } else { _library call ["_getGoal", [_taskId]] };
if (isNil "_definition") then { throw format ["GTN unknown goal or primitive %1", _taskId] };
private _satisfied = !_primitive && {[_state, _resolved, _bindings] call (_definition get "satisfied")};
if (_checkpoint && {!_satisfied}) exitWith {
    _planner set ["_failureReason", format ["PROJECTED_GOAL:%1", _taskId]];
    nil
};
if (!_satisfied && {!([_state, _resolved, _bindings] call (_definition get "preconditions"))}) exitWith {
    _planner set ["_failureReason", format ["PRECONDITIONS:%1", _taskId]];
    nil
};
if (_primitive || {_satisfied}) exitWith {
    private _nextState = _state;
    private _nextBindings = _bindings;
    if (_primitive) then {
        _nextState = +_state;
        _nextBindings = +_bindings;
        [_nextState, _resolved, _nextBindings] call (_definition get "effects");
    };
    private _suffix = [_planner, _remaining, _nextState, _nextBindings] call FLO_fnc_gtnPlanSearch;
    if (isNil "_suffix") exitWith { nil };
    private _node = _planner call ["_createPlanNode", [_taskId, _params, _depth, ["GOAL", "TASK"] select _primitive, _definition]];
    _node set ["methodUsed", _methodUsed];
    [[_node] + (_suffix select 0), _suffix select 1, _suffix select 2]
};
private _ranked = [];
{
    if ([_state, _resolved, _bindings] call (_x get "conditions")) then {
        private _score = [_state, _resolved, _bindings] call (_x get "score");
        if !(_score isEqualType 0) then { throw format ["GTN method %1 returned nonnumeric score", _x get "id"] };
        if (_score >= 0) then { _ranked pushBack [-_score, _forEachIndex, _x] };
    };
} forEach (_definition get "methods");
_ranked sort true;
private _solution = nil;
{
    if ((_planner get "_searchSteps") >= (_planner get "_maxSearchSteps")) exitWith {};
    private _method = _x select 2;
    private _network = [];
    {
        _x params ["_childId", "_childParams"];
        // Keep output references symbolic until their producing task has completed.
        private _arguments = [_childParams, _params, _bindings, false] call FLO_fnc_gtnResolvePlanParams;
        _network pushBack [_childId, _arguments, _depth + 1, false, ""];
    } forEach (_method get "subtasks");
    _network pushBack [_taskId, _params, _depth, true, _method get "id"];
    _network append _remaining;
    // The continuation belongs to this choice: a later failure retries this method.
    _solution = [_planner, _network, +_state, +_bindings] call FLO_fnc_gtnPlanSearch;
    if (!isNil "_solution") exitWith {};
} forEach _ranked;
if (isNil "_solution") exitWith {
    if ((_planner get "_failureReason") == "") then { _planner set ["_failureReason", format ["NO_METHOD:%1", _taskId]] };
    nil
};
_solution
