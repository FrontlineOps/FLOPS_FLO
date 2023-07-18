

_thisTownTrigger = _this select 0;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_AGGRSCORE = parseNumber (markerText _mrkr) ; 


_mrkrs = allMapMarkers select {markerColor _x == "Color4_FD_F"};
_mrkr = _mrkrs select 0;
_REPSCORE = parseNumber (markerText _mrkr) ;  

_Chance = selectRandom [0,1,2,3]; 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if ( INFDIS == 0 ) then {

PRL = [getPos _thisTownTrigger, East, [selectRandom CivMenArray, selectRandom CivMenArray]] call BIS_fnc_spawnGroup;
[PRL, getPos _thisTownTrigger, 50] call BIS_fnc_taskPatrol;
{_uniform = uniform _x;
_x setUnitLoadout (selectRandom GuerMenArray);
removeHeadgear _x; 
_x forceAddUniform _uniform;
} foreach Units PRL; 


if ((dayTime < 21) && (dayTime > 6)) then {


PRL = [getPos _thisTownTrigger, East, [selectRandom CivMenArray, selectRandom CivMenArray]] call BIS_fnc_spawnGroup;
[PRL, getPos _thisTownTrigger, 100] call BIS_fnc_taskPatrol;
{_uniform = uniform _x;
_x setUnitLoadout (selectRandom GuerMenArray);
removeHeadgear _x; 
_x forceAddUniform _uniform;
} foreach Units PRL; 


}; };

//////////Veicle////////////////////////////////////////////////////////////////////////

_nearRoad = selectRandom (((getPos _thisTownTrigger) nearRoads 200) - ((getPos _thisTownTrigger) nearRoads 100)) ; 
_V = createVehicle [ selectRandom ["Land_Barricade_01_10m_F", "Land_Barricade_01_4m_F"], (_nearRoad getRelPos [0, 0]), [], 2, "NONE"]; 
		_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
		_dir = _nearRoad getDir _nextRoad;
_V setDir _dir ;		
_V setVectorUp [0,0,1];

if (_REPSCORE < 7) then {
_nearRoad = selectRandom (((getPos _thisTownTrigger) nearRoads 200) - ((getPos _thisTownTrigger) nearRoads 100)) ; 
_V = createVehicle [ selectRandom ["Land_Barricade_01_10m_F", "Land_Barricade_01_4m_F"], (_nearRoad getRelPos [0, 0]), [], 2, "NONE"]; 
		_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
		_dir = _nearRoad getDir _nextRoad;
_V setDir _dir ;		
_V setVectorUp [0,0,1];
};

if (_REPSCORE < 5) then {
_nearRoad = selectRandom (((getPos _thisTownTrigger) nearRoads 200) - ((getPos _thisTownTrigger) nearRoads 100)) ; 
_V = createVehicle [ selectRandom ["Land_Barricade_01_10m_F", "Land_Barricade_01_4m_F"], (_nearRoad getRelPos [0, 0]), [], 2, "NONE"]; 
		_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
		_dir = _nearRoad getDir _nextRoad;
_V setDir _dir ;		
_V setVectorUp [0,0,1];
};
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if (_Chance > 1) then {
		if (count ( (getPos _thisTownTrigger) nearRoads 200 ) > 0 ) then {

_nearRoad = selectRandom ( (getPos _thisTownTrigger) nearRoads 200 ) ; 
_V = createVehicle [ selectRandom GuerVehArray, (_nearRoad getRelPos [0, 0]), [], 2, "NONE"]; 

_Group = createVehicleCrew _V; 
_VC = createGroup East;
{[_x] join _VC} forEach units _Group;

sleep 3;
_nearRoad2 =_thisTownTrigger nearRoads 1500 ; 
_nearRoad1 = _thisTownTrigger nearRoads 800 ; 

_nearRoadleft = _nearRoad2 - _nearRoad1;
_nearRoad0 = selectRandom _nearRoadleft; 
I1_WP_0 = _VC addWaypoint [getPos _nearRoad0, 0];
I1_WP_0 SetWaypointType "MOVE";
I1_WP_0 setWaypointBehaviour "SAFE";
I1_WP_0 setWaypointSpeed "LIMITED";

I1_WP_00 = _VC addWaypoint [getPos _nearRoad, 0];
I1_WP_00 SetWaypointType "MOVE";
I1_WP_00 setWaypointBehaviour "SAFE";
I1_WP_00 setWaypointSpeed "LIMITED";

I1_WP_1 = _VC addWaypoint [getPos _nearRoad, 3];
I1_WP_1 SetWaypointType "CYCLE";
I1_WP_1 setWaypointBehaviour "SAFE";
I1_WP_1 setWaypointSpeed "LIMITED";
		};
};



if (_AGGRSCORE > 5) then {
	if (count ( (getPos _thisTownTrigger) nearRoads 150 ) > 0 ) then {
_nearRoad = selectRandom ( (getPos _thisTownTrigger) nearRoads 150 ) ; 
_V = createVehicle [ selectRandom GuerVehArray, (_nearRoad getRelPos [0, 0]), [], 2, "NONE"]; 

_Group = createVehicleCrew _V; 
_VC = createGroup East;
{[_x] join _VC} forEach units _Group;
	};
};
//////OBJECTIVE////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if (_Chance < 3) then {
_Buildings = nearestObjects [(getpos _thisTownTrigger), ["House"], 200];  
_allPositionBuildings = _Buildings select {count (_x buildingPos -1) > 3}; 
_Position = _allPositionBuildings select 0;
_Pos = selectRandom (_Position buildingPos -1);

_V = createVehicle [selectRandom ["Land_PowerGenerator_F", "Box_FIA_Ammo_F", "Box_FIA_Support_F"] , _Pos, [], 500, "NONE"]; 
_V allowDammage false;
_V setPos _Pos;
sleep 3;
_V allowDammage true;
_V addEventHandler ["Killed", { 
 
["ScoreAdded", ["Insurgent Stash Destroyed", 30]] remoteExec ["BIS_fnc_showNotification", 0];

[30] execVM "Scripts\Reward.sqf";
[] execVM "Scripts\ReputationPlus.sqf";


execVM "Scripts\Civ_Relations.sqf";

 playMusic "EventTrack01_F_Curator"; 
}];

_Pos = selectRandom (_Position buildingPos -1);
G = [_Pos, East,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;   
{_uniform = uniform _x;
_x setUnitLoadout (selectRandom GuerMenArray);
removeHeadgear _x; 
_x forceAddUniform _uniform;
} foreach Units G;  
 ((units G) select 0) disableAI "PATH";
 
_Pos = selectRandom (_Position buildingPos -1);
 G = [_Pos, East,[selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;    
  ((units G) select 0) disableAI "PATH";
 
_Pos = selectRandom (_Position buildingPos -1);
 G = [_Pos, East,[selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;    

};


_V addBackpackCargoGlobal ["B_UAV_01_backpack_F", 2];
_V addBackpackCargoGlobal ["B_Static_Designator_01_weapon_F", 2];
_V addBackpackCargoGlobal ["B_W_Static_Designator_01_weapon_F", 2];
_V addBackpackCargoGlobal ["B_UGV_02_Demining_backpack_F", 2];
_V addBackpackCargoGlobal ["B_Patrol_Respawn_bag_F", 2];


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_trg = createTrigger ["EmptyDetector", getPos _thisTownTrigger, false];  
_trg setTriggerArea [150, 150, 0, false, 20];  
_trg setTriggerTimeout [10, 10, 10, true];
_trg setTriggerActivation ["WEST SEIZED","PRESENT", false];  
_trg setTriggerStatements [  
"this && {(alive _x) && ((side _x) == EAST) && (position _x inArea thisTrigger)} count allUnits < 3", "  

_MMarks = allMapMarkers select { markerType _x == ""o_inf""};
_M = [_MMarks,  thisTrigger] call BIS_fnc_nearestPosition;

deleteMarker _M ; 

				[30, 'INSURGENTS GARRISON'] execVM 'Scripts\NOtification.sqf' ;
[] execVM 'Scripts\ReputationPlus.sqf';
[] execVM 'Scripts\ReputationPlus.sqf';
[] execVM 'Scripts\ReputationPlus.sqf';

[30] execVM 'Scripts\Reward.sqf';
[thisTrigger] execVM 'Scripts\VehiInsert_CSAT.sqf';
", ""]; 
 


//////Garrisons/////////////////////////////////////////////////////////////////////////////////////////

_allBuildings = nearestObjects [getPos _thisTownTrigger, ["HOUSE"], 220];
_allPositionBuildings = _allBuildings select {count (_x buildingPos -1) > 2};   
_allPositions = [];  
_allPositionBuildings apply {_allPositions append (_x buildingPos -1)};  
_Pos = selectRandom _allPositions;  

_Pos = selectRandom _allPositions;  
 G = [_Pos, East,[selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
((units G) select 0) disableAI "PATH";

 
_Pos = selectRandom _allPositions;  
 G = [_Pos, East,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;   
{_uniform = uniform _x;
_x setUnitLoadout (selectRandom GuerMenArray);
removeHeadgear _x; 
_x forceAddUniform _uniform;
} foreach Units G;  
 ((units G) select 0) disableAI "PATH";

_Pos = selectRandom _allPositions;  
G = [_Pos, East,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;   
{_uniform = uniform _x;
_x setUnitLoadout (selectRandom GuerMenArray);
removeHeadgear _x; 
_x forceAddUniform _uniform;
} foreach Units G;  
 ((units G) select 0) disableAI "PATH";

 
_Pos = selectRandom _allPositions;  
 G = [_Pos, East,[selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;    
 
 
_Pos = selectRandom _allPositions;  
G = [_Pos, East,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;   
{_uniform = uniform _x;
_x setUnitLoadout (selectRandom GuerMenArray);
removeHeadgear _x; 
_x forceAddUniform _uniform;
} foreach Units G;  

 
_Pos = selectRandom _allPositions;  
 G = [_Pos, East,[selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;    
 
 
_Pos = selectRandom _allPositions;  
 G = [_Pos, East,[selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;    


if (_AGGRSCORE > 5) then {
	
_Pos = selectRandom _allPositions;  
G = [_Pos, East,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;   
{_uniform = uniform _x;
_x setUnitLoadout (selectRandom GuerMenArray);
removeHeadgear _x; 
_x forceAddUniform _uniform;
} foreach Units G;  
 ((units G) select 0) disableAI "PATH";

_Pos = selectRandom _allPositions;  
G = [_Pos, East,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;   
{_uniform = uniform _x;
_x setUnitLoadout (selectRandom GuerMenArray);
removeHeadgear _x; 
_x forceAddUniform _uniform;
} foreach Units G;  

 
_Pos = selectRandom _allPositions;  
 G = [_Pos, East,[selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;    

_Pos = selectRandom _allPositions;  
 G = [_Pos, East,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup; 
{_uniform = uniform _x;
_x setUnitLoadout (selectRandom GuerMenArray);
removeHeadgear _x; 
_x forceAddUniform _uniform;
} foreach Units G;   

 
_Pos = selectRandom _allPositions;  
 G = [_Pos, East,[selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;    
 
_Pos = selectRandom _allPositions;  
 G = [_Pos, East,[selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;    


};

if (_AGGRSCORE > 10) then {

_Pos = selectRandom _allPositions;  
G = [_Pos, East,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup; 
{_uniform = uniform _x;
_x setUnitLoadout (selectRandom GuerMenArray);
removeHeadgear _x; 
_x forceAddUniform _uniform;
} foreach Units G;      
((units G) select 0) disableAI "PATH";

_Pos = selectRandom _allPositions;  
G = [_Pos, East,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;   
{_uniform = uniform _x;
_x setUnitLoadout (selectRandom GuerMenArray);
removeHeadgear _x; 
_x forceAddUniform _uniform;
} foreach Units G;  

 
_Pos = selectRandom _allPositions;  
 G = [_Pos, East,[selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;    

_Pos = selectRandom _allPositions;  
 G = [_Pos, East,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;
{_uniform = uniform _x;
_x setUnitLoadout (selectRandom GuerMenArray);
removeHeadgear _x; 
_x forceAddUniform _uniform;
} foreach Units G;   

 
_Pos = selectRandom _allPositions;  
 G = [_Pos, East,[selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;    
 
_Pos = selectRandom _allPositions;  
 G = [_Pos, East,[selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;    


};



//////Assault////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if ( INFDIS == 0 ) then {

_Chance = selectRandom [1, 2, 3]; 
if (_Chance > 1) then {
if (count ( nearestobjects [player,["Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_large_F"],33000]) > 0 ) then {

PRL = [getPos _thisTownTrigger, East, [selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;


_FOBT = nearestobjects [player,["Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_large_F"],33000] select 0 ; 
_W_1 = PRL addWaypoint [(getPos _FOBT), 0];
_W_1 SetWaypointType "MOVE";
_W_1 setWaypointBehaviour "AWARE";

}; }; };

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_Chance2 = selectRandom [0,1,2,3]; 

if (_Chance2 > 1) then {
if (_REPSCORE < 7) then {
_Buildings = nearestObjects [(getpos _thisTownTrigger), ["House"], 200];  
_allPositionBuildings = _Buildings select {count (_x buildingPos -1) > 3}; 
_Position = selectRandom _allPositionBuildings;
_dir = getDirVisual _Position;
_Chance3 = selectRandom [ 1, 2, 3, 4];

if (_Chance3 > 0) then {
_Cost = 40;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  

if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;
	
[parseText "<t color='#00DB07' font='PuristaBold' align = 'right' shadow = '1' size='3'>! WARNING !</t><br /><t  align = 'right' shadow = '1' size='1.3'>One of our Supply Convoys Ambushed by Guerilla Insurgents, </t><br /><t  align = 'right' shadow = '1' size='1.3'>We believe They are in Possession of our Supply Payload,</t>", [0, 0.5, 1, 1], nil, 13, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];
_MMarks = allMapMarkers select { markerType _x == "o_unknown"};
_M = [_MMarks,  _thisTownTrigger] call BIS_fnc_nearestPosition;

sleep 2;

openMap true;
 [markerSize _M, markerPos _M, 1] call BIS_fnc_zoomOnArea;

	
_Pos = selectRandom (_Position buildingPos -1);
_posit = _thisTownTrigger getPos [(10 +(random 150)), (0 + (random 360))] ;
_V = createVehicle [ "CargoNet_01_box_F", [_posit select 0, _posit select 1, (_posit select 2) + 5000], [], 2, "NONE"]; 
_V allowDammage false;
_V setDir _dir;
_V setpos _Pos;
  };
};

sleep 2;

if (_Chance3 > 1) then {
_Cost = 40;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  

if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;
	
_Pos = selectRandom (_Position buildingPos -1);
_posit = _thisTownTrigger getPos [(10 +(random 150)), (0 + (random 360))] ;
_V = createVehicle [ "CargoNet_01_box_F", [_posit select 0, _posit select 1, (_posit select 2) + 5000], [], 2, "NONE"]; 
_V allowDammage false;
_V setpos _Pos;
_V setDir _dir;
  };
};

sleep 2;

if (_Chance3 > 2) then {
_Cost = 40;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  

if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;
	
_Pos = selectRandom (_Position buildingPos -1);
_posit = _thisTownTrigger getPos [(10 +(random 150)), (0 + (random 360))] ;
_V = createVehicle [ "CargoNet_01_box_F", [_posit select 0, _posit select 1, (_posit select 2) + 5000], [], 2, "NONE"]; 
_V allowDammage false;
_V setpos _Pos;
_V setDir _dir;
  };
};

sleep 2;

_Pos = selectRandom _allPositions;  
G = [_Pos, East,[selectRandom CivMenArray]] call BIS_fnc_spawnGroup;   
{_uniform = uniform _x;
_x setUnitLoadout (selectRandom GuerMenArray);
removeHeadgear _x; 
_x forceAddUniform _uniform;
} foreach Units G;  
 ((units G) select 0) disableAI "PATH";
 
_Pos = selectRandom _allPositions;  
 G = [_Pos, East,[selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;    
  ((units G) select 0) disableAI "PATH";
 
_Pos = selectRandom _allPositions;  
 G = [_Pos, East,[selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;  
	
	
}; };


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// {

// _nvg = hmd _x;
//  _x unassignItem _nvg;
//  _x removeItem _nvg;
// 	  _x addPrimaryWeaponItem "acc_flashlight";
// 	  _x assignItem "acc_flashlight";
// 	  _x enableGunLights "ForceOn";
//   } foreach (allUnits select {side _x == east}); 


sleep 10;



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{ if !((side _x) == west) then {
            ZEUS removeCuratorEditableObjects [[_x],true];
}; } foreach allUnits;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// {
// _nvg = hmd _x;
//  _x unassignItem _nvg;
//  _x removeItem _nvg;
// 	  _x addPrimaryWeaponItem "acc_flashlight";
// 	  _x assignItem "acc_flashlight";
// 	  _x enableGunLights "ForceOn";
//   } foreach (allUnits select {side _x == east}); 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

[_thisTownTrigger, 200] execVM "Scripts\INTLitems.sqf";


sleep 2 ;

