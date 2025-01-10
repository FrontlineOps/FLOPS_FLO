// TODO: Introduce System that depletes spawning ability if the outpost found does indeed send QRF
// TODO: Selected Outpost can deny sending QRF in certain situations
if ( COMMSDIS == 0 ) then {

	private _CNTRQRF = _this select 0;
	private _RADSQRF = _this select 1;

	// Define the markers for OPFOR outposts
	private _opforOutpostMarkers = allMapMarkers select {markerType _x == "o_installation" || markerType _x == "o_service" || markerType _x == "o_support"};
	// Find the nearest OPFOR outpost to the center of the QRF
	// Initialize variables to track the nearest marker
	private _nearestOutpost = "";
	private _nearestDistance = 1e10; // Start with a very large distance because we want to make sure we can find an outpost

	// Iterate over each marker to find the nearest (janky but works)
	{
		private _markerPos = getMarkerPos _x;
		private _distance = _markerPos distance _CNTRQRF;
		if (_distance < _nearestDistance) then {
			_nearestDistance = _distance;
			_nearestOutpost = _x;
		};
	} forEach _opforOutpostMarkers;

	// Check if a valid outpost was found
	if (_nearestOutpost != "") then {
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