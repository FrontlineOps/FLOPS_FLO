
if (((serverCommandAvailable "#kick")  &&  (serverCommandAvailable "#debug") && (isMultiplayer)) or ((backpack player == "B_RadioBag_01_wdl_F") or (backpack player == "B_RadioBag_01_mtp_F")) or !(isMultiplayer)) then {

closeDialog 0;

SatTrack = false ;

openMap [true, true]; 
hint "Select Satellite Coordination"; 
onMapSingleClick {
onMapSingleClick {}; 
TSAT setpos _pos;
hint 'Satellite Coordination Confirmed'; 
openMap [true, false]; 
openMap [false, false]; 
createDialog "Satellite_Control_Tablet";
HCAM_0 cameraEffect ["Internal", "Back", "HCAM_S"]; 
hint ""; 

};

} else { hint "only Admins and Commanders Have Access";};