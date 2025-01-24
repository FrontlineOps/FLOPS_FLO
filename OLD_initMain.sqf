// if (isServer) then {
// _Centerposition = [worldSize / 2, worldsize / 2, 0];
// _ALLFACVEHs = nearestobjects [_Centerposition,[
// "B_SAM_System_01_F",
// "B_AAA_System_01_F",
// "B_SAM_System_02_F",
// "B_SAM_System_03_F",
// "B_GMG_01_A_F",
// "B_HMG_01_A_F",
// "B_W_Static_Designator_01_F",
// "B_UGV_02_Demining_F",
// "B_UAV_02_lxWS",
// "B_UAV_01_F",
// "B_SDV_01_F",
// "B_Boat_Transport_01_F",
// "USAF_A10",
// "USAF_F22",
// "USAF_F22_Heavy",
// "USAF_F35A_STEALTH",
// "USAF_F35A",
// "USAF_AC130U",
// "USAF_C130J",
// "USAF_C130J_Cargo",
// "usaf_kc135",
// "USAF_C17",
// F_RADAR,
// F_Bike_01,
// F_ABT_01,
// F_UAV_01,
// F_UAV_02,
// F_UAV_03,
// F_UGV_01,
// F_turret_01,
// F_turret_02,
// F_turret_03,
// F_Car_01,
// F_Car_02,
// F_Car_03,
// F_Car_04,
// F_Car_05,
// F_Car_06,
// F_MRAP_01,
// F_MRAP_02,
// F_MRAP_03,
// F_MRAP_04,
// F_MRAP_05,
// F_MRAP_06,
// F_Truck_01,
// F_Truck_02,
// F_Truck_03,
// F_Truck_04,
// F_Truck_05,
// F_Truck_06,
// F_APC_01,
// F_APC_02,
// F_APC_03,
// F_APC_04,
// F_APC_05,
// F_APC_06,
// F_TNK_01,
// F_TNK_02,
// F_TNK_03,
// F_TNK_04,
// F_Art_00,
// F_Art_01,
// F_Art_02,
// F_Heli_01,
// F_Heli_02,
// F_Heli_03,
// F_Heli_04,
// F_Heli_05,
// F_Heli_06_G,
// F_Heli_07_G,
// F_Plane_01_CAS,
// F_Plane_02_CAS,
// F_Plane_03,
// F_Plane_04,
// F_Plane_05,
// F_Plane_06
// ],40000] ;

// _EXCVEH = vehicles - _ALLFACVEHs ;

// {

// deleteVehicleCrew _x ; 
			
// } foreach _EXCVEH;

// };

// if ((isServer) && !(didJIP)) then {
	
// _AIRs = nearestobjects [[0,0,0],[
// F_Plane_01_CAS,
// F_Plane_02_CAS,
// F_Plane_03,
// F_Plane_04,
// F_Plane_05,
// F_Plane_06
// ],40000] ;

// {
// 	{
// 		[_x] ordergetin false; 
// 		unassignvehicle _x;  
// 		doGetOut _x;  
// 	 } foreach crew _x; 
// } foreach  _AIRs; 

// };