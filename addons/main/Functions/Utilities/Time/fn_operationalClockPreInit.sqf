/* Initializes the monotonic campaign clock before mission systems start. */
private _missionDate = date;
private _year = _missionDate select 0;
private _dateNumber = dateToNumber _missionDate;

FLO_OperationalClock = createHashMapFromArray [
    ["year", _year],
    ["dateNumber", _dateNumber],
    ["roundingRemainderSeconds", 0],
    ["wallSinceMissionChange", 0],
    ["lastMissionYear", _year],
    ["lastMissionDateNumber", _dateNumber],
    ["lastTick", diag_tickTime]
];
