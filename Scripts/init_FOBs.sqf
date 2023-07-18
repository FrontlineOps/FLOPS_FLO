
 /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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


// [ _x,
// "<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>ARSENAL",
// "Screens\FOBA\mg_ca.paa",
// "Screens\FOBA\mg_ca.paa",
// 	"_this distance _target < 10",			
// 	"_caller distance _target < 10",	
// {},
// {},
// {
	
// 	if (isClass (configfile >> "ace_arsenal_loadoutsDisplay") == true ) then {
// 		[player, player, true] call ace_arsenal_fnc_openBox;
// 	} else {
// 		["Open", true] spawn BIS_fnc_arsenal;
// 	};
// },
// {},
// [],
// 1,
// 9999999,
// false,
// false
// ] remoteExec ["BIS_fnc_holdActionAdd",0,true];   



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
				_FOBB setDammage 1;
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
			_FOBB setDammage 1;
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

 /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
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
{
			remoteExec ["BSPCO_fnc_MissionSave", 2] ; 

	},
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

[ _x,
	"<img size=2 color='#ffa10d' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#ffa10d'>SELECT Unit Loadouts",
'Screens\FOBA\b_hq.paa',
'Screens\FOBA\b_hq.paa',
"((player == TheCommander) && (serverCommandAvailable '#kick') && (serverCommandAvailable '#debug')) || ((player == TheCommander) && (isServer)) || ((player == TheCommander) && (isServer))",       
'_caller distance _target < 40',  
{},
{},
{ execVM "Scripts\init_LoadOuts.sqf" ;},
{},
[],
2,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

[ _x,
	"<img size=2 color='#ffa10d' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#ffa10d'>RESET Unit Loadouts",
'Screens\FOBA\b_hq.paa',
'Screens\FOBA\b_hq.paa',
"((player == TheCommander) && (serverCommandAvailable '#kick') && (serverCommandAvailable '#debug')) || ((player == TheCommander) && (isServer)) || ((player == TheCommander) && (isServer))",       
'_caller distance _target < 40',  
{},
{},
{ execVM "Scripts\LDTReset.sqf" ;},
{},
[],
2,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   
 
 
 } foreach _FOBT;
 

 
 