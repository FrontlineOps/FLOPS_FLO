East_Ground_Vehicles_Ambient = ["rhs_tigr_sts_3camo_msv", "rhs_tigr_sts_msv","rhs_tigr_msv", "rhs_tigr_3camo_msv", "rhs_gaz66o_msv", "rhs_gaz66_repair_msv", "rhs_gaz66_vdv"]; 
East_Ground_Vehicles_Light = [ "rhs_btr80a_msv", "rhs_btr80_msv",  "rhs_tigr_sts_3camo_msv",  "rhs_tigr_sts_msv"]; 
East_Ground_Vehicles_Heavy = [ "rhs_zsu234_aa",  "rhs_bmp3m_msv", "rhs_bmp2k_msv", "rhs_bmp1_msv","rhs_t72be_tv","rhs_t80bvk", "rhs_t90sm_tv"]; 
East_Ground_Transport = ["rhs_tigr_3camo_msv",  "rhs_gaz66_msv", "rhs_gaz66o_msv"]; 

East_Air_Transport = ["rhs_ka60_c","RHS_Mi8mt_vvsc", "RHS_Mi8MTV3_heavy_vvsc"];
East_Air_Heli = ["RHS_Ka52_vvsc",  "RHS_Mi24P_vdv"]; 
East_Air_Jet = ["rhs_mig29sm_vvsc", "RHS_Su25SM_vvsc"]; 

East_Units = ["rhs_vdv_des_efreitor","rhs_vdv_des_rifleman","rhs_vdv_des_LAT","rhs_vdv_des_marksman","rhs_vdv_des_medic","rhs_vdv_des_arifleman","rhs_vdv_des_grenadier","rhs_vdv_des_at","rhs_vdv_des_engineer","rhs_vdv_des_marksman"];
East_FireObserver = ["rhs_vdv_des_officer"];
East_Units_Officers = ["rhs_vdv_des_officer"];

East_Groups = [
(configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_des_infantry" >> "rhs_group_rus_vdv_des_infantry_fireteam"),
(configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_des_infantry" >> "rhs_group_rus_vdv_des_infantry_section_AT"),
(configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_des_infantry" >> "rhs_group_rus_vdv_des_infantry_section_AA"),
(configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_des_infantry" >> "rhs_group_rus_vdv_des_infantry_squad_mg_sniper"),
(configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_des_infantry" >> "rhs_group_rus_vdv_des_infantry_squad_2mg")
];