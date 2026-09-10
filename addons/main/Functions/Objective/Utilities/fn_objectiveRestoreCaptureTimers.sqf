/* Rebase saved capture timers before objective publication. Format 0 has no
 * clock epoch, so its bounded, persisted secure progress supplies elapsed time.
 * A restored start may precede this process's zero; captureState owns validity.
 */
params ["_objectiveId", "_objective", ["_now", diag_tickTime, [0]]];

private _error = "";
try {
    private _version = if ("captureTimerVersion" in _objective) then { _objective get "captureTimerVersion" } else { 0 };
    if !(_version isEqualType 0 && {_version in [0, 1]}) then {
        throw format ["unsupported capture timer version %1", _version];
    };
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
    private _elapsed = _progress * (_duration max 1);
    private _statusAge = 0;
    if (_version == 1) then {
        if !("captureTimerSampleTick" in _objective) then { throw "missing capture timer epoch" };
        private _sample = _objective get "captureTimerSampleTick";
        if !(_sample isEqualType 0 && {finite _sample} && {_sample >= 0}) then { throw "invalid capture timer epoch" };
        if (_changed > _sample || {(_objective get "captureState") == "securing" && {_started > _sample}}) then {
            throw "capture timestamp exceeds its sampling epoch";
        };
        _elapsed = _sample - _started;
        _statusAge = _sample - _changed;
    } else {
        if ("captureTimerSampleTick" in _objective) then { throw "legacy capture timer contains a versioned epoch" };
    };

    _objective set ["captureSecureStartedAt", if ((_objective get "captureState") == "securing") then { _now - _elapsed } else { -1 }];
    _objective set ["captureStatusChangedAt", _now - _statusAge];
    _objective deleteAt "captureTimerVersion";
    _objective deleteAt "captureTimerSampleTick";
} catch {
    _error = format ["Saved objective %1: %2", _objectiveId, _exception];
};
if (_error != "") then {
    ["OBJECTIVE", 1, _error] call FLO_fnc_log;
    throw _error;
};
true
