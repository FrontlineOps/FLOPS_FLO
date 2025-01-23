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