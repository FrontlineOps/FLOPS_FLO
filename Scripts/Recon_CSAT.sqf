_thisReconTrigger = _this select 0;
_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_AGGRSCORE = parseNumber (markerText _mrkr) ;  

sleep 15 ; 

_allWatchposts = [ 
"Watchpost_2", 
"Watchpost_3", 
"Watchpost_4", 
"Watchpost_5", 
"Watchpost_6",
"Watchpost_7",
"Watchpost_8",
"Watchpost_9",
"Watchpost_10",
"Recon_OPF_2",
"Recon_OPF_2",
"Recon_OPF_2",
"Recon_OPF_3"
]; 


_poss = [_thisReconTrigger, 10, 200, 1, 0, 0.5, 0] call BIS_fnc_findSafePos;


if (_AGGRSCORE < 6) then {
[ selectRandom _allWatchposts, _poss, [0,0,0], 0, true ] call LARs_fnc_spawnComp;
sleep 5;
{_x setUnitLoadout selectRandom East_Units;} forEach nearestObjects [_poss,["Man"],50];
PRL = [_poss, East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
			PRL deleteGroupWhenEmpty true;

[PRL, _poss, 500] call BIS_fnc_taskPatrol;
PRL = [_poss, East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
			PRL deleteGroupWhenEmpty true;

[PRL, _poss, 1000] call BIS_fnc_taskPatrol;
};

if ((_AGGRSCORE > 5) && (_AGGRSCORE < 11)) then {
[selectRandom _allWatchposts, _poss, [0,0,0], 0, true ] call LARs_fnc_spawnComp;
sleep 1;
{_x setUnitLoadout selectRandom East_Units;} forEach nearestObjects [_poss,["Man"],50];
PRL = [_poss, East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
			PRL deleteGroupWhenEmpty true;

[PRL, _poss, 500] call BIS_fnc_taskPatrol;
PRL = [_poss, East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
			PRL deleteGroupWhenEmpty true;

[PRL, _poss, 1000] call BIS_fnc_taskPatrol;
PRL = [_poss, East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
			PRL deleteGroupWhenEmpty true;

[PRL, _poss, 2000] call BIS_fnc_taskPatrol;
};

if (_AGGRSCORE > 10) then {
[ selectRandom _allWatchposts, _poss, [0,0,0], 0, true ] call LARs_fnc_spawnComp;
sleep 1;
{_x setUnitLoadout selectRandom East_Units;} forEach nearestObjects [_poss,["Man"],50];
PRL = [_poss, East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
			PRL deleteGroupWhenEmpty true;

[PRL, _poss, 500] call BIS_fnc_taskPatrol;
PRL = [_poss, East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
			PRL deleteGroupWhenEmpty true;

[PRL, _poss, 1000] call BIS_fnc_taskPatrol;
PRL = [_poss, East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
			PRL deleteGroupWhenEmpty true;

[PRL, _poss, 2000] call BIS_fnc_taskPatrol;
PRL = [_poss, East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
			PRL deleteGroupWhenEmpty true;

[PRL, _poss, 3000] call BIS_fnc_taskPatrol;
};


		if (count (nearestObjects [_poss, ["HOUSE", "Strategic"], 20]) > 0 ) then {
			
				_allBuildings = nearestObjects [_poss, ["HOUSE", "Strategic"], 20];  
				_allPositions = [];  
				_allBuildings apply {_allPositions append (_x buildingPos -1)};  

				G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
				((units G) select 0) disableAI "PATH";  
			G deleteGroupWhenEmpty true;

				G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
				((units G) select 0) disableAI "PATH";  
			G deleteGroupWhenEmpty true;

				G = [ selectRandom _allPositions, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			G deleteGroupWhenEmpty true;


			// 	G = [(locationPosition _MountSel) getPos [(10 +(random 5)), (0 + (random 360))] , East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			// 	((units G) select 0) disableAI "PATH";  
			// G deleteGroupWhenEmpty true;

			// 	G = [(locationPosition _MountSel) getPos [(10 +(random 5)), (0 + (random 360))], East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			// 	((units G) select 0) disableAI "PATH";  
			// G deleteGroupWhenEmpty true;

			// 	G = [ (locationPosition _MountSel) getPos [(10 +(random 5)), (0 + (random 360))], East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
			// G deleteGroupWhenEmpty true;
				
		};
		
[_thisReconTrigger, 210] execVM "Scripts\INTLitems.sqf";

{ if !((side _x) == west) then {
            ZEUS removeCuratorEditableObjects [[_x],true];
}; } foreach allUnits;





