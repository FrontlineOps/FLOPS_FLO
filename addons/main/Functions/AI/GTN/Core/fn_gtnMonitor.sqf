/* A monitor belongs to the same planner that executes its track. */
params ["_planner", "_worldState"];
createHashMapObject [[
    ["_planner", _planner], ["_worldState", _worldState], ["_planSnapshot", nil],
    ["_currentGoal", ""], ["_currentGoalParams", []], ["_lastReplanTime", -1],
    ["_minReplanInterval", 60], ["_replanCooldown", 30], ["_casualtyThreshold", 0.2],
    ["_lastTriggers", []], ["_stats", createHashMapFromArray [["checksPerformed", 0], ["replansTriggered", 0]]],
    ["_takeSnapshot", {
        private _snapshot = (_self get "_planner") call ["_getState", []];
        _self set ["_planSnapshot", _snapshot];
        _snapshot
    }],
    ["_setCurrentGoal", {
        params ["_goal", ["_params", []]];
        _self set ["_currentGoal", _goal];
        _self set ["_currentGoalParams", +_params];
        _self set ["_lastReplanTime", diag_tickTime];
        _self call ["_takeSnapshot", []];
    }],
    ["_checkReplanTriggers", {
        private _stats = _self get "_stats";
        _stats set ["checksPerformed", (_stats get "checksPerformed") + 1];
        private _snapshot = _self get "_planSnapshot";
        if (isNil "_snapshot") exitWith { false };
        if (diag_tickTime - (_self get "_lastReplanTime") < (_self get "_minReplanInterval")) exitWith { false };
        private _changes = [_snapshot, (_self get "_planner") call ["_getState", []], _self get "_casualtyThreshold"] call FLO_fnc_gtnWorldStateChanges;
        _self set ["_lastTriggers", _changes];
        _changes isNotEqualTo []
    }],
    ["_triggerReplan", {
        params ["_executor"];
        private _goal = _self get "_currentGoal";
        if (_goal == "") then { throw "GTN monitor has no current goal" };
        _self set ["_lastReplanTime", diag_tickTime];
        private _stats = _self get "_stats";
        _stats set ["replansTriggered", (_stats get "replansTriggered") + 1];
        ["GTN", 3, format ["Replanning %1: %2", _goal, _self get "_lastTriggers"]] call FLO_fnc_log;
        private _plan = (_self get "_planner") call ["_replan", [_goal, _self get "_currentGoalParams", _executor]];
        if (isNil "_plan") exitWith { nil };
        _self call ["_takeSnapshot", []];
        _plan
    }],
    ["_setThresholds", {
        params [["_casualty", nil], ["_interval", nil]];
        if (!isNil "_casualty") then {
            if !(_casualty isEqualType 0 && {_casualty > 0} && {_casualty <= 1}) then { throw "GTN casualty threshold must be in (0,1]" };
            _self set ["_casualtyThreshold", _casualty];
        };
        if (!isNil "_interval") then {
            if !(_interval isEqualType 0 && {_interval >= 0}) then { throw "GTN replan interval must be nonnegative" };
            _self set ["_minReplanInterval", _interval];
        };
    }],
    ["_getCurrentGoal", { _self get "_currentGoal" }], ["_getStats", { _self get "_stats" }],
    ["_debugPrint", { format ["GTN monitor goal=%1 replans=%2 triggers=%3", _self get "_currentGoal", (_self get "_stats") get "replansTriggered", _self get "_lastTriggers"] }]
]]
