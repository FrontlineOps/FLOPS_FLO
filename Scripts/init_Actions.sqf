Centerposition = [worldSize / 2, worldsize / 2, 0];

///////// Init Weather //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_Fog_Int = selectRandom [0, 0, 0.05, 0.05, 0.1, 0.1, 0.1, 0.2, 0.2, 0.3, 0.4, 0.5] ;
_Fog_Dec = selectRandom [0.01, 0.01, 0.01, 0.02, 0.03,  0.05, 0.05, 0.1, 0.1] ;
_OverC_Int = selectRandom [ 0.1, 0.1, 0.1, 0.3,  0.3,  0.3,  0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1, 1] ;

_Fog_Alt = 0 ;

if (_OverC_Int >= 0.6) then {
0 setFog [_Fog_Int, _Fog_Dec, _Fog_Alt];
}else{
0 setFog [0, _Fog_Dec, _Fog_Alt];
}	;

0 setOvercast _OverC_Int;


forceWeatherChange;

[[west,"HQ"], "Weather Initialized Successfully ..."] remoteExec ["sideChat", 0];


///////// Init FOBs //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{  

Centerposition = [worldSize / 2, worldsize / 2, 0];
 FOBB = nearestObjects [Centerposition, ["Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V1_F"], 40000];
publicVariable "FOBB";

{ if (count (nearestObjects [ _x, ["Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_large_F"], 20]) > 0) then {     
[_x, -1, west, "LIGHT"] execVM "R3F_LOG\USER_FUNCT\init_creation_factory.sqf";
 } ;
 } foreach FOBB;


 } remoteExec ["call", 0]; 

FOBB = nearestObjects [Centerposition, ["Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V1_F"], 40000];
publicVariable "FOBB";


{ if (count (nearestObjects [ _x, ["Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_large_F"], 20]) > 0) then {     

{ null = [_x, -1, west, "LIGHT"] execVM "R3F_LOG\USER_FUNCT\init_creation_factory.sqf" } remoteExec ["call", 0]; 


[ _x,
"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>ARSENAL",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
	
	if (isClass (configfile >> "ace_arsenal_loadoutsDisplay") == true ) then {
		[player, player, true] call ace_arsenal_fnc_openBox;
	} else {
		["Open", true] spawn BIS_fnc_arsenal;
	};
},
{},
[],
1,
9999999,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   



[ _x,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#7CC2FF'>Pack FOB",
"Screens\FOBA\b_hq.paa",
"Screens\FOBA\b_hq.paa",
"player == TheCommander",       
"_caller distance _target < 40",  
{},
{},
{execVM 'Scripts\FOBPACK.sqf';},
{},
[],
5,
2,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

[ _x,
"<img size=2 color='#59ff58' image='Screens\FOBA\iconParachute_ca.paa'/><t font='PuristaBold' color='#59ff58'>H.A.L.O (250)",
"Screens\FOBA\b_hq.paa",
"Screens\FOBA\b_hq.paa",
"true",       
"_caller distance _target < 40",  
{},
{},
{
	
[player] execVM "Scripts\HALO1.sqf"; 

},
{},
[],
5,
2,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

[_x,[
	"<img size=2 color='#7CC2FF' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#7CC2FF'>REQUEST MENU",
	"Scripts\Dialog_Request.sqf",
	nil,
	99999,
	true,
	true,
	"",
	"", // _target, _this, _originalTarget
	40,
	false,
	"",
	""
]] remoteExec ["addAction",0,true];


_TFOBH = createTrigger ["EmptyDetector", getPos _x];  
_TFOBH setTriggerArea [5, 5, 0, false, 7];  
_TFOBH setTriggerTimeout [3, 3, 3, true];
_TFOBH setTriggerActivation ["NONE", "PRESENT", true];  
_TFOBH setTriggerStatements [  
"count (nearestobjects [thisTrigger,East_Units_Officers,5]) > 0 ",  
"  
_HOS = nearestobjects [thisTrigger,East_Units_Officers,10] select 0 ;    
deleteVehicle _HOS ; 
	[] execVM 'Scripts\INTL.sqf';	
[125] execVM 'Scripts\Reward.sqf';
	[125, 'ENEMY OFFICER'] execVM 'Scripts\NOtification.sqf' ;

 ", ""]; 

_TFOBH attachTo [_x, [0, 0, 0]]; 

_TFOBH = createTrigger ["EmptyDetector", getPos _x];  
_TFOBH setTriggerArea [5, 5, 0, false, 7];  
_TFOBH setTriggerTimeout [3, 3, 3, true];
_TFOBH setTriggerActivation ["NONE", "PRESENT", true];  
_TFOBH setTriggerStatements [  
"count (nearestobjects [thisTrigger,East_Units,5]) > 0 ",  
"  
_HOS = nearestobjects [thisTrigger,East_Units,10] select 0 ;    
deleteVehicle _HOS ; 
	[] execVM 'Scripts\INTL.sqf';	
[25] execVM 'Scripts\Reward.sqf';
	[25, 'ENEMY SOLDIER'] execVM 'Scripts\NOtification.sqf' ;

 ", ""]; 

_TFOBH attachTo [_x, [0, 0, 0]]; 



_CIVTRG = createTrigger ["EmptyDetector", getPos _x];  
_CIVTRG setTriggerArea [5, 5, 0, false, 7];  
_CIVTRG setTriggerTimeout [3, 3, 3, true];
_CIVTRG setTriggerActivation ["NONE", "PRESENT", true];  
_CIVTRG setTriggerStatements [  
"{(alive  _x) && (side _x == civilian)} count (thisTrigger nearEntities [['Man'], 5]) > 0",  
"
_CIVIL = (nearestObjects [thisTrigger ,['Man'], 7] select {(alive _x) && ((side _x) == civilian)}) select 0 ;
  
if ( _CIVIL getUnitTrait 'engineer' == true) then {
	[15, 'INSURGENT'] execVM 'Scripts\NOtification.sqf' ;
	[15] execVM 'Scripts\Reward.sqf';
	deleteVehicle _CIVIL ; 
	[] execVM 'Scripts\INTL_Civ.sqf';	
	[] execVM 'Scripts\ReputationPlus.sqf';
}else{
	[0, 'CIVILIAN'] execVM 'Scripts\NOtification.sqf' ;
	deleteVehicle _CIVIL ; 
	[] execVM 'Scripts\ReputationMinus.sqf';
};
 ", ""]; 

_CIVTRG attachTo [_x, [0, 0, 0]]; 



_TFOBA = createTrigger ["EmptyDetector", getPos _x];  
_TFOBA setTriggerArea [5, 5, 0, false, 7];  
_TFOBA setTriggerTimeout [3, 3, 3, true];
_TFOBA setTriggerActivation ["NONE", "PRESENT", true];  
_TFOBA setTriggerStatements [  
"count (nearestobjects [thisTrigger,['CargoNet_01_box_F'],4]) > 0 ",  
"  
_RES = nearestobjects [thisTrigger,['CargoNet_01_box_F'],10] select 0 ;    
deleteVehicle _RES ; 
	[60, 'RESOURCE'] execVM 'Scripts\NOtification.sqf' ;

[60] execVM 'Scripts\Reward.sqf';
 ", ""]; 

_TFOBA attachTo [_x, [0, 0, 0]]; 




			_x addEventHandler ["Killed", {
								
				[playerSide, 'HQ'] commandChat 'all Forces Fall Back. We Lost the FOB,...';
				_FOBC = nearestObjects [ (_this select 0), ['B_Slingload_01_Cargo_F'], 1000] select 0;
				_FOBB = nearestObjects [ (_this select 0), ['Land_Cargo_HQ_V3_F', 'Land_Cargo_HQ_V1_F'], 1000] select 0;
				_FOBT = nearestObjects [(_this select 0), ['Land_TripodScreen_01_large_sand_F', 'Land_TripodScreen_01_large_F'], 1000]  select 0;
				deleteVehicle _FOBC;
				_FOBB setdamage 1;
				deleteVehicle _FOBT;
				
				_allMarks = allMapMarkers select {markerText _x == 'FOB' && markerType _x == 'b_installation'};  
				_FOBMrk = [_allMarks,  (_this select 0)] call BIS_fnc_nearestPosition;
				deleteMarker _FOBMrk ; 
			
				_allAreaMarks = allMapMarkers select {markerColor _x == 'ColorYellow'};  
				_AreaMrk = [_allAreaMarks,  thisTrigger] call BIS_fnc_nearestPosition;
				deleteMarker _AreaMrk ; 

				[] execVM 'Scripts\Failed.sqf';

				_alltriggers = allMissionObjects "EmptyDetector";
				_triggers = _alltriggers select {position _x distance (_this select 0) < 20};
				{deleteVehicle _x;}forEach _triggers;
								
							}]; 





_TFOBB = createTrigger ["EmptyDetector", getPos _x];
_TFOBB setTriggerArea [100, 100, 0, false, 20];
_TFOBB setTriggerInterval 2;
_TFOBB setTriggerActivation ["EAST SEIZED", "PRESENT", false];
_TFOBB setTriggerStatements [
"this && {(alive _x) && ((side _x) == WEST) && (position _x inArea thisTrigger)} count allUnits < 5","


			[playerSide, 'HQ'] commandChat 'all Forces Fall Back. We Lost the FOB,...';
			_FOBC = nearestObjects [ thisTrigger, ['B_Slingload_01_Cargo_F'], 1000] select 0;
			_FOBB = nearestObjects [ thisTrigger, ['Land_Cargo_HQ_V3_F', 'Land_Cargo_HQ_V1_F'], 1000] select 0;
			_FOBT = nearestObjects [thisTrigger, ['Land_TripodScreen_01_large_sand_F', 'Land_TripodScreen_01_large_F'], 1000]  select 0;
			deleteVehicle _FOBC;
			_FOBB setdamage 1;
			deleteVehicle _FOBT;
			
			_allMarks = allMapMarkers select {markerText _x == 'FOB' && markerType _x == 'b_installation'};  
			_FOBMrk = [_allMarks,  thisTrigger] call BIS_fnc_nearestPosition;
			deleteMarker _FOBMrk ; 
			
			_allAreaMarks = allMapMarkers select {markerColor _x == 'ColorYellow'};  
			_AreaMrk = [_allAreaMarks,  thisTrigger] call BIS_fnc_nearestPosition;
			deleteMarker _AreaMrk ; 

			[] execVM 'Scripts\Failed.sqf';

			_alltriggers = allMissionObjects ""EmptyDetector"";
			_triggers = _alltriggers select {position _x inArea thisTrigger};
			{deleteVehicle _x;}forEach _triggers;

", ""];

_TFOBB attachTo [_x, [0, 0, 0]]; 

[playerSide, "HQ"] commandChat "FOB Deployed";
 }
 } foreach FOBB;

 ///////////////////////////////////////////////////////
 
_FOBT = nearestObjects [Centerposition, ["Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_large_F"], 40000];

{

[ _x,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#7CC2FF'>Skip_Time",
"Screens\FOBA\b_hq.paa",
"Screens\FOBA\b_hq.paa",
"((player == TheCommander) && (serverCommandAvailable '#kick') && (serverCommandAvailable '#debug')) || ((player == TheCommander) && (isServer)) || ((player == TheCommander) && (isServer))",       
"_caller distance _target < 40",  
{},
{},
{createDialog 'C_LOCK';},
{},
[],
5,
4,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

[ _x,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#7CC2FF'>Change_Weather",
"Screens\FOBA\b_hq.paa",
"Screens\FOBA\b_hq.paa",
"((player == TheCommander) && (serverCommandAvailable '#kick') && (serverCommandAvailable '#debug')) || ((player == TheCommander) && (isServer)) || ((player == TheCommander) && (isServer))",       
"_caller distance _target < 40",  
{},
{},
{ { null = execVM "Scripts\init_Weather.sqf" ;} remoteExec ["call", 2];},
{},
[],
5,
4,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

[ _x,
	"<img size=2 color='#FFE496' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#FFE496'>SAVE Mission Progress",
"Screens\FOBA\b_hq.paa",
"Screens\FOBA\b_hq.paa",
"((player == TheCommander) && (serverCommandAvailable '#kick') && (serverCommandAvailable '#debug')) || ((player == TheCommander) && (isServer)) || ((player == TheCommander) && (isServer))",       
"_caller distance _target < 40",  
{},
{},
{ { null = execVM "Scripts\MissionSave.sqf" } remoteExec ["call", 2];},
{},
[],
7,
6,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

[ _x,
	"<img size=2 color='#FFE496' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#FFE496'>RESET Mission Progress",
'Screens\FOBA\b_hq.paa',
'Screens\FOBA\b_hq.paa',
"((player == TheCommander) && (serverCommandAvailable '#kick') && (serverCommandAvailable '#debug')) || ((player == TheCommander) && (isServer)) || ((player == TheCommander) && (isServer))",       
'_caller distance _target < 40',  
{},
{},
{{ null = execVM "Scripts\MissionReset.sqf" } remoteExec ["call", 2];},
{},
[],
7,
5,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

[ _x,
	"<img size=2 color='#59ff58' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#59ff58'>Bribe_Militia_(200)",
'Screens\FOBA\b_hq.paa',
'Screens\FOBA\b_hq.paa',
"((player == TheCommander) && (serverCommandAvailable '#kick') && (serverCommandAvailable '#debug')) || ((player == TheCommander) && (isServer)) || ((player == TheCommander) && (isServer))",       
'_caller distance _target < 40',  
{},
{},
{[] execVM "Scripts\BRIBE.sqf"; },
{},
[],
5,
3,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

[ _x,
	"<img size=2 color='#FF0000' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#FF0000'>Create Custom Mission",
'Screens\FOBA\b_hq.paa',
'Screens\FOBA\b_hq.paa',
"((player == TheCommander) && (serverCommandAvailable '#kick') && (serverCommandAvailable '#debug')) || ((player == TheCommander) && (isServer)) || ((player == TheCommander) && (isServer))",       
'_caller distance _target < 40',  
{},
{},
{ execVM "Scripts\Mission_Select_Action.sqf" ;},
{},
[],
2,
1.5,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

[ _x,
	"<img size=2 color='#FF0000' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#FF0000'>Create Custom Zone",
'Screens\FOBA\b_hq.paa',
'Screens\FOBA\b_hq.paa',
"((player == TheCommander) && (serverCommandAvailable '#kick') && (serverCommandAvailable '#debug')) || ((player == TheCommander) && (isServer)) || ((player == TheCommander) && (isServer))",       
'_caller distance _target < 40',  
{},
{},
{ execVM "Scripts\CCO.sqf" ;},
{},
[],
2,
1.5,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   
 
 
 } foreach _FOBT;
 

[[west,"HQ"], "Friendly FOBs Initialized Successfully ..."] remoteExec ["sideChat", 0];
 
///////// Init OPs //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



_FOBB = nearestObjects [Centerposition, ["Land_Cargo_House_V1_F", "Land_Cargo_House_V3_F"], 40000];

{ if (count (nearestObjects [ _x, ["Land_TripodScreen_01_dual_v2_F", "Land_TripodScreen_01_dual_v2_sand_F"], 6]) > 0) then {     

{ null = [_x, -1, west, "LIGHT"] execVM "R3F_LOG\USER_FUNCT\init_creation_factory.sqf" } remoteExec ["call", 0]; 

[ _x,
"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>ARSENAL",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
	
	if (isClass (configfile >> "ace_arsenal_loadoutsDisplay") == true ) then {
		[player, player, true] call ace_arsenal_fnc_openBox;
	} else {
		["Open", true] spawn BIS_fnc_arsenal;
	};
},
{},
[],
1,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   



[ _x,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#7CC2FF'>Pack OP",
"Screens\FOBA\b_hq.paa",
"Screens\FOBA\b_hq.paa",
"true",       
"_caller distance _target < 40",  
{},
{},
{execVM 'Scripts\OPPACK.sqf';},
{},
[],
5,
2,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   


[_x,[
	"<img size=2 color='#7CC2FF' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#7CC2FF'>REQUEST MENU",
	"Scripts\Dialog_Request_OP.sqf",
	nil,
	99999,
	true,
	true,
	"",
	"", // _target, _this, _originalTarget
	40,
	false,
	"",
	""
]] remoteExec ["addAction",0,true];




_TFOBH = createTrigger ["EmptyDetector", getPos _x];  
_TFOBH setTriggerArea [5, 5, 0, false, 7];  
_TFOBH setTriggerTimeout [3, 3, 3, true];
_TFOBH setTriggerActivation ["NONE", "PRESENT", true];  
_TFOBH setTriggerStatements [  
"count (nearestobjects [thisTrigger,East_Units_Officers,3]) > 0 ",  
"  
_HOS = nearestobjects [thisTrigger,East_Units_Officers,10] select 0 ;    
deleteVehicle _HOS ; 
[125] execVM 'Scripts\Reward.sqf';
[] execVM 'Scripts\INTL.sqf';
	[125, 'ENEMY OFFICER'] execVM 'Scripts\NOtification.sqf' ;

 ", ""]; 

_TFOBH attachTo [_x, [0, 0, 0]]; 

_TFOBH = createTrigger ["EmptyDetector", getPos _x];  
_TFOBH setTriggerArea [5, 5, 0, false, 7];  
_TFOBH setTriggerTimeout [3, 3, 3, true];
_TFOBH setTriggerActivation ["NONE", "PRESENT", true];  
_TFOBH setTriggerStatements [  
"count (nearestobjects [thisTrigger,East_Units,3]) > 0 ",  
"  
_HOS = nearestobjects [thisTrigger,East_Units,10] select 0 ;    
deleteVehicle _HOS ; 

[25] execVM 'Scripts\Reward.sqf';
[] execVM 'Scripts\INTL.sqf';
	[25, 'ENEMY SOLDIER'] execVM 'Scripts\NOtification.sqf' ;

 ", ""]; 

_TFOBH attachTo [_x, [0, 0, 0]]; 


_CIVTRG = createTrigger ["EmptyDetector", getPos _x];  
_CIVTRG setTriggerArea [5, 5, 0, false, 7];  
_CIVTRG setTriggerTimeout [3, 3, 3, true];
_CIVTRG setTriggerActivation ["NONE", "PRESENT", true];  
_CIVTRG setTriggerStatements [  
"{(alive  _x) && (side _x == civilian)} count (thisTrigger nearEntities [['Man'], 5]) > 0",  
"
_CIVIL = (nearestObjects [thisTrigger ,['Man'], 7] select {(alive _x) && ((side _x) == civilian)}) select 0 ;
  
if ( _CIVIL getUnitTrait 'engineer' == true) then {
	[15, 'INSURGENT'] execVM 'Scripts\NOtification.sqf' ;
	[15] execVM 'Scripts\Reward.sqf';
	deleteVehicle _CIVIL ; 
	[] execVM 'Scripts\INTL_Civ.sqf';	
	[] execVM 'Scripts\ReputationPlus.sqf';
}else{
	[0, 'CIVILIAN'] execVM 'Scripts\NOtification.sqf' ;
	deleteVehicle _CIVIL ; 
	[] execVM 'Scripts\ReputationMinus.sqf';
};
 ", ""]; 

_CIVTRG attachTo [_x, [0, 0, 0]]; 


_TFOBA = createTrigger ["EmptyDetector", getPos _x];  
_TFOBA setTriggerArea [3, 3, 0, false, 7];  
_TFOBA setTriggerTimeout [3, 3, 3, true];
_TFOBA setTriggerActivation ["NONE", "PRESENT", true];  
_TFOBA setTriggerStatements [  
"count (nearestobjects [thisTrigger,['CargoNet_01_box_F'],3]) > 0 ",  
"  
_RES = nearestobjects [thisTrigger,['CargoNet_01_box_F'],10] select 0 ;    
deleteVehicle _RES ; 
	[40, 'RESOURCE'] execVM 'Scripts\NOtification.sqf' ;

[40] execVM 'Scripts\Reward.sqf';
 ", ""]; 

_TFOBA attachTo [_x, [0, 0, 0]]; 




			_x addEventHandler ["Killed", {
								
					[playerSide, 'HQ'] commandChat 'all Forces Fall Back. We Lost the OP,...';
					_FOBC = nearestObjects [ (_this select 0), ['B_Slingload_01_Cargo_F'], 1000] select 0;
					_FOBB = nearestObjects [ (_this select 0), ['Land_Cargo_House_V1_F', 'Land_Cargo_House_V3_F'], 1000] select 0;
					_FOBT = nearestObjects [(_this select 0), ['Land_TripodScreen_01_dual_v2_F', 'Land_TripodScreen_01_dual_v2_sand_F'], 1000]  select 0;
					deleteVehicle _FOBC;
					_FOBB setdamage 1;
					deleteVehicle _FOBT;
				_allMarks = allMapMarkers select {markerText _x == 'OP' && markerType _x == 'b_installation'};  
				_FOBMrk = [_allMarks,  (_this select 0)] call BIS_fnc_nearestPosition;
				deleteMarker _FOBMrk ; 


					_alltriggers = allMissionObjects "EmptyDetector";
					_triggers = _alltriggers select {position _x distance (_this select 0) < 20};
					{deleteVehicle _x;}forEach _triggers;
							}]; 







_TFOBB = createTrigger ["EmptyDetector", getPos _x];
_TFOBB setTriggerArea [100, 100, 0, false, 20];
_TFOBB setTriggerInterval 2;
_TFOBB setTriggerActivation ["EAST SEIZED", "PRESENT", false];
_TFOBB setTriggerStatements [
"this && {(alive _x) && ((side _x) == WEST) && (position _x inArea thisTrigger)} count allUnits < 5","


[playerSide, 'HQ'] commandChat 'all Forces Fall Back. We Lost the OP,...';
_FOBC = nearestObjects [ thisTrigger, ['B_Slingload_01_Cargo_F'], 1000] select 0;
_FOBB = nearestObjects [ thisTrigger, ['Land_Cargo_House_V1_F', 'Land_Cargo_House_V3_F'], 1000] select 0;
_FOBT = nearestObjects [thisTrigger, ['Land_TripodScreen_01_dual_v2_F,, ,Land_TripodScreen_01_dual_v2_sand_F'], 1000]  select 0;
deleteVehicle _FOBC;
_FOBB setdamage 1;
deleteVehicle _FOBT;
_allMarks = allMapMarkers select {markerPos _x inArea thisTrigger && markerType _x == 'b_installation'};  
	{  
deleteMarker _x ; 
	} forEach _allMarks; 


_alltriggers = allMissionObjects ""EmptyDetector"";
_triggers = _alltriggers select {position _x inArea thisTrigger};
{deleteVehicle _x;}forEach _triggers;

", ""];

_TFOBB attachTo [_x, [0, 0, 0]]; 

[playerSide, "HQ"] commandChat "OP Deployed";
 }
 } foreach _FOBB;


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 _FOBC = nearestObjects [Centerposition, ["B_Slingload_01_Cargo_F"], 40000];
{
[_x,[
	"<img size=2 color='#7CC2FF' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#7CC2FF'>UnPack FOB",
	"Scripts\FOBUNPACK.sqf",
	nil,
	0,
	true,
	true,
	"",
	"true", // _target, _this, _originalTarget
	40,
	false,
	"",
	""
]] remoteExec ["addAction",0,true];	
 } foreach _FOBC;
 
  _FOBC = nearestObjects [Centerposition, ["B_Slingload_01_Repair_F"], 40000];
{
[_x,[
	"<img size=2 color='#7CC2FF' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#7CC2FF'>UnPack OP",
	"Scripts\OPUNPACK.sqf",
	nil,
	0,
	true,
	true,
	"",
	"true", // _target, _this, _originalTarget
	40,
	false,
	"",
	""
]] remoteExec ["addAction",0,true];
 } foreach _FOBC;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




[[west,"HQ"], "Friendly OPs Initialized Successfully ..."] remoteExec ["sideChat", 0];


//////////// Vehicles Crew Management /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


ALLFACVEHs = nearestobjects [Centerposition,[
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
],40000] ;

_EXCVEH = vehicles - ALLFACVEHs ;

{

deleteVehicleCrew _x ; 
			
} foreach _EXCVEH;  
	

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_objectLocT = allMapMarkers select { markerType _x == "loc_Transmitter" };
	{
		
_TWR = nearestobjects [(getMarkerPos _x), ["Land_TTowerBig_2_F", "Land_TTowerBig_1_F"], 200] select 0;
_TWR removeAllEventHandlers "Killed";
_TWR addEventHandler ["Killed", { 
_MMarks = allMapMarkers select { markerType _x == "loc_Transmitter"};
_M = [_MMarks, (_this select 0)] call BIS_fnc_nearestPosition;
deleteMarker _M ; 
  
				[] execVM "Scripts\DangerMinus.sqf";					
				[] execVM "Scripts\DangerMinus.sqf";					
				[] execVM "Scripts\DangerMinus.sqf";					
[] execVM "Scripts\ReputationMinus.sqf";
[] execVM "Scripts\ReputationMinus.sqf";

  
[30, "RADIO TOWER"] execVM "Scripts\NOtification.sqf" ;

[30] execVM "Scripts\Reward.sqf";
 execVM "Scripts\COMDIS.sqf";
}];
	
    } forEach _objectLocT;	

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


_objectLocT = allMapMarkers select { markerType _x == "b_installation" && markerColor _x == "ColorWEST"};

	{
		
_trg = createTrigger ["EmptyDetector", (getMarkerPos _x), false];  
_trg setTriggerArea [220, 220, 0, false, 200];  
_trg setTriggerTimeout [10, 10, 10, true];
_trg setTriggerActivation ["EAST SEIZED", "PRESENT", true];  
_trg setTriggerStatements [  
"this",  "  

				[parseText '<t color=""#FF3619"" font=""PuristaBold"" align = ""right"" shadow = ""1"" size=""2"">SITREP</t><br /><t color=""#7c7c7c""  align = ""right"" shadow = ""1"" size=""0.8"">Enemy Forces Dominating the Battle,</t><br /><t color=""#7c7c7c"" align = ""right"" shadow = ""1"" size=""0.8"">Keep Up the Fight, We Must Defend and Take Back the Outpost, </t>', [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ['BIS_fnc_textTiles', 0];
				_allMarks = allMapMarkers select {markerType _x == 'b_installation'};  
				_FOBMrk = [_allMarks,  thisTrigger] call BIS_fnc_nearestPosition;
				_FOBMrk setMarkerColor 'ColorGrey' ;	
				_attackingAtGrid = mapGridPosition getMarkerPos _FOBMrk;
				[[west,'HQ'], 'Enemy Forces Dominating the Battle at grid ' + _attackingAtGrid] remoteExec ['sideChat', 0];					
				
				[thisTrigger] execVM 'Scripts\City_CSAT_CAPTURE_East.sqf';

", "

				_allMarks = allMapMarkers select {markerType _x == 'b_installation'};  
				_FOBMrk = [_allMarks,  thisTrigger] call BIS_fnc_nearestPosition;
				_FOBMrk setMarkerColor 'ColorWEST' ;		

"];				

    } forEach _objectLocT;	

_objectLocT = allMapMarkers select { markerType _x == "b_installation" && markerColor _x == "colorBLUFOR"};

	{

_trg = createTrigger ["EmptyDetector", (getMarkerPos _x), false];  
_trg setTriggerArea [120, 120, 0, false, 200];  
_trg setTriggerTimeout [10, 10, 10, true];
_trg setTriggerActivation ["EAST SEIZED", "PRESENT", true];  
_trg setTriggerStatements [  
"this",  "  

				[parseText '<t color=""#FF3619"" font=""PuristaBold"" align = ""right"" shadow = ""1"" size=""2"">SITREP</t><br /><t color=""#7c7c7c""  align = ""right"" shadow = ""1"" size=""0.8"">Enemy Forces Dominating the Battle,</t><br /><t color=""#7c7c7c"" align = ""right"" shadow = ""1"" size=""0.8"">Keep Up the Fight, We Must Defend and Take Back the Outpost, </t>', [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ['BIS_fnc_textTiles', 0];
				_allMarks = allMapMarkers select {markerType _x == 'b_installation'};  
				_FOBMrk = [_allMarks,  thisTrigger] call BIS_fnc_nearestPosition;
				_FOBMrk setMarkerColor 'ColorGrey' ;	
				_attackingAtGrid = mapGridPosition getMarkerPos _FOBMrk;
				[[west,'HQ'], 'Enemy Forces Dominating the Battle at grid ' + _attackingAtGrid] remoteExec ['sideChat', 0];					
				
				[thisTrigger] execVM 'Scripts\Outpost_CSAT_CAPTURE_East.sqf';

", "

				_allMarks = allMapMarkers select {markerType _x == 'b_installation'};  
				_FOBMrk = [_allMarks,  thisTrigger] call BIS_fnc_nearestPosition;
				_FOBMrk setMarkerColor 'colorBLUFOR' ;		

"];				

    } forEach _objectLocT;	
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

[] spawn {  
  while { true } do{  
{
 _x setDamage 0; 
 
  [true] remoteExec ["showHud", _x]; 
 
  _x stop false; 
 _x enableAI "all";    

 [_x, false] remoteExec ["setCaptive", 0, false]; 
  
 ["GetOutMan"] remoteExec ["removeAllEventHandlers", _x, false];
 
	[_x, _x] remoteExec ["ace_medical_treatment_fnc_fullHeal", _x, false]; 
	
		if ( animationState _x == "ainjppnemstpsnonwrfldnon" ) then {  [_x, "agonyStop"] remoteExec ["playActionNow", 0, false]; };
	if ( animationState _x == "unconscious" ) then {  [_x, "agonyStop"] remoteExec ["playActionNow", 0, false]; };
		_x enableAI "all";    
	
  } forEach (allUnits select {((side _x == civilian) || (side _x == west)) && (count ( nearestobjects [_x ,["Land_Medevac_house_V1_F", "Land_Medevac_HQ_V1_F", "B_Slingload_01_Medevac_F", "Land_MedicalTent_01_MTP_closed_F", "Land_MedicalTent_01_white_IDAP_med_closed_F"],20]) > 0)}) ; 
 
 sleep 3;  
 
	  {
	if ( animationState _x == "ainjppnemstpsnonwrfldnon" ) then {  [_x, "agonyStop"] remoteExec ["playActionNow", 0, false]; };
	if ( animationState _x == "unconscious" ) then {  [_x, "agonyStop"] remoteExec ["playActionNow", 0, false]; };
		_x enableAI "all";    
  } forEach (allUnits select {((side _x == civilian) || (side _x == west)) && (count ( nearestobjects [_x ,["Land_Medevac_house_V1_F", "Land_Medevac_HQ_V1_F", "B_Slingload_01_Medevac_F", "Land_MedicalTent_01_MTP_closed_F", "Land_MedicalTent_01_white_IDAP_med_closed_F"],20]) > 0)}) ; 


 sleep 30;  
  };  
};

[[west,"HQ"], "Medical Stations Initialized Successfully ..."] remoteExec ["sideChat", 0];



[] spawn {  
  while { true } do{  
{
  {_x setDamage 0; } remoteExec ["call", 0]; 
 	
	} forEach (vehicles select {((side (gunner  _x) == west) or (side (driver  _x) == west)) && (count ( nearestobjects [_x ,[F_Truck_04, "B_Slingload_01_Repair_F"],50]) > 0)}) ; 

 sleep 30;  
  };  
};

[[west,"HQ"], "Repair Stations Initialized Successfully ..."] remoteExec ["sideChat", 0];


[] spawn {  
  while { true } do{  
{
	{ _x setVehicleAmmo 1;  } remoteExec ["call", 0]; 
 	
	} forEach (vehicles select {((side (gunner  _x) == west) or (side (driver  _x) == west)) && (count ( nearestobjects [_x ,[F_Truck_03, "B_Slingload_01_Ammo_F", "Box_NATO_AmmoVeh_F"],50]) > 0)}) ; 

 sleep 30;  
  };  
};

[[west,"HQ"], "ReArm Stations Initialized Successfully ..."] remoteExec ["sideChat", 0];


[] spawn {  
  while { true } do{  
_MOBRESMarks = allMapMarkers select {markerType _x == "b_unknown" && markerColor _x == "ColorYellow" && markerAlpha _x == 0.7};
	{deleteMarker _x} forEach _MOBRESMarks ;
_MOBRESVeh = vehicles select {(typeOf _x == F_Truck_05 or typeOf _x == F_Heli_04) && alive _x } ;	
{
_markerName = "respawn_west" + (str (getPos _x));  
_mrkr = createMarkerLocal [_markerName, getPos _x];  
_mrkr setMarkerTypeLocal "b_unknown";
_mrkr setMarkerColorLocal "ColorYellow";
_mrkr setMarkerSizeLocal [1, 1]; 
_mrkr setMarkerAlpha 0.7; 
} foreach _MOBRESVeh;

 sleep 5;  
  };  
};


{ 
_MOBSER = nearestobjects [Centerposition,[F_Truck_04],40000] ;
{
	 [_x, -1, west, "LIGHT"] execVM "R3F_LOG\USER_FUNCT\init_creation_factory.sqf" ; 

} forEach _MOBSER ;  } remoteExec ["call", 0]; 

_MOBARS = nearestobjects [Centerposition,[F_Truck_03],40000] ;
{

[ _x,
"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>ARSENAL",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
	
	if (isClass (configfile >> "ace_arsenal_loadoutsDisplay") == true ) then {
		[player, player, true] call ace_arsenal_fnc_openBox;
	} else {
		["Open", true] spawn BIS_fnc_arsenal;
	};
},
{},
[],
1,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

[ _x,
"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>REARM Infantry",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
[(_this select 0)] execVM "Scripts\REARM.sqf" ;
},
{},
[],
5,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

} forEach _MOBARS ;

_SUPPARS = nearestobjects [Centerposition,["B_CargoNet_01_ammo_F"],40000] ;
{

[ _x,
"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>ARSENAL",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
	
	if (isClass (configfile >> "ace_arsenal_loadoutsDisplay") == true ) then {
		[player, player, true] call ace_arsenal_fnc_openBox;
	} else {
		["Open", true] spawn BIS_fnc_arsenal;
	};
},
{},
[],
1,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

[ _x,
"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>REARM Infantry",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
[(_this select 0)] execVM "Scripts\REARM.sqf" ;
},
{},
[],
5,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

} forEach _SUPPARS ;

_SUPPVEH = nearestobjects [Centerposition,["Box_NATO_AmmoVeh_F"],40000] ;
{

[ _x,
"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>REARM Vehicles",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
[(_this select 0)] execVM "Scripts\REARMVEH.sqf" ;
},
{},
[],
10,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

} forEach _SUPPVEH ;

[[west,"HQ"], "Supply Stations Initialized Successfully ..."] remoteExec ["sideChat", 0];


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
_VEHs = nearestobjects [Centerposition,[
F_Heli_01,
F_Heli_02,
F_Heli_03,
F_Heli_04,
F_Heli_05
],40000] ;

{(group (driver _x)) setVariable ["Vcm_Disable",true]; } forEach _VEHs ; 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_objectLoc = nearestobjects [Centerposition, ["rhsusf_stryker_m1126_m2_d", "rhsusf_stryker_m1126_mk19_d", "rhsusf_stryker_m1134_d"], 40000]; 
{[_x,["Tan",1]] call BIS_fnc_initVehicle;} forEach _objectLoc;

_TVC = nearestobjects [Centerposition, ["rhsusf_mrzr4_d"], 40000]; 
if (((markerText "Friendly_Handle" == "United States Armed Forces _ Woodland _ CUP + RHS") or (markerText "Friendly_Handle" == "United States Armed Forces _ Woodland _ RHS")) && (count _TVC > 0)) then {[_x,["mud_olive",1]] call BIS_fnc_initVehicle;} forEach _TVC;
 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{ _LOG = nearestObjects [Centerposition, ["Sign_Pointer_Blue_F" , "Land_InvisibleBarrier_F", "LocationCityCapital_F", "LocationCity_F", "Sign_Pointer_Blue_F" ], 40000]; {deleteVehicle _x} forEach _LOG ; } remoteExec ["call", 0];

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
sleep 5 ; 

  _AAAs = nearestObjects [Centerposition, ["O_Radar_System_02_F","O_SAM_System_04_F","vn_o_nva_navy_static_v11m", "vn_o_pl_static_zpu4"], 40000];
  {createVehicleCrew _x; } forEach _AAAs ; 




