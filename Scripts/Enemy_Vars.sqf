

if ((markerText "Enemy_Handle" == "CSAT Forces _ Desert") or (markerText "Enemy_Handle" == "Iran Armed Forces _ Desert _ AEW")) then {
East_Ground_Vehicles_Ambient = [ "B_GEN_Offroad_01_gen_F","B_GEN_Van_02_vehicle_F","B_GEN_Van_02_transport_F", "B_GEN_Offroad_01_covered_F", "O_LSV_02_unarmed_F","O_MRAP_02_F","O_Truck_03_transport_F", "O_Truck_02_fuel_F",  "O_Quadbike_01_F","O_UGV_01_F","O_Truck_02_covered_F","O_Truck_02_transport_F","O_Truck_02_transport_F","O_Quadbike_01_F"]; 
East_Ground_Vehicles_Light = [ "O_APC_Wheeled_02_rcws_v2_F",  "O_MRAP_02_gmg_F",  "O_MRAP_02_hmg_F","O_LSV_02_AT_F" ,"O_LSV_02_armed_F"]; 
East_Ground_Vehicles_Heavy = [ "O_APC_Tracked_02_AA_F",  "O_APC_Tracked_02_cannon_F",  "O_MBT_02_cannon_F","O_MBT_04_cannon_F" ]; 
East_Ground_Transport = ["O_MRAP_02_F",  "O_Truck_03_transport_F","O_Truck_02_transport_F", "O_LSV_02_unarmed_F"]; 

East_Air_Transport = ["O_Heli_Light_02_dynamicLoadout_F","O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_covered_F"];
East_Air_Heli = [  "O_Heli_Light_02_dynamicLoadout_F",  "O_Heli_Attack_02_dynamicLoadout_F"]; 
East_Air_Jet = ["O_Plane_Fighter_02_F",  "O_Plane_CAS_02_dynamicLoadout_F"]; 

East_Units = ["O_HeavyGunner_F", "O_Soldier_AT_F", "O_Soldier_GL_F", "O_Soldier_lite_F",  "O_Soldier_F","O_Soldier_AR_F","O_soldier_exp_F","O_engineer_F","O_soldier_M_F","O_soldier_UAV_F","O_Sharpshooter_F", "O_Soldier_lite_F"];
East_Units_Officers = ["O_officer_F","O_T_Officer_F"];

East_Groups = [
(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry"),
(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AT"),
(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA"),
(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam"),
(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Support" >> "OI_support_Mort"),
(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Support" >> "OI_support_MG"),
(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad_Weapons")
];
};


if ((markerText "Enemy_Handle" == "CSAT Forces _ Woodland") or (markerText "Enemy_Handle" == "Chinese Armed Forces _ Woodland _ AEW")) then {
East_Ground_Vehicles_Ambient = [ "B_GEN_Offroad_01_gen_F","B_GEN_Van_02_vehicle_F","B_GEN_Van_02_transport_F", "B_GEN_Offroad_01_covered_F", "O_T_LSV_02_unarmed_F","O_T_MRAP_02_ghex_F","O_T_Truck_03_transport_ghex_F", "O_Truck_02_fuel_F",  "O_T_Quadbike_01_ghex_F","O_T_UGV_01_ghex_F", "O_T_Truck_02_transport_F","O_T_Truck_02_transport_F","O_T_Quadbike_01_ghex_F"]; 
East_Ground_Vehicles_Light = [ "O_T_APC_Wheeled_02_rcws_v2_ghex_F",  "O_T_MRAP_02_gmg_ghex_F",  "O_T_MRAP_02_hmg_ghex_F","O_T_LSV_02_AT_F" ,"O_T_LSV_02_armed_F","O_T_UGV_01_rcws_ghex_F"]; 
East_Ground_Vehicles_Heavy = [ "O_T_APC_Tracked_02_AA_ghex_F",  "O_T_APC_Tracked_02_cannon_ghex_F",  "O_T_MBT_02_cannon_ghex_F","O_T_MBT_04_cannon_F" ]; 
East_Ground_Transport = ["O_T_MRAP_02_ghex_F",  "O_T_Truck_03_transport_ghex_F","O_T_Truck_02_transport_F", "O_T_LSV_02_unarmed_F"]; 

East_Air_Transport = ["O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_covered_F"];
East_Air_Heli = ["O_Heli_Light_02_dynamicLoadout_F",  "O_Heli_Attack_02_dynamicLoadout_F"]; 
East_Air_Jet = ["O_T_VTOL_02_infantry_dynamicLoadout_F", "O_Plane_CAS_02_dynamicLoadout_F"]; 

East_Units = ["O_T_Soldier_TL_F","O_T_Soldier_F","O_T_Soldier_LAT_F","O_T_Soldier_M_F","O_T_Medic_F","O_T_Soldier_AR_F","O_T_Soldier_GL_F", "O_T_Soldier_AT_F","O_T_Soldier_Exp_F"];
East_Units_Officers = ["O_officer_F","O_T_Officer_F"];

East_Groups = [
(configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfSentry"),
(configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfTeam_AT"),
(configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfTeam_AA"),
(configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfTeam"),
(configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Support" >> "O_T_support_Mort"),
(configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Support" >> "O_T_support_MG"),
(configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfSquad_Weapons")
];
}; 


 if (markerText "Enemy_Handle" == "Altis Armed Forces _ Woodland") then {
East_Ground_Vehicles_Ambient = ["I_MRAP_03_F","I_MRAP_03_gmg_F", "I_Truck_02_covered_F", "I_Truck_02_ammo_F", "I_Truck_02_fuel_F", "I_Truck_02_transport_F"]; 
East_Ground_Vehicles_Light = [ "I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F", "I_APC_Wheeled_03_cannon_F", "I_LT_01_cannon_F", "I_LT_01_AA_F"]; 
East_Ground_Vehicles_Heavy = [ "I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F"]; 
East_Ground_Transport = ["I_MRAP_03_F", "I_Truck_02_covered_F",  "I_Truck_02_transport_F"]; 

East_Air_Transport = ["I_Heli_Transport_02_F","I_Heli_light_03_unarmed_F"];
East_Air_Heli = ["I_Heli_light_03_dynamicLoadout_F"]; 
East_Air_Jet = ["I_Plane_Fighter_03_dynamicLoadout_F", "I_Plane_Fighter_04_F"]; 

East_Units = ["I_Soldier_SL_F","I_Soldier_TL_F","I_Soldier_lite_F","I_soldier_F","I_Soldier_LAT2_F","I_Soldier_GL_F","I_Soldier_AR_F","I_Soldier_M_F","I_engineer_F","I_medic_F"];
East_Units_Officers = ["I_officer_F"];

East_Groups = [
(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry"),
(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam_AT"),
(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam_AA"),
(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "I_InfTeam_Light"),
(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad"),
(configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad_Weapons")
];
}; 


if (markerText "Enemy_Handle" == "Livonia Defence Forces _ Woodland") then {
East_Ground_Vehicles_Ambient = ["I_E_Offroad_01_F","I_E_Van_02_transport_F", "I_E_Offroad_01_covered_F", "I_E_Truck_02_transport_F", "I_E_Truck_02_fuel_F", "I_E_Truck_02_F", "I_E_Truck_02_MRL_F"]; 
East_Ground_Vehicles_Light = [ "I_E_UGV_01_rcws_F", "O_G_Offroad_01_armed_F", "O_G_Offroad_01_AT_F"]; 
East_Ground_Vehicles_Heavy = [ "I_E_APC_tracked_03_cannon_F"]; 
East_Ground_Transport = ["I_E_Van_02_transport_F", "I_E_Offroad_01_F", "I_E_Offroad_01_covered_F",  "I_E_Truck_02_F", "I_E_Truck_02_transport_F"]; 

East_Air_Transport = ["I_Heli_Transport_02_F","I_E_Heli_light_03_unarmed_F"];
East_Air_Heli = ["I_E_Heli_light_03_dynamicLoadout_F"]; 
East_Air_Jet = ["I_Plane_Fighter_03_dynamicLoadout_F", "I_Plane_Fighter_04_F"]; 

East_Units = ["I_E_Soldier_F","I_E_Soldier_A_F","I_E_Soldier_AR_F","I_E_Soldier_lite_F","I_E_soldier_M_F","I_E_Soldier_SL_F","I_E_Soldier_LAT2_F", "I_E_RadioOperator_F", "I_E_Soldier_Exp_F"];
East_Units_Officers = ["I_E_Officer_F"];

East_Groups = [
(configfile >> "CfgGroups" >> "Indep" >> "IND_E_F" >> "Infantry" >> "I_E_InfSentry"),
(configfile >> "CfgGroups" >> "Indep" >> "IND_E_F" >> "Infantry" >> "I_E_InfTeam"),
(configfile >> "CfgGroups" >> "Indep" >> "IND_E_F" >> "Infantry" >> "I_E_InfSquad")
];
}; 


 if (markerText "Enemy_Handle" ==  "Sefrawi Freedom Forces _ Desert _ Western Sahara") then {
East_Ground_Vehicles_Ambient = [ "O_SFIA_Truck_02_covered_lxWS","I_C_Offroad_02_AT_F","I_C_Offroad_02_LMG_F", "O_SFIA_Offroad_lxWS", "I_C_Offroad_02_unarmed_F","O_SFIA_Truck_02_transport_lxWS","I_C_Offroad_02_LMG_F","O_T_Quadbike_01_ghex_F"]; 
East_Ground_Vehicles_Light = ["O_SFIA_Offroad_armed_lxWS",  "I_C_Offroad_02_LMG_F",  "I_C_Offroad_02_AT_F","O_SFIA_Offroad_AT_lxWS" ,"I_C_Offroad_02_LMG_F", "O_SFIA_Truck_02_aa_lxWS", "O_SFIA_Truck_02_MRL_lxWS"]; 
East_Ground_Vehicles_Heavy = [ "O_SFIA_APC_Tracked_02_30mm_lxWS",  "O_SFIA_APC_Wheeled_02_hmg_lxWS",  "O_SFIA_Truck_02_aa_lxWS"]; 
East_Ground_Transport = ["O_SFIA_Offroad_lxWS",  "O_SFIA_Truck_02_transport_lxWS","O_SFIA_Truck_02_covered_lxWS"]; 

East_Air_Transport = ["O_Heli_Light_02_dynamicLoadout_F", "O_Heli_Transport_04_covered_F"];
East_Air_Heli = ["O_SFIA_Heli_Attack_02_dynamicLoadout_lxWS"]; 
East_Air_Jet = ["O_SFIA_Heli_Attack_02_dynamicLoadout_lxWS"]; 

East_Units = ["O_SFIA_Soldier_universal_lxWS","O_SFIA_Soldier_TL_lxWS","O_SFIA_Soldier_AAA_lxWS","O_SFIA_Soldier_AAT_lxWS","O_SFIA_Soldier_AR_lxWS","O_SFIA_medic_lxWS","O_SFIA_exp_lxWS","O_SFIA_Soldier_GL_lxWS","O_SFIA_soldier_aa_lxWS","O_SFIA_soldier_at_lxWS","O_SFIA_repair_lxWS","O_SFIA_soldier_lxWS","O_SFIA_sharpshooter_lxWS"];
East_Units_Officers = ["O_SFIA_officer_lxWS"];

East_Groups = [
(configfile >> "CfgGroups" >> "East" >> "OPF_SFIA_lxWS" >> "Infantry" >> "OSFIA_InfTeam_lxWS"),
(configfile >> "CfgGroups" >> "East" >> "OPF_SFIA_lxWS" >> "Infantry" >> "OSFIA_InfTeam_lxWS"),
(configfile >> "CfgGroups" >> "East" >> "OPF_SFIA_lxWS" >> "Infantry" >> "OSFIA_InfSquad_lxWS")
];
}; 


 if (markerText "Enemy_Handle" ==  "Tura tribe insurgents _ Desert _ Western Sahara") then {
East_Ground_Vehicles_Ambient = [ "O_SFIA_Offroad_lxWS","I_C_Offroad_02_AT_F","I_C_Offroad_02_LMG_F", "O_Tura_Offroad_armor_lxWS", "I_C_Offroad_02_unarmed_F","O_SFIA_Truck_02_transport_lxWS","I_C_Offroad_02_LMG_F","O_T_Quadbike_01_ghex_F"]; 
East_Ground_Vehicles_Light = ["O_Tura_Offroad_armor_lxWS",  "O_Tura_Offroad_armor_AT_lxWS",  "O_Tura_Offroad_armor_armed_lxWS","O_SFIA_Offroad_AT_lxWS" ,"I_C_Offroad_02_LMG_F", "O_Tura_Truck_02_aa_lxWS"]; 
East_Ground_Vehicles_Heavy = [ "O_SFIA_APC_Tracked_02_cannon_lxWS", "O_Tura_Truck_02_aa_lxWS", "O_SFIA_Truck_02_MRL_lxWS"]; 
East_Ground_Transport = ["O_Tura_Offroad_armor_lxWS",  "O_SFIA_Truck_02_transport_lxWS","O_SFIA_Offroad_lxWS"]; 

East_Air_Transport = ["I_C_Heli_Light_01_civil_F", "O_Heli_Transport_04_covered_F"];
East_Air_Heli = ["O_Heli_Light_02_dynamicLoadout_F"]; 
East_Air_Jet = ["O_Heli_Light_02_dynamicLoadout_F"]; 

East_Units = ["O_Tura_watcher_lxWS","O_Tura_deserter_lxWS","O_Tura_enforcer_lxWS","O_Tura_hireling_lxWS","O_Tura_scout_lxWS","O_Tura_medic2_lxWS","O_Tura_thug_lxWS"];
East_Units_Officers = ["O_SFIA_officer_lxWS"];

East_Groups = [
(configfile >> "CfgGroups" >> "East" >> "OPF_TURA_lxWS" >> "Infantry" >> "B_Tura_InfTeam_lxWS"),
(configfile >> "CfgGroups" >> "East" >> "OPF_TURA_lxWS" >> "Infantry" >> "B_Tura_InfTeam_lxWS"),
(configfile >> "CfgGroups" >> "East" >> "OPF_TURA_lxWS" >> "Infantry" >> "B_Tura_InfSquad_lxWS")
];
}; 


 if (markerText "Enemy_Handle" ==  "Syndikat Insurgents _ Woodland") then {
East_Ground_Vehicles_Ambient = [ "I_G_Offroad_01_armed_F","I_C_Offroad_02_AT_F","I_C_Offroad_02_LMG_F", "I_C_Offroad_02_unarmed_F", "I_C_Offroad_02_unarmed_F","I_C_Van_01_transport_F","I_C_Van_02_transport_F","O_T_Quadbike_01_ghex_F"]; 
East_Ground_Vehicles_Light = ["I_G_Offroad_01_armed_F",  "I_C_Offroad_02_LMG_F",  "I_C_Offroad_02_AT_F","I_G_Offroad_01_armed_F" ,"I_C_Offroad_02_LMG_F"]; 
East_Ground_Vehicles_Heavy = [ "I_E_APC_tracked_03_cannon_F",  "I_C_Offroad_02_AT_F",  "I_G_Offroad_01_armed_F"]; 
East_Ground_Transport = ["I_C_Van_01_transport_F",  "I_C_Van_02_transport_F","I_C_Offroad_02_unarmed_F"]; 

East_Air_Transport = ["I_C_Heli_Light_01_civil_F"];
East_Air_Heli = ["I_C_Heli_Light_01_civil_F"]; 
East_Air_Jet = ["I_C_Heli_Light_01_civil_F"]; 

East_Units = ["I_C_Soldier_Para_8_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_2_F", "I_C_Soldier_Para_1_F"];
East_Units_Officers = ["I_C_Soldier_base_unarmed_F"];

East_Groups = [
(configfile >> "CfgGroups" >> "Indep" >> "IND_C_F" >> "Infantry" >> "ParaShockTeam"),
(configfile >> "CfgGroups" >> "Indep" >> "IND_C_F" >> "Infantry" >> "ParaFireTeam"),
(configfile >> "CfgGroups" >> "Indep" >> "IND_C_F" >> "Infantry" >> "ParaCombatGroup")
];
}; 


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Welcome to the Vietnam /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



if (markerText "Enemy_Handle" == "North Vietnam _ Woodland _ SOG Praire Fire") then {
East_Ground_Vehicles_Ambient = [ "vn_o_wheeled_z157_repair_nvam","vn_o_wheeled_z157_03_nvam","vn_o_wheeled_z157_ammo_nvam", "vn_o_wheeled_btr40_02_nvam", "vn_o_wheeled_z157_fuel_nvam","vn_o_wheeled_btr40_mg_01_nvam","vn_o_wheeled_btr40_mg_02_nvam", "vn_o_wheeled_z157_mg_01_nvam",  "vn_o_wheeled_z157_mg_02_nvam"]; 
East_Ground_Vehicles_Light = [ "vn_o_wheeled_btr40_mg_01_nvam",  "vn_o_wheeled_btr40_mg_02_nvam",  "vn_o_wheeled_z157_mg_01_nvam","vn_o_wheeled_z157_mg_02_nvam" ]; 
East_Ground_Vehicles_Heavy = [ "vn_o_armor_m113_01",  "vn_o_armor_m113_acav_03",  "vn_o_armor_m113_acav_01"]; 
East_Ground_Transport = ["vn_o_wheeled_z157_02_nvam",  "vn_o_wheeled_z157_01_nvam","vn_o_wheeled_btr40_01_nvam"]; 

East_Air_Transport = ["vn_o_air_mi2_01_01","vn_o_air_mi2_01_03","vn_o_air_mi2_04_03", "vn_o_air_mi2_05_06"];
East_Air_Heli = [  "vn_o_air_mi2_05_02",  "vn_o_air_mi2_03_03"]; 
East_Air_Jet = ["vn_o_air_mig19_cap",  "vn_o_air_mig19_cas"]; 

East_Units = ["vn_o_men_nva_65_21", "vn_o_men_nva_65_25", "vn_o_men_nva_65_22", "vn_o_men_nva_65_24",  "vn_o_men_nva_65_22","vn_o_men_nva_65_12","vn_o_men_nva_65_09","vn_o_men_nva_65_13","vn_o_men_nva_65_05","vn_o_men_nva_65_06","vn_o_men_nva_65_14", "vn_o_men_nva_65_14"];
East_Units_Officers = ["vn_o_men_nva_65_01"];

East_Groups = [];
};




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 if (markerText "Enemy_Handle" == "Afghan Insurgents _ CUP") then {
East_Ground_Vehicles_Ambient = ["CUP_O_Hilux_unarmed_TK_INS",  "CUP_O_V3S_Open_TKM", "CUP_O_Hilux_UB32_TK_INS", "CUP_O_Hilux_M2_TK_INS", "CUP_O_V3S_Refuel_TKM", "CUP_O_Hilux_DSHKM_TK_INS", "CUP_O_Hilux_metis_TK_INS"]; 
East_Ground_Vehicles_Light = ["CUP_O_Hilux_M2_TK_INS", "CUP_O_Hilux_DSHKM_TK_INS", "CUP_O_Hilux_UB32_TK_INS", "CUP_O_Hilux_SPG9_TK_INS", "CUP_O_Hilux_metis_TK_INS"]; 
East_Ground_Vehicles_Heavy = ["CUP_O_BMP2_CHDKZ","CUP_O_BMP2_CHDKZ", "Opf_I_I_Offroad_01_AT_F", "CUP_O_Hilux_SPG9_TK_INS", "Opf_I_I_Offroad_01_armed_F", "CUP_O_Hilux_UB32_TK_INS"];  
East_Ground_Transport = ["CUP_O_Hilux_unarmed_TK_INS",  "CUP_O_V3S_Open_TKM"]; 

East_Air_Transport = [""];
East_Air_Heli = ["O_Heli_Light_02_dynamicLoadout_F"]; 
East_Air_Jet = ["O_Heli_Light_02_dynamicLoadout_F"]; 

East_Units = ["CUP_O_TK_INS_Soldier_TL","CUP_O_TK_INS_Soldier_MG","CUP_O_TK_INS_Soldier_GL","CUP_O_TK_INS_Soldier_AT","CUP_O_TK_INS_Soldier","CUP_O_TK_INS_Soldier_MG","CUP_O_TK_INS_Soldier_AR","CUP_O_TK_INS_Sniper", "CUP_O_TK_INS_Soldier_Enfield", "CUP_O_TK_INS_Soldier_FNFAL"];
East_Units_Officers = ["Opf_I_I_Soldier_Base_unarmed_F"];

East_Groups = [
(configfile >> "CfgGroups" >> "East" >> "CUP_O_TK_MILITIA" >> "Infantry" >> "CUP_O_TK_MILITIA_Patrol"),
(configfile >> "CfgGroups" >> "East" >> "CUP_O_TK_MILITIA" >> "Infantry" >> "CUP_O_TK_MILITIA_Group"),
(configfile >> "CfgGroups" >> "East" >> "CUP_O_TK_MILITIA" >> "Infantry" >> "CUP_O_TK_MILITIA_ATTeam"),
(configfile >> "CfgGroups" >> "East" >> "CUP_O_TK_MILITIA" >> "Infantry" >> "CUP_O_TK_MILITIA_AATeam")
];
}; 


 if (markerText "Enemy_Handle" == "Afghan Armed Forces _ CUP") then {
East_Ground_Vehicles_Ambient = ["CUP_O_LR_Transport_TKA",  "CUP_O_Ural_TKA", "CUP_O_UAZ_Open_TKA", "CUP_O_LR_MG_TKM", "CUP_O_LR_MG_TKM", "CUP_O_Hilux_AGS30_TK_INS", "CUP_O_Hilux_DSHKM_TK_INS", "CUP_O_Hilux_M2_TK_INS", "CUP_O_Hilux_SPG9_TK_INS","CUP_O_BTR40_MG_TKM","CUP_O_MTLB_pk_TK_MILITIA"]; 
East_Ground_Vehicles_Light = ["CUP_O_LR_MG_TKM", "CUP_O_LR_MG_TKM", "CUP_O_Hilux_AGS30_TK_INS", "CUP_O_Hilux_DSHKM_TK_INS", "CUP_O_Hilux_M2_TK_INS", "CUP_O_Hilux_SPG9_TK_INS","CUP_O_BTR40_MG_TKM","CUP_O_MTLB_pk_TK_MILITIA"]; 
East_Ground_Vehicles_Heavy = ["CUP_O_BTR80_TK","CUP_O_BTR80A_TK", "CUP_O_BMP1P_TKA", "CUP_O_BMP2_TKA", "CUP_O_BMP2_TKA", "CUP_O_ZSU23_Afghan_TK", "CUP_O_ZSU23_TK", "CUP_O_BMP2_ZU_TKA", "CUP_O_T55_TK", "CUP_O_T72_TKA", "CUP_O_T72_TKA"]; 
East_Ground_Transport = ["CUP_O_LR_Transport_TKA",  "CUP_O_Ural_TKA", "CUP_O_UAZ_Open_TKA"]; 

East_Air_Transport = ["CUP_O_UH1H_TKA","CUP_O_Mi17_TK"];
East_Air_Heli = ["CUP_O_UH1H_gunship_TKA",  "CUP_O_Mi24_D_Dynamic_TK"]; 
East_Air_Jet = ["CUP_O_Su25_Dyn_TKA"]; 

East_Units = ["CUP_O_TK_Soldier_SL","CUP_O_TK_Soldier","CUP_O_TK_Soldier_Backpack","CUP_O_TK_Soldier_AT","CUP_O_TK_Soldier_GL","CUP_O_TK_Soldier_AR","CUP_O_TK_Soldier_MG","CUP_O_TK_Sniper","CUP_O_TK_Soldier_HAT","CUP_O_TK_Engineer"];
East_Units_Officers = ["CUP_O_TK_Officer"];

East_Groups = [
(configfile >> "CfgGroups" >> "East" >> "CUP_O_TK" >> "Infantry" >> "CUP_O_TK_InfantrySection"),
(configfile >> "CfgGroups" >> "East" >> "CUP_O_TK" >> "Infantry" >> "CUP_O_TK_InfantrySectionAT"),
(configfile >> "CfgGroups" >> "East" >> "CUP_O_TK" >> "Infantry" >> "CUP_O_TK_InfantrySectionAA"),
(configfile >> "CfgGroups" >> "East" >> "CUP_O_TK" >> "Infantry" >> "CUP_O_TK_InfantrySectionMG"),
(configfile >> "CfgGroups" >> "East" >> "CUP_O_TK" >> "Infantry" >> "CUP_O_TK_InfantrySquad"),
(configfile >> "CfgGroups" >> "East" >> "CUP_O_TK" >> "Infantry" >> "CUP_O_TK_InfantrySquad")
];
}; 





if (markerText "Enemy_Handle" == "African Insurgents _ POF") then {
East_Ground_Vehicles_Ambient = ["LOP_AFR_OPF_Offroad","LOP_AFR_OPF_Truck","I_G_Van_01_transport_F","I_G_Van_02_transport_F","LOP_AFR_OPF_BTR60","LOP_AFR_OPF_Offroad_AT","LOP_AFR_OPF_Offroad_M2","LOP_AFR_OPF_Nissan_PKM","I_C_Offroad_02_AT_F","I_C_Offroad_02_LMG_F","O_G_Offroad_01_AT_F","O_G_Offroad_01_armed_F"]; 
East_Ground_Vehicles_Light = ["LOP_AFR_OPF_BTR60","LOP_AFR_OPF_Offroad_AT","LOP_AFR_OPF_Offroad_M2","LOP_AFR_OPF_Nissan_PKM","I_C_Offroad_02_AT_F","I_C_Offroad_02_LMG_F","O_G_Offroad_01_AT_F","O_G_Offroad_01_armed_F"]; 
East_Ground_Vehicles_Heavy = ["LOP_AFR_OPF_T34", "LOP_ChDKZ_BMP1","LOP_AFR_OPF_M113_W","LOP_AFR_OPF_BTR60"]; 
East_Ground_Transport = ["LOP_AFR_OPF_Offroad","LOP_AFR_OPF_Truck","I_G_Van_01_transport_F","I_G_Van_02_transport_F"]; 

East_Air_Transport = ["rhsgref_ins_Mi8amt"];
East_Air_Heli = ["rhsgref_ins_Mi8amt"]; 
East_Air_Jet = ["rhsgref_ins_Mi8amt"]; 

East_Units = ["LOP_AFRCiv_Soldier_IED","LOP_AFRCiv_Soldier_Medic","LOP_AFRCiv_Soldier","LOP_AFRCiv_Soldier_AR","LOP_AFRCiv_Soldier_AT","LOP_AFRCiv_Soldier_Marksman","LOP_AFRCiv_Soldier_SL","LOP_AFR_OPF_Infantry_SL","LOP_AFR_OPF_Infantry_Driver"];
East_Units_Officers = ["LOP_AFR_OPF_Infantry_SL"];


}; 

 if (markerText "Enemy_Handle" == "Syrian Armed Forces _ POF") then {
East_Ground_Vehicles_Ambient = ["LOP_SYR_Ural_open","LOP_SYR_UAZ_Open","LOP_SLA_BTR70","LOP_SYR_BTR80","LOP_SYR_UAZ_DshKM","LOP_SYR_UAZ_SPG","LOP_IRA_Landrover_M2","LOP_IRA_Landrover_SPG9","LOP_SYR_UAZ"]; 
East_Ground_Vehicles_Light = ["LOP_SLA_BTR70","LOP_SYR_BTR80","LOP_SYR_UAZ_DshKM","LOP_SYR_UAZ_SPG","LOP_IRA_Landrover_M2","LOP_IRA_Landrover_SPG9","LOP_SYR_UAZ"]; 
East_Ground_Vehicles_Heavy = ["LOP_SYR_ZSU234","LOP_ISTS_OPF_BMP2","LOP_SYR_BMP2","LOP_SYR_BMP1","LOP_SYR_T55","LOP_SYR_T72BA"]; 
East_Ground_Transport = ["LOP_SYR_Ural_open","LOP_SYR_UAZ_Open"]; 

East_Air_Transport = ["rhsgref_ins_Mi8amt"];
East_Air_Heli = ["rhsgref_ins_Mi8amt"]; 
East_Air_Jet = ["rhsgref_ins_Mi8amt"]; 

East_Units = ["LOP_SYR_Infantry_AT_Asst","LOP_SYR_Infantry_AT","LOP_SYR_Infantry_Corpsman","LOP_SYR_Infantry_Engineer","LOP_SYR_Infantry_Grenadier","LOP_SYR_Infantry_MG_Asst","LOP_SYR_Infantry_MG","LOP_SYR_Infantry_SL","LOP_SYR_Infantry_Marksman","LOP_SYR_Infantry_TL"];
East_Units_Officers = ["LOP_SYR_Infantry_SL"];

};

 if (markerText "Enemy_Handle" == "ISIS Insurgents _ POF") then {
East_Ground_Vehicles_Ambient = ["rhs_tigr_sts_3camo_msv", "rhs_tigr_sts_msv","rhs_tigr_msv", "rhs_tigr_3camo_msv", "rhs_gaz66o_msv", "rhs_gaz66_repair_msv", "rhs_gaz66_vdv"]; 
East_Ground_Vehicles_Light = ["LOP_ISTS_OPF_Nissan_PKM","O_G_Offroad_01_AT_F","O_G_Offroad_01_armed_F","LOP_ISTS_OPF_Landrover_SPG9","LOP_ISTS_OPF_Landrover_M2","LOP_TKA_BTR70"]; 
East_Ground_Vehicles_Heavy = ["LOP_AFR_OPF_T55", "LOP_TKA_BMP2D","LOP_TKA_BTR70"]; 
East_Ground_Transport = ["O_G_Van_01_transport_F","LOP_AM_OPF_BTR60","O_G_Offroad_01_F","LOP_ISTS_OPF_Landrover","LOP_US_Ural_open"]; 

East_Air_Transport = ["rhsgref_ins_Mi8amt"];
East_Air_Heli = ["rhsgref_ins_Mi8amt"]; 
East_Air_Jet = ["rhsgref_ins_Mi8amt"]; 

East_Units = ["LOP_ISTS_OPF_Infantry_Engineer","LOP_ISTS_OPF_Infantry_Corpsman","LOP_ISTS_OPF_Infantry_TL","LOP_ISTS_OPF_Infantry_Rifleman_5","LOP_ISTS_OPF_Infantry_AR_Asst_2","LOP_ISTS_OPF_Infantry_AR_2","LOP_ISTS_OPF_Infantry_AR","LOP_ISTS_OPF_Infantry_AR","LOP_ISTS_OPF_Infantry_SL","LOP_ISTS_OPF_Infantry_Rifleman","LOP_ISTS_OPF_Infantry_Rifleman"];
East_Units_Officers = ["LOP_ISTS_OPF_Infantry_SL"];

}; 

 if (markerText "Enemy_Handle" == "Iran Armed Forces _ POF") then {
East_Ground_Vehicles_Ambient = ["LOP_IRAN_UAZ","LOP_IRAN_KAMAZ_Transport","LOP_IRAN_UAZ_Open","LOP_IRAN_KAMAZ_Covered","LOP_IRAN_Ural_open", "LOP_IRAN_BTR60","LOP_IRAN_BTR70","LOP_IRAN_UAZ_AGS","LOP_IRAN_UAZ_DshKM","LOP_IRAN_UAZ_SPG"]; 
East_Ground_Vehicles_Light = ["LOP_IRAN_BTR60","LOP_IRAN_BTR70","LOP_IRAN_UAZ_AGS","LOP_IRAN_UAZ_DshKM","LOP_IRAN_UAZ_SPG"]; 
East_Ground_Vehicles_Heavy = ["LOP_IRAN_T72BA","LOP_IRAN_ZSU234","LOP_IRAN_BM21","LOP_IRAN_BTR80LOP_IRAN_BMP1","LOP_IRAN_BMP2"]; 
East_Ground_Transport = ["LOP_IRAN_UAZ","LOP_IRAN_KAMAZ_Transport","LOP_IRAN_UAZ_Open","LOP_IRAN_KAMAZ_Covered","LOP_IRAN_Ural_open"]; 

East_Air_Transport = ["LOP_IRAN_CH47F","LOP_IRAN_UH1Y_UN","rhsgref_ins_Mi8amt"];
East_Air_Heli = ["LOP_IRAN_AH1Z_GS"]; 
East_Air_Jet = ["LOP_IRAN_AH1Z_GS"]; 

East_Units = ["LOP_IRAN_Infantry_SF_Marksman","LOP_IRAN_Infantry_SF_LAT","LOP_IRAN_Infantry_SF_junior_sergeant","LOP_IRAN_Infantry_AA","LOP_IRAN_Infantry_engineer","LOP_IRAN_Infantry_Grenadier","LOP_IRAN_Infantry_RPG","LOP_IRAN_Infantry_AR_2","LOP_IRAN_Infantry_Marksman","LOP_IRAN_Infantry_medic","LOP_IRAN_Infantry_Rifleman_2","LOP_IRAN_Infantry_Rifleman","LOP_IRAN_Infantry_Light","LOP_IRAN_Infantry_LAT","LOP_IRAN_Infantry_sergeant","LOP_IRAN_Infantry_SF_engineer","LOP_IRAN_Infantry_SF_Grenadier","LOP_IRAN_Infantry_SF_AR","LOP_IRAN_Infantry_SF_RPG"];
East_Units_Officers = ["LOP_IRAN_Infantry_sergeant"];

}; 





if (markerText "Enemy_Handle" == "East Europe Insurgents _ Desert _ AEW") then {
East_Ground_Vehicles_Ambient = ["Opf_I_I_Offroad_01_F",  "Opf_I_I_Van_01_transport_F", "Opf_I_I_Offroad_01_F", "Opf_I_I_Offroad_01_armed_F", "Opf_I_I_Offroad_01_armed_F", "Opf_I_I_Offroad_01_AT_F"]; 
East_Ground_Vehicles_Light = ["Opf_I_I_Offroad_01_armed_F", "Opf_I_I_Offroad_01_armed_F", "Opf_O_S_APC_Tracked_02_cannon_F", "Opf_I_I_Offroad_01_AT_F"]; 
East_Ground_Vehicles_Heavy = ["Opf_O_S_APC_Tracked_02_cannon_F","Opf_O_S_APC_Tracked_02_cannon_F", "Opf_I_I_Offroad_01_AT_F", "Opf_I_I_Offroad_01_AT_F", "Opf_I_I_Offroad_01_armed_F"]; 
East_Ground_Transport = ["Opf_I_I_Offroad_01_F",  "Opf_I_I_Van_01_transport_F"]; 

East_Air_Transport = ["Opf_I_R_Heli_Light_02_unarmed_F"];
East_Air_Heli = ["O_Heli_Light_02_dynamicLoadout_F"]; 
East_Air_Jet = ["O_Heli_Light_02_dynamicLoadout_F"]; 

East_Units = ["Opf_I_I_Soldier_1_F","Opf_I_I_Soldier_2_F","Opf_I_I_Soldier_3_F","Opf_I_I_Soldier_4_F","Opf_I_I_Soldier_5_F","Opf_I_I_Soldier_6_F","Opf_I_I_Soldier_7_F","Opf_I_I_Soldier_8_F", "Opf_O_P_soldier_TL_F", "Opf_O_P_soldier_1_F", "Opf_O_P_soldier_LAT_F", "Opf_O_P_soldier_M_F", "Opf_O_P_soldier_GL_F", "Opf_O_P_soldier_AR_F", "Opf_O_P_soldier_exp_F", "Opf_O_P_medic_F"];
East_Units_Officers = ["Opf_I_I_Soldier_Base_unarmed_F"];

East_Groups = [
(configfile >> "CfgGroups" >> "Indep" >> "Opf_IND_I_F" >> "Infantry" >> "InsurgentFireTeam"),
(configfile >> "CfgGroups" >> "Indep" >> "Opf_IND_I_F" >> "Infantry" >> "InsurgentShockTeam"),
(configfile >> "CfgGroups" >> "Indep" >> "Opf_IND_I_F" >> "Infantry" >> "InsurgentCombatGroup")
];
}; 


 if (markerText "Enemy_Handle" == "East Europe Insurgents _ Woodland _ AEW") then {
East_Ground_Vehicles_Ambient = ["Opf_I_I_Offroad_01_F",  "Opf_I_I_Van_01_transport_F", "Opf_I_I_Offroad_01_F", "Opf_O_S_Offroad_01_armed_F", "Opf_O_S_Offroad_01_armed_F", "Opf_O_S_Offroad_01_AT_F"]; 
East_Ground_Vehicles_Light = ["Opf_O_S_Offroad_01_armed_F", "Opf_O_S_Offroad_01_armed_F", "Opf_O_S_APC_Tracked_02_cannon_F", "Opf_O_S_Offroad_01_AT_F"]; 
East_Ground_Vehicles_Heavy = ["Opf_O_S_APC_Tracked_02_cannon_F","Opf_O_S_APC_Tracked_02_cannon_F", "Opf_O_S_Offroad_01_AT_F", "Opf_O_S_Offroad_01_AT_F", "Opf_O_S_Offroad_01_armed_F"]; 
East_Ground_Transport = ["Opf_O_S_Offroad_01_F",  "Opf_O_S_Truck_02_transport_F"]; 

East_Air_Transport = ["Opf_I_R_Heli_Light_02_unarmed_F"];
East_Air_Heli = ["O_Heli_Light_02_dynamicLoadout_F"]; 
East_Air_Jet = ["O_Heli_Light_02_dynamicLoadout_F"]; 

East_Units = ["Opf_O_S_Soldier_9_F","Opf_O_S_Soldier_8_F","Opf_O_S_Soldier_7_F","Opf_O_S_Soldier_6_F","Opf_O_S_Soldier_5_F","Opf_O_S_Soldier_4_F","Opf_O_S_Soldier_3_F","Opf_O_S_Soldier_2_F","Opf_O_S_Soldier_1_F", "Opf_O_P_soldier_TL_F", "Opf_O_P_soldier_1_F", "Opf_O_P_soldier_LAT_F", "Opf_O_P_soldier_M_F", "Opf_O_P_soldier_GL_F", "Opf_O_P_soldier_AR_F", "Opf_O_P_soldier_exp_F", "Opf_O_P_medic_F"];
East_Units_Officers = ["Opf_O_S_Soldier_2_F"];

East_Groups = [
(configfile >> "CfgGroups" >> "East" >> "Opf_OPF_S_F" >> "Infantry" >> "SeparatistShockTeam"),
(configfile >> "CfgGroups" >> "East" >> "Opf_OPF_S_F" >> "Infantry" >> "SeparatistFireTeam"),
(configfile >> "CfgGroups" >> "East" >> "Opf_OPF_S_F" >> "Infantry" >> "SeparatistCombatGroup")
];
};


 if (markerText "Enemy_Handle" == "Russian Armed Forces _ Desert _ RHS") then {
East_Ground_Vehicles_Ambient = ["rhs_tigr_sts_3camo_msv", "rhs_tigr_sts_msv","rhs_tigr_msv", "rhs_tigr_3camo_msv", "rhs_gaz66o_msv", "rhs_gaz66_repair_msv", "rhs_gaz66_vdv"]; 
East_Ground_Vehicles_Light = [ "rhs_btr80a_msv", "rhs_btr80_msv",  "rhs_tigr_sts_3camo_msv",  "rhs_tigr_sts_msv"]; 
East_Ground_Vehicles_Heavy = [ "rhs_zsu234_aa",  "rhs_bmp3m_msv", "rhs_bmp2k_msv", "rhs_bmp1_msv","rhs_t72be_tv","rhs_t80bvk", "rhs_t90sm_tv"]; 
East_Ground_Transport = ["rhs_tigr_3camo_msv",  "rhs_gaz66_msv", "rhs_gaz66o_msv"]; 

East_Air_Transport = ["rhs_ka60_c","RHS_Mi8mt_vvsc", "RHS_Mi8MTV3_heavy_vvsc"];
East_Air_Heli = ["RHS_Ka52_vvsc",  "RHS_Mi24P_vdv"]; 
East_Air_Jet = ["rhs_mig29sm_vvsc", "RHS_Su25SM_vvsc"]; 

East_Units = ["rhs_vdv_des_efreitor","rhs_vdv_des_rifleman","rhs_vdv_des_LAT","rhs_vdv_des_marksman","rhs_vdv_des_medic","rhs_vdv_des_arifleman","rhs_vdv_des_grenadier","rhs_vdv_des_at","rhs_vdv_des_engineer","rhs_vdv_des_marksman"];
East_Units_Officers = ["rhs_vdv_des_officer"];

East_Groups = [
(configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_des_infantry" >> "rhs_group_rus_vdv_des_infantry_fireteam"),
(configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_des_infantry" >> "rhs_group_rus_vdv_des_infantry_section_AT"),
(configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_des_infantry" >> "rhs_group_rus_vdv_des_infantry_section_AA"),
(configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_des_infantry" >> "rhs_group_rus_vdv_des_infantry_squad_mg_sniper"),
(configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_des_infantry" >> "rhs_group_rus_vdv_des_infantry_squad_2mg")
];
}; 


 if (markerText "Enemy_Handle" == "Russian Armed Forces _ Woodland _ RHS") then {
East_Ground_Vehicles_Ambient = ["rhs_tigr_sts_msv","rhs_tigr_msv", "rhs_gaz66o_msv", "rhs_gaz66_repair_msv", "rhs_gaz66_vdv"]; 
East_Ground_Vehicles_Light = [ "rhs_btr60_vmf", "rhs_tigr_sts_msv"]; 
East_Ground_Vehicles_Heavy = [ "rhs_zsu234_aa",  "rhs_Ob_681_2", "rhs_bmp2_tv", "rhs_bmp1_tv","rhs_t72be_tv","rhs_t80bvk", "rhs_t90sm_tv"]; 
East_Ground_Transport = ["rhs_tigr_msv",  "rhs_gaz66_msv", "rhs_gaz66o_msv"]; 

East_Air_Transport = ["rhs_ka60_c","RHS_Mi8mt_vvsc", "RHS_Mi8MTV3_heavy_vvsc"];
East_Air_Heli = ["RHS_Ka52_vvsc",  "RHS_Mi24P_vdv"]; 
East_Air_Jet = ["rhs_mig29sm_vvsc", "RHS_Su25SM_vvsc"]; 

East_Units = ["rhs_vdv_flora_efreitor","rhs_vdv_flora_rifleman","rhs_vdv_flora_LAT","rhs_vdv_flora_marksman","rhs_vdv_flora_medic","rhs_vdv_flora_machinegunner","rhs_vdv_flora_grenadier","rhs_vdv_flora_at","rhs_vdv_flora_engineer","rhs_vdv_flora_marksman"];
East_Units_Officers = ["rhs_vdv_des_officer", "rhs_vdv_flora_officer"];

East_Groups = [
(configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_fireteam"),
(configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_section_AT"),
(configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_section_AA"),
(configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_squad_mg_sniper"),
(configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_squad_2mg")
];
}; 




sleep 3;

E_Init = "Done";
