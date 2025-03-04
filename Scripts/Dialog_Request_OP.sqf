createDialog "supr_RequestsMenu";
waitUntil {dialog};

if ( ((typeOf player == "B_G_officer_F") or (typeOf player == F_Officer) or (leader group player == player)) or (isServer) or (player == TheCommander) or ((serverCommandAvailable '#kick') && (serverCommandAvailable '#debug')) ) then {
	
_txt = format ["35$ UAV %1", "B_UAV_01_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_UAV_01_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\uav_05_icon_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

if (isClass (configfile >> "CfgFactionClasses" >> "BLU_NATO_lxWS") == true ) then {
_txt = format ["35$ UAV %1", "B_UAV_02_lxWS"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_UAV_02_lxWS"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\uav_05_icon_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];
};


_txt = format ["35$ UGV %1", "B_UGV_02_Demining_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_UGV_02_Demining_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\portrait_UGV_01_CA.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];


_txt = format ["35$ CONTAINER %1", "B_Slingload_01_Medevac_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_Slingload_01_Medevac_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\container_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["35$ CONTAINER %1", "B_Slingload_01_Ammo_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_Slingload_01_Ammo_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\container_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["100$ CONTAINER %1", "B_Slingload_01_Repair_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,0.6,0,1]];   
lbSetData [2103, _index, "B_Slingload_01_Repair_F"];             
lbSetValue [2103, _index, 100];             
lbSetPictureRight [2103, _index, "Screens\FOBA\container_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,0.6,0,1]];

_txt = format ["35$ CONTAINER %1", "B_Slingload_01_Fuel_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_Slingload_01_Fuel_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\container_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["35$ STATIC %1", "B_W_Static_Designator_01_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_W_Static_Designator_01_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["45$ STATIC %1", "B_HMG_01_A_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_HMG_01_A_F"];             
lbSetValue [2103, _index, 45];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["45$ STATIC %1", "B_GMG_01_A_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_GMG_01_A_F"];             
lbSetValue [2103, _index, 45];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["45$ STATIC %1", F_turret_01];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, F_turret_01];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["35$ STATIC %1", F_turret_02];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, F_turret_02];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["35$ STATIC %1", F_turret_03];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, F_turret_03];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

if (F_Art_00 != "") then { 
_txt = format ["35$ STATIC %1", F_Art_00];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, F_Art_00];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];
};


_txt = format ["35$ SUPPLIES %1", "B_CargoNet_01_ammo_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_CargoNet_01_ammo_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\box_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];


_txt = format ["35$ SUPPLIES %1", "Box_NATO_AmmoVeh_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "Box_NATO_AmmoVeh_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\box_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

};

//////INFORMATION/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_Money = markerText "Money_Handle" ;

_mrkrs = allMapMarkers select {markerColor _x == "Color4_FD_F"};
_mrkr = _mrkrs select 0;
_REPSCORE = parseNumber (markerText _mrkr) ;  
_rep = "Friendly";
if (_REPSCORE < 7) then {
_rep = "Enemy";
};
if ((_REPSCORE < 11) && (_REPSCORE > 6)) then {
_rep = "Neutral";
};	
if (_REPSCORE > 10) then {
_rep = "Friendly";
};	


_agr = "100";
_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_AGGRSCORE = parseNumber (markerText _mrkr) ;  
_agr = _AGGRSCORE * 6.25;

		ctrlSetText [1000, format["Resources : %1 ", _Money]];
		ctrlSetText [1001, format["Resistance : %1 ",  _rep ]];
		ctrlSetText [1002, format["Aggression : %1 %2 ",  _agr, "%" ]];
		sleep 0.066;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

INF_REQUEST = {

    _CTRL = 2100;
	_index = lbCurSel _CTRL;
	_Name = lbData [_CTRL, _index];
    _Cost = lbValue [_CTRL, _index];
   	_SQDName = missionNamespace getVariable _Name;


_FOBB = nearestObjects [position player, [F_OP_01], 150] select 0;
_pos = _FOBB getRelPos [13, 270];

_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  
if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;




if (_Cost == 3) then {

NEWUNIT = group player createUnit [_SQDName, _pos, [], 0, "FORM"];
publicVariable "NEWUNIT";

[NEWUNIT,'MENU_COMMS_SUPPLYDROP',nil,nil,''] call BIS_fnc_addCommMenuItem;
[NEWUNIT,'MENU_COMMS_UAV_RECON',nil,nil,''] call BIS_fnc_addCommMenuItem;
[NEWUNIT,'MENU_COMMS_CAS_HELI',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[NEWUNIT,'MENU_COMMS_ARTI',nil,nil,''] call BIS_fnc_addCommMenuItem;	

NEWUNIT linkItem 'B_UavTerminal';
NEWUNIT addItem 'optic_Hamr';
	
//{ [NEWUNIT] execVM "Scripts\LDTInit.sqf" ; } remoteExec ["call", 2];

}else{
	
GRPReq = [_pos, west, _SQDName] call BIS_fnc_spawnGroup;
publicVariable "GRPReq";


{
[_x,'MENU_COMMS_SUPPLYDROP',nil,nil,''] call BIS_fnc_addCommMenuItem;
[_x,'MENU_COMMS_UAV_RECON',nil,nil,''] call BIS_fnc_addCommMenuItem;
[_x,'MENU_COMMS_CAS_HELI',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[_x,'MENU_COMMS_ARTI',nil,nil,''] call BIS_fnc_addCommMenuItem;	
} foreach Units GRPReq;

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
			
{_x enableAI 'RADIOPROTOCOL';} foreach Units GRPReq;


//{	{[_x] execVM "Scripts\LDTInit.sqf" ; } forEach Units GRPReq ;  } remoteExec ["call", 2];
{_x enableAI 'RADIOPROTOCOL'} foreach Units GRPReq;
	closeDialog 0;
{
		
		_x setUnitTrait ["engineer", true];
_x setVariable ["ACE_isEngineer", true];

} forEach (Units GRPReq select { (typeOf _x == F_Assault_Eng)  || (typeOf _x == "B_G_engineer_F")  || (typeOf _x == F_Recon_Eng)  || (typeOf _x == "B_CTRG_soldier_engineer_exp_F")} ) ;

{
	
	_x setUnitTrait ["explosiveSpecialist", true];
_x setVariable ["ACE_isEOD", true];
} forEach (Units GRPReq select {(typeOf _x == F_Assault_Eod)  || (typeOf _x == F_Recon_Eod) || (typeOf _x == "B_CTRG_soldier_engineer_exp_F") || (typeOf _x == "B_G_Soldier_exp_F")} ) ;

	{
					_x setUnitTrait ["medic", true];
_x setVariable ["ace_medical_medicclass",2, true];

} forEach (Units GRPReq select { (typeOf _x == F_Recon_Med)  || (typeOf _x == F_Assault_Med)  || (typeOf _x == "B_G_medic_F")  || (typeOf _x == "B_CTRG_soldier_M_medic_F") } ) ;


{
	
	_x setUnitTrait ["explosiveSpecialist", true];
_x setVariable ["ACE_isEOD", true];
} forEach (Units GRPReq select {(typeOf _x == F_Assault_Eod)  || (typeOf _x == F_Recon_Eod) || (typeOf _x == "B_CTRG_soldier_engineer_exp_F") || (typeOf _x == "B_G_Soldier_exp_F")} ) ;


}; }else{ 
   
  hint "Not enough Resources"; 
   	closeDialog 0;
  };



};


VEH_REQUEST = {

    _CTRL = _this select 0;
	_index = lbCurSel _CTRL;
	_VehName = lbData [_CTRL, _index];
    CostV = lbValue [_CTRL, _index];

_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  
if (_Money >= CostV) then {
_NewMoney = _Money - CostV; 
_mrkr setMarkerText str _NewMoney;


_pos = [getPosATL player select 0, getPosATL player select 1, (getPosATL player select 2) + 100];
CreatedVEH = createVehicle [_VehName,_pos,[],0,'NONE'];


if ((_VehName == "rhsusf_stryker_m1126_m2_d") or (_VehName == "rhsusf_stryker_m1126_mk19_d") or (_VehName == "rhsusf_stryker_m1134_d")) then {
[CreatedVEH,["Tan",1]] call BIS_fnc_initVehicle;
};

if (((markerText "Friendly_Handle" == "United States Armed Forces _ Woodland _ CUP + RHS") or (markerText "Friendly_Handle" == "United States Armed Forces _ Woodland _ RHS")) && (_VehName == "rhsusf_mrzr4_d") ) then {[CreatedVEH,["mud_olive",1]] call BIS_fnc_initVehicle;};

if (_VehName == "B_Slingload_01_Repair_F") then {
[CreatedVEH,[
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
};

if (_VehName == "B_CargoNet_01_ammo_F") then {
CreatedVEH addMagazineCargoGlobal  ["DemoCharge_Remote_Mag", 20];
CreatedVEH addMagazineCargoGlobal  ["APERSBoundingMine_Range_Mag", 7];
CreatedVEH addMagazineCargoGlobal  ["APERSMine_Range_Mag", 7];
CreatedVEH addMagazineCargoGlobal  ["ClaymoreDirectionalMine_Remote_Mag", 7];
CreatedVEH addMagazineCargoGlobal  ["SLAMDirectionalMine_Wire_Mag", 7];
CreatedVEH addMagazineCargoGlobal   ["B_IR_Grenade", 7];
CreatedVEH addMagazineCargoGlobal   ["SmokeShell", 7];
CreatedVEH addMagazineCargoGlobal   ["HandGrenade", 7];
CreatedVEH addBackpackCargoGlobal ["B_UAV_01_backpack_F", 2];
CreatedVEH addBackpackCargoGlobal ["B_Static_Designator_01_weapon_F", 2];
CreatedVEH addBackpackCargoGlobal ["B_W_Static_Designator_01_weapon_F", 2];
CreatedVEH addBackpackCargoGlobal ["B_UGV_02_Demining_backpack_F", 2];
CreatedVEH addBackpackCargoGlobal ["B_Patrol_Respawn_bag_F", 2];
CreatedVEH addWeaponCargoGlobal ["launch_B_Titan_tna_F", 5];
CreatedVEH addWeaponCargoGlobal ["launch_B_Titan_F", 5];
CreatedVEH addWeaponCargoGlobal ["launch_B_Titan_short_F", 5];
CreatedVEH addWeaponCargoGlobal ["launch_I_Titan_short_F", 5];
CreatedVEH addWeaponCargoGlobal ["launch_NLAW_F", 5];
CreatedVEH addMagazineCargoGlobal ["NLAW_F", 15];
CreatedVEH addMagazineCargoGlobal ["MRAWS_HEAT_F", 15];
CreatedVEH addMagazineCargoGlobal ["Titan_AT", 15];
CreatedVEH addMagazineCargoGlobal ["Titan_AA", 15];
CreatedVEH addMagazineCargoGlobal ["Titan_AP", 15];

[ CreatedVEH,
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

[ CreatedVEH,
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
1,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

};


_MOBSERName = missionNamespace getVariable "F_Truck_04";
if (_VehName == _MOBSERName) then {
[CreatedVEH, -1, west, "LIGHT"] execVM "R3F_LOG\USER_FUNCT\init_creation_factory.sqf" ;
[ CreatedVEH,
"<img size=2 color='#f37c00' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa'/><t font='PuristaBold' color='#f37c00'>REPAIR Vehicles",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
[(_this select 0)] execVM "Scripts\REPAIRVEH.sqf" ;
},
{},
[],
10,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true]; 
};
	
_MOBSERName = missionNamespace getVariable "F_Truck_03";
if (_VehName == _MOBSERName) then {
	
[ CreatedVEH,
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

[ CreatedVEH,
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

[ CreatedVEH,
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

};

CursorTracker = true ;
CreatedVEH enableSimulation false ;
CreatedVEH allowDammage false ;
CreatedVEHREF = createVehicle ["Sign_Sphere10cm_F",screenToWorld [ 0.5, 0.5 ],[],0,"NONE"] ;
CreatedVEHREF hideObjectGlobal true ;
CreatedVEHREF allowDammage false ;
CreatedVEH attachTo [CreatedVEHREF, [0, 0, 3]] ;
[] spawn {  
  while {CursorTracker == true} do {  
  CreatedVEHREF setVehiclePosition [ screenToWorld [ 0.5, 0.5 ], [], 0, "CAN_COLLIDE"];
  CreatedVEHREF setDir ((getDirVisual player) + 230);
  sleep 0.3;
  };
};


Ind01 = [ player,
"<t color='#FF0000'>CANCEL</t>",
'Screens\FOBA\iconRepairAt_ca.paa',
'Screens\FOBA\iconRepairAt_ca.paa',
'true',       
'true',  
{},
{},
{
detach CreatedVEH; 
CreatedVEH enableSimulation true;
deleteVehicle CreatedVEH;
_mrkrs = allMapMarkers select {markerColor _x == 'Color2_FD_F'};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  
_NewMoney = _Money + CostV; 
_mrkr setMarkerText str _NewMoney;
deleteVehicle CreatedVEHREF;
player removeAction Ind01;
player removeAction Ind02;
player removeAction Ind03;
},
{},
[],
3,
0,
false,
false
] call BIS_fnc_holdActionAdd; 

Ind02 = [ player,
"<t color='#FF0000'>PLACE (crew)</t>",
'Screens\FOBA\iconRepairAt_ca.paa',
'Screens\FOBA\iconRepairAt_ca.paa',
'true',       
'true',  
{},
{},
{
detach CreatedVEH; 
CreatedVEH setVehiclePosition [ getPos CreatedVEHREF, [], 0, "CAN_COLLIDE"];
CreatedVEH enableSimulation true;
CursorTracker = false ;
deleteVehicle CreatedVEHREF;
CreatedVEH enableSimulation true;
CreatedVEH allowDammage true ;
player removeAction Ind01;
player removeAction Ind02;
player removeAction Ind03;

_vehicleConfig = (configFile >> "CfgVehicles" >> typeOf CreatedVEH);
_crewType = [west, _vehicleConfig] call BIS_fnc_selectCrew;
_CrewFull = createVehicleCrew CreatedVEH ;
_CrewSelCnt = count (units _CrewFull) - 1; 
deleteVehicleCrew CreatedVEH;
_Group = createGroup West ; 
for "_x" from 0 to _CrewSelCnt do { _unit = _Group createunit [_crewType,[0,0,0], [], 0, "CAN_COLLIDE"]; }; 
{_x moveInAny CreatedVEH} foreach units _Group;  
	{ [_x] JoinSilent _Group } foreach units _Group;  
	
_H1Name = missionNamespace getVariable "F_Heli_01";
_H2Name = missionNamespace getVariable "F_Heli_02";
_H3Name = missionNamespace getVariable "F_Heli_03";
_H4Name = missionNamespace getVariable "F_Heli_04";
_H5Name = missionNamespace getVariable "F_Heli_05";
_H5Name = missionNamespace getVariable "F_Heli_05";

if (typeOf CreatedVEH == _H1Name or typeOf CreatedVEH == _H2Name or typeOf CreatedVEH == _H3Name or typeOf CreatedVEH == _H4Name or typeOf CreatedVEH == _H5Name) then {_Group setVariable ["Vcm_Disable",true]; };
TheCommander hcSetGroup [_Group];
},
{},
[],
3,
0,
false,
false
] call BIS_fnc_holdActionAdd; 

Ind03 = [ player,
"<t color='#FF0000'>PLACE </t>",
'Screens\FOBA\iconRepairAt_ca.paa',
'Screens\FOBA\iconRepairAt_ca.paa',
'true',       
'true',  
{},
{},
{
detach CreatedVEH; 
CreatedVEH setVehiclePosition [ getPos CreatedVEHREF, [], 0, "CAN_COLLIDE"];
CreatedVEH enableSimulation true;
CursorTracker = false ;
deleteVehicle CreatedVEHREF;
CreatedVEH enableSimulation true;
CreatedVEH allowDammage true ;
player removeAction Ind01;
player removeAction Ind02;
player removeAction Ind03;
},
{},
[],
3,
0,
false,
false
] call BIS_fnc_holdActionAdd; 

}else{hint "Not Enough Resources";};

	
	closeDialog 0;

};







































































   
