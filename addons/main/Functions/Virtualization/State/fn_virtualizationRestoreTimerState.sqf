/* Rebase current saved clocks from their required epoch and elapsed offsets. */
params ["_groupData", "_savedData", ["_now", diag_tickTime, [0]], ["_apply", true, [true]]];

if !("timerSampleTick" in _savedData && {"timerElapsedOffsets" in _savedData}) then {
    throw "Saved group is missing its timer epoch or elapsed offsets";
};
private _sample = _savedData get "timerSampleTick";
private _offsets = _savedData get "timerElapsedOffsets";
if !(_sample isEqualType 0 && {finite _sample} && {_sample >= 0} && {_offsets isEqualType createHashMap}) then {
    throw "Saved group has malformed timer epoch or elapsed offsets";
};
{
    if !(_x in _offsets) then { throw format ["Saved group is missing timer offset %1", _x] };
    private _offset = _offsets get _x;
    if !(_offset isEqualType 0 && {finite _offset} && {_offset >= 0}) then {
        throw format ["Saved group has invalid timer offset %1", _x];
    };
} forEach ["civilianLastIntelAt"];

{
    private _value = _savedData get _x;
    if !(_value isEqualType 0 && {finite _value} && {_value == -1 || {_value >= 0}}) then {
        throw format ["Saved group %1 has invalid timer %2", _savedData get "id", _x];
    };
    private _restored = -1;
    if (_value >= 0) then {
        _restored = _now + ((_value - _sample) max 0);
    };
    if (_apply) then { _groupData set [_x, _restored] };
} forEach ["defendLeaseUntil", "civilianRoutineUntil"];

{
    _x params ["_field", "_offsetField"];
    private _value = _savedData get _field;
    if !(_value isEqualType 0 && {finite _value} && {_value == -1 || {_value >= 0}}) then {
        throw format ["Saved group %1 has invalid timer %2", _savedData get "id", _field];
    };
    private _age = 0;
    if (_value >= 0) then {
        _age = (_sample - _value) max 0;
        if (_offsetField != "") then { _age = _age + (_offsets get _field) };
    };
    if (_apply) then {
        _groupData set [_field, if (_value < 0) then { -1 } else { (_now - _age) max 0 }];
        if (_offsetField != "") then {
            _groupData set [_offsetField, if (_value < 0) then { 0 } else { (_age - _now) max 0 }];
        };
    };
} forEach [
    ["defendLeaseIssuedAt", ""],
    ["civilianLastRoutineAt", ""],
    ["civilianLastIntelAt", "civilianIntelElapsedOffset"]
];

true
