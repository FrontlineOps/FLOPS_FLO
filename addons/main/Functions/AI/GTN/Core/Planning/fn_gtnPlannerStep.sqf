/* Advances one node. Predictions are never used as runtime completion evidence. */
params ["_planner", "_executor", "_track"];
private _result = createHashMapFromArray [["started", false], ["progress", false], ["status", _planner get "_planStatus"]];
if !((_planner get "_planStatus") in ["PENDING", "RUNNING"]) exitWith { _result };
private _node = _planner call ["_getCurrentTask", []];
if (isNil "_node") then { throw "GTN active plan has no current node" };
private _bindings = _planner get "_bindings";
private _arguments = [_node get "params", [], _bindings] call FLO_fnc_gtnResolvePlanParams;
private _reason = "";
if (isNil "_arguments") then { _reason = "UNBOUND_RUNTIME_PARAMETER" } else {
    private _ws = _planner get "_worldState";
    private _definition = _node get "definition";
    if ((_node get "kind") == "GOAL") then {
        if ([_planner call ["_getState", []], _arguments, _bindings] call (_definition get "satisfied")) then {
            _node set ["status", "SUCCESS"];
        } else { _reason = format ["GOAL_NOT_SATISFIED:%1", _node get "taskId"] };
    } else {
        if ((_node get "status") == "PENDING") then {
            if !([_planner call ["_getState", []], _arguments, _bindings] call (_definition get "preconditions")) then {
                _reason = format ["RUNTIME_PRECONDITIONS:%1", _node get "taskId"];
            } else {
                _node set ["_trackRef", _track];
                _node set ["startTime", diag_tickTime];
                _node set ["status", "RUNNING"];
                _planner set ["_planStatus", "RUNNING"];
                _result set ["started", true];
                if !(_executor call ["_executePrimitive", [_node, _arguments, _bindings, _ws]]) then {
                    _reason = format ["START_REJECTED:%1", _node get "taskId"];
                };
            };
        };
        if (_reason == "" && {(_node get "status") == "RUNNING"}) then {
            private _status = _executor call ["_checkExecution", [_node]];
            switch (_status) do {
                case "SUCCESS": {
                    private _outputs = _executor call ["_getOutputs", [_node]];
                    { _bindings set [_x, _y] } forEach _outputs;
                    _node set ["status", "SUCCESS"];
                };
                case "FAILED": { _reason = format ["EXECUTION_FAILED:%1", _node get "taskId"] };
                case "RUNNING": {
                    if (diag_tickTime - (_node get "startTime") >= (_definition get "timeout")) then {
                        _reason = format ["TIMEOUT:%1", _node get "taskId"];
                    };
                };
                default { throw format ["GTN invalid execution state %1", _status] };
            };
        };
    };
};
if (_reason != "") then {
    _node set ["status", "FAILED"];
    _planner call ["_cancel", [_executor, _reason]];
    _planner set ["_planStatus", "FAILED"];
    private _stats = _planner get "_planningStats";
    _stats set ["tasksFailed", (_stats get "tasksFailed") + 1];
    ["GTN", 2, format ["Plan %1 failed: %2", _planner get "_planId", _reason]] call FLO_fnc_log;
} else {
    if ((_node get "status") == "SUCCESS") then {
        _node set ["endTime", diag_tickTime];
        _planner set ["_currentTaskIndex", (_planner get "_currentTaskIndex") + 1];
        _result set ["progress", true];
        if ((_node get "kind") == "TASK") then {
            private _stats = _planner get "_planningStats";
            _stats set ["tasksExecuted", (_stats get "tasksExecuted") + 1];
        };
        if ((_planner get "_currentTaskIndex") >= count (_planner get "_currentPlan")) then {
            { _executor call ["_retireExecution", [_x, true, "GOAL_SATISFIED"]] } forEach (_planner get "_currentPlan");
            _planner set ["_planStatus", "SUCCESS"];
        } else { _planner set ["_planStatus", "PENDING"] };
    };
};
_result set ["status", _planner get "_planStatus"];
_result
