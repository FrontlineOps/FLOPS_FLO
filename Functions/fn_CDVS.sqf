
if (!isServer) exitWith {};

	
Centerposition = [worldSize / 2, worldsize / 2, 0];

VS_FPS insert [0,round(diag_fps),false];
if (count VS_FPS > 30) then {VS_FPS resize 30};

// Smooth out FPS over time (5 second delay between changes to VSDistance)
// Also, make sure to average out any spikes or dips in server FPS
if ((diag_tickTime - VSCurrentTime) > VSTimeDelay) then {
	private _ServerFPS = VP_FPS call BIS_fnc_arithmeticMean;
	if (_ServerFPS < 30) then {VSDistance = 700} ; 
	if (_ServerFPS < 25) then {VSDistance = 650} ; 
	if (_ServerFPS < 20) then {VSDistance = 500} ; 
	if (_ServerFPS < 15) then {VSDistance = 450} ; 
	VSCurrentTime = diag_tickTime;
};



private _allStaticObjs0 = allMissionObjects "NonStrategic";
{ deleteVehicle _x } forEach (_allStaticObjs0 select {typeOf _x == "Sign_Pointer_Yellow_F"}) ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////Static Objects Virtualization///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


private _allStaticObjs = [] ;

private _allStaticObjs0 = allMissionObjects "NonStrategic";
_allStaticObjs append _allStaticObjs0 ;	
private _allStaticObjs1 = allMissionObjects "Static";
_allStaticObjs append _allStaticObjs1 ;	
private _allStaticObjs2 = allMissionObjects "Thing";
_allStaticObjs append _allStaticObjs2 ;	

_StaticObjs =  _allStaticObjs select {
		(typeOf _x != "Sign_Pointer_Cyan_F") && 
		(typeOf _x != "Land_Garbage_square3_F") && 
		(typeOf _x != "Land_Garbage_line_F") && 
		(typeOf _x != "Sign_Pointer_Yellow_F") && 
		(typeOf _x != "Sign_Sphere10cm_F") && 
		(typeOf _x != "Land_vn_controltower_01_f") && 
		(typeOf _x != "Sign_Pointer_Blue_F") && 
		(typeOf _x != "Land_InvisibleBarrier_F") && 
		(typeOf _x != "Land_HelipadEmpty_F") && 
		(typeOf _x != "O_Radar_System_02_F") && 
		(typeOf _x != "O_G_Mortar_01_F") && 
		(typeOf _x != "O_G_HMG_02_high_F") && 
		(typeOf _x != "Land_TripodScreen_01_large_black_F") && 
		(typeOf _x != "Land_vn_b_prop_mapstand_01") && 
		(typeOf _x != "MapBoard_altis_F") && 
		(typeOf _x != "Land_Laptop_device_F") && 
		(typeOf _x != "Land_Map_Malden_F") && 
		(typeOf _x != "Land_Document_01_F") && 
		(typeOf _x != "Land_File2_F") && 
		(typeOf _x != "Land_i_Barracks_V1_F") && 
		(typeOf _x != "Land_u_Barracks_V2_F") && 
		(typeOf _x != "Land_i_Barracks_V2_F") && 
		(typeOf _x != "Land_Barracks_01_grey_F") && 
		(typeOf _x != "Land_Barracks_01_dilapidated_F") && 
		(typeOf _x != "Land_Radar_F") && 
		(typeOf _x != "Land_TTowerBig_1_F") && 
		(typeOf _x != "Land_TTowerBig_2_F") && 
		(typeOf _x != "Land_TripodScreen_01_large_F") && 
		(typeOf _x != "Land_TripodScreen_01_large_sand_F") && 
		(typeOf _x != "Land_TripodScreen_01_dual_v2_sand_F") && 
		(typeOf _x != "Land_TripodScreen_01_dual_v2_F") && 
		(typeOf _x != "Box_FIA_Support_F") && 
		(typeOf _x != "Box_FIA_Ammo_F") && 
		(typeOf _x != "Land_PowerGenerator_F") && 
		(typeOf _x != "Land_Barracks_01_camo_F") && 
		(typeOf _x != "Land_vn_barracks_01_camo_f") && 
		(typeOf _x != "Land_Cargo_House_V1_F") && 
		(typeOf _x != "Land_Cargo_Tower_V1_F") && 
		(typeOf _x != "Land_Cargo_Tower_V3_F")  && 
		(typeOf _x != "Land_Cargo_Tower_V2_F") && 
		(typeOf _x != "Land_Cargo_House_V3_F") && 
		(typeOf _x != "Land_Cargo_HQ_V3_F") && 
		(typeOf _x != "Land_Cargo_HQ_V1_F") && 
		(typeOf _x != "B_Slingload_01_Cargo_F") && 
		(typeOf _x != "B_Slingload_01_Repair_F") && 
		({(side _x == west) && (alive _x ) } count (_x nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], 1600]) == 0)
	};

	private _BLUMs = allMapMarkers select { markerType _x == "b_installation"};
	{ _Handle = createVehicle ["Sign_Pointer_Yellow_F",(getMarkerPos _x),[],0,"NONE"]; } forEach _BLUMs ;		

	{
		private _ObjTyp = typeOf _x ; 
		private _ObjPos = getPosATL _x ;
		private _ObjDir = [vectorDir _x,vectorUp _x] ; 
		private _ObjsArray = [_ObjTyp,_ObjPos,_ObjDir];
 		private _mrkr = createMarkerLocal [str _x, getPos _x];   
		_mrkr setMarkerTypeLocal "o_maint" ;  
		if (count (nearestobjects [_ObjPos,["Sign_Pointer_Yellow_F"],200]) > 0) then {
			_mrkr setMarkerColorLocal "ColorBlue";
		}else{
			_mrkr setMarkerColorLocal "colorOPFOR";
		};
			
		_mrkr setMarkerAlphaLocal 0 ;  
		_mrkr setMarkerSizeLocal [0 , 0] ;  
		_mrkr setMarkerText str _ObjsArray ; 
	    deleteVehicle _x;
		sleep 0.1 ; 
	} forEach _StaticObjs ;
	
 private _ObjMarks = allMapMarkers select { 
		(markerType _x == "o_maint") && 
		({(side _x == west) && (alive _x) && (isPlayer _x)} count ((getMarkerPos _x) nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], 1600]) != 0)
	};
 
 {
	private _ObjData = parseSimpleArray (markerText _x) ; 
	private _ObjTyp = _ObjData select 0 ;
	private _ObjPos = _ObjData select 1 ; 
	private _ObjDir = _ObjData select 2 ; 
 
	private _NewObj = createVehicle [_ObjTyp, [0,0, (500 + random 2000)], [], 0, "CAN_COLLIDE"] ;
	_NewObj setVectorDirAndUp _ObjDir;
	_NewObj setPosATL _ObjPos;
	
	deleteMarker _x ;
		
 } forEach _ObjMarks;  
	  
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////Infantry Virtualization///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


///// Virtualize Enemy Units /////
private _enemyGroups = allGroups select {
		(typeOf (vehicle (leader _x)) != "B_Pilot_F") && 
		( isNull objectParent (leader _x) ) && 
		((side _x == independent) or (side _x == east)) && 
		({(side _x == west) && (alive _x) } count ((leader _x) nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], VSDistance]) == 0)
	};	

	{
		if (count (units _x) > 0) then { 

			private _pos = getPos (units _x select 0);
			private _GrpUntCnt = (count (units _x)) -1 ; 
			private _EnmUnitsArray = [] ;
				for "_i" from 0 to _GrpUntCnt do {
					private _Uclass = typeOf ((units _x) select _i);	
					_EnmUnitsArray append [_Uclass] ;	
					deleteVehicle ((units _x) select _i);		
				}; 


			private _mrkr = createMarkerLocal [str ( [(_pos#0 + (random 1)), (_pos#1 + (random 1))]), _pos] ;   
			_mrkr setMarkerTypeLocal "o_Ordnance" ;  
			if (side _x == east) then { _mrkr setMarkerColorLocal "colorOPFOR"} ;
			if (side _x == independent) then { _mrkr setMarkerColorLocal "colorIndependent"} ;
			if (side _x == civilian) then { _mrkr setMarkerColorLocal "colorCivilian"} ;
			_mrkr setMarkerAlphaLocal 0 ;  
			_mrkr setMarkerSizeLocal [0 , 0] ;  
			_mrkr setMarkerText str _EnmUnitsArray ; 
					
					sleep 0.1 ; 
					
			deleteGroup _x;

		} else {diag_log format["fn_CDVS: Came across empty group : %1",_x]; deleteGroup _x};
		
	 } foreach _enemyGroups ;


	
///// Virtualize CIV-Friendly Units /////
private _civGroups = allGroups select {
	(typeOf (vehicle (leader _x)) != "B_Pilot_F" ) && 
	(vehicle (leader _x) == (leader _x)) && 
	(side _x == civilian) && 
	({(side _x == west) && (alive _x) && (isPlayer _x)} count ((leader _x) nearEntities [["Man"], VSDistance]) == 0)
};

	{
		if (count (units _x) > 0) then { 

			private _pos = getPos (units _x select 0);
			private _GrpUntCnt = (count (units _x)) -1 ; 
			private _CivUnitsArray = [] ;
				for "_i" from 0 to _GrpUntCnt do {
					private _Uclass = typeOf ((units _x) select _i);	
					_CivUnitsArray append [_Uclass] ;		
					deleteVehicle ((units _x) select _i);		
				}; 
			_mrkr = createMarkerLocal [str ( [(_pos#0 + (random 1)), (_pos#1 + (random 1))]), _pos] ;   
			_mrkr setMarkerTypeLocal "o_Ordnance" ;  
			_mrkr setMarkerColorLocal "colorCivilian";
			_mrkr setMarkerAlphaLocal 0 ;  
			_mrkr setMarkerSizeLocal [0 , 0] ;  
			_mrkr setMarkerText str _CivUnitsArray ; 
					
					sleep 0.1 ; 
							
			deleteGroup _x;		

		} else {diag_log format["fn_CDVS: Came across empty group : %1",_x]; deleteGroup _x};
				
	 } foreach _civGroups ;
	
	

///// Un-Virtualize Enemy Units /////
 private _EnmGroupMarks = allMapMarkers select { 
		(markerType _x == "o_Ordnance") && 
		(markerColor _x != "colorCivilian") && 
		({(side _x == west) && (alive _x)} count ((getMarkerPos _x) nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], VSDistance]) != 0)
	};

	{
		private _EnmGRP = grpNull;
		private _array = parseSimpleArray (markerText _x);

		if (markerColor _x == "colorOPFOR") then { _EnmGRP = [(getMarkerPos _x), EAST, _array] call BIS_fnc_spawnGroup ; 
			_EnmGRP deleteGroupWhenEmpty true;


		} ;
		
		if (markerColor _x == "colorIndependent") then { _EnmGRP = [(getMarkerPos _x), independent, _array] call BIS_fnc_spawnGroup ; 
			_EnmGRP deleteGroupWhenEmpty true;
				[_EnmGRP] execVM "Scripts\Civ_Relations_Ind.sqf" ;	


		} ;

				sleep 0.3 ; 

		if !(isNull _EnmGRP) then {
			if (count (_array) > 1) then { 
				[_EnmGRP, (getPos ((units _EnmGRP) select 0)), (50 +(random 200))] call BIS_fnc_taskPatrol;	
			};
			
			if (count (_array) == 1) then { 
				_allBuildings = nearestObjects [(getMarkerPos _x), ["House", "Strategic" ], 20];  
				_allPositions = [];  
				_allBuildings apply {_allPositions append (_x buildingPos -1)}; 
				((units _EnmGRP) select 0) setPos (selectRandom _allPositions) ; 
			} ;
	
			for "_i" from 0 to (count (units _EnmGrp))-1 do {
				private _unit = (units _EnmGrp) select _i;
				_nvg = hmd _unit;
				_unit unassignItem _nvg;
				_unit removeItem _nvg;
				_unit addPrimaryWeaponItem "acc_flashlight";
				_unit assignItem "acc_flashlight";
				_unit enableGunLights "ForceOn";
			} ;
				
			[(getMarkerPos _x), 20] execVM "Scripts\INTLitems.sqf";
			deleteMarker _x ;	
				
				sleep 0.1 ; 
		};

	} foreach _EnmGroupMarks ;


///// Un-Virtualize Civ-Friendly Units /////
private _CivvGroupMarks = allMapMarkers select { 
		(markerType _x == "o_Ordnance") && 
		(markerColor _x == "colorCivilian") && 
		({((side _x == west) or (side _x == civilian)) && (alive _x) && (isPlayer _x)} count ((getMarkerPos _x) nearEntities [["Man"], VSDistance]) != 0)
	};

	{
		private _CivGRP = grpNull;
		private _array = parseSimpleArray (markerText _x);
		
		if (markerColor _x == "colorCivilian") then { _CivGRP = [(getMarkerPos _x), civilian, _array] call BIS_fnc_spawnGroup ; 
					_CivGRP deleteGroupWhenEmpty true;
		
				[_CivGRP] execVM "Scripts\Civ_Relations_Civ.sqf" ;	
		} ;

		if !(isNull _CivGRP) then {
				_Chance = selectRandom [0,1,2,3,4]; 
				
				if (_Chance > 1) then { 
				[_CivGRP, (getPos ((units _CivGRP) select 0)), (50 +(random 200))] call BIS_fnc_taskPatrol;	
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
		};
				
			[(getMarkerPos _x), 20] execVM "Scripts\INTLitems.sqf";
			deleteMarker _x ;	
				
				sleep 0.1 ; 
	} foreach _CivvGroupMarks;
				

				
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////Vehicles Virtualization///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
_ALLFACVEHs = [
"B_SAM_System_01_F",
"B_AAA_System_01_F",
"B_SAM_System_02_F",
"B_SAM_System_03_F",
"B_GMG_01_A_F",
"B_HMG_01_A_F",
"B_W_Static_Designator_01_F",
"B_UGV_02_Demining_F",
"B_UAV_02_lxWS",
"B_UAV_01_F",
"B_SDV_01_F",
"B_Boat_Transport_01_F",
"USAF_A10",
"USAF_F22",
"USAF_F22_Heavy",
"USAF_F35A_STEALTH",
"USAF_F35A",
"USAF_AC130U",
"USAF_C130J",
"USAF_C130J_Cargo",
"usaf_kc135",
"USAF_C17",
F_RADAR,
F_Bike_01,
F_ABT_01,
F_UAV_01,
F_UAV_02,
F_UAV_03,
F_UGV_01,
F_turret_01,
F_turret_02,
F_turret_03,
F_Car_01,
F_Car_02,
F_Car_03,
F_Car_04,
F_Car_05,
F_Car_06,
F_MRAP_01,
F_MRAP_02,
F_MRAP_03,
F_MRAP_04,
F_MRAP_05,
F_MRAP_06,
F_Truck_01,
F_Truck_02,
F_Truck_03,
F_Truck_04,
F_Truck_05,
F_Truck_06,
F_APC_01,
F_APC_02,
F_APC_03,
F_APC_04,
F_APC_05,
F_APC_06,
F_TNK_01,
F_TNK_02,
F_TNK_03,
F_TNK_04,
F_Art_00,
F_Art_01,
F_Art_02,
F_Heli_01,
F_Heli_02,
F_Heli_03,
F_Heli_04,
F_Heli_05,
F_Heli_06_G,
F_Heli_07_G,
F_Plane_01_CAS,
F_Plane_02_CAS,
F_Plane_03,
F_Plane_04,
F_Plane_05,
F_Plane_06
];

				
	{ _x hideObjectGlobal true; _x enableSimulationGlobal false; } foreach (vehicles select {!((typeOf _x) in _ALLFACVEHs) && !((typeOf _x) in GuerVehArray) && !((typeOf _x) in East_Ground_Vehicles_Heavy) && !((typeOf _x) in East_Ground_Vehicles_Light) && !((typeOf _x) in East_Ground_Transport) && (typeOf _x != "O_G_Mortar_01_F" && typeOf _x != "vn_o_nva_navy_static_v11m"  && typeOf _x != "vn_o_pl_static_zpu4" && typeOf _x != "O_G_HMG_02_high_F" && typeOf _x != "O_SAM_System_04_F" && typeOf _x != "O_Radar_System_02_F") && (((side (driver  _x) != west) && ((driver  _x) checkAIFeature "LIGHTS" == true)) or ({alive _x} count crew _x == 0)) && !(_x isKindOf "Air")  && ({(side _x == west) && (alive _x == true) && (isPlayer _x)} count (_x nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], VSDistance]) == 0)}) ;
	
	{_x hideObjectGlobal false; _x enableSimulationGlobal true; } foreach (vehicles select {!((typeOf _x) in _ALLFACVEHs) && !((typeOf _x) in GuerVehArray) && !((typeOf _x) in East_Ground_Vehicles_Heavy) && !((typeOf _x) in East_Ground_Vehicles_Light) && !((typeOf _x) in East_Ground_Transport) && (typeOf _x != "O_G_Mortar_01_F" && typeOf _x != "vn_o_nva_navy_static_v11m"  && typeOf _x != "vn_o_pl_static_zpu4" && typeOf _x != "O_G_HMG_02_high_F" && typeOf _x != "O_SAM_System_04_F" && typeOf _x != "O_Radar_System_02_F") && (((side (driver  _x) != west) && ((driver  _x) checkAIFeature "LIGHTS" == true)) or ({alive _x} count crew _x == 0)) && !(_x isKindOf "Air")  && ({(side _x == west) && (alive _x == true) && (isPlayer _x)} count (_x nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], VSDistance]) != 0)}) ;
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////Triggers Virtualization///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {(triggerInterval _x != 2 ) && ({(side _x == west) && (alive _x)} count (_x nearEntities [["Man","Car","Tank", "Ship", "LandVehicle", "Air"], 3000]) == 0)};
 {_x hideObjectGlobal true; _x enableSimulationGlobal false; } foreach _triggers ;



_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {(triggerInterval _x != 2 ) &&  ({(side _x == west) && (alive _x )} count (_x nearEntities [["Man","Car","Tank", "Ship", "LandVehicle", "Air"], 3000]) != 0)};
 {_x hideObjectGlobal false; _x enableSimulationGlobal true; } foreach _triggers ;
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

