
// Where are Classnames ? Right click on any Unit or Vehicle in the Editor and Select find in CFG viewer, Last Name in the [path] tab is the Classname,

/*

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

*/

// Fill the Lines with your Desired Classnames in the Manners Shown Above,
// Where are Classnames ? Right click on any Unit or Vehicle in the Editor and Select find in CFG viewer, Last Name in the [path] tab is the Classname,

East_Ground_Vehicles_Ambient = ["PRACS_SLA_Tigr", "PRACS_SLA_UAZ_SPG9", "PRACS_SLA_UAZ_DSHKM"]; 
publicVariable "East_Ground_Vehicles_Ambient";
East_Ground_Vehicles_Light = ["PRACS_SLA_BMD2", "PRACS_SLA_BTR80", "PRACS_SLA_BTR80A", "PRACS_SLA_BMD1", "PRACS_SLA_BRDM", "PRACS_SLA_BRDM_ATGM", "PRACS_SLA_BMP1", "PRACS_SLA_BMP2", "PRACS_SLA_Tigr", "PRACS_SLA_UAZ_SPG9", "PRACS_SLA_UAZ_DSHKM", "PRACS_SLA_Type63", "PRACS_SLA_MTLB", "PRACS_SLA_SA9", "PRACS_SLA_SA13", "PRACS_SLA_BTR40_AAM", "PRACS_SLA_ZSU23", "PRACS_SLA_SA8", "PRACS_SLA_SA17", "PRACS_SLA_MTLB_ZU23"]; 
publicVariable "East_Ground_Vehicles_Light";
East_Ground_Vehicles_Heavy = ["PRACS_SLA_T72BV", "PRACS_SLA_T72B", "PRACS_SLA_T80U"]; 
publicVariable "East_Ground_Vehicles_Heavy";
East_Ground_Transport = ["PRACS_SLA_URAL_Open", "PRACS_SLA_URAL", "PRACS_SLA_MAZ_Transport", "PRACS_SLA_BMD2", "PRACS_SLA_BTR80", "PRACS_SLA_BTR80A", "PRACS_SLA_BMD1", "PRACS_SLA_BMP1", "PRACS_SLA_BMP2", "PRACS_SLA_BTR60_BG", "PRACS_SLA_URAL_BG", "PRACS_SLA_Type63", "PRACS_SLA_MTLB"]; 
publicVariable "East_Ground_Transport";

East_Air_Transport = ["PRACS_SLA_Mi8amt", "PRACS_SLA_Mi17Sh"];
publicVariable "East_Air_Transport";
East_Air_Heli = ["PRACS_SLA_Mi24V_UPK", "PRACS_SLA_Mi17Sh_UPK"]; 
publicVariable "East_Air_Heli";
East_Air_Jet = ["PRACS_SLA_MiG21", "PRACS_SLA_MiG27", "PRACS_SLA_SU22", "PRACS_SLA_Su25"]; 
publicVariable "East_Air_Jet";

East_Units = ["PRACS_SLA_A_Infantry_PSG", "PRACS_SLA_A_Infantry_RKT", "PRACS_SLA_A_Infantry_AA", "PRACS_SLA_A_Infantry_MG", "PRACS_SLA_A_Infantry_TL"];
publicVariable "East_Units";
East_Units_Officers = ["PRACS_SLA_Infantry_C"];
publicVariable "East_Units_Officers";

East_Groups = (configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_infantry_group_guards" >> "pracs_sla_infantry_group_AT_guards"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_infantry_group_guards" >> "pracs_sla_infantry_group_EOD_guards"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_infantry_group_guards" >> "pracs_sla_infantry_group_FP_guards"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_infantry_group_guards" >> "pracs_sla_infantry_group_guards_HMOT"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_infantry_group_guards" >> "pracs_sla_infantry_group_LMG_guards"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_infantry_group_guards" >> "pracs_sla_infantry_group_rifle_team_guards"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_infantry_group_guards" >> "pracs_sla_infantry_group_SHPS_guards"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_infantry_group_light" >> "pracs_sla_infantry_group_squad"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_infantry_group_light" >> "pracs_sla_infantry_group_AA"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_infantry_group_light" >> "pracs_sla_infantry_group_AT"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_infantry_group_light" >> "pracs_sla_infantry_group_LMG"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_Paratroopers_group" >> "pracs_sla_paratrooper_group_SHPS"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_Paratroopers_group" >> "pracs_sla_paratrooper_group_AA"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_Paratroopers_group" >> "pracs_sla_paratrooper_group_AT"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_Paratroopers_group" >> "pracs_sla_paratrooper_group_LMG"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_especas_group_light" >> "pracs_sla_especas_group_rifle_team"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_especas_group_light" >> "pracs_sla_especas_group_SF_TEAM"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_especas_group_light" >> "pracs_sla_especas_group_SHPS"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_especas_group_light" >> "pracs_sla_especas_group_squad"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_especas_group_light" >> "pracs_sla_especas_group_CTU_TEAM"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_especas_group_light" >> "pracs_sla_especas_group_FAC_TEAM"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_Naval_infantry_group_light" >> "pracs_sla_naval_infantry_group_AA"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_Naval_infantry_group_light" >> "pracs_sla_naval_infantry_group_AT"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_Naval_infantry_group_light" >> "pracs_sla_naval_infantry_group_platoon"),
(configfile >> "CfgGroups" >> "East" >> "pracs_sla_groups" >> "pracs_sla_Naval_infantry_group_light" >> "pracs_sla_naval_infantry_group_SHPS"),
publicVariable "East_Groups";