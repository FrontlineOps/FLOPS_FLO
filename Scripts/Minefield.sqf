
_thisMineFieldTrigger = _this select 0;
_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_AGGRSCORE = parseNumber (markerText _mrkr) ;  


if (_AGGRSCORE < 6) then {
_Mines = [ "APERSMine", "APERSBoundingMine" ]; 
 
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 100))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 100))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 100))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 100))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 100))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 100))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 100))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 100))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 100))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 100))];
};

if ((_AGGRSCORE > 5) && (_AGGRSCORE < 11)) then {
_Mines = [ "APERSMine", "APERSBoundingMine" ]; 
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 250))];
};

if (_AGGRSCORE > 10) then {
_Mines = [ "APERSMine", "APERSBoundingMine" ]; 
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine [selectRandom _Mines,  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 450))];
_mine = createMine ["ATMine",  getpos _thisMineFieldTrigger, [], (0 + (random 450))];

};


_TFOBA = createTrigger ["EmptyDetector", getpos _thisMineFieldTrigger];  
_TFOBA setTriggerArea [350, 350, 0, false, 50];  
_TFOBA setTriggerInterval 2;  
_TFOBA setTriggerActivation ["ANYPLAYER", "PRESENT", false];  
_TFOBA setTriggerStatements [  
"count (allMines select {position _x inArea thisTrigger}) == 0",  
"
_MMarks = allMapMarkers select { markerType _x == 'loc_mine'};
_M = [_MMarks,  thisTrigger] call BIS_fnc_nearestPosition;

deleteMarker _M ; 

				[100, 'MINEFIELD'] execVM 'Scripts\NOtification.sqf' ;

[100] execVM 'Scripts\Reward.sqf';
[] execVM 'Scripts\ReputationPlus.sqf';
[] execVM 'Scripts\ReputationPlus.sqf';
execVM 'Scripts\Civ_Relations.sqf';

", ""];
















