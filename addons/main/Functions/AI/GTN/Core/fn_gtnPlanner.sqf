/* Ordered GTN planner: bounded method search, projected effects and runtime goals. */
params ["_goalLibrary", "_worldState"];
private _planner = createHashMapObject [[
    ["_goalLibrary", _goalLibrary], ["_worldState", _worldState],
    ["_intentId", ""],
    ["_getState", {
        if ((_self get "_intentId") != "") exitWith { [_self get "_worldState", _self get "_intentId"] call FLO_fnc_gtnIntentSnapshot };
        (_self get "_worldState") call ["_getSnapshot", []]
    }],
    ["_currentPlan", []], ["_currentTaskIndex", 0], ["_planStatus", "IDLE"],
    ["_bindings", createHashMap], ["_planId", ""], ["_trackId", ""],
    ["_generation", 0], ["_nextNodeId", 0], ["_searchSteps", 0],
    ["_maxDepth", 10], ["_maxSearchSteps", 256], ["_failureReason", ""],
    ["_planningStats", createHashMapFromArray [["plansGenerated", 0], ["replans", 0], ["tasksExecuted", 0], ["tasksFailed", 0]]],
    ["_createPlanNode", {
        params ["_taskId", "_params", "_depth", "_kind", "_definition"];
        private _index = _self get "_nextNodeId";
        _self set ["_nextNodeId", _index + 1];
        createHashMapFromArray [
            ["taskId", _taskId], ["params", +_params], ["depth", _depth], ["kind", _kind],
            ["definition", _definition], ["status", "PENDING"], ["startTime", -1], ["endTime", -1],
            ["planId", _self get "_planId"], ["nodeId", _index], ["executionKey", ""], ["methodUsed", ""]
        ]
    }],
    ["_plan", {
        params ["_goalId", ["_params", []], ["_executor", nil]];
        if ((_self get "_currentPlan") isNotEqualTo []) then {
            if ((_self get "_planStatus") in ["PENDING", "RUNNING"] && {isNil "_executor"}) then {
                throw "GTN replacing an active plan requires its executor";
            };
            if (!isNil "_executor") then { _self call ["_cancel", [_executor, "REPLACED"]] };
        };
        _self set ["_currentPlan", []];
        _self set ["_currentTaskIndex", 0];
        _self set ["_bindings", createHashMap];
        _self set ["_failureReason", ""];
        _self set ["_searchSteps", 0];
        _self set ["_nextNodeId", 0];
        _self set ["_generation", (_self get "_generation") + 1];
        _self set ["_planId", format ["%1:%2", _self get "_trackId", _self get "_generation"]];
        _self set ["_planStatus", "FAILED"];
        private _snapshot = _self call ["_getState", []];
        private _decomposition = [_self, _goalId, _params, _snapshot, createHashMap] call FLO_fnc_gtnPlanDecompose;
        if (isNil "_decomposition") exitWith { nil };
        private _plan = _decomposition select 0;
        _self set ["_currentPlan", _plan];
        _self set ["_planStatus", ["PENDING", "SUCCESS"] select (_plan isEqualTo [])];
        _self set ["_failureReason", ""];
        private _stats = _self get "_planningStats";
        _stats set ["plansGenerated", (_stats get "plansGenerated") + 1];
        ["GTN", 4, format ["Plan %1 goal=%2 nodes=%3 search=%4", _self get "_planId", _goalId, count _plan, _self get "_searchSteps"]] call FLO_fnc_log;
        _plan
    }],
    ["_step", {
        params ["_executor", "_track"];
        try { [_self, _executor, _track] call FLO_fnc_gtnPlannerStep } catch {
            private _error = _exception;
            _self call ["_cancel", [_executor, "EXECUTION_EXCEPTION"]];
            _self set ["_planStatus", "FAILED"];
            ["GTN", 1, format ["Plan %1 execution failed: %2", _self get "_planId", _error]] call FLO_fnc_log;
            throw _error;
        }
    }],
    ["_cancel", {
        params ["_executor", "_reason"];
        // Nodes reference their track/planner; deep-copying them creates a cycle.
        private _nodes = _self get "_currentPlan";
        private _cleanupErrors = [];
        for "_index" from (count _nodes - 1) to 0 step -1 do {
            private _node = _nodes select _index;
            try { _executor call ["_retireExecution", [_node, false, _reason]] } catch { _cleanupErrors pushBack _exception };
            if ((_node get "status") in ["PENDING", "RUNNING"]) then { _node set ["status", "CANCELLED"]; _node set ["endTime", diag_tickTime] };
        };
        _self set ["_planStatus", "CANCELLED"];
        _self set ["_failureReason", _reason];
        if (_cleanupErrors isNotEqualTo []) then {
            ["GTN", 1, format ["Plan %1 cleanup failed: %2", _self get "_planId", _cleanupErrors]] call FLO_fnc_log;
            throw format ["GTN plan cleanup failed: %1", _cleanupErrors];
        };
        true
    }],
    ["_replan", {
        params ["_goalId", ["_params", []], ["_executor", nil]];
        private _stats = _self get "_planningStats";
        _stats set ["replans", (_stats get "replans") + 1];
        _self call ["_plan", [_goalId, _params, _executor]]
    }],
    ["_needsReplan", { params ["_snapshot"]; (_self get "_worldState") call ["_hasSignificantChange", [_snapshot]] }],
    ["_getCurrentPlan", { _self get "_currentPlan" }],
    ["_getCurrentTask", {
        private _index = _self get "_currentTaskIndex";
        private _plan = _self get "_currentPlan";
        if (_index >= count _plan) exitWith { nil };
        _plan select _index
    }],
    ["_getPlanStatus", { _self get "_planStatus" }],
    ["_getStats", { _self get "_planningStats" }],
    ["_debugPrint", { format ["GTN plan %1 status=%2 node=%3/%4 reason=%5", _self get "_planId", _self get "_planStatus", _self get "_currentTaskIndex", count (_self get "_currentPlan"), _self get "_failureReason"] }]
]];
_planner
