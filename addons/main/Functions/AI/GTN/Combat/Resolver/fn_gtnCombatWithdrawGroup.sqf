/* GTN orders a defeated/depleted maneuver group back to reported friendly cover.
 * Garrisons and mission-owned groups remain with their current owners. The
 * canonical MOVE route persists; WITHDRAW allows movement under incoming fire.
 */
params ["_commander", "_groupId", "_groupData", "_contactPos"];
if ((_groupData get "missionLock") != "" || {(_groupData get "replacementState") != ""}) exitWith { false };
if ((_groupData get "commanderOrder") == "GARRISON" || {_groupData get "transportRole"}) exitWith { false };
if ((_groupData get "orderMode") == "WITHDRAW") exitWith { false };
if ((_groupData get "attachedGroups") isNotEqualTo [] || {(_groupData get "attachedTo") != ""}) exitWith { false };
private _world = _commander get "_worldState";
private _previousIntent = _groupData get "commanderIntent";
private _objectives = _world call ["_getObjectives", []];
private _side = _commander get "_ownSide";
private _position = _groupData get "position";
private _candidates = [];
{
    private _objective = _y;
    if ((_objective get "owner") != _side || {(_objective get "enemyCount") > 0}) then { continue };
    if ((_objective get "enemyCount") < 0 && {(_objective get "friendlyCount") <= 0}) then { continue };
    if (_objective get "contested" || {_objective get "underAttack"}) then { continue };
    if !([_x] call FLO_fnc_campaignIsObjectiveIntegrated) then { continue };
    private _target = _objective get "position";
    private _distance = _position distance2D _target;
    if (_distance < 100 || {_distance > 5000} || {_target distance2D _contactPos < 600}) then { continue };
    _candidates pushBack [
        parseNumber (_x != (_groupData get "homeObjective")),
        -((_objective get "friendlyCount") min 20),
        _distance,
        _x,
        _target
    ];
} forEach _objectives;
_candidates sort true;
private _ordered = false;
{
    if (_forEachIndex >= 3) exitWith {};
    private _target = _x select 4;
    private _result = [_groupId, _groupData, "MOVE", [[_target, "MOVE", "AWARE", "FULL", "COLUMN", "YELLOW", 30]], _target, "GTN_WITHDRAW", "", "WITHDRAW"] call FLO_fnc_virtualizationCommitCommanderOrder;
    if (_result select 0) exitWith {
        _commander call ["_taskGroups", [[_groupId]]];
        _ordered = true;
    };
} forEach _candidates;
if (_ordered && {_previousIntent != ""}) then {
    // Tactical withdrawal supersedes the operation at the same ownership boundary.
    // Retiring compensation clears ownership before requesting other withdrawals.
    [_commander, (_commander get "_intents") get _previousIntent, false, "TACTICAL_WITHDRAWAL"] call FLO_fnc_gtnRetireIntent;
};
_ordered
