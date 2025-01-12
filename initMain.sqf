_Enemy = execVM "Scripts\Enemy_Vars.sqf"; 
_Friendly = execVM "Scripts\Friendly_Vars.sqf"; 
_Civilian = execVM "Scripts\Civilian_Vars.sqf"; 

 if (markerText "Friendly_Handle" == "CUSTOM_PLAYER_FACTION") then {  _Friendly = execVM "CUSTOM_PLAYER_FACTION.sqf" };
 if (markerText "Enemy_Handle" == "CUSTOM_ENEMY_FACTION") then {  _Enemy = execVM "CUSTOM_ENEMY_FACTION.sqf" };
 if (markerText "Civilian_Handle" == "CUSTOM_CIVILIAN_FACTION") then {  _Civilian = execVM "CUSTOM_CIVILIAN_FACTION.sqf" };

waitUntil {sleep 1; scriptDone _Friendly && scriptDone _Enemy && scriptDone _Civilian }; 

if (isServer) then {
_Centerposition = [worldSize / 2, worldsize / 2, 0];
_ALLFACVEHs = nearestobjects [_Centerposition,[
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
],40000] ;

_EXCVEH = vehicles - _ALLFACVEHs ;

{

deleteVehicleCrew _x ; 
			
} foreach _EXCVEH;

};

// Data Creation
FLO_configCache = createHashMapFromArray [
    ["helipads", ["Land_HelipadCircle_F","Land_HelipadCivil_F","Heli_H_rescue","Land_HelipadRescue_F","Land_HelipadSquare_F","HeliHRescue","Heli_H_civil","HeliHCivil","HeliH"]],
    ["tyres", ["Land_Tyre_F"]],
    ["vehicles", [East_Air_Heli, East_Ground_Transport, East_Ground_Vehicles_Light, East_Ground_Vehicles_Heavy, East_Ground_Vehicles_Ambient]],
    ["units", East_Units],
    ["buildings", ["House", "Land_MilOffices_V1_F", "Land_Cargo_Tower_V3_F", "Land_Cargo_Tower_V2_F", "Land_Cargo_Tower_V1_F", "Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V2_F", "Land_Cargo_HQ_V1_F", "Land_Cargo_House_V3_F", "Land_Cargo_House_V1_F"]],
    ["bunkers", ["Land_BagBunker_Large_F", "Land_BagBunker_Small_F", "Land_Cargo_House_V3_F", "Land_Cargo_House_V1_F", "Land_Cargo_Patrol_V3_F", "Land_Cargo_Patrol_V2_F", "Land_Cargo_Patrol_V1_F"]]
];


//////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script ////////


MENU_COMMS_SUPPLYDROP =
[
	["MenuName", true],
	[parseText "<img size=1 color='#3aacff' image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa'/><t font='PuristaBold' color='#3aacff'>VEHICLE DROP QUADBIKE 75 $", [2], "", -5, [["expression", "execVM 'Scripts\SupplyDrop_QDB.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#3aacff' image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa'/><t font='PuristaBold' color='#3aacff'>VEHICLE DROP BOAT 75 $", [3], "", -5, [["expression", "execVM 'Scripts\SupplyDrop_BT.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#fff23a' image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa'/><t font='PuristaBold' color='#fff23a'>SUPPLIES VEHICLE REARM  105 $", [4], "", -5, [["expression", "execVM 'Scripts\SupplyDrop_EXP.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#fff23a' image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa'/><t font='PuristaBold' color='#fff23a'>SUPPLIES INFANTRY REARM  105 $", [5], "", -5, [["expression", "execVM 'Scripts\SupplyDrop_WPN.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]

];

MENU_COMMS_GRD =
[
	["MenuName", true],
	
	[parseText "<img size=1 color='#fff23a' image='Screens\FOBA\Offroad_01_Base_ca.paa'/><t font='PuristaBold' color='#fff23a'>(CARS) VEHICLE REINFORCEMENT  ", [2], "#USER:MENU_COMMS_CARS", -5, [], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#fff23a' image='Screens\FOBA\car_ca.paa'/><t font='PuristaBold' color='#fff23a'>(MRAPS) VEHICLE REINFORCEMENT ", [3], "#USER:MENU_COMMS_MRAPS", -5, [], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#fff23a' image='\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_Ammo_CA.paa'/><t font='PuristaBold' color='#fff23a'>(TRUCKS) VEHICLE REINFORCEMENT ", [4], "#USER:MENU_COMMS_TRUCKS", -5, [], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#fff23a' image='\A3\armor_f_beta\APC_Tracked_01\Data\UI\APC_Tracked_01_AA_ca.paa'/><t font='PuristaBold' color='#fff23a'>(APCS) VEHICLE REINFORCEMENT ", [5], "#USER:MENU_COMMS_APCS", -5, [], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#fff23a' image='Screens\FOBA\tank_ca.paa'/><t font='PuristaBold' color='#fff23a'>(TANKS) VEHICLE REINFORCEMENT ", [6], "#USER:MENU_COMMS_TANKS", -5, [], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\srifle_ca.paa'/><t font='PuristaBold' color='#ff7d00'>SUPPRESSIVE FIRE [NEAR VEHICLE] ", [7], "", -5, [["expression", "[121] execVM 'Scripts\VEHFSC.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\srifle_ca.paa'/><t font='PuristaBold' color='#ff7d00'>SUPPRESSIVE FIRE [ALL VEHICLES] ", [8], "", -5, [["expression", "[212] execVM 'Scripts\VEHFSC.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],

	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\defend_ca.paa'/><t font='PuristaBold' color='#ff7d00'>COMMAND STOP [NEAR VEHICLE] ", [9], "", -5, [["expression", "[121] execVM 'Scripts\VEHHLD.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\defend_ca.paa'/><t font='PuristaBold' color='#ff7d00'>COMMAND STOP [ALL VEHICLES]  ", [10], "", -5, [["expression", "[212] execVM 'Scripts\VEHHLD.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\defend_ca.paa'/><t font='PuristaBold' color='#ff7d00'>COMMAND MOVE [ALL VEHICLES]  ", [11], "", -5, [["expression", "[222] execVM 'Scripts\VEHHLD.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\attack_ca.paa'/><t font='PuristaBold' color='#ff7d00'>COMMAND ASSAULT [NEAR VEHICLE] ", [12], "", -5, [["expression", "[121] execVM 'Scripts\VEHASLT.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\attack_ca.paa'/><t font='PuristaBold' color='#ff7d00'>COMMAND ASSAULT [ALL VEHICLES]  ", [13], "", -5, [["expression", "[212] execVM 'Scripts\VEHASLT.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]
	
];	
	
MENU_COMMS_CARS =
[
	["MenuName", true],
	
	[  parseText ("<img size=1 color='#3aacff' image='Screens\FOBA\Offroad_01_Base_ca.paa'/><t color='#3aacff'>" + "  45 $  </t>" + F_Car_01 ) , [2], "", -5, [["expression", "['F_Car_01', 45] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='Screens\FOBA\Offroad_01_Base_ca.paa'/><t color='#3aacff'>" + "  45 $  </t>" + F_Car_02 ) , [3], "", -5, [["expression", "['F_Car_02', 45] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='Screens\FOBA\Offroad_01_Base_ca.paa'/><t color='#3aacff'>" + "  45 $  </t>" + F_Car_03 ) , [4], "", -5, [["expression", "['F_Car_03', 45] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='Screens\FOBA\Offroad_01_Base_ca.paa'/><t color='#3aacff'>" + "  45 $  </t>" + F_Car_04 ) , [5], "", -5, [["expression", "['F_Car_04', 45] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='Screens\FOBA\Offroad_01_Base_ca.paa'/><t color='#3aacff'>" + "  45 $  </t>" + F_Car_05 ) , [6], "", -5, [["expression", "['F_Car_05', 45] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='Screens\FOBA\Offroad_01_Base_ca.paa'/><t color='#3aacff'>" + "  45 $  </t>" + F_Car_06 ) , [7], "", -5, [["expression", "['F_Car_06', 45] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]
	
];	

MENU_COMMS_MRAPS =
[
	["MenuName", true],
	
	[  parseText ("<img size=1 color='#3aacff' image='Screens\FOBA\car_ca.paa'/><t color='#3aacff'>" + "  65 $  </t>" + F_MRAP_01 ) , [2], "", -5, [["expression", "['F_MRAP_01', 65] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='Screens\FOBA\car_ca.paa'/><t color='#3aacff'>" + "  65 $  </t>" + F_MRAP_02 ) , [3], "", -5, [["expression", "['F_MRAP_02', 65] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='Screens\FOBA\car_ca.paa'/><t color='#3aacff'>" + "  65 $  </t>" + F_MRAP_03 ) , [4], "", -5, [["expression", "['F_MRAP_03', 65] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='Screens\FOBA\car_ca.paa'/><t color='#3aacff'>" + "  65 $  </t>" + F_MRAP_04 ) , [5], "", -5, [["expression", "['F_MRAP_04', 65] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='Screens\FOBA\car_ca.paa'/><t color='#3aacff'>" + "  65 $  </t>" + F_MRAP_05 ) , [6], "", -5, [["expression", "['F_MRAP_05', 65] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='Screens\FOBA\car_ca.paa'/><t color='#3aacff'>" + "  65 $  </t>" + F_MRAP_06 ) , [7], "", -5, [["expression", "['F_MRAP_06', 65] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]
	
];	

MENU_COMMS_TRUCKS =
[
	["MenuName", true],
	
	[  parseText ("<img size=1 color='#3aacff' image='\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_Ammo_CA.paa'/><t color='#3aacff'>" + "  75 $  </t>" + F_Truck_01 ) , [2], "", -5, [["expression", "['F_Truck_01', 75] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_Ammo_CA.paa'/><t color='#3aacff'>" + "  75 $  </t>" + F_Truck_02 ) , [3], "", -5, [["expression", "['F_Truck_02', 75] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_Ammo_CA.paa'/><t color='#3aacff'>" + "  75 $  </t>" + F_Truck_03 ) , [4], "", -5, [["expression", "['F_Truck_03', 75] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_Ammo_CA.paa'/><t color='#3aacff'>" + "  75 $  </t>" + F_Truck_04 ) , [5], "", -5, [["expression", "['F_Truck_04', 75] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_Ammo_CA.paa'/><t color='#3aacff'>" + "  75 $  </t>" + F_Truck_05 ) , [6], "", -5, [["expression", "['F_Truck_05', 75] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_Ammo_CA.paa'/><t color='#3aacff'>" + "  75 $  </t>" + F_Truck_06 ) , [7], "", -5, [["expression", "['F_Truck_06', 75] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]
	
];	

MENU_COMMS_APCS =
[
	["MenuName", true],
	
	[  parseText ("<img size=1 color='#3aacff' image='\A3\armor_f_beta\APC_Tracked_01\Data\UI\APC_Tracked_01_AA_ca.paa'/><t color='#3aacff'>" + "  85 $  </t>" + F_APC_01 ) , [2], "", -5, [["expression", "['F_APC_01', 85] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='\A3\armor_f_beta\APC_Tracked_01\Data\UI\APC_Tracked_01_AA_ca.paa'/><t color='#3aacff'>" + "  85 $  </t>" + F_APC_02 ) , [3], "", -5, [["expression", "['F_APC_02', 85] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='\A3\armor_f_beta\APC_Tracked_01\Data\UI\APC_Tracked_01_AA_ca.paa'/><t color='#3aacff'>" + "  85 $  </t>" + F_APC_03 ) , [4], "", -5, [["expression", "['F_APC_03', 85] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='\A3\armor_f_beta\APC_Tracked_01\Data\UI\APC_Tracked_01_AA_ca.paa'/><t color='#3aacff'>" + "  85 $  </t>" + F_APC_04 ) , [5], "", -5, [["expression", "['F_APC_04', 85] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='\A3\armor_f_beta\APC_Tracked_01\Data\UI\APC_Tracked_01_AA_ca.paa'/><t color='#3aacff'>" + "  85 $  </t>" + F_APC_05 ) , [6], "", -5, [["expression", "['F_APC_05', 85] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[  parseText ("<img size=1 color='#3aacff' image='\A3\armor_f_beta\APC_Tracked_01\Data\UI\APC_Tracked_01_AA_ca.paa'/><t color='#3aacff'>" + "  85 $  </t>" + F_APC_06 ) , [7], "", -5, [["expression", "['F_APC_06', 85] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]
	
];	

MENU_COMMS_TANKS =
[
	["MenuName", true],
	
	[  parseText ("<img size=1 color='#3aacff' image='Screens\FOBA\tank_ca.paa'/><t color='#3aacff'>" + "  110 $  </t>" + F_TNK_01 ) , [2], "", -5, [["expression", "['F_TNK_01', 110] execVM 'Scripts\VEHREQ.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]
];	


MENU_COMMS_UAV_RECON =
[
	["MenuName", true],
	["Call UAV_01 80$", [2], "", -5, [["expression", "execVM 'Scripts\CallUAV1.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	["Call UAV_02 80$", [3], "", -5, [["expression", "execVM 'Scripts\CallUAV2.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	["Call UAV_03 80$", [4], "", -5, [["expression", "execVM 'Scripts\CallUAV3.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	["Call UAV AR_2 Darter 80$", [5], "", -5, [["expression", "execVM 'Scripts\CallUAV0.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]
];

MENU_COMMS_CAS_HELI =
[
	["MenuName", true],
	
	[parseText "<img size=1 color='#3aacff' image='\A3\Air_F_Beta\Heli_Transport_01\Data\UI\Heli_Transport_01_base_CA.paa'/><t font='PuristaBold' color='#3aacff'>CASEVAC HELICOPTER [LITTLE BIRD] 65$", [2], "", -5, [["expression", "['F_Heli_01', 65] execVM 'Scripts\CallTRS.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#3aacff' image='\A3\Air_F_Beta\Heli_Transport_01\Data\UI\Heli_Transport_01_base_CA.paa'/><t font='PuristaBold' color='#3aacff'>CASEVAC HELICOPTER [BLACK HAWK] 75$", [3], "", -5, [["expression", "['F_Heli_03', 75] execVM 'Scripts\CallTRS.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#3aacff' image='\A3\Air_F_Beta\Heli_Transport_01\Data\UI\Heli_Transport_01_base_CA.paa'/><t font='PuristaBold' color='#3aacff'>CASEVAC HELICOPTER [CHINOOK] 85$", [4], "", -5, [["expression", "['F_Heli_04', 85] execVM 'Scripts\CallTRS.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],

	[parseText "<img size=1 color='#fff23a' image='Screens\FOBA\plane_ca.paa'/><t font='PuristaBold' color='#fff23a'>ACE CAS [ATTACK HELICOPTER] 90$", [5], "", -5, [["expression", "['F_Heli_06_G'] execVM 'Scripts\CallCAS.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#fff23a' image='Screens\FOBA\plane_ca.paa'/><t font='PuristaBold' color='#fff23a'>ACE CAS [BOMBER AIRCRAFT] 115$", [6], "", -5, [["expression", "['F_Plane_01_CAS'] execVM 'Scripts\CallCAS.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#fff23a' image='Screens\FOBA\plane_ca.paa'/><t font='PuristaBold' color='#fff23a'>ACE CAS [FIGHTER AIRCRAFT] 115$", [7], "", -5, [["expression", "['F_Plane_02_CAS'] execVM 'Scripts\CallCAS.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\srifle_ca.paa'/><t font='PuristaBold' color='#ff7d00'>SCAR AIR STRIKE [LASER GUIDED BOMBS] 90$", [8], "", -5, [["expression", "execVM 'Scripts\CallCASB.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\srifle_ca.paa'/><t font='PuristaBold' color='#ff7d00'>SCAR AIR STRIKE [GUNS MISSILES] 90$", [9], "", -5, [["expression", "execVM 'Scripts\CallCASG.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]
];

MENU_COMMS_INF =
[
	["MenuName", true],
	[parseText "<img size=1 color='#fff23a' image='\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_Ammo_CA.paa'/><t font='PuristaBold' color='#fff23a'>ASSAULT GROUP [GROUND INSERTION] 60$", [2], "", -5, [["expression", "[111, 60] execVM 'Scripts\VEHREQTRS.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#fff23a' image='\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_Ammo_CA.paa'/><t font='PuristaBold' color='#fff23a'>RECON GROUP [GROUND INSERTION] 50$", [3], "", -5, [["expression", "[222, 50] execVM 'Scripts\VEHREQTRS.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	
	[parseText "<img size=1 color='#fff23a' image='\A3\Air_F_Beta\Heli_Transport_01\Data\UI\Heli_Transport_01_base_CA.paa'/><t font='PuristaBold' color='#fff23a'>ASSAULT GROUP [AIR INSERTION] 50$", [4], "", -5, [["expression", "execVM 'Scripts\CallTRSFA.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#fff23a' image='\A3\Air_F_Beta\Heli_Transport_01\Data\UI\Heli_Transport_01_base_CA.paa'/><t font='PuristaBold' color='#fff23a'>RECON GROUP [AIR INSERTION] 40$", [5], "", -5, [["expression", "execVM 'Scripts\CallTRSFR.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\srifle_ca.paa'/><t font='PuristaBold' color='#ff7d00'>SUPPRESSIVE FIRE  [SQUAD] ", [6], "", -5, [["expression", "execVM 'Scripts\INFSUP.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\srifle_ca.paa'/><t font='PuristaBold' color='#ff7d00'>BUILDING CLEARANCE  [SQUAD] ", [7], "", -5, [["expression", "execVM 'Scripts\INFGAR.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#ff7d00'>EQUIPMENT CHEMLIGHT ATTACHMENT [SQUAD] ", [8], "", -5, [["expression", "['Chemlight_blue'] execVM 'Scripts\INFATTLIGHT.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#ff7d00'>EQUIPMENT IR STROBE ATTACHMENT [SQUAD] ", [9], "", -5, [["expression", "['NVG_TargetC'] execVM 'Scripts\INFATTLIGHT.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#ff7d00'>EQUIPMENT IR LASER ON [SQUAD] ", [10], "", -5, [["expression", "group player enableIRLasers true;"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#ff7d00'>EQUIPMENT IR LASER OFF [SQUAD] ", [11], "", -5, [["expression", "group player enableIRLasers false;"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\icon_HMG_02_ca.paa'/><t font='PuristaBold' color='#ff7d00'>STATIC WEAPON ASSEMLE [SQUAD] ", [12], "", -5, [["expression", "[] execVM 'Scripts\INFDPLSTC.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\icon_HMG_02_ca.paa'/><t font='PuristaBold' color='#ff7d00'>STATIC WEAPON DISASSEMLE [SQUAD] ", [13], "", -5, [["expression", "[] execVM 'Scripts\INFDDPLSTC.sqf';"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]


];


MENU_COMMS_ARTI =
[
	["MenuName", true],
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\srifle_ca.paa'/><t font='PuristaBold' color='#ff7d00'>[80MM SHELLS] ARTILLERY FIRE SUPPORT 95$", [2], "#USER:MENU_COMMS_Mortars", -5, [], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\srifle_ca.paa'/><t font='PuristaBold' color='#ff7d00'>[150MM SHELLS] ARTILLERY FIRE SUPPORT 125$", [3], "#USER:MENU_COMMS_Artillery", -5, [], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
	[parseText "<img size=1 color='#ff7d00' image='Screens\FOBA\srifle_ca.paa'/><t font='PuristaBold' color='#ff7d00'>[230MM ROCKETS] ARTILLERY FIRE SUPPORT 225$", [4], "#USER:MENU_COMMS_Rockets", -5, [], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]
];

MENU_COMMS_Mortars =
[
	["[80MM SHELLS] ARTILLERY FIRE SUPPORT 60$", false],
	["82mm HE Shells X3", [2], "", -5, [["expression", "['Sh_82mm_AMOS', 3] execVM 'Scripts\CallAR.sqf';"]], "1", "1"],
	["82mm HE Shells X6", [3], "", -5, [["expression", "['Sh_82mm_AMOS', 6] execVM 'Scripts\CallAR.sqf';"]], "1", "1"],
	["82mm HE Shells X9", [4], "", -5, [["expression", "['Sh_82mm_AMOS', 9] execVM 'Scripts\CallAR.sqf';"]], "1", "1"],
	["Smoke Shells X3", [5], "", -5, [["expression", "['Smoke_82mm_AMOS_White', 3] execVM 'Scripts\CallAR.sqf';"]], "1", "1"],
	["Smoke Shells X6", [6], "", -5, [["expression", "['Smoke_82mm_AMOS_White', 6] execVM 'Scripts\CallAR.sqf';"]], "1", "1"],
	["Flares Shells X6", [7], "", -5, [["expression", "['Flare_82mm_AMOS_White', 3] execVM 'Scripts\CallAR.sqf';"]], "1", "1"]
];

MENU_COMMS_Artillery =
[
	["[150MM SHELLS] ARTILLERY FIRE SUPPORT 95$", false],
	["155mm HE Shells X3", [2], "", -5, [["expression", "['Sh_155mm_AMOS', 3] execVM 'Scripts\CallAR.sqf';"]], "1", "1"],
	["155mm HE Shells X6", [3], "", -5, [["expression", "['Sh_155mm_AMOS', 6] execVM 'Scripts\CallAR.sqf';"]], "1", "1"],
	["155mm HE Shells X9", [4], "", -5, [["expression", "['Sh_155mm_AMOS', 9] execVM 'Scripts\CallAR.sqf';"]], "1", "1"],
	["Smoke Shells X3", [5], "", -5, [["expression", "['Smoke_120mm_AMOS_White', 3] execVM 'Scripts\CallAR.sqf';"]], "1", "1"],
	["Smoke Shells X6", [6], "", -5, [["expression", "['Smoke_120mm_AMOS_White', 6] execVM 'Scripts\CallAR.sqf';"]], "1", "1"],
	["AP Mine Shells X1", [7], "", -5, [["expression", "['Mine_155mm_AMOS_range', 2] execVM 'Scripts\CallAR.sqf';"]], "1", "1"],
	["AT Mine Shells X1", [8], "", -5, [["expression", "['AT_Mine_155mm_AMOS_range', 2] execVM 'Scripts\CallAR.sqf';"]], "1", "1"],
	["Cluster Shells X1", [9], "", -5, [["expression", "['G_40mm_HEDP', 1] execVM 'Scripts\CallAR.sqf';"]], "1", "1"]
];

MENU_COMMS_Rockets =
[
	["[230MM ROCKETS] ARTILLERY FIRE SUPPORT 125$", false],
	["230mm HE Rockets  X4", [2], "", -5, [["expression", "['R_230mm_HE', 4] execVM 'Scripts\CallAR.sqf';"]], "1", "1"],
	["230mm HE Rockets  X8", [3], "", -5, [["expression", "['R_230mm_HE', 8] execVM 'Scripts\CallAR.sqf';"]], "1", "1"],
	["230mm HE Rockets  X12", [4], "", -5, [["expression", "['R_230mm_HE', 12] execVM 'Scripts\CallAR.sqf';"]], "1", "1"]
];

//////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script //////////All Script ////////

if ((isServer) && !(didJIP)) then {
	
_AIRs = nearestobjects [[0,0,0],[
F_Plane_01_CAS,
F_Plane_02_CAS,
F_Plane_03,
F_Plane_04,
F_Plane_05,
F_Plane_06
],40000] ;

{
	{
		[_x] ordergetin false; 
		unassignvehicle _x;  
		doGetOut _x;  
	 } foreach crew _x; 
} foreach  _AIRs; 

};