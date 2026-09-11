params ["_commander", "_intent"];
private _id = _intent get "id";
private _world = _commander get "_worldState";
private _planner = [_commander get "_goalLibrary", _world] call FLO_fnc_gtnPlanner;
_planner set ["_trackId", _id];
_planner set ["_intentId", _id];
private _monitor = [_planner, _world] call FLO_fnc_gtnMonitor;
_monitor call ["_setThresholds", [(_commander get "_config") get "casualtyThreshold", (_commander get "_config") get "replanInterval"]];
private _goal = switch (_intent get "kind") do {
    case "CAPTURE": { "capture_objective" };
    case "GARRISON";
    case "DEFEND": { "secure_friendly_objective" };
    default { "support_objective" };
};
private _track = createHashMapFromArray [
    ["id", _id], ["goal", _goal], ["goalParams", [_id]], ["role", _intent get "kind"],
    ["planner", _planner], ["monitor", _monitor], ["status", "IDLE"], ["retryAt", -1],
    ["groupPool", +(_intent get "groupIds")]
];
(_commander get "_tracks") pushBack _track;
_track
