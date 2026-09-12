/* Strategic orchestration: maintain perception, execute intent, admit new goals. */
params ["_commander"];
private _started = diag_tickTime;
private _startFrame = diag_frameNo;
private _snapshotBefore = +((_commander get "_perf") get "snapshotTotals");
private _phaseMs = createHashMap;
private _world = _commander get "_worldState";
private _stats = _commander get "_stats";
private _config = _commander get "_config";
_commander set ["_lastUpdate", _started];
_stats set ["cyclesRun", (_stats get "cyclesRun") + 1];
_commander call ["_resetStrategicOrderBudget", []];
_commander call ["_normalizeTaskedGroups", []];
private _at = diag_tickTime;
_world call ["_update", []];
_phaseMs set ["worldState", (diag_tickTime - _at) * 1000];
_at = diag_tickTime;
private _strategicAt = _at;
private _strategicPhases = createHashMap;
private _objectives = _world get "_objectives";
private _signature = [_objectives, _commander get "_ownSide"] call FLO_fnc_gtnBuildFriendlyObjectiveOwnershipSignature;
if (_signature != (_commander get "_lastFriendlyObjectiveOwnershipSignature")) then {
    _commander set ["_attackFrontlineDirty", true];
    _commander set ["_reserveBandsCache", createHashMap];
    _commander set ["_attackSourceObjectivesCache", createHashMap];
    _commander set ["_lastFriendlyObjectiveOwnershipSignature", _signature];
};
_commander call ["_refreshAttackFrontline", []];
_strategicPhases set ["frontline", (diag_tickTime - _strategicAt) * 1000];
_strategicAt = diag_tickTime;
_commander call ["_manageCompletedAttackAssignments", []];
_strategicPhases set ["completedAssignments", (diag_tickTime - _strategicAt) * 1000];
_strategicAt = diag_tickTime;
_commander call ["_manageDefenseLeases", []];
_strategicPhases set ["defenseLeases", (diag_tickTime - _strategicAt) * 1000];
_strategicAt = diag_tickTime;
[_commander] call FLO_fnc_gtnReleaseObsoleteHolds;
_strategicPhases set ["obsoleteHolds", (diag_tickTime - _strategicAt) * 1000];
_strategicAt = diag_tickTime;
_commander set ["_objectiveAssignmentCache", [_commander] call FLO_fnc_gtnBuildObjectiveAssignmentCache];
_strategicPhases set ["assignmentIndex", (diag_tickTime - _strategicAt) * 1000];
_strategicAt = diag_tickTime;
private _supportDue = (_commander get "_frontlineSupportPictureBuiltAt") < 0
    || {_started - (_commander get "_frontlineSupportPictureBuiltAt") >= (_config get "frontlineSupportPictureIntervalSeconds")};
if (_supportDue) then {
    _commander set ["_frontlineSupportPicture", [_commander, _commander call ["_getAttackFrontlineEnemyObjectives", []]] call FLO_fnc_gtnBuildFrontlineSupportPicture];
    _commander set ["_frontlineSupportPictureBuiltAt", _started];
};
_strategicPhases set ["supportPicture", (diag_tickTime - _strategicAt) * 1000];
_strategicAt = diag_tickTime;
[_commander] call FLO_fnc_gtnBuildStrategicPicture;
_strategicPhases set ["objectiveStrategy", (diag_tickTime - _strategicAt) * 1000];
_strategicAt = diag_tickTime;
[_commander] call FLO_fnc_gtnManageFrontlineMinefields;
_strategicPhases set ["minefields", (diag_tickTime - _strategicAt) * 1000];
_phaseMs set ["strategicPicture", (diag_tickTime - _at) * 1000];
_at = diag_tickTime;
private _execution = [_commander] call FLO_fnc_gtnExecuteIntents;
_phaseMs set ["execution", (diag_tickTime - _at) * 1000];
_at = diag_tickTime;
[_commander] call FLO_fnc_gtnBuildGoalAgenda;
private _agenda = [_commander] call FLO_fnc_gtnAdmitGoalAgenda;
_phaseMs set ["agenda", (diag_tickTime - _at) * 1000];
_at = diag_tickTime;
private _playerSupport = [_commander] call FLO_fnc_gtnProcessPlayerSupportRequests;
_commander call ["_manageStaticAANetwork", []];
private _owners = [_commander get "_ownSide"] call FLO_fnc_gtnGetSideClientOwners;
if (_owners isNotEqualTo [] && {(_commander get "_intelDirty") || {_started - (_commander get "_lastIntelPublishAt") >= (_config get "intelPublishMinInterval")}}) then {
    private _published = [_commander, _owners] call FLO_fnc_gtnPublishCommanderIntel;
    if (_published get "published") then {
        _commander set ["_lastIntelPublishAt", _started];
        _commander set ["_intelDirty", false];
    };
};
_phaseMs set ["services", (diag_tickTime - _at) * 1000];
private _elapsed = (diag_tickTime - _started) * 1000;
private _perf = _commander get "_perf";
private _snapshotTotals = _perf get "snapshotTotals";
private _snapshotMetrics = [];
{ _snapshotMetrics pushBack (_x - (_snapshotBefore select _forEachIndex)) } forEach _snapshotTotals;
_perf set ["lastSnapshotMetrics", _snapshotMetrics];
_perf set ["lastCycleMs", _elapsed];
_perf set ["peakCycleMs", (_perf get "peakCycleMs") max _elapsed];
_perf set ["lastPhaseMs", _phaseMs];
_perf set ["lastStrategicPhaseMs", _strategicPhases];
_perf set ["lastCycleFrames", diag_frameNo - _startFrame];
_perf set ["lastMetrics", createHashMapFromArray [
    ["cycleIndex", _stats get "cyclesRun"], ["agenda", _agenda], ["execute", _execution],
    ["trackCount", count (_commander get "_tracks")], ["taskedCount", count (_commander get "_gtnTaskedGroups")],
    ["playerSupport", _playerSupport], ["strategicOrderBudget", _commander call ["_getStrategicOrderBudgetMetrics", []]]
]];
if (_elapsed >= (_perf get "logThresholdMs")) then {
    _perf set ["slowCycles", (_perf get "slowCycles") + 1];
    ["GTN", 4, format ["[PERF] %1 cycle=%2 ms=%3 phases=%4 snapshots=%10 agenda=%5 active=%6 execution=%7 strategic=%8 frames=%9", _commander get "_sideKey", _stats get "cyclesRun", _elapsed, _phaseMs, _agenda, count (_commander get "_intents"), _execution, _strategicPhases, _perf get "lastCycleFrames", _snapshotMetrics]] call FLO_fnc_log;
};
true
