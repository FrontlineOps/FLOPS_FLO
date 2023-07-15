
if (((serverCommandAvailable "#kick")  &&  (serverCommandAvailable "#debug") && (isMultiplayer)) or ((backpack player == "B_RadioBag_01_wdl_F") or (backpack player == "B_RadioBag_01_mtp_F")) or !(isMultiplayer)) then {

_all = allMissionObjects ""; 
_Cams = _all select {typeOf _x == "camera"}; 
_Spheres = _all select {typeOf _x == "Sign_Sphere10cm_F"}; 
HCAM_0 cameraEffect ["terminate", "Back", "HCAM_S"]; 
HCAM_0 cameraEffect ["terminate", "Back", "HCAM_V"]; 
HCAM_0 cameraEffect ["terminate", "Back", "HCAM_T"]; 
HCAM_0 cameraEffect ["terminate", "Back", "HCAM_N"]; 
deleteVehicle HCAM_0;


sleep 1;

HCAM_0 = "camera" camCreate [0,0,0];
publicVariable "HCAM_0";
HCAM_0 attachTo [TSAT, [0, 0, 550] ];  
HCAM_0 camSetFov 0.9; 
HCAM_0 setVectorDirAndUp [[0, 0, -1], [0, 1, 0]];


HCAM_0 cameraEffect ["Internal", "Back", "HCAM_V"]; 
HCAM_0 cameraEffect ["Internal", "Back", "HCAM_T"]; 
HCAM_0 cameraEffect ["Internal", "Back", "HCAM_N"]; 

"HCAM_V" setPiPEffect [0];
"HCAM_T" setPiPEffect [2];
"HCAM_N" setPiPEffect [1];


_TV = nearestObjects [ player, ["Land_Tablet_02_sand_F", "Land_Tablet_02_F", "Land_Tablet_02_black_F", "Land_MultiScreenComputer_01_sand_F", "Land_MultiScreenComputer_01_olive_F", "Land_MultiScreenComputer_01_black_F", "Land_PCSet_Intel_02_F", "Land_PCSet_Intel_01_F", "Land_PCSet_01_screen_F", "Land_FlatTV_01_F", "Land_Laptop_device_F", "Land_Laptop_unfolded_F", "Land_Laptop_Intel_01_F", "Land_Laptop_Intel_02_F", "Land_Laptop_Intel_Oldman_F", "Land_BriefingRoomDesk_01_F", "Land_BriefingRoomScreen_01_F", "Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_large_F", "Land_TripodScreen_01_large_black_F", "Land_TripodScreen_01_dual_v1_black_F", "Land_TripodScreen_01_dual_v1_F", "Land_TripodScreen_01_dual_v1_sand_F", "Land_TripodScreen_01_dual_v2_black_F", "Land_TripodScreen_01_dual_v2_F", "Land_TripodScreen_01_dual_v2_sand_F"], 50] select 0 ;

if (typeOf _TV == "Land_MultiScreenComputer_01_black_F" or typeOf _TV == "Land_MultiScreenComputer_01_olive_F" or typeOf _TV == "Land_MultiScreenComputer_01_sand_F") then {
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
_TV setObjectTextureGlobal [2, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
_TV setObjectTextureGlobal [3, "#(argb,512,512,1)r2t(HCAM_N,1.333)"];
};

if (typeOf _TV == "Land_TripodScreen_01_dual_v2_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_black_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
};

if (typeOf _TV == "Land_Tablet_02_sand_F" or typeOf _TV == "Land_Tablet_02_F" or typeOf _TV == "Land_Tablet_02_black_F" or typeOf _TV == "Land_PCSet_Intel_02_F" or typeOf _TV == "Land_PCSet_Intel_01_F" or typeOf _TV == "Land_PCSet_01_screen_F" or typeOf _TV == "Land_FlatTV_01_F" or typeOf _TV == "Land_Laptop_device_F" or typeOf _TV == "Land_Laptop_unfolded_F" or typeOf _TV == "Land_Laptop_Intel_01_F" or typeOf _TV == "Land_Laptop_Intel_02_F" or typeOf _TV == "Land_Laptop_Intel_Oldman_F" or typeOf _TV == "Land_BriefingRoomDesk_01_F" or typeOf _TV == "Land_BriefingRoomScreen_01_F" or typeOf _TV == "Land_TripodScreen_01_large_sand_F" or typeOf _TV == "Land_TripodScreen_01_large_F" or typeOf _TV == "Land_TripodScreen_01_large_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
};



_TV = nearestObjects [ player, ["Land_Tablet_02_sand_F", "Land_Tablet_02_F", "Land_Tablet_02_black_F", "Land_MultiScreenComputer_01_sand_F", "Land_MultiScreenComputer_01_olive_F", "Land_MultiScreenComputer_01_black_F", "Land_PCSet_Intel_02_F", "Land_PCSet_Intel_01_F", "Land_PCSet_01_screen_F", "Land_FlatTV_01_F", "Land_Laptop_device_F", "Land_Laptop_unfolded_F", "Land_Laptop_Intel_01_F", "Land_Laptop_Intel_02_F", "Land_Laptop_Intel_Oldman_F", "Land_BriefingRoomDesk_01_F", "Land_BriefingRoomScreen_01_F", "Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_large_F", "Land_TripodScreen_01_large_black_F", "Land_TripodScreen_01_dual_v1_black_F", "Land_TripodScreen_01_dual_v1_F", "Land_TripodScreen_01_dual_v1_sand_F", "Land_TripodScreen_01_dual_v2_black_F", "Land_TripodScreen_01_dual_v2_F", "Land_TripodScreen_01_dual_v2_sand_F"], 50] select 1 ;

if (typeOf _TV == "Land_MultiScreenComputer_01_black_F" or typeOf _TV == "Land_MultiScreenComputer_01_olive_F" or typeOf _TV == "Land_MultiScreenComputer_01_sand_F") then {
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
_TV setObjectTextureGlobal [2, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
_TV setObjectTextureGlobal [3, "#(argb,512,512,1)r2t(HCAM_N,1.333)"];
};

if (typeOf _TV == "Land_TripodScreen_01_dual_v2_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_black_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_N,1.333)"];
};

if (typeOf _TV == "Land_Tablet_02_sand_F" or typeOf _TV == "Land_Tablet_02_F" or typeOf _TV == "Land_Tablet_02_black_F" or typeOf _TV == "Land_PCSet_Intel_02_F" or typeOf _TV == "Land_PCSet_Intel_01_F" or typeOf _TV == "Land_PCSet_01_screen_F" or typeOf _TV == "Land_FlatTV_01_F" or typeOf _TV == "Land_Laptop_device_F" or typeOf _TV == "Land_Laptop_unfolded_F" or typeOf _TV == "Land_Laptop_Intel_01_F" or typeOf _TV == "Land_Laptop_Intel_02_F" or typeOf _TV == "Land_Laptop_Intel_Oldman_F" or typeOf _TV == "Land_BriefingRoomDesk_01_F" or typeOf _TV == "Land_BriefingRoomScreen_01_F" or typeOf _TV == "Land_TripodScreen_01_large_sand_F" or typeOf _TV == "Land_TripodScreen_01_large_F" or typeOf _TV == "Land_TripodScreen_01_large_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
};


_TV = nearestObjects [ player, ["Land_Tablet_02_sand_F", "Land_Tablet_02_F", "Land_Tablet_02_black_F", "Land_MultiScreenComputer_01_sand_F", "Land_MultiScreenComputer_01_olive_F", "Land_MultiScreenComputer_01_black_F", "Land_PCSet_Intel_02_F", "Land_PCSet_Intel_01_F", "Land_PCSet_01_screen_F", "Land_FlatTV_01_F", "Land_Laptop_device_F", "Land_Laptop_unfolded_F", "Land_Laptop_Intel_01_F", "Land_Laptop_Intel_02_F", "Land_Laptop_Intel_Oldman_F", "Land_BriefingRoomDesk_01_F", "Land_BriefingRoomScreen_01_F", "Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_large_F", "Land_TripodScreen_01_large_black_F", "Land_TripodScreen_01_dual_v1_black_F", "Land_TripodScreen_01_dual_v1_F", "Land_TripodScreen_01_dual_v1_sand_F", "Land_TripodScreen_01_dual_v2_black_F", "Land_TripodScreen_01_dual_v2_F", "Land_TripodScreen_01_dual_v2_sand_F"], 50] select 2 ;

if (typeOf _TV == "Land_MultiScreenComputer_01_black_F" or typeOf _TV == "Land_MultiScreenComputer_01_olive_F" or typeOf _TV == "Land_MultiScreenComputer_01_sand_F") then {
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
_TV setObjectTextureGlobal [2, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
_TV setObjectTextureGlobal [3, "#(argb,512,512,1)r2t(HCAM_N,1.333)"];
};

if (typeOf _TV == "Land_TripodScreen_01_dual_v2_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_black_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
};

if (typeOf _TV == "Land_Tablet_02_sand_F" or typeOf _TV == "Land_Tablet_02_F" or typeOf _TV == "Land_Tablet_02_black_F" or typeOf _TV == "Land_PCSet_Intel_02_F" or typeOf _TV == "Land_PCSet_Intel_01_F" or typeOf _TV == "Land_PCSet_01_screen_F" or typeOf _TV == "Land_FlatTV_01_F" or typeOf _TV == "Land_Laptop_device_F" or typeOf _TV == "Land_Laptop_unfolded_F" or typeOf _TV == "Land_Laptop_Intel_01_F" or typeOf _TV == "Land_Laptop_Intel_02_F" or typeOf _TV == "Land_Laptop_Intel_Oldman_F" or typeOf _TV == "Land_BriefingRoomDesk_01_F" or typeOf _TV == "Land_BriefingRoomScreen_01_F" or typeOf _TV == "Land_TripodScreen_01_large_sand_F" or typeOf _TV == "Land_TripodScreen_01_large_F" or typeOf _TV == "Land_TripodScreen_01_large_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_N,1.333)"];
};


_TV = nearestObjects [ player, ["Land_Tablet_02_sand_F", "Land_Tablet_02_F", "Land_Tablet_02_black_F", "Land_MultiScreenComputer_01_sand_F", "Land_MultiScreenComputer_01_olive_F", "Land_MultiScreenComputer_01_black_F", "Land_PCSet_Intel_02_F", "Land_PCSet_Intel_01_F", "Land_PCSet_01_screen_F", "Land_FlatTV_01_F", "Land_Laptop_device_F", "Land_Laptop_unfolded_F", "Land_Laptop_Intel_01_F", "Land_Laptop_Intel_02_F", "Land_Laptop_Intel_Oldman_F", "Land_BriefingRoomDesk_01_F", "Land_BriefingRoomScreen_01_F", "Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_large_F", "Land_TripodScreen_01_large_black_F", "Land_TripodScreen_01_dual_v1_black_F", "Land_TripodScreen_01_dual_v1_F", "Land_TripodScreen_01_dual_v1_sand_F", "Land_TripodScreen_01_dual_v2_black_F", "Land_TripodScreen_01_dual_v2_F", "Land_TripodScreen_01_dual_v2_sand_F"], 50] select 3 ;

if (typeOf _TV == "Land_MultiScreenComputer_01_black_F" or typeOf _TV == "Land_MultiScreenComputer_01_olive_F" or typeOf _TV == "Land_MultiScreenComputer_01_sand_F") then {
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
_TV setObjectTextureGlobal [2, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
_TV setObjectTextureGlobal [3, "#(argb,512,512,1)r2t(HCAM_N,1.333)"];
};

if (typeOf _TV == "Land_TripodScreen_01_dual_v2_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_black_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_N,1.333)"];
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
};

if (typeOf _TV == "Land_Tablet_02_sand_F" or typeOf _TV == "Land_Tablet_02_F" or typeOf _TV == "Land_Tablet_02_black_F" or typeOf _TV == "Land_PCSet_Intel_02_F" or typeOf _TV == "Land_PCSet_Intel_01_F" or typeOf _TV == "Land_PCSet_01_screen_F" or typeOf _TV == "Land_FlatTV_01_F" or typeOf _TV == "Land_Laptop_device_F" or typeOf _TV == "Land_Laptop_unfolded_F" or typeOf _TV == "Land_Laptop_Intel_01_F" or typeOf _TV == "Land_Laptop_Intel_02_F" or typeOf _TV == "Land_Laptop_Intel_Oldman_F" or typeOf _TV == "Land_BriefingRoomDesk_01_F" or typeOf _TV == "Land_BriefingRoomScreen_01_F" or typeOf _TV == "Land_TripodScreen_01_large_sand_F" or typeOf _TV == "Land_TripodScreen_01_large_F" or typeOf _TV == "Land_TripodScreen_01_large_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
};



_TV = nearestObjects [ player, ["Land_Tablet_02_sand_F", "Land_Tablet_02_F", "Land_Tablet_02_black_F", "Land_MultiScreenComputer_01_sand_F", "Land_MultiScreenComputer_01_olive_F", "Land_MultiScreenComputer_01_black_F", "Land_PCSet_Intel_02_F", "Land_PCSet_Intel_01_F", "Land_PCSet_01_screen_F", "Land_FlatTV_01_F", "Land_Laptop_device_F", "Land_Laptop_unfolded_F", "Land_Laptop_Intel_01_F", "Land_Laptop_Intel_02_F", "Land_Laptop_Intel_Oldman_F", "Land_BriefingRoomDesk_01_F", "Land_BriefingRoomScreen_01_F", "Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_large_F", "Land_TripodScreen_01_large_black_F", "Land_TripodScreen_01_dual_v1_black_F", "Land_TripodScreen_01_dual_v1_F", "Land_TripodScreen_01_dual_v1_sand_F", "Land_TripodScreen_01_dual_v2_black_F", "Land_TripodScreen_01_dual_v2_F", "Land_TripodScreen_01_dual_v2_sand_F"], 50] select 4 ;

if (typeOf _TV == "Land_MultiScreenComputer_01_black_F" or typeOf _TV == "Land_MultiScreenComputer_01_olive_F" or typeOf _TV == "Land_MultiScreenComputer_01_sand_F") then {
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
_TV setObjectTextureGlobal [2, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
_TV setObjectTextureGlobal [3, "#(argb,512,512,1)r2t(HCAM_N,1.333)"];
};

if (typeOf _TV == "Land_TripodScreen_01_dual_v2_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_black_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
};

if (typeOf _TV == "Land_Tablet_02_sand_F" or typeOf _TV == "Land_Tablet_02_F" or typeOf _TV == "Land_Tablet_02_black_F" or typeOf _TV == "Land_PCSet_Intel_02_F" or typeOf _TV == "Land_PCSet_Intel_01_F" or typeOf _TV == "Land_PCSet_01_screen_F" or typeOf _TV == "Land_FlatTV_01_F" or typeOf _TV == "Land_Laptop_device_F" or typeOf _TV == "Land_Laptop_unfolded_F" or typeOf _TV == "Land_Laptop_Intel_01_F" or typeOf _TV == "Land_Laptop_Intel_02_F" or typeOf _TV == "Land_Laptop_Intel_Oldman_F" or typeOf _TV == "Land_BriefingRoomDesk_01_F" or typeOf _TV == "Land_BriefingRoomScreen_01_F" or typeOf _TV == "Land_TripodScreen_01_large_sand_F" or typeOf _TV == "Land_TripodScreen_01_large_F" or typeOf _TV == "Land_TripodScreen_01_large_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
};


_TV = nearestObjects [ player, ["Land_Tablet_02_sand_F", "Land_Tablet_02_F", "Land_Tablet_02_black_F", "Land_MultiScreenComputer_01_sand_F", "Land_MultiScreenComputer_01_olive_F", "Land_MultiScreenComputer_01_black_F", "Land_PCSet_Intel_02_F", "Land_PCSet_Intel_01_F", "Land_PCSet_01_screen_F", "Land_FlatTV_01_F", "Land_Laptop_device_F", "Land_Laptop_unfolded_F", "Land_Laptop_Intel_01_F", "Land_Laptop_Intel_02_F", "Land_Laptop_Intel_Oldman_F", "Land_BriefingRoomDesk_01_F", "Land_BriefingRoomScreen_01_F", "Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_large_F", "Land_TripodScreen_01_large_black_F", "Land_TripodScreen_01_dual_v1_black_F", "Land_TripodScreen_01_dual_v1_F", "Land_TripodScreen_01_dual_v1_sand_F", "Land_TripodScreen_01_dual_v2_black_F", "Land_TripodScreen_01_dual_v2_F", "Land_TripodScreen_01_dual_v2_sand_F"], 50] select 5 ;

if (typeOf _TV == "Land_MultiScreenComputer_01_black_F" or typeOf _TV == "Land_MultiScreenComputer_01_olive_F" or typeOf _TV == "Land_MultiScreenComputer_01_sand_F") then {
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
_TV setObjectTextureGlobal [2, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
_TV setObjectTextureGlobal [3, "#(argb,512,512,1)r2t(HCAM_N,1.333)"];
};

if (typeOf _TV == "Land_TripodScreen_01_dual_v2_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_black_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_N,1.333)"];
};

if (typeOf _TV == "Land_Tablet_02_sand_F" or typeOf _TV == "Land_Tablet_02_F" or typeOf _TV == "Land_Tablet_02_black_F" or typeOf _TV == "Land_PCSet_Intel_02_F" or typeOf _TV == "Land_PCSet_Intel_01_F" or typeOf _TV == "Land_PCSet_01_screen_F" or typeOf _TV == "Land_FlatTV_01_F" or typeOf _TV == "Land_Laptop_device_F" or typeOf _TV == "Land_Laptop_unfolded_F" or typeOf _TV == "Land_Laptop_Intel_01_F" or typeOf _TV == "Land_Laptop_Intel_02_F" or typeOf _TV == "Land_Laptop_Intel_Oldman_F" or typeOf _TV == "Land_BriefingRoomDesk_01_F" or typeOf _TV == "Land_BriefingRoomScreen_01_F" or typeOf _TV == "Land_TripodScreen_01_large_sand_F" or typeOf _TV == "Land_TripodScreen_01_large_F" or typeOf _TV == "Land_TripodScreen_01_large_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_N,1.333)"];
};



_TV = nearestObjects [ player, ["Land_Tablet_02_sand_F", "Land_Tablet_02_F", "Land_Tablet_02_black_F", "Land_MultiScreenComputer_01_sand_F", "Land_MultiScreenComputer_01_olive_F", "Land_MultiScreenComputer_01_black_F", "Land_PCSet_Intel_02_F", "Land_PCSet_Intel_01_F", "Land_PCSet_01_screen_F", "Land_FlatTV_01_F", "Land_Laptop_device_F", "Land_Laptop_unfolded_F", "Land_Laptop_Intel_01_F", "Land_Laptop_Intel_02_F", "Land_Laptop_Intel_Oldman_F", "Land_BriefingRoomDesk_01_F", "Land_BriefingRoomScreen_01_F", "Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_large_F", "Land_TripodScreen_01_large_black_F", "Land_TripodScreen_01_dual_v1_black_F", "Land_TripodScreen_01_dual_v1_F", "Land_TripodScreen_01_dual_v1_sand_F", "Land_TripodScreen_01_dual_v2_black_F", "Land_TripodScreen_01_dual_v2_F", "Land_TripodScreen_01_dual_v2_sand_F"], 50] select 6 ;

if (typeOf _TV == "Land_MultiScreenComputer_01_black_F" or typeOf _TV == "Land_MultiScreenComputer_01_olive_F" or typeOf _TV == "Land_MultiScreenComputer_01_sand_F") then {
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
_TV setObjectTextureGlobal [2, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
_TV setObjectTextureGlobal [3, "#(argb,512,512,1)r2t(HCAM_N,1.333)"];
};

if (typeOf _TV == "Land_TripodScreen_01_dual_v2_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_black_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
};

if (typeOf _TV == "Land_Tablet_02_sand_F" or typeOf _TV == "Land_Tablet_02_F" or typeOf _TV == "Land_Tablet_02_black_F" or typeOf _TV == "Land_PCSet_Intel_02_F" or typeOf _TV == "Land_PCSet_Intel_01_F" or typeOf _TV == "Land_PCSet_01_screen_F" or typeOf _TV == "Land_FlatTV_01_F" or typeOf _TV == "Land_Laptop_device_F" or typeOf _TV == "Land_Laptop_unfolded_F" or typeOf _TV == "Land_Laptop_Intel_01_F" or typeOf _TV == "Land_Laptop_Intel_02_F" or typeOf _TV == "Land_Laptop_Intel_Oldman_F" or typeOf _TV == "Land_BriefingRoomDesk_01_F" or typeOf _TV == "Land_BriefingRoomScreen_01_F" or typeOf _TV == "Land_TripodScreen_01_large_sand_F" or typeOf _TV == "Land_TripodScreen_01_large_F" or typeOf _TV == "Land_TripodScreen_01_large_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
};



_TV = nearestObjects [ player, ["Land_Tablet_02_sand_F", "Land_Tablet_02_F", "Land_Tablet_02_black_F", "Land_MultiScreenComputer_01_sand_F", "Land_MultiScreenComputer_01_olive_F", "Land_MultiScreenComputer_01_black_F", "Land_PCSet_Intel_02_F", "Land_PCSet_Intel_01_F", "Land_PCSet_01_screen_F", "Land_FlatTV_01_F", "Land_Laptop_device_F", "Land_Laptop_unfolded_F", "Land_Laptop_Intel_01_F", "Land_Laptop_Intel_02_F", "Land_Laptop_Intel_Oldman_F", "Land_BriefingRoomDesk_01_F", "Land_BriefingRoomScreen_01_F", "Land_TripodScreen_01_large_sand_F", "Land_TripodScreen_01_large_F", "Land_TripodScreen_01_large_black_F", "Land_TripodScreen_01_dual_v1_black_F", "Land_TripodScreen_01_dual_v1_F", "Land_TripodScreen_01_dual_v1_sand_F", "Land_TripodScreen_01_dual_v2_black_F", "Land_TripodScreen_01_dual_v2_F", "Land_TripodScreen_01_dual_v2_sand_F"], 50] select 7 ;

if (typeOf _TV == "Land_MultiScreenComputer_01_black_F" or typeOf _TV == "Land_MultiScreenComputer_01_olive_F" or typeOf _TV == "Land_MultiScreenComputer_01_sand_F") then {
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
_TV setObjectTextureGlobal [2, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
_TV setObjectTextureGlobal [3, "#(argb,512,512,1)r2t(HCAM_N,1.333)"];
};

if (typeOf _TV == "Land_TripodScreen_01_dual_v2_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_F" or typeOf _TV == "Land_TripodScreen_01_dual_v2_black_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_sand_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_F" or typeOf _TV == "Land_TripodScreen_01_dual_v1_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_N,1.333)"];
_TV setObjectTextureGlobal [1, "#(argb,512,512,1)r2t(HCAM_V,1.333)"];
};

if (typeOf _TV == "Land_Tablet_02_sand_F" or typeOf _TV == "Land_Tablet_02_F" or typeOf _TV == "Land_Tablet_02_black_F" or typeOf _TV == "Land_PCSet_Intel_02_F" or typeOf _TV == "Land_PCSet_Intel_01_F" or typeOf _TV == "Land_PCSet_01_screen_F" or typeOf _TV == "Land_FlatTV_01_F" or typeOf _TV == "Land_Laptop_device_F" or typeOf _TV == "Land_Laptop_unfolded_F" or typeOf _TV == "Land_Laptop_Intel_01_F" or typeOf _TV == "Land_Laptop_Intel_02_F" or typeOf _TV == "Land_Laptop_Intel_Oldman_F" or typeOf _TV == "Land_BriefingRoomDesk_01_F" or typeOf _TV == "Land_BriefingRoomScreen_01_F" or typeOf _TV == "Land_TripodScreen_01_large_sand_F" or typeOf _TV == "Land_TripodScreen_01_large_F" or typeOf _TV == "Land_TripodScreen_01_large_black_F") then {
_TV setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(HCAM_T,1.333)"];
};


HCAM_0 cameraEffect ["Internal", "Back", "HCAM_S"]; 
hint ""; 

} else { hint "only Admins and Commanders Have Access";};




















