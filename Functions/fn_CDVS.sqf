if (!isServer) exitWith {};

	
Centerposition = [worldSize / 2, worldsize / 2, 0];

VS_FPS insert [0,[round(diag_fps)],false];
if (count VS_FPS > 30) then {VS_FPS resize 30};

// Smooth out FPS over time (5 second delay between changes to VSDistance)
// Also, make sure to average out any spikes or dips in server FPS
if ((diag_tickTime - VSCurrentTime) > VSTimeDelay) then {
	private _ServerFPS = VS_FPS call BIS_fnc_arithmeticMean;
	if (_ServerFPS < 30) then {VSDistance = 2000} ; 
	if (_ServerFPS < 25) then {VSDistance = 1750} ; 
	if (_ServerFPS < 20) then {VSDistance = 1500} ; 
	if (_ServerFPS < 15) then {VSDistance = 1000} ; 
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
	    
		sleep 0.1 ; 
	} forEach _StaticObjs ;
	{deleteVehicle _x;} forEach _StaticObjs ;
	
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
    private _leader = leader _x;
    private _vehicle = vehicle _leader;
    (typeOf _vehicle != "B_Pilot_F") &&
    (isNull objectParent _leader) &&
    ((side _x == independent) || (side _x == east)) &&
    ({(side _x == west) && (alive _x)} count (_leader nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], VSDistance]) == 0);
};

{
    private _units = units _x;
    private _unitCount = count _units;
    if (_unitCount > 0) then {
        private _pos = getPos (_units select 0);
        private _unitTypes = _units apply {typeOf _x};
        {
            deleteVehicle _x;
        } forEach _units;

        private _mrkr = createMarkerLocal [str [(_pos select 0) + (random 1), (_pos select 1) + (random 1)], _pos];
        _mrkr setMarkerTypeLocal "o_Ordnance";
        private _markerColor = switch (side _x) do {
            case east: {"colorOPFOR"};
            case independent: {"colorIndependent"};
            default {"colorCivilian"};
        };
        _mrkr setMarkerColorLocal _markerColor;
        _mrkr setMarkerAlphaLocal 0;
        _mrkr setMarkerSizeLocal [0, 0];
        _mrkr setMarkerText str _unitTypes;

        sleep 0.1;
        deleteGroup _x;
    } else {
        diag_log format ["fn_CDVS: Came across empty group : %1", _x];
        deleteGroup _x;
    };
} forEach _enemyGroups ;


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
				}; 
				while {count (units _x) > 0} do {deletevehicle (units _x select 0);};

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
	
			// for "_i" from 0 to (count (units _EnmGrp))-1 do {
			// 	private _unit = (units _EnmGrp) select _i;
			// 	_nvg = hmd _unit;
			// 	_unit unassignItem _nvg;
			// 	_unit removeItem _nvg;
			// 	_unit addPrimaryWeaponItem "acc_flashlight";
			// 	_unit assignItem "acc_flashlight";
			// 	_unit enableGunLights "ForceOn";
			// } ;
				
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

/////////////////////////////////////////////Triggers Virtualization/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {(triggerInterval _x != 2 ) && ({(side _x == west) && (alive _x)} count (_x nearEntities [["Man","Car","Tank", "Ship", "LandVehicle", "Air"], 3000]) == 0)};
 {_x hideObjectGlobal true; _x enableSimulationGlobal false; } foreach _triggers ;



_alltriggers = allMissionObjects 'EmptyDetector';
_triggers = _alltriggers select {(triggerInterval _x != 2 ) &&  ({(side _x == west) && (alive _x )} count (_x nearEntities [["Man","Car","Tank", "Ship", "LandVehicle", "Air"], 3000]) != 0)};
 {_x hideObjectGlobal false; _x enableSimulationGlobal true; } foreach _triggers ;
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
