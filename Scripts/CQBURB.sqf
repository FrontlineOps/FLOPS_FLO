
 _mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_DANSCORE = parseNumber (markerText _mrkr) ;  
_Chance = selectRandom [1,2,3]; 




_thisCQBTrigger = _this select 0;


{ if (((side _x) == east) && (getPos _x distance _thisCQBTrigger < 150))then {
_x enableAI "PATH";
_x enableAI "ANIM"; 
}; } foreach allUnits;


_allOCMarks = allMapMarkers select {(markerType _x == "n_installation" || markerType _x == "o_installation") && ((getMarkerPos _x) inArea _thisCQBTrigger)} ;  
if (count _allOCMarks != 0) then {
_Buildings = nearestObjects [_thisCQBTrigger, ['HOUSE'], 100] ;  
_allPositionBuildings = _Buildings select {count (_x buildingPos -1) > 2}; 
_HQ = _allPositionBuildings select 0;
CQBG = [(selectRandom (_HQ buildingPos -1)), East,[selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup; 
[_HQ] execVM "Scripts\VehiInsert_CSAT.sqf";



if (_DANSCORE > 5) then {
_Buildings = nearestObjects [_thisCQBTrigger, ['HOUSE'], 100] ;  
_allPositionBuildings = _Buildings select {count (_x buildingPos -1) > 2}; 
_HQ = _allPositionBuildings select 1;
CQBG = [(selectRandom (_HQ buildingPos -1)), East,[selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup; 
[_HQ] execVM "Scripts\VehiInsert_CSAT.sqf";
};


if (_DANSCORE > 10) then {
_Buildings = nearestObjects [_thisCQBTrigger, ['HOUSE'], 100] ;  
_allPositionBuildings = _Buildings select {count (_x buildingPos -1) > 2}; 
_HQ = _allPositionBuildings select 2;
CQBG = [(selectRandom (_HQ buildingPos -1)), East,[selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup; 
[_HQ] execVM "Scripts\VehiInsert_CSAT.sqf";
};

};

	
	
	
	
	
	
	
	
	
	
	
	