	
	waitUntil {sleep 120 ; (count (allMapMarkers select {markerType _x == "loc_Bunker" && markerAlpha _x == 0.003}) > 0)} ; 
	
	sleep 10 ;	

				_BunkMarks = allMapMarkers select {markerType _x == "loc_Bunker" && markerAlpha _x == 0.003};  
				{deleteMarker _x ;} forEach _BunkMarks ;

				
	_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
	_mrkr = _mrkrs select 0;
	_AGGRSCORE = parseNumber (markerText _mrkr) ;  
			
			_Time = 900 ;
			if (_AGGRSCORE > 3) then {_Time = 700 ;} ; 
			if (_AGGRSCORE > 9) then {_Time = 500 ;} ; 
			if (_AGGRSCORE > 12) then {_Time = 300 ;} ; 
			sleep _Time ;
	

private _headlessClients = entities "HeadlessClient_F" ;
private _humanPlayers = allPlayers - _headlessClients ;

if (count _humanPlayers > 0) then {

	_ENMChances = selectRandom [6, 7, 8, 9, 10, 11] ; 

	if (_AGGRSCORE > 7) then {
	_ENMChances = selectRandom [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] ; 
	};
	
	if (_ENMChances > 7) then {		
			_allZoneMarks = allMapMarkers select {markerType _x == "loc_Power" || markerType _x == "o_support" || markerType _x == "n_support" || markerType _x == "loc_Ruin" || markerType _x == "n_installation" || markerType _x == "o_installation"} ;  
			_AssltDestMrks = allMapMarkers select {markerType _x == "b_installation"  && (markerColor _x == "ColorYellow" or  markerColor _x == "colorBLUFOR" or markerColor _x == "colorWEST")};  

			_DSTall = [] ;
			
				{
					for "_i" from 0 to count _AssltDestMrks -1 do { 
					_DSTach = getMarkerPos ((_AssltDestMrks) select _i) distanceSqr (getMarkerPos _x) ;
					_DSTall append [_DSTach] ;
					}; 
				} forEach _allZoneMarks ;

			_DSTall sort true;
			_DSneeded = _DSTall select 0 ;
			_OBJmrk = [] ; 
			_Destmrk = [] ;
			
				{
					
						for "_i" from 0 to count _AssltDestMrks -1 do { 
					_DSTach = getMarkerPos ((_AssltDestMrks) select _i) distanceSqr (getMarkerPos _x) ;
					if (_DSTach == _DSneeded) then {_Destmrk append [((_AssltDestMrks) select _i)]} ;
					if (_DSTach == _DSneeded) then {_OBJmrk append [_x]} ;
						};
				} forEach _allZoneMarks ;	

			_OBJ =  _OBJmrk select 0;
			_Dest = _Destmrk select 0;
			
			_CNTR = (nearestObjects [(getMarkerPos _Dest), ["Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V1_F", "Land_Cargo_House_V1_F", "Land_Cargo_House_V3_F", "Land_Cargo_HQ_V3_ruins_F", "Land_Cargo_HQ_V1_ruins_F", "Land_Cargo_House_V1_ruins_F", "Land_Cargo_House_V3_ruins_F", "House"], 300]) select 0 ;

			
ENMASSmarkerName = "AssltDest" + (str ((getPos TheCommander) getPos [(10 + (random 150)), (0 + (random 360))]));   
 publicVariable "ENMASSmarkerName"; 
 
createMarker [ENMASSmarkerName,  (getPos _CNTR)] ;  
ENMASSmarkerName setMarkerType "mil_marker_noShadow" ;  
ENMASSmarkerName setMarkerColor "colorOPFOR" ;   
ENMASSmarkerName setMarkerSize [2.5, 2.5] ; 
ENMASSmarkerName setMarkerAlpha 0.5 ;   
 
 	[parseText "<t color='#FF3619' font='PuristaBold' align = 'right' shadow = '1' size='2'>! WARNING !</t><br /><t  color='#FF3619'  align = 'right' shadow = '1' size='1'>Friendly Objective is Under Attack</t>", [0, 0.5, 1, 1], nil, 13, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];
	sleep 1.5 ;
	_attackingAtGrid = mapGridPosition getMarkerPos ENMASSmarkerName;
	[[west,"HQ"], "Friendly Location Under Enemy attack at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];

_azimuth = (getMarkerPos _Dest) getDir (getMarkerPos _OBJ) ;

			 _QRF = selectRandom [ "Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"]; 
			[_CNTR] execVM _QRF ;
		_PRL = [(getMarkerPos _Dest) getPos [(500 + (random 100)), (_azimuth + (random 20))] , East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
		_WP_1 = _PRL addWaypoint [getMarkerPos _Dest, 0]; 
		_WP_1 SetWaypointType "MOVE"; 



	sleep 10 ;



		if (_AGGRSCORE > 5) then {
 
_azimuth = (getMarkerPos _Dest) getDir (getMarkerPos _OBJ) ;

			 _QRF = selectRandom [ "Scripts\HeliInsert_CSAT.sqf", "Scripts\VehiInsert_CSAT.sqf"]; 
			[_CNTR] execVM _QRF ;
		_PRL = [(getMarkerPos _Dest) getPos [(500 + (random 100)), (_azimuth + (random 20))] , East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
		_WP_1 = _PRL addWaypoint [getMarkerPos _Dest, 0]; 
		_WP_1 SetWaypointType "MOVE"; 

		
			};


	sleep 10 ;


		if (_AGGRSCORE > 10) then {
				
_azimuth = (getMarkerPos _Dest) getDir (getMarkerPos _OBJ) ;
			[_CNTR] execVM "Scripts\VehiInsert_CSAT_3.sqf";
		_PRL = [(getMarkerPos _Dest) getPos [(500 + (random 100)), (_azimuth - (random 20))] , East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
		_WP_1 = _PRL addWaypoint [getMarkerPos _Dest, 0]; 
		_WP_1 SetWaypointType "MOVE"; 
			};
	};

	if ((_ENMChances > 4) && (_ENMChances < 8)) then {		
			_allZoneMarks = allMapMarkers select {markerType _x == "loc_Power" || markerType _x == "o_support" || markerType _x == "n_support" || markerType _x == "loc_Ruin" || markerType _x == "n_installation" || markerType _x == "o_installation"} ;  
			_AssltDestMrks = allMapMarkers select {markerType _x == "b_installation"  && (markerColor _x == "ColorYellow" or  markerColor _x == "colorBLUFOR" or markerColor _x == "colorWEST")};  

			_DSTall = [] ;
			
				{
					for "_i" from 0 to count _AssltDestMrks -1 do { 
					_DSTach = getMarkerPos ((_AssltDestMrks) select _i) distanceSqr (getMarkerPos _x) ;
					_DSTall append [_DSTach] ;
					}; 
				} forEach _allZoneMarks ;

			_DSTall sort true;
			_DSneeded = _DSTall select 0 ;
			_DSneededFinal = _DSneeded * 2 / 3 ; 
			_OBJmrk = [] ; 
			_Destmrk = [] ;
			
				{
					
						for "_i" from 0 to count _AssltDestMrks -1 do { 
					_DSTach = getMarkerPos ((_AssltDestMrks) select _i) distanceSqr (getMarkerPos _x) ;
					if (_DSTach == _DSneeded) then {_Destmrk append [((_AssltDestMrks) select _i)]} ;
					if (_DSTach == _DSneeded) then {_OBJmrk append [_x]} ;
						};
				} forEach _allZoneMarks ;	

			_OBJ =  _OBJmrk select 0;
			_Dest = _Destmrk select 0;
						_DSneeded = (getMarkerPos _OBJ) distance (getMarkerPos _Dest) ; 
						_DSneededFinal = _DSneeded * 2 / 3 ; 
			
			
			_MountsOBJ = nearestLocations [ (getMarkerPos _OBJ), ["Mount"], _DSneededFinal];   			
			_MountsDest = nearestLocations [ (getMarkerPos _Dest), ["Mount"], _DSneededFinal]; 
			 _MountsFronline = _MountsOBJ arrayIntersect _MountsDest;
		
			_MountFinal = selectRandom _MountsFronline ;
			
			 ENMASSmarkerName = "AssltOutpost" + (str ((getPos TheCommander) getPos [(10 + (random 150)), (0 + (random 360))]));   
			 publicVariable "ENMASSmarkerName"; 
			 
			createMarker [ENMASSmarkerName,  (locationPosition _MountFinal)] ;  
			ENMASSmarkerName setMarkerType "o_support" ;  
			ENMASSmarkerName setMarkerColor "colorOPFOR" ;   
			ENMASSmarkerName setMarkerSize [1.2, 1.2] ; 
			ENMASSmarkerName setMarkerAlpha 1 ;   

							
						_trg = createTrigger ["EmptyDetector", (locationPosition _MountFinal), false];
						_trg setTriggerArea [2000, 2000, 0, false, 100];
						_trg setTriggerInterval 3;
						_trg setTriggerTimeout [1, 1, 1, true];
						_trg setTriggerActivation ["WEST", "PRESENT", false];
						_trg setTriggerStatements [
						"this","	

						[thisTrigger] execVM 'Scripts\Insurgents_Init.sqf';
							
						if ( count (nearestObjects [thisTrigger, ['Land_Cargo_Tower_V3_F', 'Land_Cargo_Tower_V2_F', 'Land_Cargo_Tower_V1_F', 'Land_Cargo_HQ_V3_F', 'Land_Cargo_HQ_V2_F', 'Land_Cargo_HQ_V1_F'], 100] ) == 0) then {

						_TERR = nearestTerrainObjects [(getPos thisTrigger), ['FOREST', 'House', 'TREE', 'SMALL TREE', 'BUSH', 'ROCK', 'ROCKS'], 40]; 
						{[_x, true] remoteExec ['hideObjectGlobal', 0];} forEach _TERR ;

						_mrkrs = allMapMarkers select {markerColor _x == 'Color6_FD_F'};
						_mrkr = _mrkrs select 0;
						_AGGRSCORE = parseNumber (markerText _mrkr) ;  

						_P1 = [ 
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


						_compReference = [ selectRandom _P1, (getPos thisTrigger), [0,0,0], _dir, true ] call LARs_fnc_spawnComp;

						_ARRAY = [ _compReference ] call LARs_fnc_getCompObjects;
						{_x setVectorUp [0,0,1];} forEach _ARRAY; 
						};

						_trgA = createTrigger ['EmptyDetector', (getPos thisTrigger), false];
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
						""this"", ""

						[thisTrigger] execVM 'Scripts\HeliInsert_CSAT.sqf';

						"",""""];

						_trgA = createTrigger ['EmptyDetector', (getPos thisTrigger), false];
						_trgA setTriggerArea [500, 500, 0, false, 60];
						_trgA setTriggerInterval 3;
						_trgA setTriggerTimeout [1, 1, 1, true];
						_trgA setTriggerActivation ['WEST', 'PRESENT', false];
						_trgA setTriggerStatements [
						""this"", ""

						[thisTrigger] execVM 'Scripts\VehiInsert_CSAT.sqf';

						"",""""];


						", ""];
 
			[parseText "<t color='#FF3619' font='PuristaBold' align = 'right' shadow = '1' size='2'>! WARNING !</t><br /><t  color='#FF3619'  align = 'right' shadow = '1' size='1'>Enemy Deployed New Military Installation</t>", [0, 0.5, 1, 1], nil, 13, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];
				_attackingAtGrid = mapGridPosition getMarkerPos ENMASSmarkerName;
	[[west,"HQ"], "Enemy Deployed New Military Installation at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];
			
			};


	if (_ENMChances < 5) then {		
			_allZoneMarks = allMapMarkers select {markerType _x == "loc_Power" || markerType _x == "o_support" || markerType _x == "n_support" || markerType _x == "loc_Ruin" || markerType _x == "n_installation" || markerType _x == "o_installation"} ;  
			_AssltDestMrks = allMapMarkers select {markerType _x == "b_installation"  && (markerColor _x == "ColorYellow" or  markerColor _x == "colorBLUFOR" or markerColor _x == "colorWEST")};  

			_DSTall = [] ;
			
				{
					for "_i" from 0 to count _AssltDestMrks -1 do { 
					_DSTach = getMarkerPos ((_AssltDestMrks) select _i) distanceSqr (getMarkerPos _x) ;
					_DSTall append [_DSTach] ;
					}; 
				} forEach _allZoneMarks ;

			_DSTall sort true;
			_DSneeded = _DSTall select 0 ;
			_DSneededFinal = _DSneeded * 2 / 3 ; 
			_OBJmrk = [] ; 
			_Destmrk = [] ;
			
				{
					
						for "_i" from 0 to count _AssltDestMrks -1 do { 
					_DSTach = getMarkerPos ((_AssltDestMrks) select _i) distanceSqr (getMarkerPos _x) ;
					if (_DSTach == _DSneeded) then {_Destmrk append [((_AssltDestMrks) select _i)]} ;
					if (_DSTach == _DSneeded) then {_OBJmrk append [_x]} ;
						};
				} forEach _allZoneMarks ;	

			_OBJ =  _OBJmrk select 0;
			_Dest = _Destmrk select 0;
									_DSneeded = (getMarkerPos _OBJ) distance (getMarkerPos _Dest) ; 
						_DSneededFinal = _DSneeded * 2 / 3 ; 
			
			_MountsOBJ = nearestLocations [ (getMarkerPos _OBJ), ["Mount"], _DSneededFinal];   			
			_MountsDest = nearestLocations [ (getMarkerPos _Dest), ["Mount"], _DSneededFinal]; 
			 _MountsFronline = _MountsOBJ arrayIntersect _MountsDest;
		
			_MountFinal = selectRandom _MountsFronline ;
			
			 ENMASSmarkerName = "AssltOutpost" + (str ((getPos TheCommander) getPos [(10 + (random 150)), (0 + (random 360))]));   
			 publicVariable "ENMASSmarkerName"; 
			 
			createMarker [ENMASSmarkerName,  (getPos _MountFinal)] ;  
			ENMASSmarkerName setMarkerType "o_service" ;  
			ENMASSmarkerName setMarkerColor "colorOPFOR" ;   
			ENMASSmarkerName setMarkerSize [0.8, 0.8] ; 
			ENMASSmarkerName setMarkerAlpha 1 ;   


				_trg = createTrigger ["EmptyDetector", (getPos _MountFinal), false];
				_trg setTriggerArea [2000, 2000, 0, false, 100];
				_trg setTriggerInterval 3;
				_trg setTriggerTimeout [1, 1, 1, true];
				_trg setTriggerActivation ["WEST", "PRESENT", false];
				_trg setTriggerStatements [
				"this","	

				_TERR = nearestTerrainObjects [(getPos thisTrigger), ['FOREST', 'House', 'TREE', 'SMALL TREE', 'BUSH', 'ROCK', 'ROCKS'], 40]; 
				{[_x, true] remoteExec ['hideObjectGlobal', 0];} forEach _TERR ;

				_mrkrs = allMapMarkers select {markerColor _x == 'Color6_FD_F'};
				_mrkr = _mrkrs select 0;
				_AGGRSCORE = parseNumber (markerText _mrkr) ;  

				_P1 = [ 
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

						
				_COM = [ selectRandom _P1, getPosATL _MountFinal, [0,0,0], _dir, true ] call LARs_fnc_spawnComp;	
				_ARRAY = [ _COM ] call LARs_fnc_getCompObjects;
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

				", ""];	
				 
			[parseText "<t color='#FF3619' font='PuristaBold' align = 'right' shadow = '1' size='2'>! WARNING !</t><br /><t  color='#FF3619'  align = 'right' shadow = '1' size='1'>Enemy Deployed New Military Installation</t>", [0, 0.5, 1, 1], nil, 13, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];
			sleep 1.5 ;
							_attackingAtGrid = mapGridPosition getMarkerPos ENMASSmarkerName;
			[[west,"HQ"], "Enemy Deployed New Military Installation at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];
			
			
		};



};

	sleep 10 ;	


				_AssMarks = allMapMarkers select {markerType _x == "mil_marker_noShadow" && markerAlpha _x == 0.5 };  
				{deleteMarker _x ;} forEach _AssMarks ;
	
[] execVM "Scripts\Mission_Defend_0.sqf";




	   