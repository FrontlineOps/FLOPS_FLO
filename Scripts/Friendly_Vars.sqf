//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 if (markerText "Friendly_Handle" == "NATO Forces _ Desert") then {

F_Officer = "B_officer_F";

F_Assault_Eng = "B_engineer_F";
F_Assault_TL = "B_Soldier_TL_F";
F_Assault_SL = "B_Soldier_SL_F";
F_Assault_Eod = "B_soldier_exp_F";
F_Assault_Mrk = "B_Sharpshooter_F";
F_Assault_AT = "B_soldier_LAT_F";
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

F_RADAR = "B_Radar_System_01_F";  

F_HQ_01 = "Land_Cargo_HQ_V3_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_sand_F";
F_OP_01 = "Land_Cargo_House_V3_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_sand_F" ;

F_Bike_01 = "B_Quadbike_01_F";

F_ABT_01 = "B_Boat_Armed_01_minigun_F";

F_UAV_01 = "B_UAV_02_dynamicLoadout_F";
F_UAV_02 = "B_UAV_05_F";
F_UAV_03 = "B_T_UAV_03_dynamicLoadout_F";
F_UGV_01 = "B_UGV_01_rcws_F";

F_turret_01 = "B_HMG_01_high_F";
F_turret_02 = "B_GMG_01_high_F";
F_turret_03 = "B_static_AT_F";

F_Car_01 = "B_LSV_01_unarmed_F";
F_Car_02 = "B_LSV_01_armed_F";
F_Car_03 = "B_LSV_01_AT_F";
F_Car_04 = "";
F_Car_05 = "";
F_Car_06 = "";

F_MRAP_01 = "B_MRAP_01_F";
F_MRAP_02 = "B_MRAP_01_hmg_F";
F_MRAP_03 = "B_MRAP_01_gmg_F";
F_MRAP_04 = "";
F_MRAP_05 = "";
F_MRAP_06 = "";

F_Truck_01 = "B_Truck_01_transport_F";
F_Truck_02 = "B_Truck_01_fuel_F";
F_Truck_03 = "B_Truck_01_ammo_F";
F_Truck_04 = "B_Truck_01_Repair_F";
F_Truck_05 = "B_Truck_01_medical_F";
F_Truck_06 = "";

F_APC_01 = "B_APC_Tracked_01_rcws_F";
F_APC_02 = "B_APC_Tracked_01_AA_F";
F_APC_03 = "B_APC_Tracked_01_CRV_F";
F_APC_04 = "B_APC_Wheeled_01_cannon_F";
F_APC_05 = "B_AFV_Wheeled_01_up_cannon_F";
F_APC_06 = "";

F_TNK_01= "B_MBT_01_TUSK_F";
F_TNK_02= "";
F_TNK_03= "";
F_TNK_04= "";

F_Art_00 = "B_Mortar_01_F";
F_Art_01 = "B_MBT_01_arty_F";
F_Art_02 = "B_MBT_01_mlrs_F";

F_Heli_01 = "B_Heli_Light_01_F";
F_Heli_02 = "B_Heli_Light_01_dynamicLoadout_F";
F_Heli_03 = "B_Heli_Transport_01_F";
F_Heli_04 = "B_Heli_Transport_03_F";
F_Heli_05 = "";

F_Heli_06_G = "B_Heli_Attack_01_dynamicLoadout_F";
F_Heli_07_G = "";

F_Plane_01_CAS = "B_Plane_CAS_01_dynamicLoadout_F";
F_Plane_02_CAS = "B_Plane_Fighter_01_F";
F_Plane_03 = "B_T_VTOL_01_infantry_F";
F_Plane_04 = "B_T_VTOL_01_vehicle_F";
F_Plane_05 = "B_T_VTOL_01_armed_F";
F_Plane_06 = "";

};

if (markerText "Friendly_Handle" == "NATO Forces _ Desert _ Western Sahara") then {
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

};

if (markerText "Friendly_Handle" == "NATO Forces _ Woodland") then {

F_Officer = "B_W_Officer_F";

F_Assault_Eng = "B_W_Engineer_F";
F_Assault_TL = "B_W_Soldier_TL_F";
F_Assault_SL = "B_W_Soldier_SL_F";
F_Assault_Eod = "B_W_Soldier_Exp_F";
F_Assault_Mrk = "B_W_soldier_M_F";
F_Assault_AT = "B_W_Soldier_LAT_F";
F_Assault_Amm = "B_W_Soldier_A_F";
F_Assault_Mg = "B_W_Soldier_AR_F";
F_Assault_Med = "B_W_Medic_F";
F_Assault_Uav= "B_W_Soldier_UAV_F";


F_Recon_Snp = "B_T_Recon_M_F";
F_Recon_Sct = "B_T_Recon_F";
F_Recon_TL = "B_T_Recon_Medic_F";
F_Recon_Mrk = "B_T_Recon_Exp_F";
F_Recon_AT = "B_T_Recon_LAT_F";
F_Recon_Eod = "B_T_Recon_Exp_F";
F_Recon_Med = "B_T_Recon_Medic_F";
F_Recon_Eng = "B_Patrol_Engineer_F";

F_Diver_TL = "B_diver_TL_F";
F_Diver_Rfl = "B_diver_F";
F_Diver_Eod = "B_diver_exp_F";

if (isClass (configfile >> "CfgFactionClasses" >> "mas_nat_actrg") == true ) then {
F_Recon_TL = "B_mas_natctrg_recon_TL_SPA_F";
F_Recon_Mrk = "B_mas_natctrg_recon_M_SPA_F";
F_Recon_AT = "B_mas_natctrg_recon_LAT_SPA_F";
F_Recon_Mg = "B_mas_natctrg_recon_AR_SPA_F";
F_Diver_TL = "B_mas_natctrg_recon_TL_diverU_F";
F_Diver_Rfl = "B_mas_natctrg_recon_exp_diverU_F";
		}; 


F_RADAR = "I_E_Radar_System_01_F";
F_HQ_01 = "Land_Cargo_HQ_V1_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_F";
F_OP_01 = "Land_Cargo_House_V1_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_F" ;

F_Bike_01 = "B_T_Quadbike_01_F";

F_ABT_01 = "B_Boat_Armed_01_minigun_F";

F_UAV_01 = "B_UAV_02_dynamicLoadout_F";
F_UAV_02 = "B_UAV_05_F";
F_UAV_03 = "B_T_UAV_03_dynamicLoadout_F";
F_UGV_01 = "B_T_UGV_01_rcws_olive_F";

F_turret_01 = "B_HMG_01_high_F";
F_turret_02 = "B_GMG_01_high_F";
F_turret_03 = "B_static_AT_F";

F_Car_01 = "B_T_LSV_01_unarmed_F";
F_Car_02 = "B_T_LSV_01_armed_F";
F_Car_03 = "B_T_LSV_01_AT_F";
F_Car_04 = "";
F_Car_05 = "";
F_Car_06 = "";

F_MRAP_01 = "B_T_MRAP_01_F";
F_MRAP_02 = "B_T_MRAP_01_hmg_F";
F_MRAP_03 = "B_T_MRAP_01_gmg_F";
F_MRAP_04 = "";
F_MRAP_05 = "";
F_MRAP_06 = "";

F_Truck_01 = "B_T_Truck_01_transport_F";
F_Truck_02 = "B_T_Truck_01_fuel_F";
F_Truck_03 = "B_T_Truck_01_ammo_F";
F_Truck_04 = "B_T_Truck_01_Repair_F";
F_Truck_05 = "B_T_Truck_01_medical_F";
F_Truck_06 = "";

F_APC_01 = "B_T_APC_Tracked_01_rcws_F";
F_APC_02 = "B_T_APC_Tracked_01_CRV_F";
F_APC_03 = "B_T_APC_Tracked_01_AA_F";
F_APC_04 = "B_T_APC_Wheeled_01_cannon_F";
F_APC_05 = "B_T_AFV_Wheeled_01_up_cannon_F";
F_APC_06 = "";

F_TNK_01= "B_T_MBT_01_TUSK_F";
F_TNK_02= "";
F_TNK_03= "";
F_TNK_04= "";

F_Art_00 = "B_T_Mortar_01_F";
F_Art_01 = "B_T_MBT_01_arty_F";
F_Art_02 = "B_T_MBT_01_mlrs_F";

F_Heli_01 = "B_Heli_Light_01_F";
F_Heli_02 = "B_Heli_Light_01_dynamicLoadout_F";
F_Heli_03 = "B_Heli_Transport_01_F";
F_Heli_04 = "B_Heli_Transport_03_F";
F_Heli_05 = "";

F_Heli_06_G = "B_Heli_Attack_01_dynamicLoadout_F";
F_Heli_07_G = "";

F_Plane_01_CAS = "B_Plane_CAS_01_dynamicLoadout_F";
F_Plane_02_CAS = "B_Plane_Fighter_01_F";

F_Plane_03 = "B_T_VTOL_01_infantry_F";
F_Plane_04 = "B_T_VTOL_01_vehicle_F";
F_Plane_05 = "B_T_VTOL_01_armed_F";
F_Plane_06 = "";

};


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 if ((markerText "Friendly_Handle" == "United States Armed Forces _ Desert _ CUP + RHS") or (markerText "Friendly_Handle" == "United States Armed Forces _ Desert _ RHS")) then {
F_Officer = "rhsusf_usmc_marpat_d_officer";
F_Assault_Eng = "rhsusf_usmc_marpat_d_engineer";
F_Assault_TL = "rhsusf_usmc_marpat_d_teamleader";
F_Assault_SL = "rhsusf_usmc_marpat_d_squadleader";
F_Assault_Eod = "rhsusf_usmc_marpat_d_explosives";
F_Assault_Mrk = "rhsusf_usmc_marpat_d_sniper_m110";
F_Assault_AT = "rhsusf_usmc_marpat_d_smaw";
F_Assault_Amm = "rhsusf_usmc_marpat_d_autorifleman_m249_ass";
F_Assault_Mg = "rhsusf_usmc_marpat_d_autorifleman_m249";
F_Assault_Med = "rhsusf_army_ocp_medic";
F_Assault_Uav= "rhsusf_usmc_marpat_d_uav";


F_Recon_Snp = "rhsusf_usmc_recon_marpat_d_marksman_lite";
F_Recon_Sct = "rhsusf_usmc_recon_marpat_d_rifleman_at_lite";

F_Recon_TL = "rhsusf_usmc_recon_marpat_d_teamleader_fast";
F_Recon_Mrk = "rhsusf_usmc_recon_marpat_d_marksman_fast";
F_Recon_AT = "rhsusf_usmc_recon_marpat_d_rifleman_at_fast";
F_Recon_Mg = "rhsusf_usmc_recon_marpat_d_autorifleman_fast";
F_Recon_Eod = "rhsusf_socom_marsoc_cso_breacher";
F_Recon_Med = "rhsusf_socom_marsoc_sarc";
F_Recon_Eng = "rhsusf_socom_marsoc_cso_mechanic";

F_Diver_TL = "B_diver_TL_F";
F_Diver_Rfl = "B_diver_F";
F_Diver_Eod = "B_diver_exp_F";



if (isClass (configfile >> "CfgFactionClasses" >> "mas_usl_amulti") == true ) then {
F_Recon_Snp = "B_mas_usl_recon_M_F_hc";
F_Recon_Sct = "B_mas_usl_recon_OPDelta_F_hc";
F_Recon_TL = "B_mas_usl_recon_JTAC_F";
F_Recon_Mrk = "B_mas_usl_recon_exp_F";
F_Recon_AT = "B_mas_usl_recon_AT_F";
F_Recon_Mg = "B_mas_usl_recon_medic_F";
F_Diver_TL = "B_mas_usl_diverUn_exp_F";
F_Diver_Rfl = "B_mas_usl_diverUn_rec_F";
		}; 


F_RADAR = "B_Radar_System_01_F";  
F_HQ_01 = "Land_Cargo_HQ_V3_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_sand_F";
F_OP_01 = "Land_Cargo_House_V3_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_sand_F" ;

F_Bike_01 = "B_Quadbike_01_F";

F_ABT_01 = "rhsusf_mkvsoc";

F_UAV_01 = "B_UAV_02_dynamicLoadout_F";
F_UAV_02 = "B_UAV_05_F";
F_UAV_03 = "B_T_UAV_03_dynamicLoadout_F";
F_UGV_01 = "B_UGV_01_rcws_F";

F_turret_01 = "RHS_M2StaticMG_D";
F_turret_02 = "RHS_MK19_TriPod_D";
F_turret_03 = "RHS_TOW_TriPod_D";

F_Car_01 = "rhsusf_m1151_usarmy_d";
F_Car_02 = "rhsusf_m1151_m2_v2_usarmy_d";
F_Car_03 = "rhsusf_m1151_mk19_v2_usarmy_d";
F_Car_04 = "rhsusf_m966_d";
F_Car_05 = "";
F_Car_06 = "rhsusf_mrzr4_d";

F_MRAP_01 = "rhsusf_m1240a1_usarmy_d";
F_MRAP_02 = "rhsusf_m1240a1_m2_uik_usarmy_d";
F_MRAP_03 = "rhsusf_m1240a1_mk19_uik_usarmy_d";
F_MRAP_04 = "rhsusf_M1230a1_usarmy_d";
F_MRAP_05 = "rhsusf_M1230_M2_usarmy_d";
F_MRAP_06 = "rhsusf_M1230_MK19_usarmy_d";

F_Truck_01 = "rhsusf_M1083A1P2_B_M2_D_fmtv_usarmy";
F_Truck_02 = "rhsusf_M978A4_BKIT_usarmy_d";
F_Truck_03 = "rhsusf_M977A4_AMMO_BKIT_M2_usarmy_d";
F_Truck_04 = "rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_d";
F_Truck_05 = "rhsusf_M1085A1P2_B_D_Medical_fmtv_usarmy";
F_Truck_06 = "";

F_APC_01 = "rhsusf_stryker_m1126_m2_d";
F_APC_02 = "rhsusf_stryker_m1126_mk19_d";
F_APC_03 = "rhsusf_stryker_m1134_d";
F_APC_04 = "rhsusf_m113d_usarmy";
F_APC_05 = "RHS_M6";
F_APC_06 = "RHS_M2A3_BUSKIII";

F_TNK_01= "rhsusf_m1a2sep1tuskiid_usarmy";
F_TNK_02= "rhsusf_m1a2sep1tuskid_usarmy";
F_TNK_03= "rhsusf_m1a2sep2d_usarmy";
F_TNK_04= "B_MBT_01_TUSK_F";

F_Art_00 = "B_Mortar_01_F";
F_Art_01 = "B_MBT_01_arty_F";
F_Art_02 = "B_MBT_01_mlrs_F";

F_Heli_01 = "RHS_MELB_MH6M";
F_Heli_02 = "RHS_MELB_AH6M";
F_Heli_03 = "RHS_UH60M_d";
F_Heli_04 = "RHS_CH_47F_10";
F_Heli_05 = "RHS_CH_47F_10_cargo";

F_Heli_06_G = "RHS_AH64D";
F_Heli_07_G = "RHS_AH1Z";

F_Plane_01_CAS = "RHS_A10";
F_Plane_02_CAS = "rhsusf_f22";
F_Plane_03 = "RHS_C130J";
F_Plane_04 = "RHS_C130J_Cargo";
F_Plane_05 = "B_T_VTOL_01_infantry_F";
F_Plane_06 = "B_T_VTOL_01_vehicle_F";

};

if ((markerText "Friendly_Handle" == "United States Armed Forces _ Woodland _ CUP + RHS") or (markerText "Friendly_Handle" == "United States Armed Forces _ Woodland _ RHS")) then {
F_Officer = "rhsusf_usmc_marpat_wd_officer";
F_Assault_Eng = "rhsusf_usmc_marpat_wd_engineer";
F_Assault_TL = "rhsusf_usmc_marpat_wd_teamleader";
F_Assault_SL = "rhsusf_usmc_marpat_wd_squadleader";
F_Assault_Eod = "rhsusf_usmc_marpat_wd_explosives";
F_Assault_Mrk = "rhsusf_usmc_marpat_wd_marksman";
F_Assault_AT = "rhsusf_usmc_marpat_wd_smaw";
F_Assault_Amm = "rhsusf_usmc_marpat_wd_autorifleman_m249_ass";
F_Assault_Mg = "rhsusf_usmc_marpat_wd_autorifleman_m249";
F_Assault_Med = "rhsusf_army_ocp_medic";
F_Assault_Uav= "rhsusf_usmc_marpat_wd_uav";

F_Recon_Snp = "rhsusf_usmc_recon_marpat_wd_marksman_lite";
F_Recon_Sct = "rhsusf_usmc_recon_marpat_wd_rifleman_at_lite";

F_Recon_TL = "rhsusf_usmc_recon_marpat_wd_teamleader_fast";
F_Recon_Mrk = "rhsusf_usmc_recon_marpat_wd_marksman_fast";
F_Recon_AT = "rhsusf_usmc_recon_marpat_wd_rifleman_at_fast";
F_Recon_Mg = "rhsusf_usmc_recon_marpat_wd_autorifleman_fast";
F_Recon_Eod = "rhsusf_socom_marsoc_cso_breacher";
F_Recon_Med = "rhsusf_socom_marsoc_sarc";
F_Recon_Eng = "rhsusf_socom_marsoc_cso_mechanic";

F_Diver_TL = "B_diver_TL_F";
F_Diver_Rfl = "B_diver_F";
F_Diver_Eod = "B_diver_exp_F";

if (isClass (configfile >> "CfgFactionClasses" >> "mas_usl_amulti") == true ) then {
F_Recon_Snp = "B_mas_usl_recon_M_F_bw";
F_Recon_Sct = "B_mas_usl_recon_OPmarsoc_F_bw";
F_Recon_TL = "B_mas_usl_recon_F_bw";
F_Recon_Mrk = "B_mas_usl_recon_exp_F_bw";
F_Recon_AT = "B_mas_usl_recon_AT_F_bw";
F_Recon_Mg = "B_mas_usl_recon_medic_F_bw";
F_Diver_TL = "B_mas_usl_diverUn_exp_F";
F_Diver_Rfl = "B_mas_usl_diverUn_rec_F";
		}; 


F_RADAR = "I_E_Radar_System_01_F";
F_HQ_01 = "Land_Cargo_HQ_V1_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_F";
F_OP_01 = "Land_Cargo_House_V1_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_F" ;

F_Bike_01 = "B_T_Quadbike_01_F";

F_ABT_01 = "rhsusf_mkvsoc";

F_UAV_01 = "B_UAV_02_dynamicLoadout_F";
F_UAV_02 = "B_UAV_05_F";
F_UAV_03 = "B_T_UAV_03_dynamicLoadout_F";
F_UGV_01 = "B_T_UGV_01_rcws_olive_F";

F_turret_01 = "RHS_M2StaticMG_WD";
F_turret_02 = "RHS_MK19_TriPod_WD";
F_turret_03 = "RHS_TOW_TriPod_WD";

F_Car_01 = "rhsusf_m1151_usarmy_wd";
F_Car_02 = "rhsusf_m1151_m2_v2_usarmy_wd";
F_Car_03 = "rhsusf_m1151_mk19_v2_usarmy_wd";
F_Car_04 = "rhsusf_m966_w";
F_Car_05 = "";
F_Car_06 = "rhsusf_mrzr4_d";

F_MRAP_01 = "rhsusf_m1240a1_usarmy_wd";
F_MRAP_02 = "rhsusf_m1240a1_m2_uik_usarmy_wd";
F_MRAP_03 = "rhsusf_m1240a1_mk19_uik_usarmy_wd";
F_MRAP_04 = "rhsusf_M1230a1_usarmy_wd";
F_MRAP_05 = "rhsusf_M1230_M2_usarmy_wd";
F_MRAP_06 = "rhsusf_M1230_MK19_usarmy_wd";

F_Truck_01 = "rhsusf_M1083A1P2_B_M2_WD_fmtv_usarmy";
F_Truck_02 = "rhsusf_M978A4_usarmy_wd";
F_Truck_03 = "rhsusf_M977A4_AMMO_BKIT_M2_usarmy_wd";
F_Truck_04 = "rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_wd";
F_Truck_05 = "rhsusf_M1085A1P2_B_WD_Medical_fmtv_usarmy";
F_Truck_06 = "";

F_APC_01 = "rhsusf_stryker_m1126_m2_wd";
F_APC_02 = "rhsusf_stryker_m1126_mk19_wd";
F_APC_03 = "rhsusf_stryker_m1134_wd";
F_APC_04 = "rhsusf_m113_usarmy";
F_APC_05 = "RHS_M6_wd";
F_APC_06 = "RHS_M2A3_BUSKIII_wd";

F_TNK_01= "rhsusf_m1a2sep1tuskiiwd_usarmy";
F_TNK_02= "rhsusf_m1a2sep1tuskiwd_usarmy";
F_TNK_03= "rhsusf_m1a2sep2wd_usarmy";
F_TNK_04= "B_T_MBT_01_TUSK_F";

F_Art_00 = "B_T_Mortar_01_F";
F_Art_01 = "B_T_MBT_01_arty_F";
F_Art_02 = "B_T_MBT_01_mlrs_F";

F_Heli_01 = "RHS_MELB_MH6M";
F_Heli_02 = "RHS_MELB_AH6M";
F_Heli_03 = "RHS_UH60M_d";
F_Heli_04 = "RHS_CH_47F_10";
F_Heli_05 = "RHS_CH_47F_10_cargo";

F_Heli_06_G = "RHS_AH64D";
F_Heli_07_G = "RHS_AH1Z";

F_Plane_01_CAS = "RHS_A10";
F_Plane_02_CAS = "rhsusf_f22";
F_Plane_03 = "RHS_C130J";
F_Plane_04 = "RHS_C130J_Cargo";
F_Plane_05 = "B_T_VTOL_01_infantry_F";
F_Plane_06 = "B_T_VTOL_01_vehicle_F";

};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Welcome to the Vietnam /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if (markerText "Friendly_Handle" == "United States Armed Forces _ Woodland _ SOG Praire Fire") then {
	
F_Officer = "vn_b_men_army_01";
F_Assault_Eng = "vn_b_men_army_04";
F_Assault_TL = "vn_b_men_army_15";
F_Assault_SL = "vn_b_men_army_02";
F_Assault_Eod = "vn_b_men_army_05";
F_Assault_Mrk = "vn_b_men_army_10";
F_Assault_AT = "vn_b_men_army_12";
F_Assault_Amm = "vn_b_men_army_08";
F_Assault_Mg = "vn_b_men_army_06";
F_Assault_Med = "vn_b_men_army_03";
F_Assault_Uav= "vn_b_men_army_19";

F_Recon_Snp = "vn_b_men_sf_21";
F_Recon_Sct = "vn_b_men_sf_04";

F_Recon_TL = "vn_b_men_sf_01";
F_Recon_Mrk = "vn_b_men_sf_13";
F_Recon_AT = "vn_b_men_sf_08";
F_Recon_Mg = "vn_b_men_sf_05";
F_Recon_Eod = "vn_b_men_sf_03";
F_Recon_Med = "vn_b_men_sf_02";
F_Recon_Eng = "vn_b_men_army_26";

F_Diver_TL = "vn_b_men_seal_32";
F_Diver_Rfl = "vn_b_men_seal_29";
F_Diver_Eod = "vn_b_men_seal_36";

F_RADAR = "I_E_Radar_System_01_F";
F_HQ_01 = "Land_Cargo_HQ_V1_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_F";
F_OP_01 = "Land_Cargo_House_V1_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_F" ;

F_Bike_01 = "B_T_Quadbike_01_F";

F_ABT_01 = "vn_b_boat_11_01";
F_ABT_02 = "vn_b_boat_12_02";
F_ABT_03 = "vn_b_boat_05_02";

F_UAV_01 = "";
F_UAV_02 = "";
F_UAV_03 = "";
F_UGV_01 = "";

F_turret_01 = "vn_b_army_static_m1919a4_high";
F_turret_02 = "vn_b_army_static_mk18";
F_turret_03 = "vn_b_army_static_tow";

F_Car_01 = "vn_b_wheeled_m151_02_mp";
F_Car_02 = "vn_b_wheeled_m151_01";
F_Car_03 = "vn_b_wheeled_m151_mg_04";
F_Car_04 = "vn_b_wheeled_m151_mg_02";
F_Car_05 = "vn_b_wheeled_m151_mg_06";
F_Car_06 = "vn_b_wheeled_m151_mg_05";

F_MRAP_01 = "";
F_MRAP_02 = "";
F_MRAP_03 = "";
F_MRAP_04 = "";
F_MRAP_05 = "";
F_MRAP_06 = "";

F_Truck_01 = "vn_b_wheeled_m54_01_aus_army";
F_Truck_02 = "vn_b_wheeled_m54_fuel";
F_Truck_03 = "vn_b_wheeled_m54_ammo";
F_Truck_04 = "vn_b_wheeled_m54_repair";
F_Truck_05 = "vn_b_wheeled_m54_03";
F_Truck_06 = "";

F_APC_01 = "vn_b_armor_m113_acav_04";
F_APC_02 = "vn_b_armor_m113_acav_02";
F_APC_03 = "vn_b_armor_m113_acav_06";
F_APC_04 = "vn_b_armor_m113_acav_03";
F_APC_05 = "vn_b_armor_m113_acav_05";
F_APC_06 = "vn_b_armor_m113_01";

F_TNK_01= "vn_b_armor_m41_01_02";
F_TNK_02= "vn_b_armor_m41_01_01";
F_TNK_03= "";
F_TNK_04= "";

F_Art_00 = "vn_b_army_static_m101_02";
F_Art_01 = "vn_b_army_static_mortar_m29";
F_Art_02 = "vn_b_army_static_mortar_m2";

F_Heli_01 = "vn_b_air_oh6a_01";
F_Heli_02 = "vn_b_air_oh6a_05";
F_Heli_03 = "vn_b_air_uh1d_02_02";
F_Heli_04 = "vn_b_air_uh1d_01_01";
F_Heli_05 = "vn_b_air_uh1c_02_01";

F_Heli_06_G = "vn_b_air_ah1g_07";
F_Heli_07_G = "vn_b_air_ah1g_03";

F_Plane_01_CAS = "vn_b_air_f100d_cas";
F_Plane_02_CAS = "vn_b_air_f4b_navy_cas";
F_Plane_03 = "";
F_Plane_04 = "";
F_Plane_05 = "";
F_Plane_06 = "";

};





//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if (markerText "Friendly_Handle" == "German Armed Forces _ Desert _ BW") then {
F_Officer = "BWA3_Officer_Tropen";

F_Assault_Eng = "BWA3_Engineer_Tropen";
F_Assault_TL = "BWA3_TL_Tropen";
F_Assault_SL = "BWA3_SL_Tropen";
F_Assault_Eod = "BWA3_Engineer_Tropen";
F_Assault_Mrk = "BWA3_Marksman_Tropen";
F_Assault_AT = "BWA3_RiflemanAT_PzF3_Tropen";
F_Assault_Amm = "BWA3_RiflemanAA_Fliegerfaust_Tropen";
F_Assault_Mg = "BWA3_MachineGunner_MG5_Tropen";
F_Assault_Med = "BWA3_Medic_Tropen";
F_Assault_Uav= "B_soldier_UAV_F";


F_Recon_Snp = "BWA3_Sniper_G82_Tropen";
F_Recon_Sct = "BWA3_Spotter_Tropen";

F_Recon_TL = "BWA3_recon_TL_Tropen";
F_Recon_Mrk = "BWA3_recon_Marksman_Tropen";
F_Recon_AT = "BWA3_recon_LAT_Tropen";
F_Recon_Mg = "BWA3_recon_Tropen";
F_Recon_Eod = "BWA3_recon_Pioneer_Tropen";
F_Recon_Med = "BWA3_recon_Medic_Tropen";
F_Recon_Eng = "B_Patrol_Engineer_F";

F_Diver_TL = "B_diver_TL_F";
F_Diver_Rfl = "B_diver_F";
F_Diver_Eod = "B_diver_exp_F";

if (isClass (configfile >> "CfgFactionClasses" >> "mas_ger_caor1") == true ) then {
F_Recon_Snp = "B_mas_ger_recon_M_F_ca";
F_Recon_Sct = "B_mas_ger_recon_AA_F_ca";
F_Recon_TL = "B_mas_ger_recon_F_ca";
F_Recon_Mrk = "B_mas_ger_recon_exp_F_ca";
F_Recon_AT = "B_mas_ger_recon_AT_F_ca";
F_Recon_Mg = "B_mas_ger_recon_medic_F_ca";
F_Diver_TL = "B_mas_ger_diverUn_exp_F";
F_Diver_Rfl = "B_mas_ger_diverUn_rec_F";
		}; 

F_RADAR = "B_Radar_System_01_F";  
F_HQ_01 = "Land_Cargo_HQ_V3_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_sand_F";
F_OP_01 = "Land_Cargo_House_V3_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_sand_F" ;

F_Bike_01 = "B_Quadbike_01_F";

F_ABT_01 = "B_Boat_Armed_01_minigun_F";

F_UAV_01 = "B_UAV_02_dynamicLoadout_F";
F_UAV_02 = "B_UAV_05_F";
F_UAV_03 = "B_T_UAV_03_dynamicLoadout_F";
F_UGV_01 = "B_UGV_01_rcws_F";

F_turret_01 = "CUP_B_M2StaticMG_GER";
F_turret_02 = "CUP_B_AGS_ACR";
F_turret_03 = "CUP_B_RBS70_ACR";

F_Car_01 = "BWA3_Eagle_Tropen";
F_Car_02 = "BWA3_Eagle_FLW100_Tropen";
F_Car_03 = "";
F_Car_04 = "";
F_Car_05 = "";
F_Car_06 = "";

F_MRAP_01 = "BWA3_Dingo2_FLW100_MG3_CG13_Tropen";
F_MRAP_02 = "BWA3_Dingo2_FLW200_M2_CG13_Tropen";
F_MRAP_03 = "BWA3_Dingo2_FLW200_GMW_CG13_Tropen";
F_MRAP_04 = "";
F_MRAP_05 = "";
F_MRAP_06 = "";

F_Truck_01 = "CUP_B_T810_Armed_CZ_DES";
F_Truck_02 = "CUP_B_T810_Refuel_CZ_DES";
F_Truck_03 = "CUP_B_T810_Reammo_CZ_DES";
F_Truck_04 = "CUP_B_T810_Repair_CZ_DES";
F_Truck_05 = "CUP_B_LR_Ambulance_GB_D";
F_Truck_06 = "";

F_APC_01 = "CUP_B_Boxer_HMG_GER_DES";
F_APC_02 = "CUP_B_Boxer_GMG_GER_DES";
F_APC_03 = "BWA3_Puma_Tropen";
F_APC_04 = "";
F_APC_05 = "";
F_APC_06 = "";

F_TNK_01= "BWA3_Leopard2_Tropen";
F_TNK_02= "";
F_TNK_03= "";
F_TNK_04= "";

F_Art_00 = "B_Mortar_01_F";
F_Art_01 = "B_MBT_01_arty_F";
F_Art_02 = "B_MBT_01_mlrs_F";

F_Heli_01 = "CUP_B_UH1D_slick_GER_KSK_Des";
F_Heli_02 = "CUP_B_UH1D_gunship_GER_KSK_Des";
F_Heli_03 = "";
F_Heli_04 = "CUP_B_CH53E_GER";
F_Heli_05 = "CUP_B_CH53E_VIV_GER";

F_Heli_06_G = "BWA3_Tiger_RMK_Universal";
F_Heli_07_G = "";

F_Plane_01_CAS = "B_Plane_CAS_01_dynamicLoadout_F";
F_Plane_02_CAS = "B_Plane_Fighter_01_F";
F_Plane_03 = "B_T_VTOL_01_infantry_F";
F_Plane_04 = "B_T_VTOL_01_vehicle_F";
F_Plane_05 = "B_T_VTOL_01_armed_F";
F_Plane_06 = "";

};

 if (markerText "Friendly_Handle" == "German Armed Forces _ Woodland _ BW") then {

F_Officer = "BWA3_Officer_Fleck";
F_Assault_Eng = "BWA3_Grenadier_G27_Fleck";
F_Assault_TL = "BWA3_TL_Fleck";
F_Assault_SL = "BWA3_SL_Fleck";
F_Assault_Eod = "BWA3_Engineer_Fleck";
F_Assault_Mrk = "BWA3_Marksman_Fleck";
F_Assault_AT = "BWA3_RiflemanAT_PzF3_Fleck";
F_Assault_Amm = "BWA3_RiflemanAA_Fliegerfaust_Fleck";
F_Assault_Mg = "BWA3_MachineGunner_MG5_Fleck";
F_Assault_Med = "BWA3_Medic_Fleck";
F_Assault_Uav= "B_W_Soldier_UAV_F";


F_Recon_Snp = "BWA3_recon_Marksman_Fleck";
F_Recon_Sct = "BWA3_recon_Pioneer_Fleck";

F_Recon_TL = "BWA3_recon_TL_Fleck";
F_Recon_Mrk = "BWA3_recon_Marksman_Fleck";
F_Recon_AT = "BWA3_recon_LAT_Fleck";
F_Recon_Mg = "BWA3_recon_Fleck";
F_Recon_Eod = "BWA3_recon_Pioneer_Fleck";
F_Recon_Med = "BWA3_recon_Medic_Tropen";
F_Recon_Eng = "B_Patrol_Engineer_F";

F_Diver_TL = "B_diver_TL_F";
F_Diver_Rfl = "B_diver_F";
F_Diver_Eod = "B_diver_exp_F";

if (isClass (configfile >> "CfgFactionClasses" >> "mas_ger_caor1") == true ) then {
F_Recon_Snp = "B_mas_ger_recon_M_F_da";
F_Recon_Sct = "B_mas_ger_recon_AA_F_da";
F_Recon_TL = "B_mas_ger_recon_F_da";
F_Recon_Mrk = "B_mas_ger_recon_exp_F_da";
F_Recon_AT = "B_mas_ger_recon_AT_F_da";
F_Recon_Mg = "B_mas_ger_recon_medic_F_da";
F_Diver_TL = "B_mas_ger_diverUn_exp_F";
F_Diver_Rfl = "B_mas_ger_diverUn_rec_F";
		}; 

F_RADAR = "I_E_Radar_System_01_F";
F_HQ_01 = "Land_Cargo_HQ_V1_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_F";
F_OP_01 = "Land_Cargo_House_V1_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_F" ;

F_Bike_01 = "B_T_Quadbike_01_F";

F_ABT_01 = "B_Boat_Armed_01_minigun_F";

F_UAV_01 = "B_UAV_02_dynamicLoadout_F";
F_UAV_02 = "B_UAV_05_F";
F_UAV_03 = "B_T_UAV_03_dynamicLoadout_F";
F_UGV_01 = "B_T_UGV_01_rcws_olive_F";

F_turret_01 = "CUP_B_M2StaticMG_GER_Fleck";
F_turret_02 = "CUP_B_AGS_ACR";
F_turret_03 = "CUP_B_RBS70_ACR";

F_Car_01 = "BWA3_Eagle_Fleck";
F_Car_02 = "BWA3_Eagle_FLW100_Fleck";
F_Car_03 = "";
F_Car_04 = "";
F_Car_05 = "";
F_Car_06 = "";

F_MRAP_01 = "BWA3_Dingo2_FLW100_MG3_CG13_Fleck";
F_MRAP_02 = "BWA3_Dingo2_FLW200_M2_CG13_Fleck";
F_MRAP_03 = "BWA3_Dingo2_FLW200_GMW_CG13_Fleck";
F_MRAP_04 = "";
F_MRAP_05 = "";
F_MRAP_06 = "";

F_Truck_01 = "CUP_B_T810_Armed_CZ_WDL";
F_Truck_02 = "CUP_B_T810_Refuel_CZ_WDL";
F_Truck_03 = "CUP_B_T810_Reammo_CZ_WDL";
F_Truck_04 = "CUP_B_T810_Repair_CZ_WDL";
F_Truck_05 = "CUP_B_LR_Ambulance_CZ_W";
F_Truck_06 = "";

F_APC_01 = "CUP_B_Boxer_HMG_GER_WDL";
F_APC_02 = "CUP_B_Boxer_GMG_GER_WDL";
F_APC_03 = "BWA3_Puma_Fleck";
F_APC_04 = "";
F_APC_05 = "";
F_APC_06 = "";

F_TNK_01= "BWA3_Leopard2_Fleck";
F_TNK_02= "";
F_TNK_03= "";
F_TNK_04= "";

F_Art_00 = "B_T_Mortar_01_F";
F_Art_01 = "B_T_MBT_01_arty_F";
F_Art_02 = "B_T_MBT_01_mlrs_F";

F_Heli_01 = "CUP_B_UH1D_slick_GER_KSK";
F_Heli_02 = "CUP_B_UH1D_gunship_GER_KSK";
F_Heli_03 = "";
F_Heli_04 = "CUP_B_CH53E_GER";
F_Heli_05 = "CUP_B_CH53E_VIV_GER";

F_Heli_06_G = "BWA3_Tiger_RMK_Universal";
F_Heli_07_G = "";

F_Plane_01_CAS = "B_Plane_CAS_01_dynamicLoadout_F";
F_Plane_02_CAS = "B_Plane_Fighter_01_F";

F_Plane_03 = "B_T_VTOL_01_infantry_F";
F_Plane_04 = "B_T_VTOL_01_vehicle_F";
F_Plane_05 = "B_T_VTOL_01_armed_F";
F_Plane_06 = "";

};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 if (markerText "Friendly_Handle" == "Spanish Armed Forces  _ Woodland _ FFAA") then {
F_Officer = "ffaa_bripac_oficial";
F_Assault_Eng = "ffaa_brilat_ingeniero";
F_Assault_TL = "ffaa_bripac_jefe_peloton";
F_Assault_SL = "ffaa_bripac_jefe_escuadra";
F_Assault_Eod = "ffaa_et_moe_sabot";
F_Assault_Mrk = "ffaa_bripac_tirador";
F_Assault_AT = "ffaa_bripac_proveedor_alcotan";
F_Assault_Amm = "ffaa_bripac_fusilero_mochila";
F_Assault_Mg = "ffaa_bripac_tirador_ameli";
F_Assault_Med = "ffaa_bripac_medico";
F_Assault_Uav= "ffaa_bripac_operador_UAV";


F_Recon_Snp = "ffaa_bripac_francotirador_barrett";
F_Recon_Sct = "ffaa_bripac_observador";

F_Recon_TL = "ffaa_et_moe_lider";
F_Recon_Mrk = "ffaa_et_moe_tirador";
F_Recon_AT = "ffaa_et_moe_at";
F_Recon_Mg = "ffaa_et_moe_mg";
F_Recon_Eod = "ffaa_et_moe_sabot";
F_Recon_Med = "ffaa_et_moe_medico";
F_Recon_Eng = "ffaa_et_moe_sabot";

F_Diver_TL = "B_diver_TL_F";
F_Diver_Rfl = "B_diver_F";
F_Diver_Eod = "B_diver_exp_F";

if (isClass (configfile >> "CfgFactionClasses" >> "mas_esp_amulti") == true ) then {
F_Recon_Snp = "B_mas_esp_recon_M_F";
F_Recon_Sct = "B_mas_esp_recon_AA_F";
F_Recon_TL = "B_mas_esp_recon_F";
F_Recon_Mrk = "B_mas_esp_recon_exp_F";
F_Recon_AT = "B_mas_esp_recon_AT_F";
F_Recon_Mg = "B_mas_esp_recon_medic_F";
F_Diver_TL = "B_mas_esp_diverUn_exp_F";
F_Diver_Rfl = "B_mas_esp_diverUn_rec_F";
		}; 

F_RADAR = "I_E_Radar_System_01_F";
F_HQ_01 = "Land_Cargo_HQ_V1_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_F";
F_OP_01 = "Land_Cargo_House_V1_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_F" ;

F_Bike_01 = "B_T_Quadbike_01_F";

F_ABT_01 = "B_Boat_Armed_01_minigun_F";

F_UAV_01 = "ffaa_ea_reaper";
F_UAV_02 = "B_UAV_05_F";
F_UAV_03 = "B_T_UAV_03_dynamicLoadout_F";
F_UGV_01 = "B_UGV_01_rcws_F";

F_turret_01 = "ffaa_m2_ship_tripode";
F_turret_02 = "ffaa_lag40_tripode";
F_turret_03 = "ffaa_tow_tripode";

F_Car_01 = "ffaa_et_vamtac_ume";
F_Car_02 = "ffaa_et_vamtac_m2";
F_Car_03 = "ffaa_et_vamtac_lag40";
F_Car_04 = "ffaa_et_vamtac_tow";
F_Car_05 = "ffaa_et_vamtac_cardom";
F_Car_06 = "ffaa_et_vamtac_mistral";

F_MRAP_01 = "ffaa_et_lince_ambulancia";
F_MRAP_02 = "ffaa_et_lince_m2";
F_MRAP_03 = "ffaa_et_lince_lag40";
F_MRAP_04 = "ffaa_et_rg31_samson";
F_MRAP_05 = "";
F_MRAP_06 = "";

F_Truck_01 = "ffaa_et_m250_carga_blin";
F_Truck_02 = "ffaa_et_m250_combustible_blin";
F_Truck_03 = "ffaa_et_m250_sistema_nasams_blin";
F_Truck_04 = "ffaa_et_m250_repara_municion_blin";
F_Truck_05 = "ffaa_et_lince_ambulancia";
F_Truck_06 = "";

F_APC_01 = "ffaa_et_toa_mando";
F_APC_02 = "ffaa_et_toa_ambulancia";
F_APC_03 = "ffaa_et_toa_zapador";
F_APC_04 = "ffaa_et_toa_spike";
F_APC_05 = "ffaa_et_pizarro_mauser";
F_APC_06 = "";

F_TNK_01= "ffaa_et_leopardo";
F_TNK_02= "";
F_TNK_03= "";
F_TNK_04= "";

F_Art_00 = "B_T_Mortar_01_F";
F_Art_01 = "B_T_MBT_01_arty_F";
F_Art_02 = "B_T_MBT_01_mlrs_F";

F_Heli_01 = "";
F_Heli_02 = "ffaa_famet_ec135";
F_Heli_03 = "";
F_Heli_04 = "ffaa_nh90_tth_transport";
F_Heli_05 = "ffaa_nh90_tth_cargo";

F_Heli_06_G = "ffaa_famet_tigre";
F_Heli_07_G = "";

F_Plane_01_CAS = "B_Plane_CAS_01_dynamicLoadout_F";
F_Plane_02_CAS = "ffaa_ar_harrier";
F_Plane_03 = "ffaa_ea_hercules";
F_Plane_04 = "ffaa_ea_hercules_cargo";
F_Plane_05 = "";
F_Plane_06 = "";

};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 if (markerText "Friendly_Handle" == "British Armed Forces _ Desert _ AEW") then {
F_Officer = "B_A_Officer_F";
F_Assault_Eng = "B_A_Engineer_F";
F_Assault_TL = "B_A_Soldier_TL_F";
F_Assault_SL = "B_A_Soldier_SL_F";
F_Assault_Eod = "B_A_Soldier_Exp_F";
F_Assault_Mrk = "B_A_soldier_M_F";
F_Assault_AT = "B_A_Soldier_LAT_F";
F_Assault_Amm = "B_A_Soldier_A_F";
F_Assault_Mg = "B_A_Soldier_AR_F";
F_Assault_Med = "B_A_Medic_F";
F_Assault_Uav= "B_A_Soldier_UAV_F";


F_Recon_Snp = "B_A_ghillie_ard_F";
F_Recon_Sct = "B_A_ghillie_spotter_ard_F";

F_Recon_TL = "B_A_Recon_TL_F";
F_Recon_Mrk = "B_A_Recon_M_F";
F_Recon_AT = "B_A_Recon_LAT_F";
F_Recon_Mg = "B_A_Recon_MG_F";
F_Recon_Eod = "B_A_Recon_Exp_F";
F_Recon_Med = "B_A_Recon_Medic_F";
F_Recon_Eng = "B_A_Engineer_F";

F_Diver_TL = "B_diver_TL_F";
F_Diver_Rfl = "B_diver_F";
F_Diver_Eod = "B_diver_exp_F";


F_RADAR = "B_Radar_System_01_F";  
F_HQ_01 = "Land_Cargo_HQ_V3_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_sand_F";
F_OP_01 = "Land_Cargo_House_V3_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_sand_F" ;

F_Bike_01 = "B_A_Quadbike_01_F";

F_ABT_01 = "B_A_Boat_Armed_01_hmg_F";

F_UAV_01 = "B_UAV_02_dynamicLoadout_F";
F_UAV_02 = "B_UAV_05_F";
F_UAV_03 = "B_T_UAV_03_dynamicLoadout_F";
F_UGV_01 = "B_UGV_01_rcws_F";

F_turret_01 = "B_A_HMG_02_high_F";
F_turret_02 = "B_A_GMG_01_high_F";
F_turret_03 = "B_A_static_AT_F";

F_Car_01 = "B_A_LSV_01_light_F";
F_Car_02 = "B_A_LSV_01_armed_F";
F_Car_03 = "B_A_LSV_01_AT_F";
F_Car_04 = "";
F_Car_05 = "";
F_Car_06 = "";

F_MRAP_01 = "B_A_MRAP_03_F";
F_MRAP_02 = "B_A_MRAP_03_hmg_F";
F_MRAP_03 = "B_A_MRAP_03_gmg_F";
F_MRAP_04 = "";
F_MRAP_05 = "";
F_MRAP_06 = "";

F_Truck_01 = "B_A_Truck_01_transport_F";
F_Truck_02 = "B_A_Truck_01_fuel_F";
F_Truck_03 = "B_A_Truck_01_ammo_F";
F_Truck_04 = "B_A_Truck_01_Repair_F";
F_Truck_05 = "B_A_Truck_01_medical_F";
F_Truck_06 = "";

F_APC_01 = "B_A_APC_tracked_03_cannon_v2_F";
F_APC_02 = "";
F_APC_03 = "";
F_APC_04 = "";
F_APC_05 = "";
F_APC_06 = "";

F_TNK_01= "B_MBT_01_TUSK_F";
F_TNK_02= "";
F_TNK_03= "";
F_TNK_04= "";

F_Art_00 = "B_Mortar_01_F";
F_Art_01 = "B_MBT_01_arty_F";
F_Art_02 = "B_MBT_01_mlrs_F";

F_Heli_01 = "B_A_Heli_light_03_unarmed_F";
F_Heli_02 = "B_A_Heli_light_03_dynamicLoadout_F";
F_Heli_03 = "";
F_Heli_04 = "B_A_Heli_Transport_02_F";
F_Heli_05 = "";

F_Heli_06_G = "B_A_Heli_Attack_01_dynamicLoadout_F";
F_Heli_07_G = "";

F_Plane_01_CAS = "B_Plane_CAS_01_dynamicLoadout_F";
F_Plane_02_CAS = "B_A_Plane_Fighter_05_F";
F_Plane_03 = "B_A_VTOL_01_infantry_F";
F_Plane_04 = "B_A_VTOL_01_vehicle_F";
F_Plane_05 = "";
F_Plane_06 = "";

};

if (markerText "Friendly_Handle" == "British Armed Forces _ Woodland _ AEW") then {

F_Officer = "B_A_Officer_wdl_F";
F_Assault_Eng = "B_A_Engineer_wdl_F";
F_Assault_TL = "B_A_Soldier_TL_wdl_F";
F_Assault_SL = "B_A_Soldier_SL_wdl_F";
F_Assault_Eod = "B_A_Soldier_Exp_wdl_F";
F_Assault_Mrk = "B_A_soldier_M_wdl_F";
F_Assault_AT = "B_A_Soldier_LAT_wdl_F";
F_Assault_Amm = "B_A_Soldier_A_wdl_F";
F_Assault_Mg = "B_A_Soldier_AR_wdl_F";
F_Assault_Med = "B_A_Medic_wdl_F";
F_Assault_Uav= "B_A_Soldier_UAV_wdl_F";


F_Recon_Snp = "B_A_ghillie_wdl_F";
F_Recon_Sct = "B_A_ghillie_spotter_wdl_F";

F_Recon_TL = "B_A_Recon_TL_wdl_F";
F_Recon_Mrk = "B_A_Recon_M_wdl_F";
F_Recon_AT = "B_A_Recon_LAT_wdl_F";
F_Recon_Mg = "B_A_Recon_MG_wdl_F";
F_Recon_Eod = "B_A_Recon_Exp_wdl_F";
F_Recon_Med = "B_A_Recon_Medic_wdl_F";
F_Recon_Eng = "B_A_Engineer_F";

F_Diver_TL = "B_diver_TL_F";
F_Diver_Rfl = "B_diver_F";
F_Diver_Eod = "B_diver_exp_F";


F_RADAR = "I_E_Radar_System_01_F";
F_HQ_01 = "Land_Cargo_HQ_V1_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_F";
F_OP_01 = "Land_Cargo_House_V1_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_F" ;

F_Bike_01 = "B_A_Quadbike_01_wdl_F";

F_ABT_01 = "B_A_Boat_Armed_01_hmg_F";

F_UAV_01 = "B_UAV_02_dynamicLoadout_F";
F_UAV_02 = "B_UAV_05_F";
F_UAV_03 = "B_T_UAV_03_dynamicLoadout_F";
F_UGV_01 = "B_T_UGV_01_rcws_olive_F";

F_turret_01 = "B_A_HMG_02_high_wdl_F";
F_turret_02 = "B_A_GMG_01_high_wdl_F";
F_turret_03 = "B_A_Static_AT_wdl_F";

F_Car_01 = "B_A_LSV_01_light_wdl_F";
F_Car_02 = "B_A_LSV_01_armed_wdl_F";
F_Car_03 = "B_A_LSV_01_AT_wdl_F";
F_Car_04 = "";
F_Car_05 = "";
F_Car_06 = "";

F_MRAP_01 = "B_A_MRAP_03_wdl_F";
F_MRAP_02 = "B_A_MRAP_03_hmg_wdl_F";
F_MRAP_03 = "B_A_MRAP_03_gmg_wdl_F";
F_MRAP_04 = "";
F_MRAP_05 = "";
F_MRAP_06 = "";

F_Truck_01 = "B_A_Truck_01_transport_wdl_F";
F_Truck_02 = "B_A_Truck_01_fuel_wdl_F";
F_Truck_03 = "B_A_Truck_01_ammo_wdl_F";
F_Truck_04 = "B_A_Truck_01_Repair_wdl_F";
F_Truck_05 = "B_A_Truck_01_medical_wdl_F";
F_Truck_06 = "";

F_APC_01 = "B_A_APC_tracked_03_cannon_v2_wdl_F";
F_APC_02 = "";
F_APC_03 = "";
F_APC_04 = "";
F_APC_05 = "";
F_APC_06 = "";

F_TNK_01= "B_T_MBT_01_TUSK_F";
F_TNK_02= "";
F_TNK_03= "";
F_TNK_04= "";

F_Art_00 = "B_T_Mortar_01_F";
F_Art_01 = "B_T_MBT_01_arty_F";
F_Art_02 = "B_T_MBT_01_mlrs_F";

F_Heli_01 = "B_A_Heli_light_03_unarmed_F";
F_Heli_02 = "B_A_Heli_light_03_dynamicLoadout_F";
F_Heli_03 = "";
F_Heli_04 = "B_A_Heli_Transport_02_F";
F_Heli_05 = "";

F_Heli_06_G = "B_A_Heli_Attack_01_dynamicLoadout_F";
F_Heli_07_G = "";

F_Plane_01_CAS = "B_Plane_CAS_01_dynamicLoadout_F";
F_Plane_02_CAS = "B_A_Plane_Fighter_05_F";
F_Plane_03 = "B_A_VTOL_01_infantry_F";
F_Plane_04 = "B_A_VTOL_01_vehicle_F";
F_Plane_05 = "";
F_Plane_06 = "";

};
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 if (markerText "Friendly_Handle" == "German Armed Forces _ Woodland _ AEW") then {

F_Officer = "Atlas_B_G_Officer_F";
F_Assault_Eng = "Atlas_B_G_Engineer_F";
F_Assault_TL = "Atlas_B_G_Soldier_TL_F";
F_Assault_SL = "Atlas_B_G_Soldier_SL_F";
F_Assault_Eod = "Atlas_B_G_Soldier_Exp_F";
F_Assault_Mrk = "Atlas_B_G_soldier_M_F";
F_Assault_AT = "Atlas_B_G_Soldier_LAT_F";
F_Assault_Amm = "Atlas_B_G_Soldier_A_F";
F_Assault_Mg = "Atlas_B_G_HeavyGunner_F";
F_Assault_Med = "Atlas_B_G_Medic_F";
F_Assault_Uav= "Atlas_B_G_Soldier_UAV_F";


F_Recon_Snp = "Atlas_B_G_Recon_M_F";
F_Recon_Sct = "Atlas_B_G_Recon_JTAC_F";

F_Recon_TL = "Atlas_B_G_Recon_TL_F";
F_Recon_Mrk = "Atlas_B_G_Recon_M_F";
F_Recon_AT = "Atlas_B_G_Recon_LAT_F";
F_Recon_Mg = "Atlas_B_G_Recon_MG_F";
F_Recon_Eod = "Atlas_B_G_Recon_Exp_F";
F_Recon_Med = "Atlas_B_G_Recon_Medic_F";
F_Recon_Eng = "Atlas_B_G_Engineer_F";

F_Diver_TL = "B_diver_TL_F";
F_Diver_Rfl = "B_diver_F";
F_Diver_Eod = "B_diver_exp_F";


F_RADAR = "I_E_Radar_System_01_F";
F_HQ_01 = "Land_Cargo_HQ_V1_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_F";
F_OP_01 = "Land_Cargo_House_V1_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_F" ;

F_Bike_01 = "B_A_Quadbike_01_wdl_F";

F_ABT_01 = "B_A_Boat_Armed_01_hmg_F";

F_UAV_01 = "B_UAV_02_dynamicLoadout_F";
F_UAV_02 = "B_UAV_05_F";
F_UAV_03 = "B_T_UAV_03_dynamicLoadout_F";
F_UGV_01 = "Atlas_B_G_UGV_01_rcws_F";

F_turret_01 = "Atlas_B_G_HMG_02_high_F";
F_turret_02 = "Atlas_B_G_GMG_01_high_F";
F_turret_03 = "Atlas_B_G_Static_AT_F";

F_Car_01 = "";
F_Car_02 = "";
F_Car_03 = "";
F_Car_04 = "";
F_Car_05 = "";
F_Car_06 = "";

F_MRAP_01 = "Atlas_B_G_MRAP_03_F";
F_MRAP_02 = "Atlas_B_G_MRAP_03_gmg_F";
F_MRAP_03 = "Atlas_B_G_MRAP_03_hmg_F";
F_MRAP_04 = "";
F_MRAP_05 = "";
F_MRAP_06 = "";

F_Truck_01 = "Atlas_I_I_Truck_01_transport_F";
F_Truck_02 = "Atlas_I_I_Truck_01_fuel_F";
F_Truck_03 = "Atlas_I_I_Truck_01_ammo_F";
F_Truck_04 = "Atlas_I_I_Truck_01_Repair_F";
F_Truck_05 = "Atlas_I_I_Truck_01_medical_F";
F_Truck_06 = "";

F_APC_01 = "Atlas_B_G_APC_Wheeled_03_cannon_F";
F_APC_02 = "Atlas_B_G_LT_01_scout_F";
F_APC_03 = "Atlas_B_G_LT_01_cannon_F";
F_APC_04 = "Atlas_B_G_LT_01_AT_F";
F_APC_05 = "Atlas_B_G_LT_01_AA_F";
F_APC_06 = "";

F_TNK_01= "Atlas_B_G_MBT_03_cannon_F";
F_TNK_02= "";
F_TNK_03= "";
F_TNK_04= "";

F_Art_00 = "B_T_Mortar_01_F";
F_Art_01 = "B_T_MBT_01_arty_F";
F_Art_02 = "B_T_MBT_01_mlrs_F";

F_Heli_01 = "";
F_Heli_02 = "";
F_Heli_03 = "";
F_Heli_04 = "Atlas_B_G_Heli_Transport_02_F";
F_Heli_05 = "";

F_Heli_06_G = "";
F_Heli_07_G = "";

F_Plane_01_CAS = "B_Plane_CAS_01_dynamicLoadout_F";
F_Plane_02_CAS = "";
F_Plane_03 = "";
F_Plane_04 = "";
F_Plane_05 = "";
F_Plane_06 = "";


};
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if (markerText "Friendly_Handle" == "Isreal Armed Forces _ Woodland _ AEW") then {

F_Officer = "Atlas_I_I_officer_F";
F_Assault_Eng = "Atlas_I_I_engineer_F";
F_Assault_TL = "Atlas_I_I_Soldier_TL_F";
F_Assault_SL = "Atlas_I_I_Soldier_SL_F";
F_Assault_Eod = "Atlas_I_I_soldier_exp_F";
F_Assault_Mrk = "Atlas_I_I_soldier_M_F";
F_Assault_AT = "Atlas_I_I_Soldier_LAT_F";
F_Assault_Amm = "Atlas_I_I_Soldier_A_F";
F_Assault_Mg = "Atlas_I_I_Soldier_AR_F";
F_Assault_Med = "Atlas_I_I_medic_F";
F_Assault_Uav= "Atlas_I_I_Soldier_UAV_F";


F_Recon_Snp = "Atlas_I_I_sniper_F";
F_Recon_Sct = "Atlas_I_I_spotter_F";

F_Recon_TL = "Atlas_I_I_recon_JTAC_F";
F_Recon_Mrk = "Atlas_I_I_recon_GL_F";
F_Recon_AT = "Atlas_I_I_recon_LAT_F";
F_Recon_Mg = "Atlas_I_I_recon_AR_F";
F_Recon_Eod = "Atlas_I_I_recon_exp_F";
F_Recon_Med = "Atlas_I_I_recon_medic_F";
F_Recon_Eng = "Atlas_I_I_engineer_F";

F_Diver_TL = "B_diver_TL_F";
F_Diver_Rfl = "B_diver_F";
F_Diver_Eod = "B_diver_exp_F";


F_RADAR = "I_E_Radar_System_01_F";
F_HQ_01 = "Land_Cargo_HQ_V1_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_F";
F_OP_01 = "Land_Cargo_House_V1_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_F" ;

F_Bike_01 = "Atlas_I_I_Quadbike_01_F";

F_ABT_01 = "B_A_Boat_Armed_01_hmg_F";

F_UAV_01 = "B_UAV_02_dynamicLoadout_F";
F_UAV_02 = "B_UAV_05_F";
F_UAV_03 = "B_T_UAV_03_dynamicLoadout_F";
F_UGV_01 = "Atlas_I_I_UGV_01_rcws_F";

F_turret_01 = "Atlas_B_G_HMG_02_high_F";
F_turret_02 = "Atlas_B_G_GMG_01_high_F";
F_turret_03 = "Atlas_B_G_Static_AT_F";

F_Car_01 = "";
F_Car_02 = "";
F_Car_03 = "";
F_Car_04 = "";
F_Car_05 = "";
F_Car_06 = "";

F_MRAP_01 = "Atlas_I_I_MRAP_01_F";
F_MRAP_02 = "Atlas_I_I_MRAP_01_hmg_F";
F_MRAP_03 = "Atlas_I_I_MRAP_01_gmg_F";
F_MRAP_04 = "";
F_MRAP_05 = "";
F_MRAP_06 = "";

F_Truck_01 = "Atlas_B_G_Truck_01_transport_F";
F_Truck_02 = "Atlas_B_G_Truck_01_fuel_F";
F_Truck_03 = "Atlas_B_G_Truck_01_ammo_F";
F_Truck_04 = "Atlas_B_G_Truck_01_Repair_F";
F_Truck_05 = "Atlas_B_G_Truck_01_medical_F";
F_Truck_06 = "";

F_APC_01 = "Atlas_I_I_APC_Tracked_01_rcws_F";
F_APC_02 = "Atlas_I_I_APC_Tracked_01_CRV_F";
F_APC_03 = "Atlas_I_I_APC_Tracked_01_AA_F";
F_APC_04 = "";
F_APC_05 = "";
F_APC_06 = "";

F_TNK_01= "Atlas_I_I_MBT_01_cannon_F";
F_TNK_02= "";
F_TNK_03= "";
F_TNK_04= "";

F_Art_00 = "B_T_Mortar_01_F";
F_Art_01 = "B_T_MBT_01_arty_F";
F_Art_02 = "B_T_MBT_01_mlrs_F";

F_Heli_01 = "Atlas_I_I_Heli_Light_01_F";
F_Heli_02 = "Atlas_I_I_Heli_Light_01_dynamicLoadout_F";
F_Heli_03 = "";
F_Heli_04 = "Atlas_I_I_Heli_Transport_01_F";
F_Heli_05 = "";

F_Heli_06_G = "Atlas_I_I_Heli_Attack_01_dynamicLoadout_F";
F_Heli_07_G = "";

F_Plane_01_CAS = "Atlas_I_I_Plane_Fighter_05_F";
F_Plane_02_CAS = "";
F_Plane_03 = "Atlas_I_I_VTOL_01_infantry_F";
F_Plane_04 = "";
F_Plane_05 = "";
F_Plane_06 = "";

};
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if (markerText "Friendly_Handle" == "Livonia Defence Forces _ Woodland _ AEW") then {

F_Officer = "I_E_Officer_F";
F_Assault_Eng = "I_E_Engineer_F";
F_Assault_TL = "I_E_Soldier_TL_F";
F_Assault_SL = "I_E_Soldier_SL_F";
F_Assault_Eod = "I_E_Soldier_Exp_F";
F_Assault_Mrk = "I_E_soldier_M_F";
F_Assault_AT = "I_E_Soldier_LAT_F";
F_Assault_Amm = "I_E_Soldier_A_F";
F_Assault_Mg = "I_E_Soldier_AR_F";
F_Assault_Med = "I_E_Medic_F";
F_Assault_Uav= "I_E_Soldier_UAV_F";


F_Recon_Snp = "I_E_recon_M_F";
F_Recon_Sct = "I_E_recon_exp_F";

F_Recon_TL = "I_E_recon_GL_F";
F_Recon_Mrk = "I_E_recon_F";
F_Recon_AT = "I_E_recon_LAT_F";
F_Recon_Mg = "I_E_recon_AR_F";
F_Recon_Eod = "Atlas_I_I_recon_exp_F";
F_Recon_Med = "Atlas_I_I_recon_medic_F";
F_Recon_Eng = "Atlas_I_I_engineer_F";


F_Diver_TL = "B_diver_TL_F";
F_Diver_Rfl = "B_diver_F";
F_Diver_Eod = "B_diver_exp_F";


F_RADAR = "I_E_Radar_System_01_F";
F_HQ_01 = "Land_Cargo_HQ_V1_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_F";
F_OP_01 = "Land_Cargo_House_V1_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_F" ;

F_Bike_01 = "I_E_Quadbike_01_F";

F_ABT_01 = "B_A_Boat_Armed_01_hmg_F";

F_UAV_01 = "B_UAV_02_dynamicLoadout_F";
F_UAV_02 = "B_UAV_05_F";
F_UAV_03 = "B_T_UAV_03_dynamicLoadout_F";
F_UGV_01 = "I_E_UGV_01_rcws_F";

F_turret_01 = "I_E_HMG_02_high_F";
F_turret_02 = "I_E_GMG_01_F";
F_turret_03 = "I_E_Static_AT_F";

F_Car_01 = "I_E_Offroad_01_F";
F_Car_02 = "I_E_Offroad_01_comms_F";
F_Car_03 = "I_E_Offroad_01_armed_F";
F_Car_04 = "I_E_Van_02_transport_F";
F_Car_05 = "I_E_Van_02_vehicle_F";
F_Car_06 = "";

F_MRAP_01 = "Atlas_I_I_MRAP_01_F";
F_MRAP_02 = "Atlas_I_I_MRAP_01_hmg_F";
F_MRAP_03 = "Atlas_I_I_MRAP_01_gmg_F";
F_MRAP_04 = "";
F_MRAP_05 = "";
F_MRAP_06 = "";

F_Truck_01 = "I_E_Truck_02_transport_F";
F_Truck_02 = "I_E_Truck_02_fuel_F";
F_Truck_03 = "I_E_Truck_02_Ammo_F";
F_Truck_04 = "I_E_Truck_02_Box_F";
F_Truck_05 = "I_E_Truck_02_Medical_F";
F_Truck_06 = "";

F_APC_01 = "I_E_APC_tracked_03_cannon_v2_F";
F_APC_02 = "";
F_APC_03 = "";
F_APC_04 = "";
F_APC_05 = "";
F_APC_06 = "";

F_TNK_01= "B_T_MBT_01_TUSK_F";
F_TNK_02= "";
F_TNK_03= "";
F_TNK_04= "";

F_Art_00 = "B_T_Mortar_01_F";
F_Art_01 = "B_T_MBT_01_arty_F";
F_Art_02 = "B_T_MBT_01_mlrs_F";

F_Heli_01 = "";
F_Heli_02 = "";
F_Heli_03 = "";
F_Heli_04 = "I_E_Heli_light_03_unarmed_F";
F_Heli_05 = "";

F_Heli_06_G = "I_E_Heli_light_03_dynamicLoadout_F";
F_Heli_07_G = "";

F_Plane_01_CAS = "";
F_Plane_02_CAS = "";
F_Plane_03 = "";
F_Plane_04 = "";
F_Plane_05 = "";
F_Plane_06 = "";

};

if (markerText "Friendly_Handle" == "United States Armed Forces _ Desert _ AEW") then {
F_Officer = "Marine_B_USMC_officer_F";
F_Assault_Eng = "Marine_B_USMC_Soldier_GL_F";
F_Assault_TL = "Marine_B_USMC_Soldier_TL_F";
F_Assault_SL = "Marine_B_USMC_Soldier_SL_F";
F_Assault_Eod = "Marine_B_USMC_engineer_F";
F_Assault_Mrk = "Marine_B_USMC_soldier_M_F";
F_Assault_AT = "Marine_B_USMC_Soldier_LAT_F";
F_Assault_Amm = "Marine_B_USMC_Soldier_A_F";
F_Assault_Mg = "Marine_B_USMC_Soldier_AR_F";
F_Assault_Med = "Atlas_I_I_medic_F";
F_Assault_Uav= "Atlas_I_I_Soldier_UAV_F";


F_Recon_Snp = "B_recon_M_F";
F_Recon_Sct = "B_recon_exp_F";

F_Recon_TL = "B_recon_GL_F";
F_Recon_Mrk = "B_recon_medic_F";
F_Recon_AT = "B_recon_LAT_F";
F_Recon_Mg = "B_recon_MG_F";
F_Recon_Eod = "Atlas_I_I_recon_exp_F";
F_Recon_Med = "Atlas_I_I_recon_medic_F";
F_Recon_Eng = "Atlas_I_I_engineer_F";

F_Diver_TL = "B_diver_TL_F";
F_Diver_Rfl = "B_diver_F";
F_Diver_Eod = "B_diver_exp_F";


F_RADAR = "B_Radar_System_01_F";  
F_HQ_01 = "Land_Cargo_HQ_V3_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_sand_F";
F_OP_01 = "Land_Cargo_House_V3_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_sand_F" ;

F_Bike_01 = "B_Quadbike_01_F";

F_ABT_01 = "B_Boat_Armed_01_minigun_F";

F_UAV_01 = "B_UAV_02_dynamicLoadout_F";
F_UAV_02 = "B_UAV_05_F";
F_UAV_03 = "B_T_UAV_03_dynamicLoadout_F";
F_UGV_01 = "B_UGV_01_rcws_F";

F_turret_01 = "B_HMG_01_high_F";
F_turret_02 = "B_GMG_01_high_F";
F_turret_03 = "B_static_AT_F";

F_Car_01 = "B_LSV_01_unarmed_F";
F_Car_02 = "B_LSV_01_armed_F";
F_Car_03 = "B_LSV_01_AT_F";
F_Car_04 = "";
F_Car_05 = "";
F_Car_06 = "";

F_MRAP_01 = "B_MRAP_01_F";
F_MRAP_02 = "B_MRAP_01_hmg_F";
F_MRAP_03 = "B_MRAP_01_gmg_F";
F_MRAP_04 = "";
F_MRAP_05 = "";
F_MRAP_06 = "";

F_Truck_01 = "B_Truck_01_transport_F";
F_Truck_02 = "B_Truck_01_fuel_F";
F_Truck_03 = "B_Truck_01_ammo_F";
F_Truck_04 = "B_Truck_01_Repair_F";
F_Truck_05 = "B_Truck_01_medical_F";
F_Truck_06 = "";

F_APC_01 = "B_APC_Tracked_01_rcws_F";
F_APC_02 = "B_APC_Tracked_01_AA_F";
F_APC_03 = "B_APC_Tracked_01_CRV_F";
F_APC_04 = "B_APC_Wheeled_01_cannon_F";
F_APC_05 = "B_AFV_Wheeled_01_up_cannon_F";
F_APC_06 = "";

F_TNK_01= "B_MBT_01_TUSK_F";
F_TNK_02= "";
F_TNK_03= "";
F_TNK_04= "";

F_Art_00 = "B_Mortar_01_F";
F_Art_01 = "B_MBT_01_arty_F";
F_Art_02 = "B_MBT_01_mlrs_F";

F_Heli_01 = "B_Heli_Light_01_F";
F_Heli_02 = "B_Heli_Light_01_dynamicLoadout_F";
F_Heli_03 = "B_Heli_Transport_01_F";
F_Heli_04 = "B_Heli_Transport_03_F";
F_Heli_05 = "";

F_Heli_06_G = "B_Heli_Attack_01_dynamicLoadout_F";
F_Heli_07_G = "";

F_Plane_01_CAS = "B_Plane_CAS_01_dynamicLoadout_F";
F_Plane_02_CAS = "B_Plane_Fighter_01_F";
F_Plane_03 = "B_T_VTOL_01_infantry_F";
F_Plane_04 = "B_T_VTOL_01_vehicle_F";
F_Plane_05 = "B_T_VTOL_01_armed_F";
F_Plane_06 = "";

};

if (markerText "Friendly_Handle" == "United States Armed Forces _ Woodland _ AEW") then {

F_Officer = "Marine_B_USMC_officer_wdl_F";
F_Assault_Eng = "Marine_B_USMC_Soldier_GL_wdl_F";
F_Assault_TL = "Marine_B_USMC_Soldier_TL_wdl_F";
F_Assault_SL = "Marine_B_USMC_Soldier_SL_wdl_F";
F_Assault_Eod = "Marine_B_USMC_engineer_wdl_F";
F_Assault_Mrk = "Marine_B_USMC_soldier_M_wdl_F";
F_Assault_AT = "Marine_B_USMC_Soldier_LAT_wdl_F";
F_Assault_Amm = "Marine_B_USMC_Soldier_A_wdl_F";
F_Assault_Mg = "Marine_B_USMC_Soldier_AR_wdl_F";
F_Assault_Med = "Atlas_I_I_medic_F";
F_Assault_Uav= "Atlas_I_I_Soldier_UAV_F";


F_Recon_Snp = "B_W_Recon_M_F";
F_Recon_Sct = "B_W_Recon_Exp_F";

F_Recon_TL = "B_W_Recon_GL_F";
F_Recon_Mrk = "B_W_Recon_Medic_F";
F_Recon_AT = "B_W_Recon_LAT_F";
F_Recon_Mg = "B_W_Recon_MG_F";
F_Recon_Eod = "Atlas_I_I_recon_exp_F";
F_Recon_Med = "Atlas_I_I_recon_medic_F";
F_Recon_Eng = "Atlas_I_I_engineer_F";

F_Diver_TL = "B_diver_TL_F";
F_Diver_Rfl = "B_diver_F";
F_Diver_Eod = "B_diver_exp_F";


F_RADAR = "I_E_Radar_System_01_F";
F_HQ_01 = "Land_Cargo_HQ_V1_F";
F_HQ_C_01 = "Land_TripodScreen_01_large_F";
F_OP_01 = "Land_Cargo_House_V1_F" ;
F_OP_C_01 = "Land_TripodScreen_01_dual_v2_F" ;

F_Bike_01 = "B_T_Quadbike_01_F";

F_ABT_01 = "B_Boat_Armed_01_minigun_F";

F_UAV_01 = "B_UAV_02_dynamicLoadout_F";
F_UAV_02 = "B_UAV_05_F";
F_UAV_03 = "B_T_UAV_03_dynamicLoadout_F";
F_UGV_01 = "B_T_UGV_01_rcws_olive_F";

F_turret_01 = "B_HMG_01_high_F";
F_turret_02 = "B_GMG_01_high_F";
F_turret_03 = "B_static_AT_F";

F_Car_01 = "B_T_LSV_01_unarmed_F";
F_Car_02 = "B_T_LSV_01_armed_F";
F_Car_03 = "B_T_LSV_01_AT_F";
F_Car_04 = "";
F_Car_05 = "";
F_Car_06 = "";

F_MRAP_01 = "B_T_MRAP_01_F";
F_MRAP_02 = "B_T_MRAP_01_hmg_F";
F_MRAP_03 = "B_T_MRAP_01_gmg_F";
F_MRAP_04 = "";
F_MRAP_05 = "";
F_MRAP_06 = "";

F_Truck_01 = "B_T_Truck_01_transport_F";
F_Truck_02 = "B_T_Truck_01_fuel_F";
F_Truck_03 = "B_T_Truck_01_ammo_F";
F_Truck_04 = "B_T_Truck_01_Repair_F";
F_Truck_05 = "B_T_Truck_01_medical_F";
F_Truck_06 = "";

F_APC_01 = "B_T_APC_Tracked_01_rcws_F";
F_APC_02 = "B_T_APC_Tracked_01_CRV_F";
F_APC_03 = "B_T_APC_Tracked_01_AA_F";
F_APC_04 = "B_T_APC_Wheeled_01_cannon_F";
F_APC_05 = "B_T_AFV_Wheeled_01_up_cannon_F";
F_APC_06 = "";

F_TNK_01= "B_T_MBT_01_TUSK_F";
F_TNK_02= "";
F_TNK_03= "";
F_TNK_04= "";

F_Art_00 = "B_T_Mortar_01_F";
F_Art_01 = "B_T_MBT_01_arty_F";
F_Art_02 = "B_T_MBT_01_mlrs_F";

F_Heli_01 = "B_Heli_Light_01_F";
F_Heli_02 = "B_Heli_Light_01_dynamicLoadout_F";
F_Heli_03 = "B_Heli_Transport_01_F";
F_Heli_04 = "B_Heli_Transport_03_F";
F_Heli_05 = "";

F_Heli_06_G = "B_Heli_Attack_01_dynamicLoadout_F";
F_Heli_07_G = "";

F_Plane_01_CAS = "B_Plane_CAS_01_dynamicLoadout_F";
F_Plane_02_CAS = "B_Plane_Fighter_01_F";

F_Plane_03 = "B_T_VTOL_01_infantry_F";
F_Plane_04 = "B_T_VTOL_01_vehicle_F";
F_Plane_05 = "B_T_VTOL_01_armed_F";
F_Plane_06 = "";

};

 
 
 
 sleep 5 ;
 
 
 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


F_ASSLT_ENG = [F_Assault_Eng, F_Assault_AT, F_Assault_Eod, F_Assault_Mg];
publicVariable "F_ASSLT_ENG";

F_ASSLT_TEAM = [F_Assault_TL, F_Assault_Amm, F_Assault_AT, F_Assault_Mg, F_Assault_Med, F_Assault_Eng];
publicVariable "F_ASSLT_TEAM";

F_ASSLT_SQD = [F_Assault_SL, F_Assault_Eod, F_Assault_AT, F_Assault_Mg, F_Assault_Med, F_Assault_Amm, F_Assault_Eng, F_Assault_Mrk, F_Assault_AT, F_Assault_Mg, F_Assault_Med, F_Assault_Uav];
publicVariable "F_ASSLT_SQD";

F_SNP_TEAM = [F_Recon_Snp, F_Recon_Sct];
publicVariable "F_SNP_TEAM";

F_RCN_TEAM = [F_Recon_TL, F_Recon_AT, F_Recon_Med, F_Recon_Mg, F_Recon_Eod];
publicVariable "F_RCN_TEAM";

F_RCN_SQD = [F_Recon_TL, F_Recon_AT, F_Recon_Eod, F_Recon_Mg, F_Recon_Eng, F_Recon_Mrk, F_Recon_Med];
publicVariable "F_RCN_SQD";

F_DVR_TEAM = [F_Diver_TL, F_Diver_Eod, F_Diver_Rfl, F_Diver_Eod];
publicVariable "F_DVR_TEAM";

F_OFFICER_TEAM = [F_Officer, F_Assault_Amm];
publicVariable "F_OFFICER_TEAM";


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
sleep 3;


F_Init = "Done";
