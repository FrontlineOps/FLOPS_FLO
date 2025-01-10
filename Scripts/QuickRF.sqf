if ( COMMSDIS == 0 ) then {

	private _CNTRQRF = _this select 0;
	private _RADSQRF = _this select 1;

	//_allZoneMarks = allMapMarkers select {markerType _x == "n_installation" || markerType _x == "o_installation" || markerType _x == "o_antiair" || markerType _x == "o_service" || markerType _x == "loc_Power" || markerType _x == "o_support" || markerType _x == "n_support" || markerType _x == "loc_Ruin" } ;  
	//_M = [_allZoneMarks,  _CNTRQRF] call BIS_fnc_nearestPosition ;

	//_azimuth = (getPos _CNTRQRF) getDir (getMarkerPos _M);

	// Define the markers for OPFOR outposts
	private _opforOutpostMarkers = allMapMarkers select {markerType _x == "o_installation"};
	// Find the nearest OPFOR outpost to the center of the QRF
	private _nearestOutpost = [_opforOutpostMarkers, _CNTRQRF] call BIS_fnc_nearestPosition;

	// Check if a valid outpost was found
	if (!isNil "_nearestOutpost" && {_nearestOutpost isEqualType ""}) then {
		// Use the position of the nearest outpost for spawning
		private _spawnPos = getMarkerPos _nearestOutpost;
		// Send Immediate QRF if BLUFOR has captured an objective of OPFOR
		PRL = [_spawnPos, East, [selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units")]] call BIS_fnc_spawnGroup;
		WP_1 = PRL addWaypoint [(getPos _CNTRQRF), 0]; 
		WP_1 SetWaypointType "SAD"; 
		PRL deleteGroupWhenEmpty true;

		if (_RADSQRF > 1200) then {
			PRL = [_spawnPos, East, [selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units")]] call BIS_fnc_spawnGroup;
			WP_1 = PRL addWaypoint [(getPos _CNTRQRF), 0]; 
			WP_1 SetWaypointType "SAD"; 
			PRL deleteGroupWhenEmpty true;
		};

		if (_RADSQRF > 1700) then {
			PRL = [_spawnPos, East, [selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units")]] call BIS_fnc_spawnGroup;
			WP_1 = PRL addWaypoint [(getPos _CNTRQRF), 0]; 
			WP_1 SetWaypointType "SAD"; 
			PRL deleteGroupWhenEmpty true;
		};
	} else {
		diag_log "No valid OPFOR outpost found for QRF deployment.";
	};

	_QRF = selectRandom [ "Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"]; 
	[_CNTRQRF] execVM _QRF;

	sleep 30 ;
	if (_RADSQRF > 1200) then {
		_QRF = selectRandom [ "Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"]; 
		[_CNTRQRF] execVM _QRF;
		[_CNTRQRF] execVM "Scripts\VehiInsert_CSAT_1.sqf";
	};

	sleep 30 ;
	if (_RADSQRF > 1700) then {
		_QRF = selectRandom [ "Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"]; 
		[_CNTRQRF] execVM _QRF;
		[_CNTRQRF] execVM "Scripts\VehiInsert_CSAT_1.sqf";
		[_CNTRQRF] execVM "Scripts\VehiInsert_CSAT_1.sqf";
	};

	if (_RADSQRF > 1700) then {
		[_CNTRQRF] execVM "Scripts\VehiInsert_CSAT_3.sqf";
	};


};

sleep 30;
{ removeFromRemainsCollector [_x]; } foreach (allUnits select { side _x != west });
{ removeFromRemainsCollector [_x]; } foreach (vehicles select { side (driver  _x) != west }); 
sleep 3; 
{ addToRemainsCollector [_x]; } foreach (allUnits select { side _x != west });
{ addToRemainsCollector [_x]; } foreach (vehicles select { side (driver  _x) != west }); 