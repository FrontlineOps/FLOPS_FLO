/* Run bounded work and retire terminal state in the same commander cycle. */
params ["_cmdr", "_track"];
private _metrics = createHashMapFromArray [
    ["emptyPoolSkips", 0], ["planCalls", 0], ["plansCreated", 0], ["planTaskTotal", 0], ["planMs", 0],
    ["primitiveExecCalls", 0], ["primitiveExecMs", 0], ["primitiveFailures", 0], ["checkCalls", 0], ["checkMs", 0],
    ["syncSuccesses", 0], ["tasksExecuted", 0], ["plansCompleted", 0], ["plansFailed", 0], ["processedTrackId", _track get "id"]
];
private _executor = _cmdr get "_executor";
private _planner = _track get "planner";
private _monitor = _track get "monitor";
private _goal = _track get "goal";
private _definition = (_cmdr get "_goalLibrary") call ["_getGoal", [_goal]];
if (isNil "_definition") then { throw format ["GTN track references unknown goal %1", _goal] };
if ((_track get "status") == "COMPLETE" || {diag_tickTime < (_track get "retryAt")}) exitWith { _metrics };
if ((_track get "status") == "RUNNING" && {_monitor call ["_checkReplanTriggers", []]}) then {
    private _start = diag_tickTime;
    private _plan = _monitor call ["_triggerReplan", [_executor]];
    _metrics set ["planCalls", 1];
    _metrics set ["planMs", (diag_tickTime - _start) * 1000];
    if (!isNil "_plan") then { _metrics set ["plansCreated", 1]; _metrics set ["planTaskTotal", count _plan] };
    private _stats = _cmdr get "_stats";
    _stats set ["replans", (_stats get "replans") + 1];
};
if ((_track get "status") == "IDLE") then {
    private _start = diag_tickTime;
    private _plan = _planner call ["_plan", [_goal, _track get "goalParams", _executor]];
    _metrics set ["planCalls", (_metrics get "planCalls") + 1];
    _metrics set ["planMs", (_metrics get "planMs") + ((diag_tickTime - _start) * 1000)];
    if (!isNil "_plan") then {
        _metrics set ["plansCreated", (_metrics get "plansCreated") + 1];
        _metrics set ["planTaskTotal", count _plan];
        _monitor call ["_setCurrentGoal", [_goal, _track get "goalParams"]];
    };
    _track set ["status", "RUNNING"];
};
private _limit = ((_cmdr get "_config") get "maxTrackTasksPerCycle") max 1;
private _started = 0;
private _steps = 0;
private _continue = true;
// Structural goal checkpoints consume a bounded node budget, not order budget.
while {_continue && {_steps < 32} && {(_planner get "_planStatus") in ["PENDING", "RUNNING"]}} do {
    private _node = _planner call ["_getCurrentTask", []];
    if ((_node get "kind") == "TASK" && {(_node get "status") == "PENDING"} && {_started >= _limit}) exitWith {};
    private _start = diag_tickTime;
    private _step = _planner call ["_step", [_executor, _track]];
    private _ms = (diag_tickTime - _start) * 1000;
    _steps = _steps + 1;
    if (_step get "started") then {
        _started = _started + 1;
        _metrics set ["primitiveExecCalls", (_metrics get "primitiveExecCalls") + 1];
        _metrics set ["primitiveExecMs", (_metrics get "primitiveExecMs") + _ms];
        _metrics set ["tasksExecuted", (_metrics get "tasksExecuted") + 1];
        private _stats = _cmdr get "_stats";
        _stats set ["tasksExecuted", (_stats get "tasksExecuted") + 1];
        if ((_node get "status") == "SUCCESS") then { _metrics set ["syncSuccesses", (_metrics get "syncSuccesses") + 1] };
    } else {
        _metrics set ["checkCalls", (_metrics get "checkCalls") + 1];
        _metrics set ["checkMs", (_metrics get "checkMs") + _ms];
    };
    _continue = _step get "progress";
};
private _stats = _cmdr get "_stats";
_stats set ["plansCreated", (_stats get "plansCreated") + (_metrics get "plansCreated")];
switch (_planner get "_planStatus") do {
    case "SUCCESS": {
        _metrics set ["plansCompleted", 1];
        _track set ["status", ["COMPLETE", "IDLE"] select (_definition get "repeat")];
    };
    case "FAILED": {
        _metrics set ["plansFailed", 1];
        _track set ["status", "IDLE"];
        _track set ["retryAt", diag_tickTime + (_monitor get "_replanCooldown")];
    };
};
_metrics
