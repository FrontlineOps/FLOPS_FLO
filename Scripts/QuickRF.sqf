
if ( COMMSDIS == 0 ) then {

CNTRQRF = _this select 0;
RADSQRF = _this select 1;



_Chance = selectRandom [1, 2, 3, 4]; 

/*
_GRPs = (allGroups select {side _x == east && getPos ((units _x) select 0) distance CNTRQRF < RADSQRF});
_GRPCNT = count _GRPs;
_GRPCNTNEW = round ( _GRPCNT / 2 );
_GRPsALLNEW = _GRPs call BIS_fnc_arrayShuffle;
_GRPsSEL = _GRPsALLNEW select [0, _GRPCNTNEW];
_AllWs = {waypoints _x } foreach _GRPsSEL; 

{
for "_i" from count waypoints _x - 1 to 0 step -1 do
{deleteWaypoint [_x, _i];};
} foreach _GRPsSEL;

sleep 2 ;

{_x addWaypoint [position CNTRQRF, 0]; } foreach _GRPsSEL;

*/


_GRPs = (allGroups select {side _x == east && getPos ((units _x) select 0) distance CNTRQRF < RADSQRF});
_GRPCNT = count _GRPs;
_GRPCNTNEW = round ( _GRPCNT / 2 );
_GRPsALLNEW = _GRPs call BIS_fnc_arrayShuffle;
_GRPsSEL = _GRPsALLNEW select [0, _GRPCNTNEW];


{
_Gcount = count units _x ;
PRLCLWNGRP = [(getPos ((units _x) select 0)), East, _Gcount] call BIS_fnc_spawnGroup;
{_x setUnitLoadout selectRandom East_Units;} forEach (units PRLCLWNGRP) ;
PRLCLWNGRP addWaypoint [position CNTRQRF, 0];
			PRLCLWNGRP deleteGroupWhenEmpty true;

} foreach _GRPsSEL;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



 	   _allZoneMarks = allMapMarkers select {markerType _x == "n_installation" || markerType _x == "o_installation" || markerType _x == "o_antiair" || markerType _x == "o_service" || markerType _x == "loc_Power" || markerType _x == "o_support" || markerType _x == "n_support" || markerType _x == "loc_Ruin" } ;  
       _M = [_allZoneMarks,  CNTRQRF] call BIS_fnc_nearestPosition ;

_azimuth = (getPos CNTRQRF) getDir (getMarkerPos _M);


PRL = [(getPos CNTRQRF) getPos [(400 + (random 200)), (_azimuth + (random 20))] , East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
WP_1 = PRL addWaypoint [(getPos CNTRQRF), 0]; 
WP_1 SetWaypointType "MOVE"; 
			PRL deleteGroupWhenEmpty true;


if (RADSQRF > 1200) then {
PRL = [(getPos CNTRQRF) getPos [(400 + (random 200)), (_azimuth + (random 20))] , East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
WP_1 = PRL addWaypoint [(getPos CNTRQRF), 0]; 
WP_1 SetWaypointType "MOVE"; 
			PRL deleteGroupWhenEmpty true;
};

if (RADSQRF > 1700) then {
PRL = [(getPos CNTRQRF) getPos [(400 + (random 200)), (_azimuth - (random 20))] , East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
WP_1 = PRL addWaypoint [(getPos CNTRQRF), 0]; 
WP_1 SetWaypointType "MOVE"; 
			PRL deleteGroupWhenEmpty true;
};



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

			 _QRF = selectRandom [ "Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"]; 
			[CNTRQRF] execVM _QRF ;

sleep 30 ;
if (RADSQRF > 1200) then {
			 _QRF = selectRandom [ "Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"]; 
			[CNTRQRF] execVM _QRF ;
[CNTRQRF] execVM "Scripts\VehiInsert_CSAT_1.sqf";
};

sleep 30 ;
if (RADSQRF > 1700) then {
			 _QRF = selectRandom [ "Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"]; 
			[CNTRQRF] execVM _QRF ;
			[CNTRQRF] execVM "Scripts\VehiInsert_CSAT_1.sqf";
[CNTRQRF] execVM "Scripts\VehiInsert_CSAT_1.sqf";

};



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if (RADSQRF > 1700) then {
[CNTRQRF] execVM "Scripts\VehiInsert_CSAT_3.sqf";
};


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

};

sleep 30 ;

	{ removeFromRemainsCollector [_x]; } foreach (allUnits select { side _x != west }) ;
	{ removeFromRemainsCollector [_x]; } foreach (vehicles select { side (driver  _x) != west }) ; 


sleep 3 ; 

	{ addToRemainsCollector [_x]; } foreach (allUnits select { side _x != west }) ;
	{ addToRemainsCollector [_x]; } foreach (vehicles select { side (driver  _x) != west }) ; 












