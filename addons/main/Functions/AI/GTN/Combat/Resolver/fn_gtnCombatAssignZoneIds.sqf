/* Matches the complete contact pass by surviving participants, never by objective.
 * Largest overlap keeps continuity through merges/splits; an ID can be claimed
 * only once per pass. A split child starts fresh instead of copying momentum.
 */
params ["_zones"];
private _state = call FLO_fnc_gtnCombatGetState;
private _previous = _state get "zoneTracks";
private _memberOwners = createHashMap;
{
    private _id = _x;
    { _memberOwners set [_x, _id]; } forEach _y;
} forEach _previous;

private _membersByZone = [];
private _matches = [];
{
    private _zoneIndex = _forEachIndex;
    private _members = ((_x select 0) + (_x select 1)) apply { _x select 0 };
    _members sort true;
    _membersByZone pushBack _members;
    private _overlaps = createHashMap;
    {
        if !(_x in _memberOwners) then { continue };
        private _id = _memberOwners get _x;
        _overlaps set [_id, (_overlaps getOrDefault [_id, 0]) + 1];
    } forEach _members;
    { _matches pushBack [-_y, _x, _members select 0, _zoneIndex]; } forEach _overlaps;
} forEach _zones;
_matches sort true;
private _assigned = createHashMap;
private _claimed = createHashMap;
{
    _x params ["_overlap", "_id", "_firstMember", "_index"];
    if (_index in _assigned || {_id in _claimed}) then { continue };
    _assigned set [_index, _id];
    _claimed set [_id, true];
} forEach _matches;

private _next = createHashMap;
private _ids = [];
{
    private _index = _forEachIndex;
    private _id = if (_index in _assigned) then { _assigned get _index } else {
        private _sequence = (_state get "nextZoneId") + 1;
        _state set ["nextZoneId", _sequence];
        format ["engagement_%1", _sequence]
    };
    _next set [_id, _x];
    _ids pushBack _id;
} forEach _membersByZone;
// Retired identities cannot be revived by a later split or an unrelated fight.
private _engagements = _state get "engagements";
{ if !(_x in _next) then { _engagements deleteAt _x; }; } forEach (keys _previous);
_state set ["zoneTracks", _next];
_ids
