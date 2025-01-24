if (!isServer) exitWith {};

waitUntil {
    sleep 120;
    (count (allMapMarkers select {markerType _x == "loc_Bunker" && markerAlpha _x == 0.003}) > 0)
};

sleep 10;

private _BunkMarks = allMapMarkers select {markerType _x == "loc_Bunker" && markerAlpha _x == 0.003};
{deleteMarker _x;} forEach _BunkMarks;

private _mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
private _mrkr = _mrkrs select 0;

private _AGGRSCORE = markerText _mrkr call BIS_fnc_parseNumber;

// OPFOR Frontline Becomes More Aggressive as Aggression Increases 
// Setting up more Outpost FOBs pushing BLUFOR Installations
private _Time = 900;
if (_AGGRSCORE > 3) then {_Time = 700;};
if (_AGGRSCORE > 9) then {_Time = 500;};
if (_AGGRSCORE > 12) then {_Time = 300;};
sleep _Time;

private _headlessClients = entities "HeadlessClient_F";
private _humanPlayers = allPlayers - _headlessClients;

if (count _humanPlayers > 0) then {

    private _ENMChances = selectRandom [6, 7, 8, 9, 10, 11];

    if (_AGGRSCORE > 7) then {
        _ENMChances = selectRandom [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    };

    // This chance rolls then we do a full scale assault using vehicles & helicopters
    // This does not create a new OPFOR FOB
    if (_ENMChances > 7) then {
        private _allZoneMarks = allMapMarkers select {
            markerType _x == "loc_Power" ||
            markerType _x == "o_support" ||
            markerType _x == "n_support" ||
            markerType _x == "loc_Ruin" ||
            markerType _x == "n_installation" ||
            markerType _x == "o_installation"
        };
        private _AssltDestMrks = allMapMarkers select {
            markerType _x == "b_installation" &&
            (markerColor _x == "ColorYellow" || markerColor _x == "colorBLUFOR" || markerColor _x == "colorWEST")
        };

        private _DSTall = [];

        {
            for "_i" from 0 to count _AssltDestMrks - 1 do {
                private _DSTach = getMarkerPos ((_AssltDestMrks) select _i) distanceSqr (getMarkerPos _x);
                _DSTall append [_DSTach];
            };
        } forEach _allZoneMarks;

        _DSTall sort true;
        private _DSneeded = _DSTall select 0;
        private _OBJmrkmrk = [];
        private _Destmrkmrk = [];

        {
            for "_i" from 0 to count _AssltDestMrks - 1 do {
                private _DSTach = getMarkerPos ((_AssltDestMrks) select _i) distanceSqr (getMarkerPos _x);
                if (_DSTach == _DSneeded) then {
                    _Destmrkmrk append [((_AssltDestMrks) select _i)];
                    _OBJmrkmrk append [_x];
                };
            };
        } forEach _allZoneMarks;

        private _OBJmrk = _OBJmrkmrk select 0;
        private _Destmrk = _Destmrkmrk select 0;

        private _CNTR = (nearestObjects [
            (getMarkerPos _Destmrk),
            FLO_configCache get "HQbuildings",
            300
        ]) select 0;

        private _ENMASSmarkerName = "AssltDest" + (str ([0, 0, 0] getPos [(10 + (random 150)), (0 + (random 360))]));
        publicVariable "_ENMASSmarkerName";

        createMarker [_ENMASSmarkerName, (getPos _CNTR)];
        _ENMASSmarkerName setMarkerType "mil_marker_noShadow";
        _ENMASSmarkerName setMarkerColor "colorOPFOR";
        _ENMASSmarkerName setMarkerSize [2.5, 2.5];
        _ENMASSmarkerName setMarkerAlpha 0.5;

        [parseText "<t color='#FF3619' font='PuristaBold' align = 'right' shadow = '1' size='2'>! WARNING !</t><br /><t  color='#FF3619'  align = 'right' shadow = '1' size='1'>Friendly Objective is Under Attack</t>", [0, 0.5, 1, 1], nil, 13, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];
        sleep 1.5;
        private _attackingAtGrid = mapGridPosition getMarkerPos _ENMASSmarkerName;
        [[west,"HQ"], "Friendly Location Under Enemy attack at grid" + _attackingAtGrid] remoteExec ["sideChat", 0];

        private _Assaultazimuth = (getMarkerPos _Destmrk) getDir (getMarkerPos _OBJmrk);

        // Start with recon if aggression is high enough
        if (_AGGRSCORE > 3) then {
            [getPos _CNTR] call FLO_fnc_airRecon;
            sleep 300;
        };
        
        // Artillery prep based on aggression
        if (_AGGRSCORE > 5) then {
            [getPos _CNTR, _AGGRSCORE] call FLO_fnc_artilleryPrep;
            sleep 180;
        };
        
        // Select attack pattern based on terrain and situation
        private _pattern = selectRandom ["PINCER", "FRONTAL", "INFILTRATION"];
        if (_AGGRSCORE > 10) then {
            _pattern = "FRONTAL"; // More aggressive at high aggression
        };
        
        // Execute the attack with combined arms
        [getPos _CNTR, getMarkerPos _OBJmrk, _pattern, _AGGRSCORE] call FLO_fnc_executeAttackPattern;
        
        // Original QRF and vehicle insertions follow
        private _QRF = selectRandom ["Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"];
        [_CNTR] execVM _QRF;
        private _PRL = [(getMarkerPos _Destmrk) getPos [(500 + (random 100)), (_Assaultazimuth + (random 20))], East, [
            selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"),
            selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units")
        ]] call BIS_fnc_spawnGroup;
        private _WP_1 = _PRL addWaypoint [getMarkerPos _Destmrk, 0];
        _WP_1 SetWaypointType "MOVE";

        sleep 10;

        if (_AGGRSCORE > 5) then {
            _Assaultazimuth = (getMarkerPos _Destmrk) getDir (getMarkerPos _OBJmrk);

            _QRF = selectRandom ["Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"];
            [_CNTR] execVM _QRF;
            _PRL = [(getMarkerPos _Destmrk) getPos [(500 + (random 100)), (_Assaultazimuth + (random 20))], East, [
                selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"),
                selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units")
            ]] call BIS_fnc_spawnGroup;
            _WP_1 = _PRL addWaypoint [getMarkerPos _Destmrk, 0];
            _WP_1 SetWaypointType "MOVE";
        };

        sleep 10;

        if (_AGGRSCORE > 10) then {
            _Assaultazimuth = (getMarkerPos _Destmrk) getDir (getMarkerPos _OBJmrk);
            [_CNTR] execVM "Scripts\VehiInsert_CSAT_3.sqf";
            _PRL = [(getMarkerPos _Destmrk) getPos [(500 + (random 100)), (_Assaultazimuth - (random 20))], East, [
                selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"),
                selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units")
            ]] call BIS_fnc_spawnGroup;
            _WP_1 = _PRL addWaypoint [getMarkerPos _Destmrk, 0];
            _WP_1 SetWaypointType "MOVE";
        };
    };

    // This chance rolls then we do not perform an assault
    // but this time we create a new OPFOR FOB 
    if ((_ENMChances > 4) && (_ENMChances < 8)) then {
        private _allZoneMarks = allMapMarkers select {
            markerType _x == "loc_Power" ||
            markerType _x == "o_support" ||
            markerType _x == "n_support" ||
            markerType _x == "loc_Ruin" ||
            markerType _x == "n_installation" ||
            markerType _x == "o_installation"
        };
        private _AssltDestMrks = allMapMarkers select {
            markerType _x == "b_installation" &&
            (markerColor _x == "ColorYellow" || markerColor _x == "colorBLUFOR" || markerColor _x == "colorWEST")
        };

        private _DSTall = [];

        {
            for "_i" from 0 to count _AssltDestMrks - 1 do {
                private _DSTach = getMarkerPos ((_AssltDestMrks) select _i) distanceSqr (getMarkerPos _x);
                _DSTall append [_DSTach];
            };
        } forEach _allZoneMarks;

        _DSTall sort true;
        private _DSneeded = _DSTall select 0;
        private _DSneededFinal = _DSneeded * 2 / 3;
        private _OBJmrkmrk = [];
        private _Destmrkmrk = [];

        {
            for "_i" from 0 to count _AssltDestMrks - 1 do {
                private _DSTach = getMarkerPos ((_AssltDestMrks) select _i) distanceSqr (getMarkerPos _x);
                if (_DSTach == _DSneeded) then {
                    _Destmrkmrk append [((_AssltDestMrks) select _i)];
                    _OBJmrkmrk append [_x];
                };
            };
        } forEach _allZoneMarks;

        private _OBJmrk = _OBJmrkmrk select 0;
        private _Destmrk = _Destmrkmrk select 0;
        _DSneeded = (getMarkerPos _OBJmrk) distance (getMarkerPos _Destmrk);
        _DSneededFinal = _DSneeded * 2 / 3;

        private _MountsOBJ = nearestLocations [(getMarkerPos _OBJmrk), ["Mount"], _DSneededFinal];
        private _MountsDest = nearestLocations [(getMarkerPos _Destmrk), ["Mount"], _DSneededFinal];
        private _MountsFronline = _MountsOBJ arrayIntersect _MountsDest;

        private _validMounts = _MountsFronline select {
            private _mount = _x;
            private _nearPlayers = _mount nearEntities ["CAManBase", 1000] select {isPlayer _x && {side _x isEqualTo west}};
            count _nearPlayers isEqualTo 0
        };

        if (_validMounts isEqualTo []) then {
            diag_log "[FLO] WARNING: No valid mounts found without players nearby, using original list";
            _validMounts = _MountsFronline;
        };

        private _MountFinal = selectRandom _validMounts;

        private _ENMASSmarkerName = "AssltOutpost" + (str ([0, 0, 0] getPos [(10 + (random 150)), (0 + (random 360))]));
        publicVariable "_ENMASSmarkerName";

        createMarker [_ENMASSmarkerName, (locationPosition _MountFinal)];
        _ENMASSmarkerName setMarkerType "o_support";
        _ENMASSmarkerName setMarkerColor "colorOPFOR";
        _ENMASSmarkerName setMarkerSize [1.2, 1.2];
        _ENMASSmarkerName setMarkerAlpha 1;

        private _trg = createTrigger ["EmptyDetector", (locationPosition _MountFinal), false];
        _trg setTriggerArea [2000, 2000, 0, false, 100];
        _trg setTriggerInterval 3;
        _trg setTriggerTimeout [1, 1, 1, true];
        _trg setTriggerActivation ["WEST", "PRESENT", false];
        _trg setTriggerStatements [
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
        [parseText "<t color='#FF3619' font='PuristaBold' align = 'right' shadow = '1' size='2'>! WARNING !</t><br /><t  color='#FF3619'  align = 'right' shadow = '1' size='1'>Enemy Deployed New Military Installation</t>", [0, 0.5, 1, 1], nil, 13, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];
        _attackingAtGrid = mapGridPosition getMarkerPos _ENMASSmarkerName;
        [[west,"HQ"], "Enemy Deployed New Military Installation at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];
    };

    // This chance rolls then we do not perform an assault
    // We just setup a new roadblock
    if (_ENMChances < 5) then {
        private _allZoneMarks = allMapMarkers select {
            markerType _x == "loc_Power" ||
            markerType _x == "o_support" ||
            markerType _x == "n_support" ||
            markerType _x == "loc_Ruin" ||
            markerType _x == "n_installation" ||
            markerType _x == "o_installation"
        };
        private _AssltDestMrks = allMapMarkers select {
            markerType _x == "b_installation" &&
            (markerColor _x == "ColorYellow" || markerColor _x == "colorBLUFOR" || markerColor _x == "colorWEST")
        };

        private _DSTall = [];

        {
            for "_i" from 0 to count _AssltDestMrks - 1 do {
                private _DSTach = getMarkerPos ((_AssltDestMrks) select _i) distanceSqr (getMarkerPos _x);
                _DSTall append [_DSTach];
            };
        } forEach _allZoneMarks;

        _DSTall sort true;
        private _DSneeded = _DSTall select 0;
        private _DSneededFinal = _DSneeded * 2 / 3;
        private _OBJmrkmrk = [];
        private _Destmrkmrk = [];

        {
            for "_i" from 0 to count _AssltDestMrks - 1 do {
                private _DSTach = getMarkerPos ((_AssltDestMrks) select _i) distanceSqr (getMarkerPos _x);
                if (_DSTach == _DSneeded) then {
                    _Destmrkmrk append [((_AssltDestMrks) select _i)];
                    _OBJmrkmrk append [_x];
                };
            };
        } forEach _allZoneMarks;

        private _OBJmrk = _OBJmrkmrk select 0;
        private _Destmrk = _Destmrkmrk select 0;
        _DSneeded = (getMarkerPos _OBJmrk) distance (getMarkerPos _Destmrk);
        _DSneededFinal = _DSneeded * 2 / 3;

        private _MountsOBJ = nearestLocations [(getMarkerPos _OBJmrk), ["Mount"], _DSneededFinal];
        private _MountsDest = nearestLocations [(getMarkerPos _Destmrk), ["Mount"], _DSneededFinal];
        private _MountsFronline = _MountsOBJ arrayIntersect _MountsDest;

        private _validMounts = _MountsFronline select {
            private _mount = _x;
            private _nearPlayers = _mount nearEntities ["CAManBase", 1000] select {isPlayer _x && {side _x isEqualTo west}};
            count _nearPlayers isEqualTo 0
        };

        if (_validMounts isEqualTo []) then {
            diag_log "[FLO] WARNING: No valid mounts found without players nearby, using original list";
            _validMounts = _MountsFronline;
        };

        private _MountFinal = selectRandom _validMounts;

        private _ENMASSmarkerName = "AssltOutpost" + (str ([0, 0, 0] getPos [(10 + (random 150)), (0 + (random 360))]));
        publicVariable "_ENMASSmarkerName";

        createMarker [_ENMASSmarkerName, (getPos _MountFinal)];
        _ENMASSmarkerName setMarkerType "o_service";
        _ENMASSmarkerName setMarkerColor "colorOPFOR";
        _ENMASSmarkerName setMarkerSize [0.8, 0.8];
        _ENMASSmarkerName setMarkerAlpha 1;

        private _trg = createTrigger ["EmptyDetector", (getPos _MountFinal), false];
        _trg setTriggerArea [2000, 2000, 0, false, 100];
        _trg setTriggerInterval 3;
        _trg setTriggerTimeout [1, 1, 1, true];
        _trg setTriggerActivation ["WEST", "PRESENT", false];
        _trg setTriggerStatements [
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

						
				private _COM = [ selectRandom _P1, getPosATL _MountFinal, [0,0,0], _dir, true ] call LARs_fnc_spawnComp;	
				private _ARRAY = [ _COM ] call LARs_fnc_getCompObjects;
				{_x setVectorUp [0,0,1]} forEach _ARRAY;


				_trgA = createTrigger ['EmptyDetector', (getPosATL _MountFinal), false];
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

        [parseText "<t color='#FF3619' font='PuristaBold' align = 'right' shadow = '1' size='2'>! WARNING !</t><br /><t  color='#FF3619'  align = 'right' shadow = '1' size='1'>Enemy Deployed New Military Installation</t>", [0, 0.5, 1, 1], nil, 13, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];
        sleep 1.5;
        _attackingAtGrid = mapGridPosition getMarkerPos _ENMASSmarkerName;
        [[west,"HQ"], "Enemy Deployed New Military Installation at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];
    };
};

sleep 10;

private _AssMarks = allMapMarkers select {markerType _x == "mil_marker_noShadow" && markerAlpha _x == 0.5};
{deleteMarker _x;} forEach _AssMarks;

frontLineComplete = true;