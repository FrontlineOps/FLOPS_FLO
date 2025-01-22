CivVehArray = ("(configname _x iskindOf 'car') && (gettext (_x >> 'faction') == 'CUP_C_TK')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
CivMenArray = ("(configname _x iskindOf 'CAManBase') && (gettext (_x >> 'faction') == 'CUP_C_TK')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
GuerMenArray = ("(configname _x iskindOf 'CAManBase') && (gettext (_x >> 'faction') == 'CUP_I_TK_GUE')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
GuerVehArray = ("(configname _x iskindOf 'car') && (gettext (_x >> 'faction') == 'CUP_I_TK_GUE')" configClasses (configfile >> "CfgVehicles")) apply {configName _x};
