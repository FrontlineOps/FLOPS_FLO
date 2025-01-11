if (!isServer) exitWith {};

	
Centerposition = [worldSize / 2, worldsize / 2, 0];

VS_FPS insert [0,[round(diag_fps)],false];
if (count VS_FPS > 30) then {VS_FPS resize 30};

// Smooth out FPS over time (5 second delay between changes to VSDistance)
// Also, make sure to average out any spikes or dips in server FPS
if ((diag_tickTime - VSCurrentTime) > VSTimeDelay) then {
	private _ServerFPS = VS_FPS call BIS_fnc_arithmeticMean;
	if (_ServerFPS < 30) then {VSDistance = 2000}; 
	if (_ServerFPS < 25) then {VSDistance = 1750}; 
	if (_ServerFPS < 20) then {VSDistance = 1500}; 
	if (_ServerFPS < 15) then {VSDistance = 1000}; 
	VSCurrentTime = diag_tickTime;
};

/////////////////////////////////////////////Static Object Virtualization///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private _allStaticObjs = (allMissionObjects "NonStrategic") + (allMissionObjects "Static") + (allMissionObjects "Thing");

private _excludedTypes = [
    "Sign_Pointer_Cyan_F", "Land_Garbage_square3_F", "Land_Garbage_line_F",
    "Sign_Pointer_Yellow_F", "Sign_Sphere10cm_F", "Land_vn_controltower_01_f",
    "Sign_Pointer_Blue_F", "Land_InvisibleBarrier_F", "Land_HelipadEmpty_F",
    "O_Radar_System_02_F", "O_G_Mortar_01_F", "O_G_HMG_02_high_F",
    "Land_TripodScreen_01_large_black_F", "Land_vn_b_prop_mapstand_01",
    "MapBoard_altis_F", "Land_Laptop_device_F", "Land_Map_Malden_F",
    "Land_Document_01_F", "Land_File2_F", "Land_i_Barracks_V1_F",
    "Land_u_Barracks_V2_F", "Land_i_Barracks_V2_F", "Land_Barracks_01_grey_F",
    "Land_Barracks_01_dilapidated_F", "Land_Radar_F", "Land_TTowerBig_1_F",
    "Land_TTowerBig_2_F", "Land_TripodScreen_01_large_F",
    "Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_dual_v2_sand_F",
    "Land_TripodScreen_01_dual_v2_F", "Box_FIA_Support_F", "Box_FIA_Ammo_F",
    "Land_PowerGenerator_F", "Land_Barracks_01_camo_F", "Land_vn_barracks_01_camo_f",
    "Land_Cargo_House_V1_F", "Land_Cargo_Tower_V1_F", "Land_Cargo_Tower_V3_F",
    "Land_Cargo_Tower_V2_F", "Land_Cargo_House_V3_F", "Land_Cargo_HQ_V3_F",
    "Land_Cargo_HQ_V1_F", "B_Slingload_01_Cargo_F", "B_Slingload_01_Repair_F"
];

private _allStaticObjs = _allStaticObjs select {
    private _objClass = typeOf _x;
    count (_excludedTypes select { _objClass isKindOf _x }) == 0;
};

private _StaticObjs = _allStaticObjs select {
    {(side _x == west) && (alive _x)} count (_x nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], 1600]) == 0;
};

private _BLUMs = allMapMarkers select { markerType _x == "b_installation" };
{ createVehicle ["Sign_Pointer_Yellow_F", (getMarkerPos _x), [], 0, "NONE"]; } forEach _BLUMs;

{
    private _ObjTyp = typeOf _x;
    private _ObjPos = getPosATL _x;
    private _ObjDir = [vectorDir _x, vectorUp _x];
    private _ObjsArray = [_ObjTyp, _ObjPos, _ObjDir];
    private _mrkr = createMarkerLocal [str _x, getPos _x];
    _mrkr setMarkerTypeLocal "o_maint";
    private _markerColor = if (count (nearestObjects [_ObjPos, ["Sign_Pointer_Yellow_F"], 200]) > 0) then {"ColorBlue"} else {"colorOPFOR"};
    _mrkr setMarkerColorLocal _markerColor;
    _mrkr setMarkerAlphaLocal 0;
    _mrkr setMarkerSizeLocal [0, 0];
    _mrkr setMarkerText str _ObjsArray;

    sleep 0.1;
} forEach _StaticObjs;
{ deleteVehicle _x; } forEach _StaticObjs;

private _ObjMarks = allMapMarkers select {
    (markerType _x == "o_maint") &&
    ({(side _x == west) && (alive _x) && (isPlayer _x)} count ((getMarkerPos _x) nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], 1600]) != 0);
};

{
    private _ObjData = parseSimpleArray (markerText _x);
    private _ObjTyp = _ObjData select 0;
    private _ObjPos = _ObjData select 1;
    private _ObjDir = _ObjData select 2;

    private _NewObj = createVehicle [_ObjTyp, [0, 0, (500 + random 2000)], [], 0, "CAN_COLLIDE"];
    _NewObj setVectorDirAndUp _ObjDir;
    _NewObj setPosATL _ObjPos;

    deleteMarker _x;
} forEach _ObjMarks;

/////////////////////////////////////////////Infantry Virtualization///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
} forEach _enemyGroups;


///// Virtualize CIV-Friendly Units /////
private _civGroups = allGroups select {
    private _leader = leader _x;
    private _vehicle = vehicle _leader;
    (typeOf _vehicle != "B_Pilot_F") &&
    (_vehicle == _leader) &&
    (side _x == civilian) &&
    ({(side _x == west) && (alive _x) && (isPlayer _x)} count (_leader nearEntities [["Man"], VSDistance]) == 0);
};

{
    private _units = units _x;
    private _unitCount = count _units;
    if (_unitCount > 0) then {
        private _pos = getPos (_units select 0);
        private _civUnitsArray = _units apply {typeOf _x};
        {
            deleteVehicle _x;
        } forEach _units;

        private _mrkr = createMarkerLocal [str [(_pos select 0) + (random 1), (_pos select 1) + (random 1)], _pos];
        _mrkr setMarkerTypeLocal "o_Ordnance";
        _mrkr setMarkerColorLocal "colorCivilian";
        _mrkr setMarkerAlphaLocal 0;
        _mrkr setMarkerSizeLocal [0, 0];
        _mrkr setMarkerText str _civUnitsArray;

        sleep 0.1;
        deleteGroup _x;
    } else {
        diag_log format ["fn_CDVS: Came across empty group : %1", _x];
        deleteGroup _x;
    };
} forEach _civGroups;


///// Un-Virtualize Enemy Units /////
private _EnmGroupMarks = allMapMarkers select {
    (markerType _x == "o_Ordnance") &&
    (markerColor _x != "colorCivilian") &&
    ({(side _x == west) && (alive _x)} count ((getMarkerPos _x) nearEntities [["Man","Car","Tank", "Ship", "LandVehicle"], VSDistance]) != 0);
};

{
    private _EnmGRP = grpNull;
    private _array = parseSimpleArray (markerText _x);
    private _spawnSide = switch (markerColor _x) do {
        case "colorOPFOR": {EAST};
        case "colorIndependent": {independent};
        default {grpNull};
    };

    if (_spawnSide != grpNull) then {
        _EnmGRP = [(getMarkerPos _x), _spawnSide, _array] call BIS_fnc_spawnGroup;
        _EnmGRP deleteGroupWhenEmpty true;

        if (_spawnSide == independent) then {
            [_EnmGRP] execVM "Scripts\Civ_Relations_Ind.sqf";
        };

        sleep 0.3;

        if !(isNull _EnmGRP) then {
            if (count (_array) > 1) then {
                [_EnmGRP, (getPos ((units _EnmGRP) select 0)), (50 +(random 200))] call BIS_fnc_taskPatrol;
            } else {
                _allBuildings = nearestObjects [(getMarkerPos _x), ["House", "Strategic"], 20];
                _allPositions = [];
                _allBuildings apply {_allPositions append (_x buildingPos -1)};
                ((units _EnmGRP) select 0) setPos (selectRandom _allPositions);
            };

            [(getMarkerPos _x), 20] execVM "Scripts\INTLitems.sqf";
            deleteMarker _x;

            sleep 0.1;
        };
    };
} forEach _EnmGroupMarks;


///// Un-Virtualize Civ-Friendly Units /////
private _CivvGroupMarks = allMapMarkers select {
	(markerType _x == "o_Ordnance") &&
	(markerColor _x == "colorCivilian") &&
	({((side _x == west) or (side _x == civilian)) && (alive _x) && (isPlayer _x)} count ((getMarkerPos _x) nearEntities [["Man"], VSDistance]) != 0);
};

{
	private _CivGRP = grpNull;
	private _array = parseSimpleArray (markerText _x);

	_CivGRP = [(getMarkerPos _x), civilian, _array] call BIS_fnc_spawnGroup;
	_CivGRP deleteGroupWhenEmpty true;
	[_CivGRP] execVM "Scripts\Civ_Relations_Civ.sqf";

	if !(isNull _CivGRP) then {
		private _chance = selectRandom [0,1,2,3,4];

		if (_chance > 1) then {
			[_CivGRP, (getPos ((units _CivGRP) select 0)), (50 +(random 200))] call BIS_fnc_taskPatrol;
		} else {
			_allBuildings = nearestObjects [(getMarkerPos _x), ["House", "Strategic"], 20];
			_allPositions = [];
			_allBuildings apply {_allPositions append (_x buildingPos -1)};
			((units _CivGRP) select 0) setPos (selectRandom _allPositions);
		};

		if (_chance < 3) then {
			((units _CivGRP) select 0) setUnitTrait ["engineer", true];
		};
	};

	[(getMarkerPos _x), 20] execVM "Scripts\INTLitems.sqf";
	deleteMarker _x;

	sleep 0.1;
} forEach _CivvGroupMarks;

/////////////////////////////////////////////Triggers Virtualization/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_alltriggers = allMissionObjects 'EmptyDetector';
{
    private _isActive = ({(side _x == west) && (alive _x)} count (_x nearEntities [["Man","Car","Tank", "Ship", "LandVehicle", "Air"], 3000]) != 0);
    _x hideObjectGlobal !_isActive;
    _x enableSimulationGlobal _isActive;
} forEach (_alltriggers select {triggerInterval _x != 2});
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
