/* A detached planning view contains the intent's forces and objective neighborhood. */
params ["_world", "_intentId"];
private _started = diag_tickTime;
private _commander = _world get "_commander";
private _intent = (_commander get "_intents") get _intentId;
private _allObjectives = _world get "_objectives";
private _objectives = createHashMap;
private _ids = [_intent get "objectiveId", _intent get "stageObjective"];
{
    if (_x in _allObjectives) then {
        _ids append ((_allObjectives get _x) get "linkedObjectives");
    };
} forEach +_ids;
// Staging and target neighborhoods overlap; each fresh view needs one copy per objective.
{ if (_x in _allObjectives) then { _objectives set [_x, +(_allObjectives get _x)] } } forEach (_ids arrayIntersect _ids);
private _objectiveMs = (diag_tickTime - _started) * 1000;
private _groups = createHashMap;
private _facts = _world get "_ownGroupFacts";
{ if (_x in _facts) then { _groups set [_x, +(_facts get _x)] } } forEach (_intent get "groupIds");
private _readyStarted = diag_tickTime;
private _forceAtStage = [_commander, _intent, true] call FLO_fnc_gtnIntentForceReady;
private _readyMs = (diag_tickTime - _readyStarted) * 1000;
private _snapshot = createHashMapFromArray [
    ["intent", +_intent], ["objectives", _objectives], ["groups", _groups],
    ["forceAtStage", _forceAtStage],
    ["ownSide", _world get "_ownSide"], ["forces", +(_world get "_ownForces")],
    ["assets", +(_world get "_supportAssets")], ["time", diag_tickTime]
];
// Cumulative counters let the cycle owner measure every planner/checkpoint call.
// calls, total ms, objective-copy ms, readiness ms, requested IDs, unique IDs, groups
private _totals = (_commander get "_perf") get "snapshotTotals";
private _sample = [1, (diag_tickTime - _started) * 1000, _objectiveMs, _readyMs, count _ids, count _objectives, count _groups];
{ _totals set [_forEachIndex, (_totals select _forEachIndex) + _x] } forEach _sample;
_snapshot
