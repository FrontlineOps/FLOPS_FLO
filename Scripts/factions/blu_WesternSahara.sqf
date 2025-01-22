F_Officer = "B_D_officer_lxWS";
F_Assault_Eng = "B_D_engineer_lxWS";
F_Assault_TL = "B_D_Soldier_TL_lxWS";
F_Assault_SL = "B_D_Soldier_SL_lxWS";
F_Assault_Eod = "B_D_soldier_exp_lxWS";
F_Assault_Mrk = "B_D_soldier_M_lxWS";
F_Assault_AT = "B_D_soldier_LAT_lxWS";
F_Assault_Amm = "B_D_Soldier_A_lxWS";
F_Assault_Mg = "B_D_soldier_AR_lxWS";
F_Assault_Med = "B_D_medic_lxWS";
F_Assault_Uav= "B_D_soldier_UAV01_lxWS";


F_Recon_Snp = "B_D_recon_M_lxWS";
F_Recon_Sct = "B_D_recon_lxWS";

F_Recon_TL = "B_D_recon_TL_lxWS";
F_Recon_Mrk = "B_D_recon_medic_lxWS";
F_Recon_AT = "B_D_recon_LAT_lxWS";
F_Recon_Mg = "B_D_recon_exp_lxWS";
F_Recon_Eod = "B_D_recon_exp_lxWS";
F_Recon_Med = "B_D_recon_medic_lxWS";
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


F_RADAR = "B_Radar_System_01_F";  
F_HQ_01 = "Land_Cargo_HQ_V3_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_sand_F";
F_OP_01 = "Land_Cargo_House_V3_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_sand_F" ;

F_Bike_01 = "B_D_Quadbike_01_lxWS";

F_ABT_01 = "B_Boat_Armed_01_minigun_F";

F_UAV_01 = "B_UAV_02_dynamicLoadout_F";
F_UAV_02 = "B_UAV_05_F";
F_UAV_03 = "B_T_UAV_03_dynamicLoadout_F";
F_UGV_01 = "B_D_UGV_01_rcws_lxWS";

F_turret_01 = "B_HMG_01_high_F";
F_turret_02 = "B_GMG_01_high_F";
F_turret_03 = "B_static_AT_F";

F_Car_01 = "B_LSV_01_unarmed_F";
F_Car_02 = "B_LSV_01_armed_F";
F_Car_03 = "B_LSV_01_AT_F";
F_Car_04 = "";
F_Car_05 = "";
F_Car_06 = "";

F_MRAP_01 = "B_D_MRAP_01_lxWS";
F_MRAP_02 = "B_D_MRAP_01_hmg_lxWS";
F_MRAP_03 = "B_D_MRAP_01_gmg_lxWS";
F_MRAP_04 = "";
F_MRAP_05 = "";
F_MRAP_06 = "";

F_Truck_01 = "B_D_Truck_01_transport_lxWS";
F_Truck_02 = "B_D_Truck_01_fuel_lxWS";
F_Truck_03 = "B_D_Truck_01_ammo_lxWS";
F_Truck_04 = "B_D_Truck_01_Repair_lxWS";
F_Truck_05 = "B_D_Truck_01_medical_lxWS";
F_Truck_06 = "";

F_APC_01 = "B_D_APC_Tracked_01_rcws_lxWS";
F_APC_02 = "B_D_APC_Tracked_01_CRV_lxWS";
F_APC_03 = "B_D_APC_Wheeled_01_command_lxWS";
F_APC_04 = "B_D_APC_Wheeled_01_mortar_lxWS";
F_APC_05 = "B_D_APC_Wheeled_01_atgm_lxWS";
F_APC_06 = "B_D_APC_Tracked_01_aa_lxWS";

F_TNK_01= "B_D_MBT_01_TUSK_lxWS";
F_TNK_02= "";
F_TNK_03= "";
F_TNK_04= "";

F_Art_00 = "B_Mortar_01_F";
F_Art_01 = "B_MBT_01_arty_F";
F_Art_02 = "B_MBT_01_mlrs_F";

F_Heli_01 = "B_D_Heli_Light_01_lxWS";
F_Heli_02 = "B_D_Heli_Light_01_dynamicLoadout_lxWS";
F_Heli_03 = "B_D_Heli_Transport_01_lxWS";
F_Heli_04 = "B_Heli_Transport_03_F";
F_Heli_05 = "";

F_Heli_06_G = "B_D_Heli_Attack_01_dynamicLoadout_lxWS";
F_Heli_07_G = "";

F_Plane_01_CAS = "B_D_Plane_CAS_01_dynamicLoadout_lxWS";
F_Plane_02_CAS = "B_Plane_Fighter_01_F";
F_Plane_03 = "B_T_VTOL_01_infantry_F";
F_Plane_04 = "B_T_VTOL_01_vehicle_F";
F_Plane_05 = "B_T_VTOL_01_armed_F";
F_Plane_06 = "";