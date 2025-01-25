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

	// Iterate over each marker to find the nearest valid outpost
	{
		private _markerPos = getMarkerPos _x;
		private _distance = _markerPos distance _CNTRQRF;
		
		// Check if there are any players near this outpost
		private _noPlayersNear = {
			if (side _x isEqualTo west && alive _x) exitWith {1};
		} count (_markerPos nearEntities [["Man", "Car", "Tank", "Ship", "LandVehicle"], 1000]) isEqualTo 0;
		
		if (_distance < _nearestDistance && _noPlayersNear) then {
			_nearestDistance = _distance;
			_nearestOutpost = _x;
		};
	} forEach _opforOutpostMarkers;

	// Check if a valid outpost was found
	if (_nearestOutpost != "") then {
		// Use the position of the nearest outpost for spawning
		private _spawnPos = getMarkerPos _nearestOutpost;
		// Send Immediate QRF if BLUFOR has captured an objective of OPFOR
		private _unitTypes = [selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), 
		                     selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), 
		                     selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), 
		                     selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"),
		                     "I_RadioOperator_F"];  
		private _PRL = [_spawnPos, East, _unitTypes] call BIS_fnc_spawnGroup;
		
		// Initialize the Radio Operator as Fire Observer
		{
			if (typeOf _x == "I_RadioOperator_F") then {
				[_x, East] call FLO_fnc_fireObserver;
			};
		} forEach units _PRL;
		
		private _WP_1 = _PRL addWaypoint [(getPos _CNTRQRF), 0]; 
		_WP_1 SetWaypointType "SAD"; 
		_PRL deleteGroupWhenEmpty true;

		if (_RADSQRF > 1200) then {
			private _unitTypes = [selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), 
			                     selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), 
			                     selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), 
			                     selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"),
			                     "I_RadioOperator_F"];  
			private _PRL = [_spawnPos, East, _unitTypes] call BIS_fnc_spawnGroup;
			
			// Initialize the Radio Operator as Fire Observer
			{
				if (typeOf _x == "I_RadioOperator_F") then {
					[_x, East] call FLO_fnc_fireObserver;
				};
			} forEach units _PRL;
			
			private _WP_1 = _PRL addWaypoint [(getPos _CNTRQRF), 0]; 
			_WP_1 SetWaypointType "SAD"; 
			_PRL deleteGroupWhenEmpty true;
		};

		if (_RADSQRF > 1700) then {
			private _unitTypes = [selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), 
			                     selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), 
			                     selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), 
			                     selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"),
			                     "I_RadioOperator_F"];  
			private _PRL = [_spawnPos, East, _unitTypes] call BIS_fnc_spawnGroup;
			
			// Initialize the Radio Operator as Fire Observer
			{
				if (typeOf _x == "I_RadioOperator_F") then {
					[_x, East] call FLO_fnc_fireObserver;
				};
			} forEach units _PRL;
			
			private _WP_1 = _PRL addWaypoint [(getPos _CNTRQRF), 0]; 
			_WP_1 SetWaypointType "SAD"; 
			_PRL deleteGroupWhenEmpty true;
		};
	} else {
		diag_log "No valid OPFOR outpost found for QRF deployment.";
	};

	private _QRF = selectRandom [ "Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"]; 
	[_CNTRQRF] execVM _QRF;

	sleep 30;
	if (_RADSQRF > 1200) then {
		private _QRF = selectRandom [ "Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"]; 
		[_CNTRQRF] execVM _QRF;
		[_CNTRQRF] execVM "Scripts\VehiInsert_CSAT_1.sqf";
	};

	sleep 30;
	if (_RADSQRF > 1700) then {
		private _QRF = selectRandom [ "Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"]; 
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