

TRGNew = _this select 0;
RADationius = _this select 1;

_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_DANSCORE = parseNumber (markerText _mrkr) ;  

_Chance = selectRandom [1, 2, 3]; 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if ( INFDIS == 0 ) then {
	

if (RADationius >= 2000) then {
PRL = [TRGNew getPos [(70 +(random 30)), (0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, getPos TRGNew, 2000] call BIS_fnc_taskPatrol;
			PRL deleteGroupWhenEmpty true;
};

if (RADationius >= 1000) then {
PRL = [TRGNew getPos [(70 +(random 30)), (0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, getPos TRGNew, 50] call BIS_fnc_taskPatrol;
			PRL deleteGroupWhenEmpty true;
PRLL = (units PRL) select 0 ;
PRLL addEventHandler ["Killed", { 
[(_this select 0), 1000] execVM 'Scripts\QuickRF.sqf';
 _flare = "F_20mm_Red" createVehicle [getPos (_this select 0) select 0, getPos (_this select 0) select 1, 120]; 
_flare setVelocity [0,0,-0.1];
 }];
};


if (_DANSCORE > 5) then {
	
if (RADationius >= 2000) then {
PRL = [TRGNew getPos [(70 +(random 30)), (0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, getPos TRGNew, 2000] call BIS_fnc_taskPatrol;
			PRL deleteGroupWhenEmpty true;
};

if (RADationius >= 1000) then {
PRL = [TRGNew getPos [(70 +(random 30)), (0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, getPos TRGNew, 50] call BIS_fnc_taskPatrol;
			PRL deleteGroupWhenEmpty true;
PRLL = (units PRL) select 0 ;
PRLL addEventHandler ["Killed", { 
[(_this select 0), 1000] execVM 'Scripts\QuickRF.sqf';
 _flare = "F_20mm_Red" createVehicle [getPos (_this select 0) select 0, getPos (_this select 0) select 1, 120]; 
_flare setVelocity [0,0,-0.1];
 }];
};

};

if (_DANSCORE > 10) then {
if (RADationius >= 2000) then {
PRL = [TRGNew getPos [(70 +(random 30)), (0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, getPos TRGNew, 2000] call BIS_fnc_taskPatrol;
			PRL deleteGroupWhenEmpty true;
PRLL = (units PRL) select 0 ;
PRLL addEventHandler ["Killed", { 
[(_this select 0), 1000] execVM 'Scripts\QuickRF.sqf';
 _flare = "F_20mm_Red" createVehicle [getPos (_this select 0) select 0, getPos (_this select 0) select 1, 120]; 
_flare setVelocity [0,0,-0.1];
 }];
	};
};

};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


_allWatchposts = [ 
"Watchpost_1", 
"Watchpost_2", 
"Watchpost_3", 
"Watchpost_4", 
"Watchpost_5", 
"Watchpost_6",
"Watchpost_7",
"Watchpost_8",
"Watchpost_9",
"Watchpost_10",
"Road_Post_CSAT_01", 
"Road_Post_CSAT_02",
"Road_Post_CSAT_01", 
"Road_Post_CSAT_02"
]; 

_MR = RADationius / 6 ;
_MountsAll = nearestLocations [ TRGNew, ["Mount"], _MR];   
_MountsNeg = nearestLocations [ TRGNew, ["Mount"], 30];   
_Mounts = _MountsAll - _MountsNeg ; 
 
if (count _mounts > 0) then {

	if (RADationius >= 2000) then {
		_Mount = selectRandom _Mounts; 
		_Watchpost = selectRandom _allWatchposts; 
		[_Mount, _Watchpost] execVM "Scripts\WatchPost.sqf";
	};

	sleep 1 ; 

	if (RADationius >= 1000) then {
		_Mount = selectRandom _Mounts; 
		_Watchpost = selectRandom _allWatchposts; 
		[_Mount, _Watchpost] execVM "Scripts\WatchPost.sqf";
	};

	sleep 1 ; 

	if (_DANSCORE > 5) then {
			
		if (RADationius >= 2000) then {
			_Mount = selectRandom _Mounts; 
			_Watchpost = selectRandom _allWatchposts; 
			[_Mount, _Watchpost] execVM "Scripts\WatchPost.sqf";
		};

		sleep 1 ; 

		if (RADationius >= 1000) then {
			_Mount = selectRandom _Mounts; 
			_Watchpost = selectRandom _allWatchposts; 
			[_Mount, _Watchpost] execVM "Scripts\WatchPost.sqf";
		};
	};

	sleep 1 ; 

	if (_DANSCORE > 10) then {
			
		if (RADationius >= 2000) then {
			_Mount = selectRandom _Mounts; 
			_Watchpost = selectRandom _allWatchposts; 
			[_Mount, _Watchpost] execVM "Scripts\WatchPost.sqf";

		};

		sleep 1 ; 

		if (RADationius >= 1500) then {
			_Mount = selectRandom _Mounts; 
			_Watchpost = selectRandom _allWatchposts; 
			[_Mount, _Watchpost] execVM "Scripts\WatchPost.sqf";

		};
	};
};


[TRGNew, 360] execVM "Scripts\INTLitems.sqf";

