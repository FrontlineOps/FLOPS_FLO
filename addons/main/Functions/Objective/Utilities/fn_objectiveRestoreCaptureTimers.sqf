/* Rebase current capture timestamps before objective publication. */
params ["_objectiveId", "_objective", ["_now", diag_tickTime, [0]]];

private _error = "";
try {
    private _progress = _objective get "captureSecureProgress";
    private _duration = _objective get "captureSecureTime";
    private _started = _objective get "captureSecureStartedAt";
    private _changed = _objective get "captureStatusChangedAt";
    if !(_progress isEqualType 0 && {finite _progress} && {_progress >= 0 && {_progress <= 1}}) then {
        throw "invalid secure progress";
    };
    if !(_duration isEqualType 0 && {finite _duration} && {_duration >= 0}) then { throw "invalid secure duration" };
    if !(_started isEqualType 0 && {finite _started} && {_changed isEqualType 0 && {finite _changed}}) then {
        throw "invalid capture timestamps";
    };
    if !("captureTimerSampleTick" in _objective) then { throw "missing capture timer epoch" };
    private _sample = _objective get "captureTimerSampleTick";
    if !(_sample isEqualType 0 && {finite _sample} && {_sample >= 0}) then { throw "invalid capture timer epoch" };
    if (_changed > _sample || {(_objective get "captureState") == "securing" && {_started > _sample}}) then {
        throw "capture timestamp exceeds its sampling epoch";
    };
    private _elapsed = _sample - _started;
    private _statusAge = _sample - _changed;

    _objective set ["captureSecureStartedAt", if ((_objective get "captureState") == "securing") then { _now - _elapsed } else { -1 }];
    _objective set ["captureStatusChangedAt", _now - _statusAge];
    _objective deleteAt "captureTimerSampleTick";
} catch {
    _error = format ["Saved objective %1: %2", _objectiveId, _exception];
};
if (_error != "") then {
    ["OBJECTIVE", 1, _error] call FLO_fnc_log;
    throw _error;
};
true
