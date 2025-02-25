sleep 2;
_Chance = selectRandom [0, 1, 2, 3, 4, 5]; 

if (_Chance == 5) then {
		GNRT = "YES" ;
		DVRT = "NO" ;
		0 = [] spawn {
			  _result = ["Intel Suggests Enemy Support Convoy will be Launched toward Frontlines, We can Intercept the Convoy and Dismantle their Reinforcements and Support operation,  (Optional Mission : Destroy Enemy Convoy)", "", DVRT, GNRT,nil, false, false] call BIS_fnc_guiMessage;


						if (_result) then {
							
						_INTL = allMapMarkers select { (markerAlpha _x == 0.001 or markerAlpha _x == 0) && markerColor _x == "colorOPFOR" && markerType _x != "o_unknown" && markerType _x != "o_inf" && markerType _x != "o_Ordnance" && markerType _x != "o_maint" && markerShape _x != "RECTANGLE" && markerShape _x != "ELLIPSE"};
						_x = [_INTL,  player] call BIS_fnc_nearestPosition;
						_x setMarkerAlpha 1;

								sleep 1;
								["showNotification", ["+ NEW INTEL", "Military Intel Received", "intel"]] call FLO_fnc_intelSystem;
									_attackingAtGrid = mapGridPosition getMarkerPos _x;
								[[west,"HQ"], "Enemy Presence Confirmed at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];

						} ;

						if (!_result) then {
						_Enemy_Convoy = execVM "Scripts\Mission_Convoy.sqf";

						  };
		};

} ;



if (_Chance == 3) then {
		GNRT = "YES" ;
		DVRT = "NO" ;
		0 = [] spawn {
			  _result = ["Intel is about a Friendly Aircraft CrashSite, We can Track them Down and Rescue the Pilot and Destroy the Wreck,  (Optional Mission : Rescue Captured Pilot)", "", DVRT, GNRT,nil, false, false] call BIS_fnc_guiMessage;

						if (_result) then {
							
						_INTL = allMapMarkers select { (markerAlpha _x == 0.001 or markerAlpha _x == 0) && markerColor _x == "colorOPFOR" && markerType _x != "o_unknown" && markerType _x != "o_inf" && markerType _x != "o_Ordnance" && markerType _x != "o_maint" && markerShape _x != "RECTANGLE" && markerShape _x != "ELLIPSE"};
						_x = [_INTL,  player] call BIS_fnc_nearestPosition;
						_x setMarkerAlpha 1;

								sleep 1;
								["showNotification", ["+ NEW INTEL", "Military Intel Received", "intel"]] call FLO_fnc_intelSystem;
									_attackingAtGrid = mapGridPosition getMarkerPos _x;
								[[west,"HQ"], "Enemy Presence Confirmed at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];
						} ;

						if (!_result) then {
							_allMarks = allMapMarkers select {(markerType _x == "b_installation") or (markerType _x == "o_installation") or (markerType _x == "n_installation") or (markerType _x == "o_support") or (markerType _x == "n_support") or  (markerType _x == "loc_Power") or  (markerType _x == "loc_Ruin") };  
							_NOSHs = [] ;
							{
							_NOSH = nearestObjects [getMarkerPos _x , ["HOUSE"], 400] ; 
							_NOSHs append _NOSH ;	
							} forEach _allMarks ;

							_ALLSHs = nearestObjects [player , ["HOUSE"], 7000] select {count (_x buildingPos -1) > 2};
							_NearSHs = nearestObjects [player , ["HOUSE"], 500] select {count (_x buildingPos -1) > 2};
							_SHs = _ALLSHs - _NearSHs ; 
							_SH = _SHs - _NOSHs ;


							_HQB = _SH select 0 ;
							
								_markerName = "InvesMark" + (str (getPos _HQB));   
								_mrkr = createMarker [_markerName, (getPos _HQB)];   
								_mrkr setMarkerType "mil_unknown";  
								_mrkr setMarkerColor "colorOPFOR";  
								_mrkr setMarkerSize [0.8, 0.8]; 
								
								_trgA = createTrigger ["EmptyDetector", (getPos _HQB)];
								_trgA setTriggerArea [2000, 2000, 0, false, 60];
								_trgA setTriggerTimeout [7, 7, 7, true];
								_trgA setTriggerActivation ["WEST", "PRESENT", false];
								_trgA setTriggerStatements [
								"this","

								[thisTrigger] execVM 'Scripts\Mission_Pilot.sqf';


								", ""];
								
								sleep 1;
								["showNotification", ["+ NEW INTEL", "Military Intel Received", "intel"]] call FLO_fnc_intelSystem;
									_attackingAtGrid = mapGridPosition getMarkerPos _mrkr;
								[[west,"HQ"], "Enemy Presence Confirmed at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];
						  };
		};

} ;




if (_Chance == 4) then {
		GNRT = "YES" ;
		DVRT = "NO" ;
		0 = [] spawn {
			  _result = ["Intel Suggest the whereabouts of the Friendly Squad we Lost Contact with Earlier, We can Track them down and Rescue Them,  (Optional Mission : Rescue Missing Squad)", "", DVRT, GNRT,nil, false, false] call BIS_fnc_guiMessage;

						if (_result) then {
							
						_INTL = allMapMarkers select { (markerAlpha _x == 0.001 or markerAlpha _x == 0) && markerColor _x == "colorOPFOR" && markerType _x != "o_unknown" && markerType _x != "o_inf" && markerType _x != "o_Ordnance" && markerType _x != "o_maint" && markerShape _x != "RECTANGLE" && markerShape _x != "ELLIPSE"};
						_x = [_INTL,  player] call BIS_fnc_nearestPosition;
						_x setMarkerAlpha 1;

								sleep 1;
								["showNotification", ["+ NEW INTEL", "Military Intel Received", "intel"]] call FLO_fnc_intelSystem;
									_attackingAtGrid = mapGridPosition getMarkerPos _x;
								[[west,"HQ"], "Enemy Presence Confirmed at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];
						} ;

						if (!_result) then {
							_allMarks = allMapMarkers select {(markerType _x == "b_installation") or (markerType _x == "o_installation") or (markerType _x == "n_installation") or (markerType _x == "o_support") or (markerType _x == "n_support") or  (markerType _x == "loc_Power") or  (markerType _x == "loc_Ruin")};  
							_NOSHs = [] ;
							{
							_NOSH = nearestObjects [getMarkerPos _x , ["HOUSE"], 400] ; 
							_NOSHs append _NOSH ;	
							} forEach _allMarks ;

							_ALLSHs = nearestObjects [player , ["HOUSE"], 7000] select {count (_x buildingPos -1) > 2};
							_NearSHs = nearestObjects [player , ["HOUSE"], 500] select {count (_x buildingPos -1) > 2};
							_SHs = _ALLSHs - _NearSHs ; 
							_SH = _SHs - _NOSHs ;


							_HQB = _SH select 0 ;
							
								_markerName = "InvesMark" + (str (getPos _HQB));   
								_mrkr = createMarker [_markerName, (getPos _HQB)];   
								_mrkr setMarkerType "mil_unknown";  
								_mrkr setMarkerColor "colorOPFOR";  
								_mrkr setMarkerSize [0.8, 0.8]; 
								
								_trgA = createTrigger ["EmptyDetector", (getPos _HQB)];
								_trgA setTriggerArea [2000, 2000, 0, false, 60];
								_trgA setTriggerTimeout [7, 7, 7, true];
								_trgA setTriggerActivation ["WEST", "PRESENT", false];
								_trgA setTriggerStatements [
								"this","

								[thisTrigger] execVM 'Scripts\Mission_Squad.sqf';


								", ""];
						
								sleep 1;
								["showNotification", ["+ NEW INTEL", "Military Intel Received", "intel"]] call FLO_fnc_intelSystem;
									_attackingAtGrid = mapGridPosition getMarkerPos _mrkr;
								[[west,"HQ"], "Enemy Presence Confirmed at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];
						  };
		};

} ;



if (_Chance < 3) then {
_INTL = allMapMarkers select { (markerAlpha _x == 0.001 or markerAlpha _x == 0) && markerColor _x == "colorOPFOR" && markerType _x != "o_unknown" && markerType _x != "o_inf" && markerType _x != "o_Ordnance" && markerType _x != "o_maint" && markerShape _x != "RECTANGLE" && markerShape _x != "ELLIPSE"};
_x = [_INTL,  player] call BIS_fnc_nearestPosition;
_x setMarkerAlpha 1;

								sleep 1;
								["showNotification", ["+ NEW INTEL", "Military Intel Received", "intel"]] call FLO_fnc_intelSystem;
									_attackingAtGrid = mapGridPosition getMarkerPos _x;
								[[west,"HQ"], "Enemy Presence Confirmed at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];
};


