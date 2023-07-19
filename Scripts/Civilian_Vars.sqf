CivVehArray = [
"C_Truck_02_covered_F",
"C_Truck_02_transport_F",
"C_Truck_02_fuel_F",
"C_Van_02_vehicle_F",
"C_Van_02_service_F",
"C_Truck_02_box_F",
"C_Van_02_medevac_F",
"C_Van_01_fuel_F",
"C_Hatchback_01_sport_F",
"C_Hatchback_01_F",
"C_Offroad_01_F",
"C_Offroad_02_unarmed_F",
"C_Offroad_01_comms_F",
"C_Offroad_01_covered_F",
"C_Offroad_01_repair_F",
"C_Van_01_box_F",
"C_Van_01_transport_F",
"C_Tractor_01_F",
"C_SUV_01_F",
"C_Quadbike_01_F"
];

if (markerText "Civilian_Handle" == "Vietnam_Civilians_Insurgents") then {
CivVehArray = [
"C_Truck_02_covered_F",
"C_Truck_02_transport_F",
"vn_c_car_01_01",
"vn_c_car_03_01",
"vn_c_car_02_01",
"C_Truck_02_box_F",
"vn_c_wheeled_m151_02",
"vn_c_wheeled_m151_01",
"C_Tractor_01_F",
"vn_c_car_04_01"
];

CivMenArray = [
"vn_c_men_29",
"vn_c_men_28",
"vn_c_men_27",
"vn_c_men_26",
"vn_c_men_25",
"vn_c_men_24",
"vn_c_men_23",
"vn_c_men_22",
"vn_c_men_21",
"vn_c_men_20",
"vn_c_men_19",
"vn_c_men_18",
"vn_c_men_17",
"vn_c_men_16",
"vn_c_men_15",
"vn_c_men_14",
"vn_c_men_13",
"vn_c_men_12",
"vn_c_men_11",
"vn_c_men_10",
"vn_c_men_09",
"vn_c_men_08",
"vn_c_men_07",
"vn_c_men_06",
"vn_c_men_05",
"vn_c_men_04",
"vn_c_men_03",
"vn_c_men_02",
"vn_c_men_01"
];
GuerMenArray = ("(configname _x iskindOf 'CAManBase') && (gettext (_x >> 'faction') == 'I_LAO')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
GuerVehArray = ("(configname _x iskindOf 'car') && (gettext (_x >> 'faction') == 'I_LAO')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
};

if (markerText "Civilian_Handle" == "Greek_Civilians_Insurgents") then {
CivMenArray = [
"C_Man_casual_9_F_euro",
"C_Man_casual_8_F_euro",
"C_man_polo_1_F_euro",
"C_man_polo_2_F_euro",
"C_man_polo_3_F_euro",
"C_man_polo_4_F_euro",
"C_man_polo_5_F_euro",
"C_man_polo_6_F_euro",
"C_man_p_fugitive_F_euro",
"C_man_p_beggar_F_euro",
"C_man_p_shorts_1_F_euro",
"C_man_shorts_1_F_euro",
"C_man_shorts_2_F_euro",
"C_man_shorts_3_F_euro",
"C_man_shorts_4_F_euro",
"C_man_sport_1_F_euro",
"C_man_sport_2_F_euro",
"C_man_sport_3_F_euro",
"C_Man_casual_1_F_euro",
"C_Man_casual_2_F_euro",
"C_Journalist_01_War_F",
"C_Man_UtilityWorker_01_F",
"C_Man_Fisherman_01_F",
"C_Man_Messenger_01_F",
"C_Story_Mechanic_01_F",
"C_E_Man_Base_F",
"C_scientist_01_formal_F",
"C_scientist_02_formal_F",
"C_scientist_01_informal_F",
"C_scientist_02_informal_F",
"C_Man_casual_6_F_euro",
"C_Man_casual_5_F_euro",
"C_Man_casual_3_F_euro",
"C_Man_casual_4_F_euro",
"C_Man_casual_4_v2_F_euro",
"C_Man_smart_casual_1_F_euro",
"C_Man_casual_5_v2_F_euro",
"C_Man_casual_6_v2_F_euro",
"C_Man_casual_7_F_euro",
"C_man_p_fugitive_F",
"C_man_p_beggar_F",
"C_man_w_worker_F",
"C_scientist_F"
];
GuerMenArray = ("(configname _x iskindOf 'CAManBase') && (gettext (_x >> 'faction') == 'IND_G_F')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
GuerVehArray = ("(configname _x iskindOf 'car') && (gettext (_x >> 'faction') == 'IND_G_F')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
};

if (markerText "Civilian_Handle" == "EastEurope_Civilians_Insurgents") then {
CivMenArray = [
"C_man_enoch_base_F",
"C_Man_1_enoch_F",
"C_Man_2_enoch_F",
"C_Man_3_enoch_F",
"C_Man_4_enoch_F",
"C_Man_5_enoch_F",
"C_Man_6_enoch_F",
"C_Farmer_01_enoch_F",
"C_man_p_fugitive_F",
"C_man_p_beggar_F",
"C_man_w_worker_F",
"C_scientist_F",
"C_man_enoch_base_F",
"C_Man_1_enoch_F",
"C_Man_2_enoch_F",
"C_Man_3_enoch_F",
"C_Man_4_enoch_F",
"C_Man_5_enoch_F",
"C_Man_6_enoch_F",
"C_Farmer_01_enoch_F",
"C_man_p_fugitive_F",
"C_man_p_beggar_F",
"C_man_w_worker_F",
"C_scientist_F",
"C_Journalist_01_War_F",
"C_Man_UtilityWorker_01_F",
"C_Man_Fisherman_01_F",
"C_Man_Messenger_01_F",
"C_Story_Mechanic_01_F",
"C_E_Man_Base_F",
"C_scientist_01_formal_F",
"C_scientist_02_formal_F",
"C_scientist_01_informal_F",
"C_scientist_02_informal_F",
"C_Man_casual_6_F_euro",
"C_Man_casual_5_F_euro",
"C_Man_casual_3_F_euro",
"C_Man_casual_4_F_euro",
"C_Man_casual_4_v2_F_euro",
"C_Man_smart_casual_1_F_euro",
"C_Man_casual_5_v2_F_euro",
"C_Man_casual_6_v2_F_euro",
"C_Man_casual_7_F_euro",
"C_man_p_fugitive_F",
"C_man_p_beggar_F",
"C_man_w_worker_F",
"C_scientist_F"
];
GuerMenArray = ("(configname _x iskindOf 'CAManBase') && (gettext (_x >> 'faction') == 'IND_L_F')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
GuerVehArray = ("(configname _x iskindOf 'car') && (gettext (_x >> 'faction') == 'IND_L_F')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
};

if (markerText "Civilian_Handle" == "SefrouRamal_Civilians_Insurgents_Western Sahara") then {
CivMenArray = ["C_Djella_05_lxWS","C_Djella_01_lxWS","C_Djella_02_lxWS","C_Djella_03_lxWS","C_Djella_04_lxWS","C_Tak_02_A_lxWS","C_Tak_02_B_lxWS","C_Tak_02_C_lxWS","C_Tak_03_A_lxWS","C_Tak_03_B_lxWS","C_Tak_03_C_lxWS","C_Tak_01_A_lxWS","C_Tak_01_B_lxWS","C_Tak_01_C_lxWS"];
GuerMenArray = ("(configname _x iskindOf 'CAManBase') && (gettext (_x >> 'faction') == 'OPF_TURA_lxWS')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
GuerVehArray = ("(configname _x iskindOf 'car') && (gettext (_x >> 'faction') == 'OPF_TURA_lxWS')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
};

if (markerText "Civilian_Handle" == "EastEurope_Civilians_Insurgents_CUP") then {
CivVehArray = ("(configname _x iskindOf 'car') && (gettext (_x >> 'faction') == 'CUP_C_CHERNARUS')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
CivMenArray = ("(configname _x iskindOf 'CAManBase') && (gettext (_x >> 'faction') == 'CUP_C_CHERNARUS')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
GuerMenArray = ("(configname _x iskindOf 'CAManBase') && (gettext (_x >> 'faction') == 'CUP_I_NAPA')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
GuerVehArray = ("(configname _x iskindOf 'car') && (gettext (_x >> 'faction') == 'CUP_I_NAPA')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
};

if (markerText "Civilian_Handle" == "Tanoan_Civilians_Insurgents") then {
CivMenArray = [
"C_Man_casual_9_F_tanoan",
"C_Man_casual_8_F_tanoan",
"C_man_sport_1_F_tanoan",
"C_man_sport_2_F_tanoan",
"C_man_sport_3_F_tanoan",
"C_Man_casual_1_F_tanoan",
"C_Man_casual_2_F_tanoan",
"C_Journalist_01_War_F",
"C_Man_UtilityWorker_01_F",
"C_Man_Fisherman_01_F",
"C_Man_Messenger_01_F",
"C_Story_Mechanic_01_F",
"C_E_Man_Base_F",
"C_scientist_01_formal_F",
"C_scientist_02_formal_F",
"C_scientist_01_informal_F",
"C_scientist_02_informal_F",
"C_Man_casual_6_F_tanoan",
"C_Man_casual_5_F_tanoan",
"C_Man_casual_3_F_tanoan",
"C_Man_casual_4_F_tanoan",
"C_Man_casual_4_v2_F_tanoan",
"C_Man_smart_casual_1_F_tanoan",
"C_Man_casual_5_v2_F_tanoan",
"C_Man_casual_6_v2_F_tanoan",
"C_Man_casual_7_F_tanoan",
"C_man_p_fugitive_F",
"C_man_p_beggar_F",
"C_man_w_worker_F",
"C_scientist_F"
];
GuerMenArray = ("(configname _x iskindOf 'CAManBase') && (gettext (_x >> 'faction') == 'IND_C_F')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
GuerVehArray = ("(configname _x iskindOf 'car') && (gettext (_x >> 'faction') == 'IND_C_F')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
};

if (markerText "Civilian_Handle" == "MiddleEast_Civilians_Insurgents_CUP") then {
CivVehArray = ("(configname _x iskindOf 'car') && (gettext (_x >> 'faction') == 'CUP_C_TK')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
CivMenArray = ("(configname _x iskindOf 'CAManBase') && (gettext (_x >> 'faction') == 'CUP_C_TK')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
GuerMenArray = ("(configname _x iskindOf 'CAManBase') && (gettext (_x >> 'faction') == 'CUP_I_TK_GUE')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
GuerVehArray = ("(configname _x iskindOf 'car') && (gettext (_x >> 'faction') == 'CUP_I_TK_GUE')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
};

if (markerText "Civilian_Handle" == "Asian_Civilians_Insurgents") then {
CivMenArray = [
"C_Man_casual_9_F_asia",
"C_Man_casual_8_F_asia",
"C_man_polo_1_F_asia",
"C_man_polo_2_F_asia",
"C_man_polo_3_F_asia",
"C_man_polo_4_F_asia",
"C_man_polo_5_F_asia",
"C_man_polo_6_F_asia",
"C_man_p_fugitive_F_asia",
"C_man_p_beggar_F_asia",
"C_man_p_shorts_1_F_asia",
"C_man_shorts_1_F_asia",
"C_man_shorts_2_F_asia",
"C_man_shorts_3_F_asia",
"C_man_shorts_4_F_asia",
"C_man_sport_1_F_asia",
"C_man_sport_2_F_asia",
"C_man_sport_3_F_asia",
"C_Man_casual_1_F_asia",
"C_Man_casual_2_F_asia",
"C_Journalist_01_War_F",
"C_Man_UtilityWorker_01_F",
"C_Man_Fisherman_01_F",
"C_Man_Messenger_01_F",
"C_Story_Mechanic_01_F",
"C_E_Man_Base_F",
"C_scientist_01_formal_F",
"C_scientist_02_formal_F",
"C_scientist_01_informal_F",
"C_scientist_02_informal_F",
"C_Man_casual_6_F_asia",
"C_Man_casual_5_F_asia",
"C_Man_casual_4_F_asia",
"C_Man_casual_3_F_asia",
"C_Man_casual_4_v2_F_asia",
"C_Man_smart_casual_1_F_asia",
"C_Man_casual_5_v2_F_asia",
"C_Man_casual_6_v2_F_asia",
"C_Man_casual_7_F_asia"
];
GuerMenArray = ("(configname _x iskindOf 'CAManBase') && (gettext (_x >> 'faction') == 'IND_C_F')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
GuerVehArray = ("(configname _x iskindOf 'car') && (gettext (_x >> 'faction') == 'IND_C_F')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
};

C_Init = "Done";



































