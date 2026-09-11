/* Reserve a concrete force before admitting the objective network. */
params ["_commander", "_kind", "_objectiveId", "_groupIds", "_stageObjective", "_stagePos", "_targetPos", "_score"];
private _serial = (_commander get "_nextIntentId") + 1;
_commander set ["_nextIntentId", _serial];
private _id = format ["%1_%2", _commander get "_sideKey", _serial];
private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _units = 0;
private _power = 0;
{
    private _group = _groups get _x;
    if ((_group get "commanderIntent") != "") then { throw format ["GTN cannot reserve owned group %1", _x] };
    _units = _units + (_group get "unitCount");
    _power = _power + (([_commander get "_capabilityAnalyzer", _group] call FLO_fnc_gtnAnalyzeManeuverGroup) get "power");
} forEach _groupIds;
private _phase = switch (_kind) do {
    case "CAPTURE": { "MUSTER" };
    case "GARRISON";
    case "DEFEND": { "DISPATCH" };
    default { "REQUEST" };
};
private _intent = createHashMapFromArray [
    ["id", _id], ["kind", _kind], ["objectiveId", _objectiveId],
    ["stageObjective", _stageObjective], ["stagePos", +_stagePos], ["targetPos", +_targetPos],
    ["groupIds", +_groupIds], ["issued", []], ["phase", _phase],
    ["phaseStartedAt", diag_tickTime], ["initialUnits", _units], ["initialPower", _power],
    ["score", _score], ["scoutAttempt", 0]
];
(_commander get "_intents") set [_id, _intent];
{ (_groups get _x) set ["commanderIntent", _id] } forEach _groupIds;
_commander call ["_taskGroups", [_groupIds]];
[_commander, _intent] call FLO_fnc_gtnCreateIntentTrack;
["GTN", 3, format ["%1 intent admitted %2 %3 objective=%4 groups=%5 score=%6", _commander get "_sideKey", _id, _kind, _objectiveId, count _groupIds, round _score]] call FLO_fnc_log;
_intent
