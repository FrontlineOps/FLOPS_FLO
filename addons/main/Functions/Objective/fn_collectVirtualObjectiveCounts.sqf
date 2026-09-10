/* Count each virtual force at its nearest containing objective across the whole map.
 * The per-pass broad phase reads current geometry and group positions, so it never
 * reuses stale capture results or depends on the monitor's round-robin slice.
 */
params ["_objectiveIds", "_liveObjectives", ["_workload", []]];

private _counts = createHashMap;
{ _counts set [_x, [0, 0]] } forEach _objectiveIds;
if (_objectiveIds isEqualTo [] || {isNil "FLO_VirtualForceRegistry"}) exitWith { _counts };

private _cellSize = 1000;
private _cells = createHashMap;
{
    private _id = _x;
    private _objective = _y;
    private _pos = _objective get "position";
    private _radius = _objective get "radius";
    private _entry = [_id, _pos, _radius];
    private _minX = floor (((_pos select 0) - _radius) / _cellSize);
    private _maxX = floor (((_pos select 0) + _radius) / _cellSize);
    private _minY = floor (((_pos select 1) - _radius) / _cellSize);
    private _maxY = floor (((_pos select 1) + _radius) / _cellSize);
    for "_cx" from _minX to _maxX do {
        for "_cy" from _minY to _maxY do {
            private _key = [_cx, _cy];
            if !(_key in _cells) then { _cells set [_key, []] };
            (_cells get _key) pushBack _entry;
        };
    };
} forEach FLO_Objectives;

private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _eligible = 0;
private _checks = 0;
{
    private _group = _y;
    if (_group get "isActive") then { continue };
    if ((_group get "unitCount") <= 0) then { continue };
    if (([_group] call FLO_fnc_virtualizationGetTransportAttachment) != "") then { continue };
    if !([_group get "groupType"] call FLO_fnc_gtnCombatIsDirectCombatGroup) then { continue };
    _eligible = _eligible + 1;

    private _pos = _group get "position";
    private _key = [floor ((_pos select 0) / _cellSize), floor ((_pos select 1) / _cellSize)];
    if !(_key in _cells) then { continue };
    private _nearestId = "";
    private _nearestDistance = 1e10;
    {
        _x params ["_id", "_center", "_radius"];
        _checks = _checks + 1;
        private _distance = _pos distance2D _center;
        if (_distance < _radius && {_distance < _nearestDistance}) then {
            _nearestId = _id;
            _nearestDistance = _distance;
        };
    } forEach (_cells get _key);
    if !(_nearestId in _counts) then { continue };
    if (_nearestId in _liveObjectives) then { continue };
    private _side = _group get "side";
    if !(_side in [west, east]) then { continue };
    private _sideIndex = parseNumber (_side isEqualTo east);
    private _entry = _counts get _nearestId;
    _entry set [_sideIndex, (_entry select _sideIndex) + (_group get "unitCount")];
} forEach _groups;

_workload append [count _groups, _eligible, count _cells, _checks];
_counts
