/* A detached planning view contains the intent's forces and objective neighborhood. */
params ["_world", "_intentId"];
private _intent = ((_world get "_commander") get "_intents") get _intentId;
private _allObjectives = _world get "_objectives";
private _objectives = createHashMap;
private _ids = [_intent get "objectiveId", _intent get "stageObjective"];
{
    if (_x in _allObjectives) then {
        _ids append ((_allObjectives get _x) get "linkedObjectives");
    };
} forEach +_ids;
{ if (_x in _allObjectives) then { _objectives set [_x, +(_allObjectives get _x)] } } forEach _ids;
private _groups = createHashMap;
private _facts = _world get "_ownGroupFacts";
{ if (_x in _facts) then { _groups set [_x, +(_facts get _x)] } } forEach (_intent get "groupIds");
createHashMapFromArray [
    ["intent", +_intent], ["objectives", _objectives], ["groups", _groups],
    ["forceAtStage", [_world get "_commander", _intent, true] call FLO_fnc_gtnIntentForceReady],
    ["ownSide", _world get "_ownSide"], ["forces", +(_world get "_ownForces")],
    ["assets", +(_world get "_supportAssets")], ["time", diag_tickTime]
]
