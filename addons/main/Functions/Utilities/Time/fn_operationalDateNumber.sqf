/*
 * Advances strategic time while Arma freezes `date` on an empty dedicated
 * server, retaining fractional seconds and avoiding double-counting wall
 * time when the native minute-resolution mission date advances.
 */
private _clock = FLO_OperationalClock;
private _nowTick = diag_tickTime;
private _missionDate = date;
private _missionYear = _missionDate select 0;
private _missionDateNumber = dateToNumber _missionDate;
private _lastMissionYear = _clock get "lastMissionYear";
private _lastMissionDateNumber = _clock get "lastMissionDateNumber";
private _wallElapsed = (_nowTick - (_clock get "lastTick")) max 0;
private _missionElapsed = 0;

if (_missionYear == _lastMissionYear) then {
    _missionElapsed = [
        _lastMissionDateNumber,
        _missionDateNumber,
        _missionYear
    ] call FLO_fnc_dateNumberDeltaSeconds;
} else {
    if (_missionYear == (_lastMissionYear + 1)) then {
        _missionElapsed = ((1 - _lastMissionDateNumber) * ([_lastMissionYear] call FLO_fnc_dateNumberSecondsPerYear))
            + (_missionDateNumber * ([_missionYear] call FLO_fnc_dateNumberSecondsPerYear));
    };
};
private _wallSinceMissionChange = _clock get "wallSinceMissionChange";
_missionElapsed = (_missionElapsed - _wallSinceMissionChange) max 0;

private _elapsed = _wallElapsed max _missionElapsed;
private _year = _clock get "year";
private _dateNumber = _clock get "dateNumber";
// dateToNumber loses subsecond precision. Carry both rounded-away time and
// rounding overshoot forward so caller frequency cannot accelerate or stall it.
private _remaining = _elapsed + (_clock get "roundingRemainderSeconds");

while {_remaining > 0} do {
    private _secondsPerYear = [_year] call FLO_fnc_dateNumberSecondsPerYear;
    private _secondsToYearEnd = (1 - _dateNumber) * _secondsPerYear;
    if (_remaining < _secondsToYearEnd) exitWith {
        private _nextDateNumber = _dateNumber + (_remaining / _secondsPerYear);
        _remaining = _remaining - ((_nextDateNumber - _dateNumber) * _secondsPerYear);
        _dateNumber = _nextDateNumber;
        if (_dateNumber >= 1) then {
            _year = _year + 1;
            _dateNumber = 0;
        };
    };

    _remaining = _remaining - _secondsToYearEnd;
    _year = _year + 1;
    _dateNumber = 0;
};

_clock set ["year", _year];
_clock set ["dateNumber", _dateNumber];
_clock set ["roundingRemainderSeconds", _remaining];
_clock set ["wallSinceMissionChange", if (_missionYear == _lastMissionYear && {_missionDateNumber == _lastMissionDateNumber}) then {
    _wallSinceMissionChange + _wallElapsed
} else {
    0
}];
_clock set ["lastMissionYear", _missionYear];
_clock set ["lastMissionDateNumber", _missionDateNumber];
_clock set ["lastTick", _nowTick];

_dateNumber
