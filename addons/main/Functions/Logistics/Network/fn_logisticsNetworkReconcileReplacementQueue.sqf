/* Interleaves missing types while preserving the saved head as the next turn.
 * A one-creation work window advances to another type on the next pass.
 */
params ["_queue", "_neededCounts", "_priority"];
private _remaining = createHashMap;
{ if !(_x in _priority) then { throw format ["Unprioritized replacement type %1", _x]; }; _remaining set [_x, _y]; } forEach _neededCounts;
{ if !(_x in _priority) then { throw format ["Unprioritized queued replacement type %1", _x]; }; } forEach _queue;
private _turns = [];
{ if ((_remaining getOrDefault [_x, 0]) > 0) then { _turns pushBackUnique _x; }; } forEach (_queue + _priority);
private _result = [];
while {_turns isNotEqualTo []} do {
    private _nextTurns = [];
    {
        _result pushBack _x;
        private _count = (_remaining get _x) - 1;
        _remaining set [_x, _count];
        if (_count > 0) then { _nextTurns pushBack _x; };
    } forEach _turns;
    _turns = _nextTurns;
};
_result
