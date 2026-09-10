/* Restores process-relative timers after validated version-29 group hydration.
 * Timer format 0 has no sampling epoch: deadlines expire and elapsed timers
 * restart once, bounding uncertainty by the existing lease/cooldown policy.
 * Format 1 preserves remaining deadlines and elapsed ages across restarts.
 */
params ["_groupData", "_savedData", ["_now", diag_tickTime, [0]], ["_apply", true, [true]]];

private _version = if ("timerFormatVersion" in _savedData) then { _savedData get "timerFormatVersion" } else { 0 };
if !(_version isEqualType 0 && {_version in [0, 1]}) then {
    throw format ["Unsupported saved group timer format %1", _version];
};
if (_version == 0 && {"timerSampleTick" in _savedData || {"timerElapsedOffsets" in _savedData}}) then {
    throw "Unanchored timer format 0 cannot contain format-1 timer metadata";
};
private _sample = 0;
private _offsets = createHashMapFromArray [["civilianLastIntelAt", 0], ["transportUnloadIssuedAt", 0]];
if (_version == 1) then {
    if !("timerSampleTick" in _savedData && {"timerElapsedOffsets" in _savedData}) then {
        throw "Saved timer format 1 is missing its epoch or elapsed offsets";
    };
    _sample = _savedData get "timerSampleTick";
    _offsets = _savedData get "timerElapsedOffsets";
    if !(_sample isEqualType 0 && {finite _sample} && {_sample >= 0} && {_offsets isEqualType createHashMap}) then {
        throw "Saved timer format 1 has malformed epoch or offsets";
    };
    {
        if !(_x in _offsets) then { throw format ["Saved timer format 1 is missing offset %1", _x] };
        private _offset = _offsets get _x;
        if !(_offset isEqualType 0 && {finite _offset} && {_offset >= 0}) then {
            throw format ["Saved timer format 1 has invalid offset %1", _x];
        };
    } forEach ["civilianLastIntelAt", "transportUnloadIssuedAt"];
};

{
    private _value = _savedData get _x;
    if !(_value isEqualType 0 && {finite _value} && {_value == -1 || {_value >= 0}}) then {
        throw format ["Saved group %1 has invalid timer %2", _savedData get "id", _x];
    };
    private _restored = -1;
    if (_value >= 0) then {
        _restored = if (_version == 0) then { _now } else { _now + ((_value - _sample) max 0) };
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
    if (_version == 1 && {_value >= 0}) then {
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
    ["civilianLastIntelAt", "civilianIntelElapsedOffset"],
    ["transportUnloadIssuedAt", "transportUnloadElapsedOffset"]
];

true
