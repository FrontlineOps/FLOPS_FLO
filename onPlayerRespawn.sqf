
removeAllActions player;

 player setDamage 0; 
  player setVariable ["ais_stabilized", true, true];
  player setVariable ["ais_unconscious", false, true];

  player setVariable ["ais_fireDamage", 0]; 
 
 [player] remoteExecCall ["AIS_System_fnc_restoreFaks", player, false]; 
 
  [true] remoteExec ["showHud", player]; 
   [true] remoteExecCall ["AIS_Effects_fnc_toggleRadio", player, false]; 
 
  player stop false; 
 player enableAI "all";    

 
		player call AIS_Effects_fnc_removeinjuredMarker;
			[player, 50] call AIS_system_fnc_reveal;

 [player, false] remoteExec ["setCaptive", 0, false]; 
  
 ["GetOutMan"] remoteExec ["removeAllEventHandlers", player, false];
 

if ((typeOf  player == F_Recon_Eod) || (typeOf  player == F_Recon_Med) || (typeOf  player == F_Recon_Eng) ||  (typeOf  player == F_Recon_Mg) || (typeOf  player == F_Recon_AT) || (typeOf  player == F_Recon_Mrk) || (typeOf  player == F_Recon_TL) || (typeOf player == "B_G_Soldier_TL_F")) then {
[
	player,											
	'H.A.L.O',										
	'Screens\FOBA\iconParachute_ca.paa',	
	'Screens\FOBA\iconParachute_ca.paa',	
	' (getPosATL vehicle player) select 2 > 500 ',					
	'true',					
	{},												
	{},												
	{ 

{_x setPos ((getPos (vehicle player)) vectorAdd [(0 + (random 10)),(0 + (random 10)),(0 - (random 10))])} forEach units group player;
_Height = Position player select 2 ;
{[_x,_Height] spawn BIS_fnc_halo} forEach units group player;
	{ unassignvehicle _x;} forEach units group player;
playMusic 'LeadTrack02_F_Mark';
[player] execVM "Scripts\HALO.sqf"; 

	},				
	{},													
	[],													
	3,													
	0,													
	false,												
	false												
] call BIS_fnc_holdActionAdd;	

};

if ((typeOf player == F_Assault_Uav) || (typeOf player == F_Assault_Med) || (typeOf player == F_Assault_AT) || (typeOf player == F_Assault_Amm) || (typeOf player == F_Assault_Mg) || (typeOf player == F_Assault_Eod) || (typeOf player == F_Assault_Mrk) || (typeOf player == F_Assault_SL) || (typeOf player == F_Assault_TL) || (typeOf player == "B_G_Soldier_SL_F")) then {
[ player,   
 "<img size=2 color='#FFE496' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#FFE496'>Deploy Sandbags",   
'',   
'',   
'_target  == player',          
'_caller distance _target < 1',     
{player playMove "AinvPknlMstpSnonWnonDnon_medic_1" ; },   
{},   
{  
_pos =  player getRelPos [1, 0];  
_dir = getDirVisual player + 180;  
_veh = createVehicle ["Land_BagFence_Round_F", _pos, [], 0, "CAN_COLLIDE"];  
_veh setDir _dir;
_veh setVectorUp [0,0,1];
},   
{},   
[],   
6,   
5,   
false,   
false   
] call BIS_fnc_holdActionAdd;	


};

if ((typeOf player == F_Diver_Eod) || (typeOf player == F_Diver_Rfl) || (typeOf player == F_Diver_TL) || (typeOf player == "B_T_Diver_F")) then {
[player] call EtV_Actions; 

};

// if ((typeOf player == F_Assault_Eng)  || (typeOf player == "B_G_engineer_F")  || (typeOf player == F_Recon_Eng)) then {
// [ player,
// "<img size=2 color='#f37c00' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa'/><t font='PuristaBold' color='#f37c00'>REPAIR Vehicles",
// "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa",
// "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa",
// 	"_this distance _target < 5",			
// 	"_caller distance _target < 5",	
// {(_this select 0) playMove "AinvPknlMstpSnonWnonDnon_medic_1" ; },
// {},
// {
// [(_this select 0)] execVM "Scripts\REPAIRVEH.sqf" ;
// },
// {},
// [],
// 10,
// 1,
// false,
// false
// ] remoteExec ["BIS_fnc_holdActionAdd",0,true];  
// };

// if ((typeOf player == F_Assault_Amm)  || (typeOf player == "B_G_Soldier_A_F")) then {
// [ player,
// "<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>REARM Infantry",
// "Screens\FOBA\mg_ca.paa",
// "Screens\FOBA\mg_ca.paa",
// 	"_this distance _target < 5",			
// 	"_caller distance _target < 5",	
// {(_this select 0) playMove "AinvPknlMstpSnonWnonDnon_medic_1" ; },
// {},
// {
// [(_this select 0)] execVM "Scripts\REARM.sqf" ;
// },
// {},
// [],
// 5,
// 1,
// false,
// false
// ] remoteExec ["BIS_fnc_holdActionAdd",0,true];   
// } ;

// if ((typeOf player == F_Recon_Med)  || (typeOf player == F_Assault_Med)  || (typeOf player == "B_G_medic_F")  || (typeOf player == "B_CTRG_soldier_M_medic_F")) then {
// [player,[
// 	"<img size=2 color='#0bff00' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa'/><t font='PuristaBold' color='#0bff00'>HEAL Infantry",
// {
// (_this select 0) playMove "AinvPknlMstpSnonWnonDnon_medic_1" ; 
// [(_this select 0)] execVM "Scripts\HEAL.sqf" ;
// },
// 	nil,
// 	0,
// 	true,
// 	true,
// 	"",
// 	"_this distance _target < 5", // _target, _this, _originalTarget
// 	5,
// 	false,
// 	"",
// 	""
// ]] remoteExec ["addAction",0,true]; 
// } ;

sleep 1 ;

			private _headlessClients = entities "HeadlessClient_F";
			private _humanPlayers = allPlayers - _headlessClients;
			hcRemoveAllGroups player;  
			 {player hcRemoveGroup _x ;} forEach (allGroups select {side _x == west}); 
			 _GRPs = (allGroups select {(side _x == (side player)) && !(((units _x) select 0) in switchableUnits)}); 
			if (count _humanPlayers == 1 ) then {
			{player hcSetGroup [_x];} forEach _GRPs;
			}else{
			{TheCommander hcSetGroup [_x];} forEach _GRPs;
			};

player addAction
	[
	"<t color='#7CC2FF'>" + localize "STR_KPPLM_ACTIONOPEN" + "</t>",
    {[] call KPPLM_fnc_openDialog;},
	nil,
    -803,
	true,		
	true,		
	"",			
	"true", 	
	5,			
	false,		
	"",			
	""			
];
   
   (_this select 1) setPos [0,0,0] ;
   deleteVehicle (_this select 1);
   
   
BIS_DeathBlur ppEffectAdjust [0.0]; 
BIS_DeathBlur ppEffectCommit 0.0;

sleep 1;


if ((serverCommandAvailable "#kick")  &&  (serverCommandAvailable "#debug")) then {
	
	{unassignCurator ZEUS;} remoteExec ["call", 2];

ZEUSNetworkId = clientOwner;
publicVariable "ZEUSNetworkId";

	{		
		_ZEUSPLYOBJ = allPlayers select {owner _x == ZEUSNetworkId};	
		(_ZEUSPLYOBJ select 0) assignCurator ZEUS;
		
	} remoteExec ["call", 2]; 
  
 }; 




ShowHUD [true, true, true, true, true, true, true, true, true, true];

BIS_DeathBlur ppEffectAdjust [0.0]; 
BIS_DeathBlur ppEffectCommit 0.0;


if (isNil "RESPAWN_IS_FORCED" || RESPAWN_IS_FORCED == false) then {
	private _OLDGRP = group player ;

	[player] join grpNull ;

	player setUnitLoadout (player getVariable ["Respawn_Saved_Loadout",[]]);

	if (count ((units _OLDGRP) select {alive _x == true}) > 0) then {
			GNRT = "YES" ;
			DVRT = "NO" ;
			0 = [] spawn {
				_result = ["REJOIN YOUR TEAM ?", "", DVRT, GNRT,nil, false, false] call BIS_fnc_guiMessage;

							if (_result) then {
							} ;

							if (!_result) then {
							[player] join _OLDGRP ;	
							group player selectLeader player;						
							};
			};
	};
} else {
	RESPAWN_IS_FORCED = false;
}

if (markerText "Revive_Handle" == "Activate") then {  {[_x] call AIS_System_fnc_loadAIS;} forEach Units group player; };
