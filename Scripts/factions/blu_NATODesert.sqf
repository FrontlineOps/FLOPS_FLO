F_Officer = "B_officer_F";

F_Assault_Eng = "B_engineer_F";
F_Assault_TL = "B_Soldier_TL_F";
F_Assault_SL = "B_Soldier_SL_F";
F_Assault_Eod = "B_soldier_exp_F";
F_Assault_Mrk = "B_Sharpshooter_F";
F_Assault_LAT = "B_soldier_LAT_F";
F_Assault_AT = "B_soldier_AT_F";
F_Assault_AA = "B_soldier_AA_F";
F_Assault_Amm = "B_Soldier_A_F";
F_Assault_Mg = "B_soldier_AR_F";
F_Assault_Med = "B_medic_F";
F_Assault_Uav= "B_soldier_UAV_F";


F_Recon_Snp = "B_Recon_Sharpshooter_F";
F_Recon_Sct = "B_recon_F";

F_Recon_TL = "B_Patrol_Soldier_TL_F";
F_Recon_Mrk = "B_Patrol_Soldier_M_F";
F_Recon_AT = "B_recon_LAT_F";
F_Recon_Mg = "B_Patrol_Soldier_MG_F";
F_Recon_Eod = "B_recon_exp_F";
F_Recon_Med = "B_Patrol_Medic_F";
F_Recon_Eng = "B_Patrol_Engineer_F";

F_Diver_TL = "B_diver_TL_F";
F_Diver_Rfl = "B_diver_F";
F_Diver_Eod = "B_diver_exp_F";

if (isClass (configfile >> "CfgFactionClasses" >> "mas_nat_actrg") == true ) then {
F_Recon_TL = "B_mas_natctrg_recon_TL_F";
F_Recon_Mrk = "B_mas_natctrg_recon_M_F";
F_Recon_AT = "B_mas_natctrg_recon_LAT_F";
F_Recon_Mg = "B_mas_natctrg_recon_AR_F";
F_Diver_TL = "B_mas_natctrg_recon_TL_diverU_F";
F_Diver_Rfl = "B_mas_natctrg_recon_exp_diverU_F";
		}; 

/// DETERMINES WHAT UNITS ARE IN REQUEST LIST
F_ALL_INF = [
	F_Assault_Eng,
	F_Assault_TL,
	F_Assault_SL,
	F_Assault_Eod,
	F_Assault_Mrk,
	F_Assault_LAT,
	F_Assault_AT,
	F_Assault_AA,
	F_Assault_Amm,
	F_Assault_Mg,
	F_Assault_Med,
	F_Assault_Uav,
	F_Recon_Snp,
	F_Recon_Sct,
	F_Recon_TL,
	F_Recon_Mrk,
	F_Recon_AT,
	F_Recon_Mg,
	F_Recon_Eod,
	F_Recon_Med,
	F_Recon_Eng,
	F_Diver_TL,
	F_Diver_Rfl,
	F_Diver_Eod
];

F_ALL_GROUND = [
	["B_Radar_System_01_F", 100],  
	["B_Quadbike_01_F", 100],
	["B_T_UAV_03_dynamicLoadout_F", 100],
	["B_UGV_01_rcws_F", 100],
	["B_HMG_01_high_F", 100],
	["B_GMG_01_high_F", 100],
	["B_static_AT_F", 100],
	["B_LSV_01_unarmed_F", 100],
	["B_LSV_01_armed_F", 100],
	["B_LSV_01_AT_F", 100],
	["B_MRAP_01_F", 100],
	["B_MRAP_01_hmg_F", 100],
	["B_MRAP_01_gmg_F", 100],
	["B_Truck_01_transport_F", 100],
	["B_Truck_01_fuel_F", 100],
	["B_Truck_01_ammo_F", 100],
	["B_Truck_01_Repair_F", 100],
	["B_Truck_01_medical_F", 100],
	["B_APC_Tracked_01_rcws_F", 100],
	["B_APC_Tracked_01_AA_F", 100],
	["B_APC_Tracked_01_CRV_F", 100],
	["B_APC_Wheeled_01_cannon_F", 100],
	["B_AFV_Wheeled_01_up_cannon_F", 100],
	["B_MBT_01_TUSK_F", 100],
	["B_Mortar_01_F", 100],
	["B_MBT_01_arty_F", 100],
	["B_MBT_01_mlrs_F", 100]
];

F_ALL_AIR = [
	["B_Boat_Armed_01_minigun_F", 100],
	["B_UAV_02_dynamicLoadout_F", 100],
	["B_UAV_05_F", 100],
	["B_Heli_Light_01_F", 100],
	["B_Heli_Light_01_dynamicLoadout_F", 100],
	["B_Heli_Transport_01_F", 100],
	["B_Heli_Transport_03_F", 100],
	["B_Heli_Attack_01_dynamicLoadout_F", 100],
	["B_Plane_CAS_01_dynamicLoadout_F", 100],
	["B_Plane_Fighter_01_F", 100],
	["B_T_VTOL_01_infantry_F", 100],
	["B_T_VTOL_01_vehicle_F", 100],
	["B_T_VTOL_01_armed_F", 100]
];

//// DETERMINES WHAT GROUPS ARE IN REQUEST LIST
//Each Array : [NAME, Unit Classes ARRAY, Cost (tokens or points - token = roughly 100 pts), PRIORITY Use case ]
//				PRIORITY = [Defend, Attack, Patrol, Occupy, Recon, Support, Capture, Destroy] 
//    			value from 0 to 3 where 0 = never, 1 = last resort, 2 = normal and 3 is priority 
F_ALL_INF_GROUPS = [
		["Engineers", 	
			[F_Assault_Eng, F_Assault_AT, F_Assault_Eod, F_Assault_Mg],
			100,
			[0,0,0,0,0,0,0,3]
		],
		["Defense Team",		
			[F_Assault_TL, F_Assault_Amm, F_Assault_SL, F_Assault_Mg, F_Assault_Med, F_Assault_Mrk, F_Assault_Med, F_Assault_Amm],
			200,
			[3,0,0,3,0,0,0,0]
		],
		["Defense Team AT",		
			[F_Assault_TL, F_Assault_Amm, F_Assault_AT, F_Assault_Mg, F_Assault_Med, F_Assault_AT],
			150,
			[3,0,0,0,0,0,0,0]
		],
		["Defense Team AA",		
			[F_Assault_TL, F_Assault_Amm, F_Assault_AA, F_Assault_Mg, F_Assault_Med, F_Assault_AA],
			150,
			[3,0,0,0,0,0,0,0]
		],
		["Assault Team",		
			[F_Assault_TL, F_Assault_Amm, F_Assault_LAT, F_Assault_Mg, F_Assault_Med],
			125,
			[1,3,3,0,0,0,2,0]
		],
		["Assault Squad",		
			[F_Assault_SL, F_Assault_Eod, F_Assault_AT, F_Assault_Mg, F_Assault_Med, F_Assault_Amm, F_Assault_Eng, F_Assault_Mrk, F_Assault_AT, F_Assault_Mg, F_Assault_Med, F_Assault_AA],
			300,
			[1,3,0,0,0,0,2,0]
		],
		["Sniper Team",			
			[F_Recon_Snp, F_Recon_Sct],
			75,
			[1,3,3,1,3,0,0,0]
		],
		["Recon Team",			
			[F_Recon_TL, F_Recon_AT, F_Recon_Med, F_Recon_Mg, F_Recon_Eod],
			150,
			[0,2,2,0,2,0,0,1]
		],
		["Recon Squad",			
			[F_Recon_TL, F_Recon_AT, F_Recon_Eod, F_Recon_Mg, F_Recon_Eng, F_Recon_Mrk, F_Recon_Med],
			200,
			[0,2,2,0,3,0,0,1]
		],
		["Officer Team",		
			[F_Officer, F_Assault_Amm],
			50,
			[0,0,0,0,0,2,3,0]
		]
	];

F_ALL_VEH_GROUPS = [ 
	["LSV AT Section",["B_LSV_01_AT_F","B_LSV_01_AT_F"], 100 ,[2,2,0,0,0,0,0,0]],
	["Motorized Recon",["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F"],  100 ,[1,1,0,0,3,0,0,0]],
	["Support Platoon",["B_Truck_01_fuel_F","B_Truck_01_ammo_F","B_Truck_01_Repair_F","B_Truck_01_medical_F"],  100,[0,0,0,0,0,3,0,0]],
	["APC RCWS Section",["B_APC_Tracked_01_rcws_F","B_APC_Tracked_01_rcws_F"],  100 ,[2,2,0,0,0,0,0,0]],
	["AA Section",["B_APC_Tracked_01_AA_F","B_APC_Tracked_01_AA_F"],  100 ,[3,1,0,0,0,0,0,0]],
	["APC Section",["B_APC_Wheeled_01_cannon_F","B_APC_Wheeled_01_cannon_F"],  100 ,[2,2,0,0,0,0,0,0]],
	["TUSK Section",["B_MBT_01_TUSK_F","B_MBT_01_TUSK_F"],  100 ,[2,2,0,0,0,0,0,0]],
	["Artillery Section",["B_MBT_01_mlrs_F","B_MBT_01_mlrs_F"],  100 ,[2,0,0,0,0,0,0,0]],
	["H Assault 1",["B_Heli_Light_01_dynamicLoadout_F"],  100 ,[1,3,0,0,0,0,0,0]],
	["H Assault 2",["B_Heli_Attack_01_dynamicLoadout_F"],  100 ,[1,3,0,0,0,0,0,0]],
	["P Assault CAS",["B_PlanF_CAS_01_dynamicLoadout_F"],  100 ,[1,3,0,0,0,0,0,0]],
	["P Assault CAP",["B_PlanF_Fighter_01_F"],  100 ,[1,3,0,0,0,0,0,0]]
]; 

