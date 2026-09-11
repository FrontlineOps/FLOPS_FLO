/* Associate fresh reports with objective geometry; capture counts never enter this view. */
params ["_worldState"];
private _started = diag_tickTime;
private _objectives = _worldState get "_objectives";
private _contacts = (_worldState get "_enemyIntel") get "contactReports";
private _recon = _worldState get "_objectiveIntel";
private _now = diag_tickTime;
private _maxAge = _worldState get "_objectiveIntelMaxAge";
private _cellSize = 500;
private _cells = createHashMap;
private _observations = createHashMap;
{
    private _pos = _y get "position";
    private _radius = _y get "radius";
    for "_cx" from floor (((_pos select 0) - _radius) / _cellSize) to floor (((_pos select 0) + _radius) / _cellSize) do {
        for "_cy" from floor (((_pos select 1) - _radius) / _cellSize) to floor (((_pos select 1) + _radius) / _cellSize) do {
            private _key = format ["%1:%2", _cx, _cy];
            if !(_key in _cells) then { _cells set [_key, []] };
            (_cells get _key) pushBack _x;
        };
    };
    _observations set [_x, createHashMapFromArray [["observed", 0], ["combat", 0], ["time", -1], ["confidence", 0]]];
} forEach _objectives;
{ _y sort true } forEach _cells;
private _latest = createHashMap;
{
    _x params ["_pos", "_time", "_strength", "_type", "_confidence", ["_object", objNull], ["_groupId", ""], ["_zoneId", ""]];
    if (_time > _now || {_now - _time > _maxAge} || {_confidence < 0.25} || {_strength <= 0}) then { continue };
    private _key = if (_type == "combat") then { "COMBAT:" + _zoneId } else {
        if (!isNull _object) then { "ENTITY:" + str _object } else {
            if (_groupId != "") then { "GROUP:" + _groupId } else { format ["REPORT:%1:%2", _type, _pos] }
        }
    };
    if !(_key in _latest) then { _latest set [_key, _x] } else {
        if (((_latest get _key) select 1) <= _time) then { _latest set [_key, _x] };
    };
} forEach _contacts;
private _candidateChecks = 0;
{
    _y params ["_pos", "_time", "_strength", "_type", "_confidence"];
    private _cell = format ["%1:%2", floor ((_pos select 0) / _cellSize), floor ((_pos select 1) / _cellSize)];
    if !(_cell in _cells) then { continue };
    private _nearest = "";
    private _best = 1e12;
    {
        private _objective = _objectives get _x;
        private _distance = _pos distance2D (_objective get "position");
        _candidateChecks = _candidateChecks + 1;
        if (_distance <= (_objective get "radius") && {_distance < _best}) then {
            _nearest = _x;
            _best = _distance;
        };
    } forEach (_cells get _cell);
    if (_nearest == "") then { continue };
    private _observation = _observations get _nearest;
    if (_type == "combat") then {
        // Battle reports overlap individual observations; never add both counts.
        _observation set ["combat", (_observation get "combat") max (4 * ceil (_strength / 4))];
    } else { _observation set ["observed", (_observation get "observed") + _strength] };
    _observation set ["time", (_observation get "time") max _time];
    _observation set ["confidence", (_observation get "confidence") max (_confidence min 1)];
} forEach _latest;
private _known = 0;
{
    private _observation = _observations get _x;
    private _time = _observation get "time";
    private _confidence = _observation get "confidence";
    private _enemyCount = if (_time >= 0) then { (_observation get "observed") max (_observation get "combat") } else { -1 };
    if (_x in _recon) then {
        private _report = _recon get _x;
        if ("observedUnits" in _report) then {
            private _reconTime = _report get "areaObservationTime";
            private _quality = _report get "areaObservationConfidence";
            if ((_report get "areaObserved" || {(_report get "observedUnits") > 0}) && {_quality >= 0.5} && {_reconTime >= _time} && {_reconTime <= _now} && {_now - _reconTime <= _maxAge}) then {
                _enemyCount = _report get "observedUnits";
                _time = _reconTime;
                _confidence = _quality;
            };
        };
    };
    private _friendly = _y get "friendlyCount";
    private _owner = _y get "owner";
    private _knownStrength = _enemyCount >= 0;
    if (_knownStrength) then { _known = _known + 1 };
    _y set ["enemyCount", _enemyCount];
    _y set ["enemyStrengthKnown", _knownStrength];
    _y set ["enemyIntelTime", _time];
    _y set ["enemyIntelConfidence", _confidence];
    _y set ["contested", _friendly > 0 && {_enemyCount > 0}];
    _y set ["underAttack", _owner == (_worldState get "_ownSide") && {_enemyCount > 0}];
    _y set ["vulnerable", _owner == (_worldState get "_enemySide") && {_knownStrength} && {_enemyCount == 0} && {_friendly < 3}];
    _y set ["forceRatio", if (!_knownStrength) then { -1 } else { if (_enemyCount > 0) then { _friendly / _enemyCount } else {999} }];
} forEach _objectives;
private _ms = (diag_tickTime - _started) * 1000;
_worldState set ["_objectiveObservationMetrics", createHashMapFromArray [["objectives", count _objectives], ["reports", count _contacts], ["distinctReports", count _latest], ["candidateChecks", _candidateChecks], ["known", _known], ["totalMs", _ms]]];
if (_ms >= 20) then { ["GTN", 4, format ["Objective observations objectives=%1 reports=%2 distinct=%3 candidates=%4 known=%5 ms=%6", count _objectives, count _contacts, count _latest, _candidateChecks, _known, _ms]] call FLO_fnc_log };
true
