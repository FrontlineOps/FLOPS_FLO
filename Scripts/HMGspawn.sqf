

_thisCntrPos = getPos (_this select 0);


_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_AGGRSCORE = parseNumber (markerText _mrkr) ;  

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_nearHQs = nearestObjects [ _thisCntrPos, [ "Land_Cargo_HQ_V1_F", "Land_Cargo_HQ_V2_F", "Land_Cargo_HQ_V3_F"], 200] ;

if (count _nearHQs > 0) then {
	{	
			_Chance = selectRandom [5, 10, 15] ; 
					if (_Chance > 5) then {
				_BPos = selectRandom [5, 7] ; 
				    private _actualBpodPosition = (_x buildingPos _BPos) vectorAdd [0,0,1];
					sleep 5;
					_V = createVehicle ["O_G_HMG_02_high_F", _actualBpodPosition, [], 0, "NONE"]; 
					_V setVectorUp [0,0,1];
					_Group = createVehicleCrew _V; 
					{_x setUnitLoadout (selectRandom East_Units)} forEach units _Group;
					};
					
		if (_AGGRSCORE > 10) then {					
			_Chance = selectRandom [5, 10, 15] ; 
					if (_Chance > 5) then {
				_BPos = selectRandom [6, 6] ; 
					private _actualBpodPosition = (_x buildingPos _BPos) vectorAdd [0,0,1];
					sleep 5;
					_V = createVehicle ["O_G_HMG_02_high_F", _actualBpodPosition, [], 0, "NONE"]; 
					_V setVectorUp [0,0,1];
					_Group = createVehicleCrew _V; 
					{_x setUnitLoadout (selectRandom East_Units)} forEach units _Group;
					};
		};	
	} forEach _nearHQs ;  		
};


_nearTowers = nearestObjects [ _thisCntrPos, [ "Land_Cargo_Tower_V1_F", "Land_Cargo_Tower_V2_F", "Land_Cargo_Tower_V3_F"], 200] ;

if (count _nearTowers > 0) then {
	{	
			_Chance = selectRandom [5, 10, 15] ; 
					if (_Chance > 5) then {
				_BPos = selectRandom [10, 11, 12, 13, 14, 15, 16, 17] ; 
					private _actualBpodPosition = (_x buildingPos _BPos) vectorAdd [0,0,1];
					sleep 5;
					_V = createVehicle ["O_G_HMG_02_high_F", _actualBpodPosition, [], 0, "NONE"]; 
					_V setVectorUp [0,0,1];
					_Group = createVehicleCrew _V; 
					{_x setUnitLoadout (selectRandom East_Units)} forEach units _Group;
					};
					
		if (_AGGRSCORE > 10) then {					
			_Chance = selectRandom [5, 10, 15] ; 
					if (_Chance > 5) then {
				_BPos = selectRandom [10, 11, 12, 13, 14, 15, 16, 17] ; 
					private _actualBpodPosition = (_x buildingPos _BPos) vectorAdd [0,0,1];
					sleep 5;
					_V = createVehicle ["O_G_HMG_02_high_F", _actualBpodPosition, [], 0, "NONE"]; 
					_V setVectorUp [0,0,1];
					_Group = createVehicleCrew _V; 
					{_x setUnitLoadout (selectRandom East_Units)} forEach units _Group;
					};
		};	
	} forEach _nearTowers ;  		
};
		
					
_nearTrenches = nearestObjects [ _thisCntrPos, [ "Land_vn_controltower_01_f"], 200] ;

if (count _nearTrenches > 0) then {
	{	
			_Chance = selectRandom [5, 10, 15] ; 
					if (_Chance > 5) then {
				_BPos = selectRandom [17, 15] ; 
					private _actualBpodPosition = (_x buildingPos _BPos) vectorAdd [0,0,1];
					sleep 5;
					_V = createVehicle ["O_G_HMG_02_high_F", _actualBpodPosition, [], 0, "NONE"]; 
					_V setVectorUp [0,0,1];
					_Group = createVehicleCrew _V; 
					{_x setUnitLoadout (selectRandom East_Units)} forEach units _Group;
					};

	} forEach _nearTrenches ;  		
};
										
					
					
					
					