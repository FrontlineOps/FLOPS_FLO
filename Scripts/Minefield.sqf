private _thisMineFieldTrigger = _this select 0;
private _mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
private _mrkr = _mrkrs select 0;
private _AGGRSCORE = parseNumber (markerText _mrkr) ;  

private _mines = [];
private _mineCount = 10; // Default mine count

if (_AGGRSCORE < 6) then {
    _mineCount = 10;
} else {
    _mineCount = 20;
};

if (_AGGRSCORE > 10) then {
    _mineCount = 40;
};

private _minesToCreate = [];
if (_AGGRSCORE > 5) then {
    _minesToCreate = ["APERSMine", "APERSBoundingMine", "ATMine"];
} else {
    _minesToCreate = ["APERSMine", "APERSBoundingMine"];
};

for "_i" from 1 to _mineCount do {
    private _mineType = selectRandom _minesToCreate;
    private _distance = 0 + (random (if (_AGGRSCORE < 6) then {100} else {if (_AGGRSCORE < 11) then {250} else {450}}));
    _mine = createMine [_mineType, getPos _thisMineFieldTrigger, [], _distance];
    _mines pushBack _mine;
};

[] spawn {
    while {true} do {
        sleep 10; // Check every 10 seconds

        if (count (allMines select {position _x inArea _thisMineFieldTrigger}) == 0) then {
            private _MMarks = allMapMarkers select {markerType _x == "loc_mine"};
            private _M = [_MMarks, _thisMineFieldTrigger] call BIS_fnc_nearestPosition;

            if (!isNil "_M") then {
                deleteMarker _M;
            };

            [100, "MINEFIELD"] execVM "Scripts\\NOtification.sqf";
            [100] execVM "Scripts\\Reward.sqf";
            [] execVM "Scripts\\ReputationPlus.sqf";
            execVM "Scripts\\Civ_Relations.sqf";

            break; // Exit the loop once the condition is met
        };
    };
};