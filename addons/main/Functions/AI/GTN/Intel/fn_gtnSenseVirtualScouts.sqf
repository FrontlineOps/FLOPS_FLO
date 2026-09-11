/* A tasked scout reports only local visible contacts; active groups use live sensors. */
params ["_world"];
private _started = diag_tickTime;
private _commander = _world get "_commander";
private _intents = _commander get "_intents";
private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _objectives = _world get "_objectives";
private _ids = keys _intents;
_ids sort true;
private _range = 900 * ((1 - fog) max 0.25) * ([0.55, 1] select (sunOrMoon > 0.2));
private _scanned = 0;
private _candidates = 0;
private _checks = 0;
private _reports = 0;
private _contacts = (_world get "_enemyIntel") get "contactReports";
private _reportIndex = createHashMap;
{if (count _x > 6 && {(_x select 6) != ""}) then {_reportIndex set [_x select 6, _forEachIndex]}} forEach _contacts;
private _cursor = _world get "_scoutCursor";
if (_ids isNotEqualTo []) then {
    _cursor = _cursor mod count _ids;
    _ids = (_ids select [_cursor]) + (_ids select [0, _cursor]);
};
private _visited = 0;
{
    if (_scanned >= 8) exitWith {};
    _visited = _visited + 1;
    private _intent = _intents get _x;
    if ((_intent get "phase") != "SCOUT" || {(_intent get "groupIds") isEqualTo []}) then { continue };
    private _scoutId = (_intent get "groupIds") select 0;
    if !(_scoutId in _groups) then { continue };
    private _scout = _groups get _scoutId;
    if (_scout get "isActive" || {(_scout get "unitCount") <= 0} || {(_scout get "attachedTo") != ""} || {(_scout get "mountedIn") != ""}) then { continue };
    private _position = _scout get "position";
    private _objectiveId = _intent get "objectiveId";
    private _objective = _objectives get _objectiveId;
    private _center = _objective get "position";
    private _radius = _objective get "radius";
    if (_position distance2D _center > _range + _radius) then { continue };
    _scanned = _scanned + 1;
    private _near = ["queryRadius", [_position, _range, _world get "_enemySide", true]] call FLO_fnc_virtualizationSpatialIndex;
    _candidates = _candidates + count _near;
    private _observed = 0;
    private _power = 0;
    private _hasArmor = false;
    private _complete = count _near <= 32;
    {
        if (_forEachIndex >= 32) exitWith {};
        private _enemy = _groups get _x;
        if ((_enemy get "position") distance2D _center > _radius) then { continue };
        if ((_enemy get "unitCount") <= 0 || {(_enemy get "groupType") in ["helicopter", "air"]}) then { continue };
        _checks = _checks + 1;
        if !([_position, _enemy get "position", _range] call FLO_fnc_gtnGroundVisibility) then { _complete = false; continue };
        private _strength = _enemy get "unitCount";
        _observed = _observed + _strength;
        private _profile = [_commander get "_capabilityAnalyzer", _enemy] call FLO_fnc_gtnAnalyzeManeuverGroup;
        _power = _power + (_profile get "power");
        _hasArmor = _hasArmor || {_profile get "hasArmor"};
        private _reportedPos = (_enemy get "position") apply {round (_x / 100) * 100};
        private _report = [_reportedPos, diag_tickTime, _strength, _enemy get "spawnClass", 0.65, objNull, _x, ""];
        if (_x in _reportIndex) then {
            _contacts set [_reportIndex get _x, _report];
        } else { _reportIndex set [_x, _contacts pushBack _report] };
        _reports = _reports + 1;
    } forEach _near;
    // Clearance needs coverage of the full radius as well as unobstructed sectors.
    if ((_position distance2D _center) + _radius > _range) then { _complete = false };
    if (_complete) then {
        private _points = [_center];
        { _points pushBack (_center getPos [_radius, _x]) } forEach [0,45,90,135,180,225,270,315];
        {
            _checks = _checks + 1;
            if !([_position, _x, _range] call FLO_fnc_gtnGroundVisibility) exitWith { _complete = false };
        } forEach _points;
    };
    if (_observed > 0 || {_complete}) then {
        _world call ["_updateObjectiveIntel", [_objectiveId, createHashMapFromArray [
            ["intelQuality", 0.65], ["groundPower", _power], ["hasArmor", _hasArmor],
            ["observedUnits", _observed], ["areaObserved", _complete]
        ], true]];
    };
} forEach _ids;
_world set ["_scoutCursor", _cursor + _visited];
private _ms = (diag_tickTime - _started) * 1000;
_world set ["_scoutMetrics", createHashMapFromArray [["scouts", _scanned], ["candidates", _candidates], ["visibilityChecks", _checks], ["reports", _reports], ["ms", _ms]]];
if (_ms >= 20) then { ["GTN", 4, format ["[PERF] Scout perception scouts=%1 candidates=%2 checks=%3 reports=%4 ms=%5", _scanned, _candidates, _checks, _reports, _ms]] call FLO_fnc_log };
true
