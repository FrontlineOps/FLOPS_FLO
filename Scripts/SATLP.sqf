

if (((serverCommandAvailable "#kick")  &&  (serverCommandAvailable "#debug") && (isMultiplayer)) or ((backpack player == "B_RadioBag_01_wdl_F") or (backpack player == "B_RadioBag_01_mtp_F")) or !(isMultiplayer)) then {
	
	closeDialog 0;
SatTrack = true ;

openMap [true, true]; 
hint "Select Satellite Target"; 
onMapSingleClick {
onMapSingleClick {}; 
TSAT setpos _pos;

_side = side player;
_radius = 50;
_radius_sqr = _radius ^ 2;
_side_groups_near = allGroups select { side _x isEqualTo _side and { leader _x distanceSqr _pos < _radius_sqr  and {alive leader _x}}} apply {[leader _x distanceSqr _pos, _x]};
_side_groups_near sort true;
_side_Nearest_group = _side_groups_near select 0;
_GRP = _side_Nearest_group select 1;
SLT1I = leader _GRP;

 [] spawn {  
while {SatTrack == true} do{  
TSAT setVehiclePosition [ (position (vehicle SLT1I)), [], 0, "NONE" ];
sleep 0.2;
   }
 };	

hint 'Satellite Lock Initialized'; 
openMap [true, false]; 
openMap [false, false]; 
createDialog "Satellite_Control_Tablet";
HCAM_0 cameraEffect ["Internal", "Back", "HCAM_S"]; 
hint ""; 
};


} else { hint "only Admins and Commanders Have Access";};

















