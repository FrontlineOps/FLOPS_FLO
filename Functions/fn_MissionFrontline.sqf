/*
    Function: FLO_fnc_MissionFrontline
    
    Description:
    Manages OPFOR frontline operations including offensive operations, 
    establishing new outposts, and setting up roadblocks.
    
    Parameters:
    None
    
    Returns:
    None
*/

if (!isServer) exitWith {};

// Check activation conditions for frontline operations
private _activationConditions = {
    private _headlessClients = entities "HeadlessClient_F";
    private _humanPlayers = allPlayers - _headlessClients;
    private _minPlayers = 4; // Adjust this number as needed
    
    // Check various conditions that could activate the mission
    private _bunkerMarkersExist = count (allMapMarkers select {markerType _x == "loc_Bunker" && markerAlpha _x == 0.003}) > 0; // loc_Bunker markers are created if Players capture an Objective (Outpost/HQ)
    private _sufficientPlayers = count _humanPlayers >= _minPlayers;
    private _aggrScore = parseNumber (markerText ((allMapMarkers select {markerColor _x == "Color6_FD_F"}) select 0));
    private _highAggression = _aggrScore >= 5;
    
    // Return true if any activation condition is met
    (_bunkerMarkersExist && _sufficientPlayers) || 
    (_highAggression && _sufficientPlayers)
};

// Wait for activation conditions to be met
waitUntil {
    sleep 120;
    call _activationConditions
};

sleep 10;

// Clean up any existing bunker markers
private _bunkerMarkers = allMapMarkers select {markerType _x == "loc_Bunker" && markerAlpha _x == 0.003};
{deleteMarker _x;} forEach _bunkerMarkers;

// Get current aggression score
private _aggressionScore = parseNumber (markerText ((allMapMarkers select {markerColor _x == "Color6_FD_F"}) select 0));

// OPFOR Frontline becomes more aggressive as aggression increases
// Adjust timing based on aggression level
private _operationDelay = 900;
if (_aggressionScore > 3) then {_operationDelay = 700;};
if (_aggressionScore > 9) then {_operationDelay = 500;};
if (_aggressionScore > 12) then {_operationDelay = 300;};
sleep _operationDelay;

// Check if players are still online
private _headlessClients = entities "HeadlessClient_F";
private _humanPlayers = allPlayers - _headlessClients;

if (count _humanPlayers > 0) then {
    // Determine operation type based on random chance
    private _operationType = selectRandom [6, 7, 8, 9, 10, 11];

    // Higher aggression means more aggressive operations
    if (_aggressionScore > 7) then {
        _operationType = selectRandom [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    };

    // Full-scale assault (8-11)
    if (_operationType > 7) then {
        // Launch offensive operation
        [_aggressionScore] call FLO_fnc_requestOffensiveOps;
    };

    // Create new OPFOR outpost (5-7)
    if ((_operationType > 4) && (_operationType < 8)) then {
        // Find suitable locations for new outpost
        private _opforInstallations = allMapMarkers select {
            markerType _x in ["loc_Power", "o_support", "n_support", "loc_Ruin", "n_installation", "o_installation"]
        };
        
        private _bluforInstallations = allMapMarkers select {
            markerType _x == "b_installation" &&
            (markerColor _x == "ColorYellow" || markerColor _x == "colorBLUFOR" || markerColor _x == "colorWEST")
        };

        // Calculate distances between installations
        private _distanceMap = [];
        {
            for "_i" from 0 to count _bluforInstallations - 1 do {
                private _distance = getMarkerPos _x distanceSqr (getMarkerPos (_bluforInstallations select _i));
                _distanceMap pushBack _distance;
            };
        } forEach _opforInstallations;

        _distanceMap sort true;
        private _closestDistance = _distanceMap select 0;
        private _sourceOpforMarker = "";
        private _targetBluforMarker = "";

        // Find the specific markers that match this distance
        {
            for "_i" from 0 to count _bluforInstallations - 1 do {
                private _distance = getMarkerPos _x distanceSqr (getMarkerPos (_bluforInstallations select _i));
                if (_distance == _closestDistance) then {
                    _targetBluforMarker = _bluforInstallations select _i;
                    _sourceOpforMarker = _x;
                };
            };
        } forEach _opforInstallations;

        // Calculate distance and find suitable location between installations
        private _actualDistance = (getMarkerPos _sourceOpforMarker) distance (getMarkerPos _targetBluforMarker);
        private _intermediateDistance = _actualDistance * 2 / 3;

        // Find elevated positions (mounts) in the area between installations
        private _mountsNearOpfor = nearestLocations [(getMarkerPos _sourceOpforMarker), ["Mount"], _intermediateDistance];
        private _mountsNearBlufor = nearestLocations [(getMarkerPos _targetBluforMarker), ["Mount"], _intermediateDistance];
        private _mountsInBetween = _mountsNearOpfor arrayIntersect _mountsNearBlufor;

        // Filter out positions with players nearby
        private _validPositions = _mountsInBetween select {
            private _position = _x;
            private _positionCoords = locationPosition _position;
            private _nearPlayers = allPlayers select {(_x distance _positionCoords) < 1000 && {side _x isEqualTo west}};
            count _nearPlayers isEqualTo 0
        };

        if (_validPositions isEqualTo []) then {
            diag_log "[FLO] WARNING: No valid positions found without players nearby, using original list";
            _validPositions = _mountsInBetween;
        };

        // Select a random position for the outpost
        private _selectedPosition = selectRandom _validPositions;

        // Create marker for new outpost
        private _outpostMarkerName = "AssltOutpost" + (str ([0, 0, 0] getPos [(10 + (random 150)), (0 + (random 360))]));
        publicVariable "_outpostMarkerName";

        createMarker [_outpostMarkerName, (locationPosition _selectedPosition)];
        _outpostMarkerName setMarkerType "o_support";
        _outpostMarkerName setMarkerColor "colorOPFOR";
        _outpostMarkerName setMarkerSize [1.2, 1.2];
        _outpostMarkerName setMarkerAlpha 1;

        // Create trigger for outpost initialization
        private _outpostTrigger = createTrigger ["EmptyDetector", (locationPosition _selectedPosition), false];
        _outpostTrigger setTriggerArea [2000, 2000, 0, false, 100];
        _outpostTrigger setTriggerInterval 3;
        _outpostTrigger setTriggerTimeout [1, 1, 1, true];
        _outpostTrigger setTriggerActivation ["WEST", "PRESENT", false];
        _outpostTrigger setTriggerStatements [
            "this","	

			[thisTrigger] execVM 'Scripts\Insurgents_Init.sqf';
							
			if ( count (nearestObjects [thisTrigger, ['Land_Cargo_Tower_V3_F', 'Land_Cargo_Tower_V2_F', 'Land_Cargo_Tower_V1_F', 'Land_Cargo_HQ_V3_F', 'Land_Cargo_HQ_V2_F', 'Land_Cargo_HQ_V1_F'], 100] ) == 0) then {

			private _TERR = nearestTerrainObjects [(getPos thisTrigger), ['FOREST', 'House', 'TREE', 'SMALL TREE', 'BUSH', 'ROCK', 'ROCKS'], 40]; 
			{_x hideObjectGlobal true;} forEach _TERR ;

			private _mrkrs = allMapMarkers select {markerColor _x == 'Color6_FD_F'};
			private _mrkr = _mrkrs select 0;
			_AGGRSCORE = markerText _mrkr call BIS_fnc_parseNumber;  

			private _P1 = [ 
			'Outpost_01',  
			'Outpost_02',  
			'Outpost_03',  
			'Outpost_04',  
			'Outpost_05',  
			'Outpost_06',  
			'Outpost_07'   
			]; 	

			if (_AGGRSCORE > 8) then {
			_P1 = [ 
			'Outpost_08',  
			'Outpost_09',  
			'Outpost_10',  
			'Outpost_11',  
			'Outpost_12',  
			'Outpost_13'
			]; };



			_dir = 0 + (random 360);
			if (count (nearestObjects [(getPos thisTrigger), ['House'], 200]) != 0) then {
			_dir = getDirVisual ((nearestObjects [(getPos thisTrigger), ['House'], 200]) select 0);
			};


			private _compReference = [ selectRandom _P1, (getPos thisTrigger), [0,0,0], _dir, true ] call LARs_fnc_spawnComp;

			private _ARRAY = [ _compReference ] call LARs_fnc_getCompObjects;
			{_x setVectorUp [0,0,1];} forEach _ARRAY; 
			};

			private _trgA = createTrigger ['EmptyDetector', (getPos thisTrigger), false];
			_trgA setTriggerArea [1000, 1000, 0, false, 100];
			_trgA setTriggerInterval 3;
			_trgA setTriggerTimeout [11,11, 11, true];
			_trgA setTriggerActivation ['WEST', 'PRESENT', false];
			_trgA setTriggerStatements [
			""this"",""

			[thisTrigger] execVM 'Scripts\Outpost_CSAT.sqf';

			"",""""];

			_trgA = createTrigger ['EmptyDetector', (getPos thisTrigger), false];
			_trgA setTriggerArea [500, 500, 0, false, 60];
			_trgA setTriggerInterval 3;
			_trgA setTriggerTimeout [1, 1, 1, true];
			_trgA setTriggerActivation ['WEST', 'PRESENT', false];
			_trgA setTriggerStatements [
			""this"",""

			[thisTrigger] execVM 'Scripts\HeliInsert_CSAT.sqf';

			"",""""];

			_trgA = createTrigger ['EmptyDetector', (getPos thisTrigger), false];
			_trgA setTriggerArea [500, 500, 0, false, 60];
			_trgA setTriggerInterval 3;
			_trgA setTriggerTimeout [1, 1, 1, true];
			_trgA setTriggerActivation ['WEST', 'PRESENT', false];
			_trgA setTriggerStatements [
			""this"",""

			[thisTrigger] execVM 'Scripts\VehiInsert_CSAT.sqf';

			"",""""];


			", ""
        ];
        
        // Notify players
        ["showNotification", ["! WARNING !", "Enemy Deployed New Military Installation!", "warning"]] call FLO_fnc_intelSystem;
        private _outpostGrid = mapGridPosition getMarkerPos _outpostMarkerName;
        [[west,"HQ"], "Enemy Deployed New Military Installation at grid " + _outpostGrid] remoteExec ["sideChat", 0];
    };

    // Create new roadblock (1-4)
    if (_operationType < 5) then {
        // Find suitable locations for new roadblock
        private _opforInstallations = allMapMarkers select {
            markerType _x in ["loc_Power", "o_support", "n_support", "loc_Ruin", "n_installation", "o_installation"]
        };
        
        private _bluforInstallations = allMapMarkers select {
            markerType _x == "b_installation" &&
            (markerColor _x == "ColorYellow" || markerColor _x == "colorBLUFOR" || markerColor _x == "colorWEST")
        };

        // Calculate distances between installations
        private _distanceMap = [];
        {
            for "_i" from 0 to count _bluforInstallations - 1 do {
                private _distance = getMarkerPos _x distanceSqr (getMarkerPos (_bluforInstallations select _i));
                _distanceMap pushBack _distance;
            };
        } forEach _opforInstallations;

        _distanceMap sort true;
        private _closestDistance = _distanceMap select 0;
        private _sourceOpforMarker = "";
        private _targetBluforMarker = "";

        // Find the specific markers that match this distance
        {
            for "_i" from 0 to count _bluforInstallations - 1 do {
                private _distance = getMarkerPos _x distanceSqr (getMarkerPos (_bluforInstallations select _i));
                if (_distance == _closestDistance) then {
                    _targetBluforMarker = _bluforInstallations select _i;
                    _sourceOpforMarker = _x;
                };
            };
        } forEach _opforInstallations;

        // Calculate distance and find suitable location between installations
        private _actualDistance = (getMarkerPos _sourceOpforMarker) distance (getMarkerPos _targetBluforMarker);
        private _intermediateDistance = _actualDistance * 2 / 3;

        // Find elevated positions (mounts) in the area between installations
        private _mountsNearOpfor = nearestLocations [(getMarkerPos _sourceOpforMarker), ["Mount"], _intermediateDistance];
        private _mountsNearBlufor = nearestLocations [(getMarkerPos _targetBluforMarker), ["Mount"], _intermediateDistance];
        private _mountsInBetween = _mountsNearOpfor arrayIntersect _mountsNearBlufor;

        // Filter out positions with players nearby
        private _validPositions = _mountsInBetween select {
            private _position = _x;
            private _positionCoords = locationPosition _position;
            private _nearPlayers = allPlayers select {(_x distance _positionCoords) < 1000 && {side _x isEqualTo west}};
            count _nearPlayers isEqualTo 0
        };

        if (_validPositions isEqualTo []) then {
            diag_log "[FLO] WARNING: No valid positions found without players nearby, using original list";
            _validPositions = _mountsInBetween;
        };

        // Select a random position for the roadblock
        private _selectedPosition = selectRandom _validPositions;
        private _positionCoords = locationPosition _selectedPosition;

        // Create marker for new roadblock
        private _roadblockMarkerName = "AssltOutpost" + (str ([0, 0, 0] getPos [(10 + (random 150)), (0 + (random 360))]));
        publicVariable "_roadblockMarkerName";

        createMarker [_roadblockMarkerName, _positionCoords];
        _roadblockMarkerName setMarkerType "o_service";
        _roadblockMarkerName setMarkerColor "colorOPFOR";
        _roadblockMarkerName setMarkerSize [0.8, 0.8];
        _roadblockMarkerName setMarkerAlpha 1;

        // Create trigger for roadblock initialization
        private _roadblockTrigger = createTrigger ["EmptyDetector", _positionCoords, false];
        _roadblockTrigger setTriggerArea [2000, 2000, 0, false, 100];
        _roadblockTrigger setTriggerInterval 3;
        _roadblockTrigger setTriggerTimeout [1, 1, 1, true];
        _roadblockTrigger setTriggerActivation ["WEST", "PRESENT", false];
        _roadblockTrigger setTriggerStatements [
            "this","	

				private _TERR = nearestTerrainObjects [(getPos thisTrigger), ['FOREST', 'House', 'TREE', 'SMALL TREE', 'BUSH', 'ROCK', 'ROCKS'], 40]; 
				{_x hideObjectGlobal true;} forEach _TERR ;

				private _mrkrs = allMapMarkers select {markerColor _x == 'Color6_FD_F'};
				private _mrkr = _mrkrs select 0;
				_AGGRSCORE = markerText _mrkr call BIS_fnc_parseNumber;  

				private _P1 = [ 
				'Road_Post_CSAT_01',  
				'Road_Post_CSAT_02',
				'Road_Post_CSAT_01',  
				'Road_Post_CSAT_02',
				'Road_Post_CSAT_01',  
				'Road_Post_CSAT_02',
				'Road_Post_CSAT_01',  
				'Road_Post_CSAT_02',
				'Road_Post_CSAT_01',  
				'Road_Post_CSAT_02',
				'Road_Post_CSAT_01',  
				'Road_Post_CSAT_02',
				'Watchpost_1', 
				'Watchpost_2', 
				'Watchpost_3', 
				'Watchpost_4', 
				'Watchpost_5', 
				'Watchpost_6',
				'Watchpost_7',
				'Watchpost_8',
				'Watchpost_9',
				'Watchpost_10'
				 ]; 

				if (_AGGRSCORE > 5) then {
				_P1 =  [ 
				'Road_Post_CSAT_03',  
				'Road_Post_CSAT_04',
				'Road_Post_CSAT_03',  
				'Road_Post_CSAT_04',
				'Road_Post_CSAT_03',  
				'Road_Post_CSAT_04',
				'Road_Post_CSAT_03',  
				'Road_Post_CSAT_04',
				'Road_Post_CSAT_03',  
				'Road_Post_CSAT_04',
				'Road_Post_CSAT_03',  
				'Road_Post_CSAT_04',
				'Watchpost_1', 
				'Watchpost_2', 
				'Watchpost_3', 
				'Watchpost_4', 
				'Watchpost_5', 
				'Watchpost_6',
				'Watchpost_7',
				'Watchpost_8',
				'Watchpost_9',
				'Watchpost_10'
				]; };

				if (_AGGRSCORE > 10) then {
				_P1 =  [ 
				'Road_Post_CSAT_05',  
				'Road_Post_CSAT_06',
				'Road_Post_CSAT_05',  
				'Road_Post_CSAT_06',
				'Road_Post_CSAT_05',  
				'Road_Post_CSAT_06',
				'Road_Post_CSAT_05',  
				'Road_Post_CSAT_06',
				'Road_Post_CSAT_05',  
				'Road_Post_CSAT_06',
				'Road_Post_CSAT_05',  
				'Road_Post_CSAT_06',
				'Watchpost_1', 
				'Watchpost_2', 
				'Watchpost_3', 
				'Watchpost_4', 
				'Watchpost_5', 
				'Watchpost_6',
				'Watchpost_7',
				'Watchpost_8',
				'Watchpost_9',
				'Watchpost_10'
				]; };

						
				private _COM = [ selectRandom _P1, _positionCoords, [0,0,0], _dir, true ] call LARs_fnc_spawnComp;	
				private _ARRAY = [ _COM ] call LARs_fnc_getCompObjects;
				{_x setVectorUp [0,0,1]} forEach _ARRAY;


				_trgA = createTrigger ['EmptyDetector', _positionCoords, false];
				_trgA setTriggerArea [1000, 1000, 0, false, 100];
				_trgA setTriggerInterval 3;
				_trgA setTriggerTimeout [3, 3, 3, true];
				_trgA setTriggerActivation ['WEST', 'PRESENT', false];
				_trgA setTriggerStatements [
				""this"",""

				[thisTrigger] execVM 'Scripts\RoadBlock_CSAT.sqf';

				"",""""];

				", ""
        ];

        // Notify players
        ["showNotification", ["! WARNING !", "Enemy Deployed New Military Installation!", "warning"]] call FLO_fnc_intelSystem;
        private _roadblockGrid = mapGridPosition getMarkerPos _roadblockMarkerName;
        [[west,"HQ"], "Enemy Deployed New Military Installation at grid " + _roadblockGrid] remoteExec ["sideChat", 0];
    };
};

sleep 10;

// Clean up assault markers
private _assaultMarkers = allMapMarkers select {markerType _x == "mil_marker_noShadow" && markerAlpha _x == 0.5};
{deleteMarker _x;} forEach _assaultMarkers;

frontLineComplete = true;