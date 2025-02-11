_thisRadioTrigger = _this select 0;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_RadioTower = nearestObjects [(getPos _thisRadioTrigger), ["Land_TTowerBig_2_F", "Land_TTowerBig_1_F", "Land_Communication_F"], 150] select 0;   
_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_AGGRSCORE = parseNumber (markerText _mrkr) ;  

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_Mine = selectRandom [ 
"APERSMine", 
"APERSBoundingMine"
 ]; 
_mine = createMine [_Mine,  (getpos _thisRadioTrigger), [], (0 + (random 40))];

_Mine = selectRandom [ 
"APERSMine", 
"APERSBoundingMine"
 ]; 
_mine = createMine [_Mine,  (getpos _thisRadioTrigger), [], (0 + (random 40))];

_Mine = selectRandom [ 
"APERSMine", 
"APERSBoundingMine"
 ]; 
_mine = createMine [_Mine,  (getpos _thisRadioTrigger), [], (0 + (random 40))];

_Mine = selectRandom [ 
"APERSMine", 
"APERSBoundingMine"
 ]; 
_mine = createMine [_Mine,  (getpos _thisRadioTrigger), [], (0 + (random 40))];

_Mine = selectRandom [ 
"APERSMine", 
"APERSBoundingMine"
 ]; 
_mine = createMine [_Mine,  (getpos _thisRadioTrigger), [], (0 + (random 40))];

_Mine = selectRandom [ 
"APERSMine", 
"APERSBoundingMine"
 ]; 
_mine = createMine [_Mine,  (getpos _thisRadioTrigger), [], (0 + (random 40))];
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


_Position = nearestObjects [(getpos _thisRadioTrigger), ["Land_TTowerBig_2_F", "Land_TTowerBig_1_F", "Land_Communication_F"], 50] select 0;  
_poss = getPos _Position ;


PRL = [_Position getPos [(40 + (random 10)), (0 + (random 350))], East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, _poss, 50] call BIS_fnc_taskPatrol;

PRLL = (units PRL) select 0 ;
PRLL addEventHandler ["Killed", { 
[getPos _thisRadioTrigger, 1000] call FLO_fnc_requestQRF;

 _flare = "F_20mm_Red" createVehicle [getPos (_this select 0) select 0, getPos (_this select 0) select 1, 120]; 
_flare setVelocity [0,0,-0.1];
 }];


if (_AGGRSCORE > 5) then {
PRL = [_Position getPos [(40 + (random 10)), (0 + (random 350))], East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, _poss, 150] call BIS_fnc_taskPatrol;
};

if (_AGGRSCORE > 10) then {
PRL = [_Position getPos [(40 + (random 10)), (0 + (random 350))], East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, _poss, 300] call BIS_fnc_taskPatrol;
};

