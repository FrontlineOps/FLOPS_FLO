	{
		_U0 = typeOf ((units _x) select 0);
		_U1 = typeOf ((units _x) select 1);
		_U2 = typeOf ((units _x) select 2);
		_U3 = typeOf ((units _x) select 3);
		_U4 = typeOf ((units _x) select 4);
		_U5 = typeOf ((units _x) select 5);
		_U6 = typeOf ((units _x) select 6);
		_U7 = typeOf ((units _x) select 7);
		_U8 = typeOf ((units _x) select 8);
		_U9 = typeOf ((units _x) select 9);
		_U10 = typeOf ((units _x) select 10);
		_U11 = typeOf ((units _x) select 11);
		_U12 = typeOf ((units _x) select 12);	
		_EnmUnitsArray = [_U0,_U1,_U2,_U3,_U4,_U5,_U6,_U7,_U8,_U9,_U10,_U11,_U12];
		_mrkr = createMarkerLocal [str(units _x select 0), getPos (units _x select 0)];   
		_mrkr setMarkerTypeLocal "o_Ordnance" ;  
		if (side _x == east) then { _mrkr setMarkerColorLocal "colorOPFOR"} ;
		if (side _x == independent) then { _mrkr setMarkerColorLocal "colorIndependent"} ;
		if (side _x == civilian) then { _mrkr setMarkerColorLocal "colorCivilian"} ;
		_mrkr setMarkerAlphaLocal 0 ;  
		_mrkr setMarkerSizeLocal [0 , 0] ;  
		_mrkr setMarkerText str _EnmUnitsArray ; 
		{deleteVehicle _x} forEach Units _x ;
	 } foreach (allGroups select {(typeOf (vehicle (leader _x)) != "B_Pilot_F") && (typeOf (vehicle (leader _x)) != "O_SAM_System_04_F") && (typeOf (vehicle (leader _x)) != "O_Radar_System_02_F") && (vehicle (leader _x) == (leader _x)) && ((side _x == independent) or (side _x == east)) && ({(side _x == west) && (alive _x) } count ((leader _x) nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], 650]) == 0)}) ;


	
	{
		_U0 = typeOf ((units _x) select 0);
		_U1 = typeOf ((units _x) select 1);
		_U2 = typeOf ((units _x) select 2);
		_U3 = typeOf ((units _x) select 3);
		_U4 = typeOf ((units _x) select 4);
		_U5 = typeOf ((units _x) select 5);
		_U6 = typeOf ((units _x) select 6);
		_EnmUnitsArray = [_U0,_U1,_U2,_U3,_U4,_U5,_U6];
		_mrkr = createMarkerLocal [str(units _x select 0), getPos (units _x select 0)];   
		_mrkr setMarkerTypeLocal "o_Ordnance" ;  
		_mrkr setMarkerColorLocal "colorCivilian";
		_mrkr setMarkerAlphaLocal 0 ;  
		_mrkr setMarkerSizeLocal [0 , 0] ;  
		_mrkr setMarkerText str _EnmUnitsArray ; 
		{deleteVehicle _x} forEach Units _x ;
	 } foreach (allGroups select {(typeOf (vehicle (leader _x)) != "B_Pilot_F" ) && (vehicle (leader _x) == (leader _x)) && (side _x == civilian) && ({(side _x == west) && (alive _x) && (isPlayer _x)} count ((leader _x) nearEntities [["Man"], 450]) == 0)}) ;
	
	
 private "_EnmGRP";
 _EnmGroupMarks = allMapMarkers select { markerType _x == "o_Ordnance" && markerColor _x != "colorCivilian"};
	{
		
		if (markerColor _x == "colorOPFOR") then { _EnmGRP = [(getMarkerPos _x), EAST, parseSimpleArray (markerText _x)] call BIS_fnc_spawnGroup ; } ;

		if (markerColor _x == "colorIndependent") then { _EnmGRP = [(getMarkerPos _x), independent, parseSimpleArray (markerText _x)] call BIS_fnc_spawnGroup ; 

		} ;

				if (count (parseSimpleArray (markerText _x)) != 1) then { 
				[_EnmGRP, (getMarkerPos _x), (50 +(random 200))] call BIS_fnc_taskPatrol;	
				};
				
				if (count (parseSimpleArray (markerText _x)) == 1) then { 
				_allBuildings = nearestObjects [(getMarkerPos _x), ["House", "Strategic" ], 20];  
				_allPositions = [];  
				_allBuildings apply {_allPositions append (_x buildingPos -1)}; 
				((units _EnmGRP) select 0) setPos (selectRandom _allPositions) ; 
				} ;
		
					// {
					// _nvg = hmd _x;
					//  _x unassignItem _nvg;
					//  _x removeItem _nvg;
					// 	  _x addPrimaryWeaponItem "acc_flashlight";
					// 	  _x assignItem "acc_flashlight";
					// 	  _x enableGunLights "ForceOn";
					//   } foreach (allUnits select {side _x == east or side _x == independent}); 
		
		[(getMarkerPos _x), 20] execVM "Scripts\INTLitems.sqf";
		
		deleteMarker _x ;	
	} foreach (_EnmGroupMarks select { {(side _x == west) && (alive _x)} count ((getMarkerPos _x) nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], 650]) != 0}) ;

private "_CivGRP";
 _EnmGroupMarks = allMapMarkers select { markerType _x == "o_Ordnance" && markerColor _x == "colorCivilian" };
	{
		
		if (markerColor _x == "colorCivilian") then { _CivGRP = [(getMarkerPos _x), civilian, parseSimpleArray (markerText _x)] call BIS_fnc_spawnGroup ; 

		} ;

				_Chance = selectRandom [0,1,2,3,4]; 
				
				if (_Chance > 1) then { 
				[_CivGRP, (getMarkerPos _x), (50 +(random 200))] call BIS_fnc_taskPatrol;	
				};
				
				if (_Chance < 2) then { 
				_allBuildings = nearestObjects [(getMarkerPos _x), ["House", "Strategic" ], 20];  
				_allPositions = [];  
				_allBuildings apply {_allPositions append (_x buildingPos -1)}; 
				((units _CivGRP) select 0) setPos (selectRandom _allPositions) ;
							
				} ;
		
				if (_Chance < 3) then { 
				((units _CivGRP) select 0) setUnitTrait ["engineer", true]; 	
				};
				
					// {
					// _nvg = hmd _x;
					//  _x unassignItem _nvg;
					//  _x removeItem _nvg;
					// 	  _x addPrimaryWeaponItem "acc_flashlight";
					// 	  _x assignItem "acc_flashlight";
					// 	  _x enableGunLights "ForceOn";
					//   } foreach (allUnits select {side _x == east or side _x == independent}); 
		
		[(getMarkerPos _x), 20] execVM "Scripts\INTLitems.sqf";

			deleteMarker _x ;	
	} foreach (_EnmGroupMarks select { {((side _x == west) or (side _x == civilian)) && (alive _x) && (isPlayer _x)} count ((getMarkerPos _x) nearEntities [["Man"], 450]) != 0}) ;
				
				execVM "Scripts\Civ_Relations.sqf" ;	
				
	{ _x hideObjectGlobal true; _x enableSimulationGlobal false; } foreach (vehicles select {!((typeOf _x) in East_Ground_Vehicles_Heavy) && !((typeOf _x) in East_Ground_Vehicles_Light) && !((typeOf _x) in East_Ground_Transport) && (typeOf _x != "O_G_Mortar_01_F" && typeOf _x != "O_G_HMG_02_high_F" && typeOf _x != "O_SAM_System_04_F" && typeOf _x != "O_Radar_System_02_F") && (((side (driver  _x) != west) && ((driver  _x) checkAIFeature "LIGHTS" == true)) or ({alive _x} count crew _x == 0)) && !(_x isKindOf "Air")  && ({(side _x == west) && (alive _x == true) && (isPlayer _x)} count (_x nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], 1000]) == 0)}) ;
	
	{_x hideObjectGlobal false; _x enableSimulationGlobal true; } foreach (vehicles select {!((typeOf _x) in East_Ground_Vehicles_Heavy) && !((typeOf _x) in East_Ground_Vehicles_Light) && !((typeOf _x) in East_Ground_Transport) && (typeOf _x != "O_G_Mortar_01_F" && typeOf _x != "O_G_HMG_02_high_F" && typeOf _x != "O_SAM_System_04_F" && typeOf _x != "O_Radar_System_02_F") && (((side (driver  _x) != west) && ((driver  _x) checkAIFeature "LIGHTS" == true)) or ({alive _x} count crew _x == 0)) && !(_x isKindOf "Air")  && ({(side _x == west) && (alive _x == true) && (isPlayer _x)} count (_x nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], 1000]) != 0)}) ;

_allStaticObjs = [] ;

_allStaticObjs0 = allMissionObjects "NonStrategic";
_allStaticObjs append _allStaticObjs0 ;	
_allStaticObjs1 = allMissionObjects "Static";
_allStaticObjs append _allStaticObjs1 ;	
_allStaticObjs2 = allMissionObjects "Thing";
_allStaticObjs append _allStaticObjs2 ;	

_StaticObjs =  _allStaticObjs select {(typeOf _x != "Sign_Pointer_Blue_F") && (typeOf _x != "Land_InvisibleBarrier_F") && (typeOf _x != "Land_HelipadEmpty_F") && (typeOf _x != "O_Radar_System_02_F") && (typeOf _x != "O_G_Mortar_01_F") && (typeOf _x != "O_G_HMG_02_high_F") && (typeOf _x != "Land_TripodScreen_01_large_black_F") && (typeOf _x != "MapBoard_altis_F") && (typeOf _x != "Land_Laptop_device_F") && (typeOf _x != "Land_Map_Malden_F") && (typeOf _x != "Land_Document_01_F") && (typeOf _x != "Land_File2_F") && (typeOf _x != "Land_i_Barracks_V1_F") && (typeOf _x != "Land_u_Barracks_V2_F") && (typeOf _x != "Land_i_Barracks_V2_F") && (typeOf _x != "Land_Barracks_01_grey_F") && (typeOf _x != "Land_Barracks_01_dilapidated_F") && (typeOf _x != "Land_Radar_F") && (typeOf _x != "Land_TTowerBig_1_F") && (typeOf _x != "Land_TTowerBig_2_F") && (typeOf _x != "Land_TripodScreen_01_large_F") && (typeOf _x != "Land_TripodScreen_01_large_sand_F") && (typeOf _x != "Land_TripodScreen_01_dual_v2_sand_F") && (typeOf _x != "Land_TripodScreen_01_dual_v2_F") && (typeOf _x != "Box_FIA_Support_F") && (typeOf _x != "Box_FIA_Ammo_F") && (typeOf _x != "Land_PowerGenerator_F") && (typeOf _x != "Land_Cargo_House_V1_F") && (typeOf _x != "Land_Cargo_House_V3_F") && (typeOf _x != "Land_Cargo_HQ_V3_F") && (typeOf _x != "Land_Cargo_HQ_V1_F") && (typeOf _x != "B_Slingload_01_Cargo_F") && (typeOf _x != "B_Slingload_01_Repair_F") && ({((side _x == west) && (alive _x ) && (isPlayer _x)) or (isPlayer _x)} count (_x nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], 1000]) == 0)};

	{
		_ObjTyp = typeOf _x ; 
		_ObjPos = getPosATL _x ;
		_ObjDir = [vectorDir _x,vectorUp _x] ; 
		_ObjsArray = [_ObjTyp,_ObjPos,_ObjDir];
 		_mrkr = createMarkerLocal [str _x, getPos _x];   
		_mrkr setMarkerTypeLocal "o_maint" ;  
		_mrkr setMarkerColorLocal "colorOPFOR";
		_mrkr setMarkerAlphaLocal 0 ;  
		_mrkr setMarkerSizeLocal [0 , 0] ;  
		_mrkr setMarkerText str _ObjsArray ; 
	    deleteVehicle _x;
	} forEach _StaticObjs ;
	
 _ObjMarks = allMapMarkers select { markerType _x == "o_maint" && markerColor _x == "colorOPFOR"};
 
 {
 _ObjData = parseSimpleArray (markerText _x) ; 
 _ObjTyp = _ObjData select 0 ;
 _ObjPos = _ObjData select 1 ; 
 _ObjDir = _ObjData select 2 ; 
 
		_NewObj = createVehicle [_ObjTyp, [0,0, (500 + random 2000)], [], 0, "CAN_COLLIDE"] ;
		_NewObj setVectorDirAndUp _ObjDir;
		_NewObj setPosATL _ObjPos;
		
		deleteMarker _x ;
		
 } forEach (_ObjMarks select { {(side _x == west) && (alive _x) && (isPlayer _x)} count ((getMarkerPos _x) nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], 1000]) != 0});  
	  


_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {(triggerInterval _x != 2 ) && ({(side _x == west) && (alive _x)} count (_x nearEntities [["Man","Car","Tank", "Ship", "LandVehicle", "Air"], 3000]) == 0)};
 {_x hideObjectGlobal true; _x enableSimulationGlobal false; } foreach _triggers ;



_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {(triggerInterval _x != 2 ) &&  ({(side _x == west) && (alive _x )} count (_x nearEntities [["Man","Car","Tank", "Ship", "LandVehicle", "Air"], 3000]) != 0)};
 {_x hideObjectGlobal false; _x enableSimulationGlobal true; } foreach _triggers ;
