_alltriggers = allMissionObjects "EmptyDetector";
_referencePos = getPosWorld player; //or whatever you want
_sortedByRange = [_alltriggers,[],{_referencePos distanceSqr getPos _x},"ASCEND"] call BIS_fnc_sortBy;
_sortedByRange params ["_nearesttrigger"];
deleteVehicle _nearesttrigger;

sleep 1;

_alltriggers = allMissionObjects "EmptyDetector";
_referencePos = getPosWorld player; //or whatever you want
_sortedByRange = [_alltriggers,[],{_referencePos distanceSqr getPos _x},"ASCEND"] call BIS_fnc_sortBy;
_sortedByRange params ["_nearesttrigger"];
deleteVehicle _nearesttrigger;

sleep 1;

_alltriggers = allMissionObjects "EmptyDetector";
_referencePos = getPosWorld player; //or whatever you want
_sortedByRange = [_alltriggers,[],{_referencePos distanceSqr getPos _x},"ASCEND"] call BIS_fnc_sortBy;
_sortedByRange params ["_nearesttrigger"];
deleteVehicle _nearesttrigger;

sleep 1;

_alltriggers = allMissionObjects "EmptyDetector";
_referencePos = getPosWorld player; //or whatever you want
_sortedByRange = [_alltriggers,[],{_referencePos distanceSqr getPos _x},"ASCEND"] call BIS_fnc_sortBy;
_sortedByRange params ["_nearesttrigger"];
deleteVehicle _nearesttrigger;

_MMarks = allMapMarkers select {markerText _x == "FOB"};  
_M = [_MMarks,  player] call BIS_fnc_nearestPosition;

deleteMarker _M ; 


_FOBB = nearestObjects [position player, ["Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V1_F"], 70] select 0;
_FOBT = nearestObjects [position player, ["Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_large_F"], 70]  select 0;


_pos = getpos _FOBB;
_dir = getDirVisual _FOBB;


deleteVehicle _FOBB;
deleteVehicle _FOBT;


sleep 1;

_FOBC = createVehicle ["B_Slingload_01_Cargo_F",_pos,[],0,"NONE"];
_FOBC setDir _dir;
[_FOBC,[
	"<img size=2 color='#7CC2FF' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#7CC2FF'>UnPack FOB",
	"Scripts\FOBUNPACK.sqf",
	nil,
	0,
	true,
	true,
	"",
	"typeOf player == 'B_G_officer_F'", // _target, _this, _originalTarget
	40,
	false,
	"",
	""
]] remoteExec ["addAction",0,true];
