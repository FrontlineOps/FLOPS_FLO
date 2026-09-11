/* Execution contexts remain owned by unique task nodes until their plan retires. */
params ["_commander", "_sideContext"];
private _executor = createHashMapObject [[
    ["_aiCommander", _commander], ["_gtnCommander", nil], ["_sideContext", _sideContext],
    ["_sideKey", _sideContext get "sideKey"], ["_handlers", createHashMap],
    ["_activeExecutions", createHashMap], ["_nextExecutionId", 0],
    ["_perf", createHashMapFromArray [["lastPrimitiveMs", createHashMap], ["peakPrimitiveMs", createHashMap], ["lastCheckMs", createHashMap]]],
    ["_setGTNCommander", { params ["_cmdr"]; _self set ["_gtnCommander", _cmdr] }],
    ["_registerHandler", {
        params ["_id", "_handler"];
        {
            if !(_x in _handler && {(_handler get _x) isEqualType {}}) then { throw format ["GTN handler %1 requires %2 code", _id, _x] };
        } forEach ["start", "poll", "cancel", "finish"];
        (_self get "_handlers") set [_id, _handler];
    }],
    ["_getExecutionKey", { params ["_node"]; _node get "executionKey" }],
    ["_getContext", {
        params ["_node"];
        private _key = _node get "executionKey";
        private _active = _self get "_activeExecutions";
        if (_key == "" || {!(_key in _active)}) exitWith { nil };
        private _context = _active get _key;
        // A context from a different executor generation cannot match by key alone.
        if !((_context get "taskNode") isEqualRef _node) exitWith { nil };
        _context
    }],
    ["_executePrimitive", {
        params ["_node", "_arguments", "_bindings", "_worldState"];
        if ((_node get "executionKey") != "") then { throw "GTN task cannot be started twice" };
        private _id = _node get "taskId";
        private _handlers = _self get "_handlers";
        if !(_id in _handlers) then { throw format ["GTN missing execution handler for %1", _id] };
        private _serial = (_self get "_nextExecutionId") + 1;
        _self set ["_nextExecutionId", _serial];
        private _key = format ["%1:%2", _self get "_sideKey", _serial];
        _node set ["executionKey", _key];
        private _context = createHashMapFromArray [
            ["commander", _self get "_gtnCommander"], ["executor", _self], ["worldState", _worldState],
            ["taskNode", _node], ["executionKey", _key], ["params", _arguments],
            ["bindings", _bindings], ["outputs", createHashMap], ["data", createHashMapFromArray [["completionReported", false]]],
            ["completionValidated", false],
            ["handler", _handlers get _id], ["status", "RUNNING"], ["startTime", diag_tickTime]
        ];
        (_self get "_activeExecutions") set [_key, _context];
        private _start = diag_tickTime;
        private _accepted = false;
        try { _accepted = [_context] call ((_context get "handler") get "start") } catch {
            _context set ["status", "FAILED"];
            _self call ["_retireExecution", [_node, false, "START_EXCEPTION"]];
            ["GTN", 1, format ["Primitive %1 start failed: %2", _id, _exception]] call FLO_fnc_log;
            throw _exception;
        };
        if !(_accepted isEqualType true) then { throw format ["GTN primitive %1 start must return BOOL", _id] };
        if (!_accepted) then { _context set ["status", "FAILED"] };
        private _ms = (diag_tickTime - _start) * 1000;
        private _perf = _self get "_perf";
        (_perf get "lastPrimitiveMs") set [_id, _ms];
        private _peaks = _perf get "peakPrimitiveMs";
        _peaks set [_id, _ms max (_peaks getOrDefault [_id, 0])];
        if (_ms >= 10) then { ["GTN", 4, format ["Primitive %1 start=%2ms execution=%3", _id, _ms, _key]] call FLO_fnc_log };
        _accepted
    }],
    ["_checkExecution", {
        params ["_node"];
        private _context = _self call ["_getContext", [_node]];
        if (isNil "_context") then { throw "GTN running task lost its execution context" };
        if ((_context get "status") == "FAILED" || {_context get "completionValidated"}) exitWith { _context get "status" };
        private _start = diag_tickTime;
        [_context] call ((_context get "handler") get "poll");
        if ((_context get "status") != "FAILED") then {
            private _complete = [_context] call ((_node get "definition") get "completionCheck");
            if !(_complete isEqualType true) then { throw "GTN completion predicate must return BOOL" };
            _context set ["status", ["RUNNING", "SUCCESS"] select _complete];
            _context set ["completionValidated", _complete];
        };
        private _ms = (diag_tickTime - _start) * 1000;
        ((_self get "_perf") get "lastCheckMs") set [_node get "taskId", _ms];
        if (_ms >= 10) then { ["GTN", 4, format ["Primitive %1 poll=%2ms", _node get "taskId", _ms]] call FLO_fnc_log };
        _context get "status"
    }],
    ["_getOutputs", {
        params ["_node"];
        private _context = _self call ["_getContext", [_node]];
        if (isNil "_context" || {(_context get "status") != "SUCCESS"}) then { throw "GTN outputs requested before successful completion" };
        +(_context get "outputs")
    }],
    ["_completeExecution", {
        params ["_node", ["_success", true], ["_outputs", createHashMap]];
        private _context = _self call ["_getContext", [_node]];
        if (isNil "_context" || {(_context get "status") != "RUNNING"} || {(_context get "data") get "completionReported"}) exitWith { false };
        if !(_outputs isEqualType createHashMap) then { throw "GTN execution outputs must be a HashMap" };
        if (_success) then {
            _context set ["outputs", +_outputs];
            (_context get "data") set ["completionReported", true];
            // The completion predicate remains authoritative on the next poll.
        } else { _context set ["status", "FAILED"] };
        true
    }],
    ["_updateExecution", {
        params ["_node", "_key", "_value"];
        private _context = _self call ["_getContext", [_node]];
        if (isNil "_context" || {(_context get "status") != "RUNNING"}) exitWith { false };
        (_context get "data") set [_key, _value];
        true
    }],
    ["_retireExecution", {
        params ["_node", "_success", "_reason"];
        if ((_node get "kind") != "TASK") exitWith { false };
        private _context = _self call ["_getContext", [_node]];
        if (isNil "_context") exitWith { false };
        // Remove ownership before cleanup, so callbacks cannot resurrect this work.
        (_self get "_activeExecutions") deleteAt (_node get "executionKey");
        _context set ["status", ["CANCELLED", "SUCCESS"] select _success];
        private _callback = (_context get "handler") get (["cancel", "finish"] select _success);
        [_context, _reason] call _callback;
        true
    }],
    ["_getPerf", { _self get "_perf" }]
]];
[_executor] call FLO_fnc_gtnRegisterPlanHandlers;
_executor
