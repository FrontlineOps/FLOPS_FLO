//////ASSETLIST/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		createDialog "supr_RequestsMenu";
		waitUntil {dialog};
				
//////ASSETLIST/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////INFANTRY/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// if (F_Officer != "") then { 
// _txt = format ["3$ HQ OFFICER %1", F_Officer];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Officer"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Assault_Eng != "") then { 
// _txt = format ["3$ ASSAULT ENGINEER %1", F_Assault_Eng];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Assault_Eng"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Assault_TL != "") then { 
// _txt = format ["3$ ASSAULT SQUAD LEADER %1", F_Assault_TL];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Assault_TL"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Assault_SL != "") then { 
// _txt = format ["3$ ASSAULT PLATTON LEADER %1", F_Assault_SL];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Assault_SL"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Assault_Eod != "") then { 
// _txt = format ["3$ ASSAULT EXPLOSIVE SPECIALIST%1", F_Assault_Eod];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Assault_Eod"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Assault_Mrk != "") then { 
// _txt = format ["3$ ASSAULT MARKSMAN %1", F_Assault_Mrk];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Assault_Mrk"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Assault_AT != "") then { 
// _txt = format ["3$ ASSAULT ANTI TANK %1", F_Assault_AT];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Assault_AT"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Assault_Amm != "") then { 
// _txt = format ["3$ ASSAULT AMMO BEARER %1", F_Assault_Amm];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Assault_Amm"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Assault_Mg != "") then { 
// _txt = format ["3$ ASSAULT MACHINEGUNNER %1", F_Assault_Mg];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Assault_Mg"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Assault_Med != "") then { 
// _txt = format ["3$ ASSAULT MEDIC %1", F_Assault_Med];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Assault_Med"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Assault_Uav != "") then { 
// _txt = format ["3$ ASSAULT UAV SPECIALIST %1", F_Assault_Uav];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Assault_Uav"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Recon_Snp != "") then { 
// _txt = format ["3$ RECON SNIPER %1", F_Recon_Snp];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Recon_Snp"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Recon_Sct != "") then { 
// _txt = format ["3$ RECON SPOTTER %1", F_Recon_Sct];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Recon_Sct"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };


// if (F_Recon_TL != "") then { 
// _txt = format ["3$ RECON TEAM LEADER %1", F_Recon_TL];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Recon_TL"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Recon_Mrk != "") then { 
// _txt = format ["3$ RECON MARKSMAN %1", F_Recon_Mrk];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Recon_Mrk"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Recon_AT != "") then { 
// _txt = format ["3$ RECON ANTI TANK %1", F_Recon_AT];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Recon_AT"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Recon_Mg != "") then { 
// _txt = format ["3$ RECON MACHINEGUNNER %1", F_Recon_Mg];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Recon_Mg"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Recon_Eod != "") then { 
// _txt = format ["3$ RECON EXPLOSIVE SPECIALIST %1", F_Recon_Eod];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Recon_Eod"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Recon_Med != "") then { 
// _txt = format ["3$ RECON MEDIC %1", F_Recon_Med];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Recon_Med"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Recon_Eng != "") then { 
// _txt = format ["3$ RECON ENGINEER %1", F_Recon_Eng];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Recon_Eng"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };


// if (F_Diver_TL != "") then { 
// _txt = format ["3$ DIVER EXPLOSIVE SPECIALIST %1", F_Diver_TL];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Diver_TL"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Diver_Rfl != "") then { 
// _txt = format ["3$ DIVER OPERATOR  %1", F_Diver_Rfl];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Diver_Rfl"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };

// if (F_Diver_Eod != "") then { 
// _txt = format ["3$ DIVER EXPLOSIVE SPECIALIST %1", F_Diver_Eod];
// _index = lbAdd [2100, _txt];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_Diver_Eod"];        
// lbSetValue [2100, _index, 3];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\crew_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];
// };


// _index = lbAdd [2100, "50$ GROUP HQ "];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_OFFICER_TEAM"]; 
// lbSetValue [2100, _index, 50];            
// lbSetPictureRight [2100, _index, "Screens\FOBA\meet_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];



// if ( ((typeOf player == "B_G_officer_F") or (typeOf player == F_Officer)) or (isServer) or (player == TheCommander) or ((serverCommandAvailable '#kick') && (serverCommandAvailable '#debug')) ) then {
	
// _index = lbAdd [2100, "5$ GROUP ASSAULT Engineers "];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_ASSLT_ENG"]; 
// lbSetValue [2100, _index, 5];            
// lbSetPictureRight [2100, _index, "Screens\FOBA\meet_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];

// _index = lbAdd [2100, "20$ GROUP ASSAULT Squad "];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_ASSLT_TEAM"];  
// lbSetValue [2100, _index, 20];                   
// lbSetPictureRight [2100, _index, "Screens\FOBA\meet_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];

// _index = lbAdd [2100, "40$ GROUP ASSAULT Platoon "];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_ASSLT_SQD"];       
// lbSetValue [2100, _index, 40];              
// lbSetPictureRight [2100, _index, "Screens\FOBA\meet_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];

// _index = lbAdd [2100, "20$ GROUP Sniper Team "];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_SNP_TEAM"];         
// lbSetValue [2100, _index, 20];            
// lbSetPictureRight [2100, _index, "Screens\FOBA\meet_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];

// _index = lbAdd [2100, "20$ GROUP RECON Team "];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_RCN_TEAM"];         
// lbSetValue [2100, _index, 20];            
// lbSetPictureRight [2100, _index, "Screens\FOBA\meet_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];

// _index = lbAdd [2100, "40$ GROUP RECON Squad "];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_RCN_SQD"];         
// lbSetValue [2100, _index, 40];            
// lbSetPictureRight [2100, _index, "Screens\FOBA\meet_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];

// _index = lbAdd [2100, "40$ GROUP DIVER Team "];            
// lbSetColor [2100, _index, [1,1,1,1]];   
// lbSetData [2100, _index, "F_DVR_TEAM"];        
// lbSetValue [2100, _index, 40];             
// lbSetPictureRight [2100, _index, "Screens\FOBA\meet_ca.paa"]; 
// (findDisplay 1599 displayCtrl 2100) lbSetPictureRightColor [_index, [1,1,1,1]];


//////GROUND/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


if (F_Bike_01 != "") then { 
_txt = format ["5$ BIKE %1", F_Bike_01];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_Bike_01];         
lbSetValue [2101, _index, 5];                 
lbSetPictureRight [2101, _index, "\A3\Soft_F\Quadbike_01\Data\UI\Quadbike_01_CA.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (F_Car_01 != "") then { 
_txt = format ["35$ CAR %1", F_Car_01];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_Car_01];             
lbSetValue [2101, _index, 35];             
lbSetPictureRight [2101, _index, "Screens\FOBA\Offroad_01_Base_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (F_Car_02 != "") then { 
_txt = format ["35$ CAR %1", F_Car_02];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_Car_02];             
lbSetValue [2101, _index, 35];             
lbSetPictureRight [2101, _index, "Screens\FOBA\Offroad_01_Base_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (F_Car_03 != "") then { 
_txt = format ["35$ CAR %1", F_Car_03];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_Car_03];             
lbSetValue [2101, _index, 35];             
lbSetPictureRight [2101, _index, "Screens\FOBA\Offroad_01_Base_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (F_Car_04 != "") then { 
_txt = format ["35$ CAR %1", F_Car_04];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_Car_04];             
lbSetValue [2101, _index, 35];             
lbSetPictureRight [2101, _index, "Screens\FOBA\Offroad_01_Base_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (F_Car_05 != "") then { 
_txt = format ["35$ CAR %1", F_Car_05];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_Car_05];             
lbSetValue [2101, _index, 35];             
lbSetPictureRight [2101, _index, "Screens\FOBA\Offroad_01_Base_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (F_Car_06 != "") then { 
_txt = format ["35$ CAR %1", F_Car_06];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_Car_06];             
lbSetValue [2101, _index, 35];             
lbSetPictureRight [2101, _index, "Screens\FOBA\Offroad_01_Base_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (F_MRAP_01 != "") then { 
_txt = format ["55$ MRAP %1", F_MRAP_01];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_MRAP_01];             
lbSetValue [2101, _index, 55];             
lbSetPictureRight [2101, _index, "Screens\FOBA\car_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (F_MRAP_02 != "") then { 
_txt = format ["55$ MRAP %1", F_MRAP_02];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_MRAP_02];             
lbSetValue [2101, _index, 55];             
lbSetPictureRight [2101, _index, "Screens\FOBA\car_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (F_MRAP_03 != "") then { 
_txt = format ["55$ MRAP %1", F_MRAP_03];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_MRAP_03];             
lbSetValue [2101, _index, 55];             
lbSetPictureRight [2101, _index, "Screens\FOBA\car_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (F_MRAP_04 != "") then { 
_txt = format ["55$ MRAP %1", F_MRAP_04];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_MRAP_04];             
lbSetValue [2101, _index, 55];             
lbSetPictureRight [2101, _index, "Screens\FOBA\car_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (F_MRAP_05 != "") then { 
_txt = format ["55$ MRAP %1", F_MRAP_05];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_MRAP_05];             
lbSetValue [2101, _index, 55];             
lbSetPictureRight [2101, _index, "Screens\FOBA\car_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (F_MRAP_06 != "") then { 
_txt = format ["55$ MRAP %1", F_MRAP_06];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_MRAP_06];             
lbSetValue [2101, _index, 55];             
lbSetPictureRight [2101, _index, "Screens\FOBA\car_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (F_Truck_01 != "") then { 
_txt = format ["65$ TRUCK %1", F_Truck_01];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_Truck_01];             
lbSetValue [2101, _index, 65];             
lbSetPictureRight [2101, _index, "\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_Ammo_CA.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (F_Truck_02 != "") then { 
_txt = format ["65$ TRUCK %1", F_Truck_02];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_Truck_02];             
lbSetValue [2101, _index, 65];             
lbSetPictureRight [2101, _index, "\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_Ammo_CA.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (F_Truck_03 != "") then { 
_txt = format ["65$ TRUCK %1", F_Truck_03];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,0.6,0,1]];   
lbSetData [2101, _index, F_Truck_03];             
lbSetValue [2101, _index, 65];             
lbSetPictureRight [2101, _index, "\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_Ammo_CA.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,0.6,0,1]];
};


if (F_Truck_04 != "") then { 
_txt = format ["65$ TRUCK %1", F_Truck_04];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,0.6,0,1]];   
lbSetData [2101, _index, F_Truck_04];             
lbSetValue [2101, _index, 65];             
lbSetPictureRight [2101, _index, "\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_Ammo_CA.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,0.6,0,1]];
};


if (F_Truck_05 != "") then { 
_txt = format ["65$ TRUCK RESPAWN %1", F_Truck_05];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [0.9,1,0,1]];   
lbSetData [2101, _index, F_Truck_05];             
lbSetValue [2101, _index, 65];             
lbSetPictureRight [2101, _index, "\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_Ammo_CA.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [0.9,1,0,1]];
};


if (F_Truck_06 != "") then { 
_txt = format ["65$ TRUCK %1", F_Truck_06];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [1,1,1,1]];   
lbSetData [2101, _index, F_Truck_06];             
lbSetValue [2101, _index, 65];             
lbSetPictureRight [2101, _index, "\a3\soft_f_gamma\Truck_01\Data\UI\Truck_01_Ammo_CA.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then {
if (F_APC_01 != "") then { 
_txt = format ["75$ APC %1", F_APC_01];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [0.2,0.6,0.99,1]];   
lbSetData [2101, _index, F_APC_01];             
lbSetValue [2101, _index, 75];             
lbSetPictureRight [2101, _index, "\A3\armor_f_beta\APC_Tracked_01\Data\UI\APC_Tracked_01_AA_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then {
if (F_APC_02 != "") then { 
_txt = format ["75$ APC %1", F_APC_02];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [0.2,0.6,0.99,1]];   
lbSetData [2101, _index, F_APC_02];             
lbSetValue [2101, _index, 75];             
lbSetPictureRight [2101, _index, "\A3\armor_f_beta\APC_Tracked_01\Data\UI\APC_Tracked_01_AA_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then {
if (F_APC_03 != "") then { 
_txt = format ["75$ APC %1", F_APC_03];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [0.2,0.6,0.99,1]];   
lbSetData [2101, _index, F_APC_03];             
lbSetValue [2101, _index, 75];             
lbSetPictureRight [2101, _index, "\A3\armor_f_beta\APC_Tracked_01\Data\UI\APC_Tracked_01_AA_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then {
if (F_APC_04 != "") then { 
_txt = format ["75$ APC %1", F_APC_04];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [0.2,0.6,0.99,1]];   
lbSetData [2101, _index, F_APC_04];             
lbSetValue [2101, _index, 75];             
lbSetPictureRight [2101, _index, "\A3\armor_f_beta\APC_Tracked_01\Data\UI\APC_Tracked_01_AA_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then {
if (F_APC_05 != "") then { 
_txt = format ["75$ APC %1", F_APC_05];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [0.2,0.6,0.99,1]];   
lbSetData [2101, _index, F_APC_05];             
lbSetValue [2101, _index, 75];             
lbSetPictureRight [2101, _index, "\A3\armor_f_beta\APC_Tracked_01\Data\UI\APC_Tracked_01_AA_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then {
if (F_APC_06 != "") then { 
_txt = format ["75$ APC %1", F_APC_06];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [0.2,0.6,0.99,1]];   
lbSetData [2101, _index, F_APC_06];             
lbSetValue [2101, _index, 75];             
lbSetPictureRight [2101, _index, "\A3\armor_f_beta\APC_Tracked_01\Data\UI\APC_Tracked_01_AA_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then {
if (F_TNK_01 != "") then { 
_txt = format ["95$ TANK %1", F_TNK_01];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [0.2,0.6,0.99,1]];   
lbSetData [2101, _index, F_TNK_01];             
lbSetValue [2101, _index, 95];             
lbSetPictureRight [2101, _index, "Screens\FOBA\tank_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then {
if (F_TNK_02 != "") then { 
_txt = format ["95$ TANK %1", F_TNK_02];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [0.2,0.6,0.99,1]];   
lbSetData [2101, _index, F_TNK_02];             
lbSetValue [2101, _index, 95];             
lbSetPictureRight [2101, _index, "Screens\FOBA\tank_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then {
if (F_TNK_03 != "") then { 
_txt = format ["95$ TANK %1", F_TNK_03];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [0.2,0.6,0.99,1]];   
lbSetData [2101, _index, F_TNK_03];             
lbSetValue [2101, _index, 95];             
lbSetPictureRight [2101, _index, "Screens\FOBA\tank_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then {
if (F_TNK_04 != "") then { 
_txt = format ["95$ TANK %1", F_TNK_04];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [0.2,0.6,0.99,1]];   
lbSetData [2101, _index, F_TNK_04];             
lbSetValue [2101, _index, 95];             
lbSetPictureRight [2101, _index, "Screens\FOBA\tank_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then {
if (F_Art_01 != "") then { 
_txt = format ["95$ ARTILLERY %1", F_Art_01];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [0.2,0.6,0.99,1]];   
lbSetData [2101, _index, F_Art_01];             
lbSetValue [2101, _index, 95];             
lbSetPictureRight [2101, _index, "Screens\FOBA\tank_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then {
if (F_Art_02 != "") then { 
_txt = format ["95$ ARTILLERY %1", F_Art_02];
_index = lbAdd [2101, _txt];            
lbSetColor [2101, _index, [0.2,0.6,0.99,1]];   
lbSetData [2101, _index, F_Art_02];             
lbSetValue [2101, _index, 95];             
lbSetPictureRight [2101, _index, "Screens\FOBA\tank_ca.paa"]; 
(findDisplay 1599 displayCtrl 2101) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

//////AIR\SEA/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_Heli_01 != "") then { 
_txt = format ["55$ HELI %1", F_Heli_01];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0.2,0.6,0.99,1]];   
lbSetData [2102, _index, F_Heli_01];             
lbSetValue [2102, _index, 55];             
lbSetPictureRight [2102, _index, "\A3\Air_F_Beta\Heli_Transport_01\Data\UI\Heli_Transport_01_base_CA.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_Heli_02 != "") then { 
_txt = format ["55$ HELI %1", F_Heli_02];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0.2,0.6,0.99,1]];   
lbSetData [2102, _index, F_Heli_02];             
lbSetValue [2102, _index, 55];             
lbSetPictureRight [2102, _index, "\A3\Air_F_Beta\Heli_Transport_01\Data\UI\Heli_Transport_01_base_CA.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_Heli_03 != "") then { 
_txt = format ["55$ HELI %1", F_Heli_03];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0.2,0.6,0.99,1]];   
lbSetData [2102, _index, F_Heli_03];             
lbSetValue [2102, _index, 55];             
lbSetPictureRight [2102, _index, "\A3\Air_F_Beta\Heli_Transport_01\Data\UI\Heli_Transport_01_base_CA.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_Heli_04 != "") then { 
_txt = format ["55$ HELI RESPAWN %1", F_Heli_04];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0.9,1,0,1]];   
lbSetData [2102, _index, F_Heli_04];             
lbSetValue [2102, _index, 55];             
lbSetPictureRight [2102, _index, "\A3\Air_F_Beta\Heli_Transport_01\Data\UI\Heli_Transport_01_base_CA.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0.9,1,0,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_Heli_05 != "") then { 
_txt = format ["55$ HELI %1", F_Heli_05];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0.2,0.6,0.99,1]];   
lbSetData [2102, _index, F_Heli_05];             
lbSetValue [2102, _index, 55];             
lbSetPictureRight [2102, _index, "\A3\Air_F_Beta\Heli_Transport_01\Data\UI\Heli_Transport_01_base_CA.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_Heli_06_G != "") then { 
_txt = format ["80$ HELI GUNSHIP %1", F_Heli_06_G];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0.2,0.6,0.99,1]];   
lbSetData [2102, _index, F_Heli_06_G];             
lbSetValue [2102, _index, 80];             
lbSetPictureRight [2102, _index, "\A3\Air_F_Beta\Heli_Transport_01\Data\UI\Heli_Transport_01_base_CA.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_Heli_07_G != "") then { 
_txt = format ["80$ HELI GUNSHIP %1", F_Heli_07_G];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0.2,0.6,0.99,1]];   
lbSetData [2102, _index, F_Heli_07_G];             
lbSetValue [2102, _index, 80];             
lbSetPictureRight [2102, _index, "\A3\Air_F_Beta\Heli_Transport_01\Data\UI\Heli_Transport_01_base_CA.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_Plane_01_CAS != "") then { 
_txt = format ["95$ PLANE %1", F_Plane_01_CAS];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0.2,0.6,0.99,1]];   
lbSetData [2102, _index, F_Plane_01_CAS];             
lbSetValue [2102, _index, 95];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_Plane_02_CAS != "") then { 
_txt = format ["95$ PLANE %1", F_Plane_02_CAS];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0.2,0.6,0.99,1]];   
lbSetData [2102, _index, F_Plane_02_CAS];             
lbSetValue [2102, _index, 95];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_Plane_03 != "") then { 
_txt = format ["95$ PLANE %1", F_Plane_03];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0.2,0.6,0.99,1]];   
lbSetData [2102, _index, F_Plane_03];             
lbSetValue [2102, _index, 95];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_Plane_04 != "") then { 
_txt = format ["95$ PLANE %1", F_Plane_04];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0.2,0.6,0.99,1]];   
lbSetData [2102, _index, F_Plane_04];             
lbSetValue [2102, _index, 95];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_Plane_05 != "") then { 
_txt = format ["95$ PLANE %1", F_Plane_05];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0.2,0.6,0.99,1]];   
lbSetData [2102, _index, F_Plane_05];             
lbSetValue [2102, _index, 95];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_Plane_06 != "") then { 
_txt = format ["95$ PLANE %1", F_Plane_06];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0.2,0.6,0.99,1]];   
lbSetData [2102, _index, F_Plane_06];             
lbSetValue [2102, _index, 95];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (isClass (configfile >> "CfgVehicles" >> "USAF_A10") == true ) then {
_txt = format ["95$ PLANE %1", "USAF_A10"];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0,1,0,1]];   
lbSetData [2102, _index, "USAF_A10"];             
lbSetValue [2102, _index, 95];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0,1,0,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (isClass (configfile >> "CfgVehicles" >> "USAF_F22") == true ) then {
_txt = format ["100$ PLANE %1", "USAF_F22"];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0,1,0,1]];   
lbSetData [2102, _index, "USAF_F22"];             
lbSetValue [2102, _index, 100];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0,1,0,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (isClass (configfile >> "CfgVehicles" >> "USAF_F22_Heavy") == true ) then {
_txt = format ["100$ PLANE %1", "USAF_F22_Heavy"];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0,1,0,1]];   
lbSetData [2102, _index, "USAF_F22_Heavy"];             
lbSetValue [2102, _index, 100];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0,1,0,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (isClass (configfile >> "CfgVehicles" >> "USAF_F35A_STEALTH") == true ) then {
_txt = format ["100$ PLANE %1", "USAF_F35A_STEALTH"];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0,1,0,1]];   
lbSetData [2102, _index, "USAF_F35A_STEALTH"];             
lbSetValue [2102, _index, 100];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0,1,0,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (isClass (configfile >> "CfgVehicles" >> "USAF_F35A") == true ) then {
_txt = format ["100$ PLANE %1", "USAF_F35A"];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0,1,0,1]];   
lbSetData [2102, _index, "USAF_F35A"];             
lbSetValue [2102, _index, 100];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0,1,0,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (isClass (configfile >> "CfgVehicles" >> "USAF_AC130U") == true ) then {
_txt = format ["250$ PLANE %1", "USAF_AC130U"];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0,1,0,1]];   
lbSetData [2102, _index, "USAF_AC130U"];             
lbSetValue [2102, _index, 250];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0,1,0,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (isClass (configfile >> "CfgVehicles" >> "USAF_C130J") == true ) then {
_txt = format ["100$ PLANE %1", "USAF_C130J"];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0,1,0,1]];   
lbSetData [2102, _index, "USAF_C130J"];             
lbSetValue [2102, _index, 100];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0,1,0,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (isClass (configfile >> "CfgVehicles" >> "USAF_C130J_Cargo") == true ) then {
_txt = format ["100$ PLANE %1", "USAF_C130J_Cargo"];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0,1,0,1]];   
lbSetData [2102, _index, "USAF_C130J_Cargo"];             
lbSetValue [2102, _index, 100];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0,1,0,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (isClass (configfile >> "CfgVehicles" >> "usaf_kc135") == true ) then {
_txt = format ["250$ PLANE %1", "usaf_kc135"];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0,1,0,1]];   
lbSetData [2102, _index, "usaf_kc135"];             
lbSetValue [2102, _index, 250];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0,1,0,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (isClass (configfile >> "CfgVehicles" >> "USAF_C17") == true ) then {
_txt = format ["500$ PLANE %1", "USAF_C17"];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [0,1,0,1]];   
lbSetData [2102, _index, "USAF_C17"];             
lbSetValue [2102, _index, 500];             
lbSetPictureRight [2102, _index, "Screens\FOBA\plane_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [0,1,0,1]];
};};




_txt = format ["25$ BOAT %1", "B_Boat_Transport_01_F"];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [1,1,1,1]];   
lbSetData [2102, _index, "B_Boat_Transport_01_F"];             
lbSetValue [2102, _index, 25];             
lbSetPictureRight [2102, _index, "Screens\FOBA\naval_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [1,1,1,1]];

if (F_ABT_01 != "") then { 
_txt = format ["55$ BOAT %1", F_ABT_01];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [1,1,1,1]];   
lbSetData [2102, _index, F_ABT_01];             
lbSetValue [2102, _index, 55];             
lbSetPictureRight [2102, _index, "Screens\FOBA\naval_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [1,1,1,1]];
};

_txt = format ["55$ BOAT %1", "B_SDV_01_F"];
_index = lbAdd [2102, _txt];            
lbSetColor [2102, _index, [1,1,1,1]];   
lbSetData [2102, _index, "B_SDV_01_F"];             
lbSetValue [2102, _index, 55];             
lbSetPictureRight [2102, _index, "Screens\FOBA\naval_ca.paa"]; 
(findDisplay 1599 displayCtrl 2102) lbSetPictureRightColor [_index, [1,1,1,1]];


//////SUPPLIES/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



_txt = format ["35$ UAV %1", "B_UAV_01_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_UAV_01_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\uav_05_icon_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

if (isClass (configfile >> "CfgFactionClasses" >> "BLU_NATO_lxWS") == true ) then {
_txt = format ["35$ UAV %1", "B_UAV_02_lxWS"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_UAV_02_lxWS"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\uav_05_icon_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (isClass (configfile >> "CfgVehicles" >> "USAF_RQ4A") == true ) then {
_txt = format ["100$ UAV %1", "USAF_RQ4A"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [0,1,0,1]];   
lbSetData [2103, _index, "USAF_RQ4A"];             
lbSetValue [2103, _index, 100];             
lbSetPictureRight [2103, _index, "Screens\FOBA\uav_05_icon_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [0,1,0,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (isClass (configfile >> "CfgVehicles" >> "USAF_MQ9") == true ) then {
_txt = format ["120$ UAV %1", "USAF_MQ9"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [0,1,0,1]];   
lbSetData [2103, _index, "USAF_MQ9"];             
lbSetValue [2103, _index, 120];             
lbSetPictureRight [2103, _index, "Screens\FOBA\uav_05_icon_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [0,1,0,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_UAV_01 != "") then { 
_txt = format ["80$ UAV %1", F_UAV_01];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, F_UAV_01];             
lbSetValue [2103, _index, 80];             
lbSetPictureRight [2103, _index, "Screens\FOBA\uav_05_icon_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_UAV_02 != "") then { 
_txt = format ["80$ UAV %1", F_UAV_02];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, F_UAV_02];             
lbSetValue [2103, _index, 80];             
lbSetPictureRight [2103, _index, "Screens\FOBA\uav_05_icon_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];
};};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
if (F_UAV_03 != "") then { 
_txt = format ["80$ UAV %1", F_UAV_03];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, F_UAV_03];             
lbSetValue [2103, _index, 80];             
lbSetPictureRight [2103, _index, "Screens\FOBA\uav_05_icon_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];
};};

_txt = format ["35$ UGV %1", "B_UGV_02_Demining_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_UGV_02_Demining_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\portrait_UGV_01_CA.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

if (F_UGV_01 != "") then { 
_txt = format ["55$ UGV %1", F_UGV_01];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, F_UGV_01];             
lbSetValue [2103, _index, 55];             
lbSetPictureRight [2103, _index, "Screens\FOBA\portrait_UGV_01_CA.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];
};

_txt = format ["35$ CONTAINER %1", "B_Slingload_01_Medevac_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_Slingload_01_Medevac_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\container_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["35$ CONTAINER %1", "B_Slingload_01_Ammo_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_Slingload_01_Ammo_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\container_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["100$ CONTAINER %1", "B_Slingload_01_Repair_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,0.6,0,1]];   
lbSetData [2103, _index, "B_Slingload_01_Repair_F"];             
lbSetValue [2103, _index, 100];             
lbSetPictureRight [2103, _index, "Screens\FOBA\container_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,0.6,0,1]];

_txt = format ["35$ CONTAINER %1", "B_Slingload_01_Fuel_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_Slingload_01_Fuel_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\container_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["35$ STATIC %1", "B_W_Static_Designator_01_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_W_Static_Designator_01_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["45$ STATIC %1", "B_HMG_01_A_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_HMG_01_A_F"];             
lbSetValue [2103, _index, 45];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["45$ STATIC %1", "B_GMG_01_A_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_GMG_01_A_F"];             
lbSetValue [2103, _index, 45];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["45$ STATIC %1", F_turret_01];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, F_turret_01];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["35$ STATIC %1", F_turret_02];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, F_turret_02];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

_txt = format ["35$ STATIC %1", F_turret_03];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, F_turret_03];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

if (F_Art_00 != "") then { 
_txt = format ["35$ STATIC %1", F_Art_00];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, F_Art_00];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];
};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
_txt = format ["35$ STATIC %1", "B_SAM_System_01_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [0.2,0.6,0.99,1]];   
lbSetData [2103, _index, "B_SAM_System_01_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
_txt = format ["35$ STATIC %1", "B_SAM_System_02_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [0.2,0.6,0.99,1]];   
lbSetData [2103, _index, "B_SAM_System_02_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
_txt = format ["35$ STATIC %1", "B_SAM_System_03_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [0.2,0.6,0.99,1]];   
lbSetData [2103, _index, "B_SAM_System_03_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};

if (count (nearestObjects [position player, ["B_Radar_System_01_F", "I_E_Radar_System_01_F"], 500]) > 0) then { 
_txt = format ["35$ STATIC %1", "B_AAA_System_01_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [0.2,0.6,0.99,1]];   
lbSetData [2103, _index, "B_AAA_System_01_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\icon_HMG_02_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};

_txt = format ["35$ SUPPLIES %1", "B_CargoNet_01_ammo_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "B_CargoNet_01_ammo_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\box_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];


_txt = format ["35$ SUPPLIES %1", "Box_NATO_AmmoVeh_F"];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [1,1,1,1]];   
lbSetData [2103, _index, "Box_NATO_AmmoVeh_F"];             
lbSetValue [2103, _index, 35];             
lbSetPictureRight [2103, _index, "Screens\FOBA\box_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [1,1,1,1]];

if (F_RADAR != "") then { 
_txt = format ["250$ OPERATION CONTROL SYSTEM %1", F_RADAR];
_index = lbAdd [2103, _txt];            
lbSetColor [2103, _index, [0.2,0.6,0.99,1]];   
lbSetData [2103, _index, F_RADAR];             
lbSetValue [2103, _index, 250];             
lbSetPictureRight [2103, _index, "Screens\FOBA\Radar_ca.paa"]; 
(findDisplay 1599 displayCtrl 2103) lbSetPictureRightColor [_index, [0.2,0.6,0.99,1]];
};
};

//////INFORMATION/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_Money = markerText "Money_Handle" ;

_mrkrs = allMapMarkers select {markerColor _x == "Color4_FD_F"};
_mrkr = _mrkrs select 0;
_REPSCORE = parseNumber (markerText _mrkr) ;  
_rep = "Friendly";
if (_REPSCORE < 7) then {
_rep = "Enemy";
};
if ((_REPSCORE < 11) && (_REPSCORE > 6)) then {
_rep = "Neutral";
};	
if (_REPSCORE > 10) then {
_rep = "Friendly";
};	


_agr = "100";
_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_AGGRSCORE = parseNumber (markerText _mrkr) ;  
_agr = _AGGRSCORE * 6.25;

		ctrlSetText [1000, format["Resources : %1 ", _Money]];
		ctrlSetText [1001, format["Resistance : %1 ",  _rep ]];
		ctrlSetText [1002, format["Aggression : %1 %2 ",  _agr, "%" ]];
		sleep 0.066;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

INF_REQUEST = {

    _CTRL = 2100;
	_index = lbCurSel _CTRL;
	_Name = lbData [_CTRL, _index];
    _Cost = lbValue [_CTRL, _index];
   	_SQDName = missionNamespace getVariable _Name;


_FOBB = nearestObjects [position player, [F_HQ_01], 150] select 0;
_pos = _FOBB getRelPos [13, 270];

_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  
if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;




if (_Cost == 3) then {

NEWUNIT = group player createUnit [_SQDName, _pos, [], 0, "FORM"];
publicVariable "NEWUNIT";

[NEWUNIT,'MENU_COMMS_UAV_RECON',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[NEWUNIT,'MENU_COMMS_SUPPLYDROP',nil,nil,''] call BIS_fnc_addCommMenuItem;
[NEWUNIT,'MENU_COMMS_INF',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[NEWUNIT,'MENU_COMMS_GRD',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[NEWUNIT,'MENU_COMMS_CAS_HELI',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[NEWUNIT,'MENU_COMMS_ARTI',nil,nil,''] call BIS_fnc_addCommMenuItem;	

NEWUNIT linkItem 'B_UavTerminal';
NEWUNIT addItem 'optic_Hamr';
	
//{ [NEWUNIT] execVM "Scripts\LDTInit.sqf" ; } remoteExec ["call", 2];

}else{
	
GRPReq = [_pos, west, _SQDName] call BIS_fnc_spawnGroup;
publicVariable "GRPReq";


{
[_x,'MENU_COMMS_UAV_RECON',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[_x,'MENU_COMMS_SUPPLYDROP',nil,nil,''] call BIS_fnc_addCommMenuItem;
[_x,'MENU_COMMS_INF',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[_x,'MENU_COMMS_GRD',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[_x,'MENU_COMMS_CAS_HELI',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[_x,'MENU_COMMS_ARTI',nil,nil,''] call BIS_fnc_addCommMenuItem;	
} foreach Units GRPReq;

			private _headlessClients = entities "HeadlessClient_F";
			private _humanPlayers = allPlayers - _headlessClients;
			hcRemoveAllGroups player;  
			 {player hcRemoveGroup _x ;} forEach (allGroups select {side _x == west}); 
			 _GRPs = (allGroups select {(side _x == (side player)) && !(((units _x) select 0) in switchableUnits)}); 
			if (count _humanPlayers == 1 ) then {
			{player hcSetGroup [_x];} forEach _GRPs;
			}else{
			{TheCommander hcSetGroup [_x];} forEach _GRPs;
			};
			
{_x enableAI 'RADIOPROTOCOL';} foreach Units GRPReq;


//{	{[_x] execVM "Scripts\LDTInit.sqf" ; } forEach Units GRPReq ;  } remoteExec ["call", 2];
{_x enableAI 'RADIOPROTOCOL'} foreach Units GRPReq;
	closeDialog 0;
	
{
	
		_x setUnitTrait ["engineer", true];
_x setVariable ["ACE_isEngineer", true];

} forEach (Units GRPReq select { (typeOf _x == F_Assault_Eng)  || (typeOf _x == "B_G_engineer_F")  || (typeOf _x == F_Recon_Eng)  || (typeOf _x == "B_CTRG_soldier_engineer_exp_F")} ) ;

{
	
	_x setUnitTrait ["explosiveSpecialist", true];
_x setVariable ["ACE_isEOD", true];
} forEach (Units GRPReq select {(typeOf _x == F_Assault_Eod)  || (typeOf _x == F_Recon_Eod) || (typeOf _x == "B_CTRG_soldier_engineer_exp_F") || (typeOf _x == "B_G_Soldier_exp_F")} ) ;

	{
		
			_x setUnitTrait ["medic", true];
_x setVariable ["ace_medical_medicclass",2, true];
} forEach (Units GRPReq select { (typeOf _x == F_Recon_Med)  || (typeOf _x == F_Assault_Med)  || (typeOf _x == "B_G_medic_F")  || (typeOf _x == "B_CTRG_soldier_M_medic_F") } ) ;


{
	
	_x setUnitTrait ["explosiveSpecialist", true];
_x setVariable ["ACE_isEOD", true];
} forEach (Units GRPReq select {(typeOf _x == F_Assault_Eod)  || (typeOf _x == F_Recon_Eod) || (typeOf _x == "B_CTRG_soldier_engineer_exp_F") || (typeOf _x == "B_G_Soldier_exp_F")} ) ;


}; }else{ 
   
  hint "Not enough Resources"; 
   	closeDialog 0;
  };



};


VEH_REQUEST = {

    _CTRL = _this select 0;
	_index = lbCurSel _CTRL;
	_VehName = lbData [_CTRL, _index];
    CostV = lbValue [_CTRL, _index];

_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  
if (_Money >= CostV) then {
_NewMoney = _Money - CostV; 
_mrkr setMarkerText str _NewMoney;


_pos = [getPosATL player select 0, getPosATL player select 1, (getPosATL player select 2) + 100];
CreatedVEH = createVehicle [_VehName,_pos,[],0,'NONE'];


if ((_VehName == "rhsusf_stryker_m1126_m2_d") or (_VehName == "rhsusf_stryker_m1126_mk19_d") or (_VehName == "rhsusf_stryker_m1134_d")) then {
[CreatedVEH,["Tan",1]] call BIS_fnc_initVehicle;
};

if (((markerText "Friendly_Handle" == "United States Armed Forces _ Woodland _ CUP + RHS") or (markerText "Friendly_Handle" == "United States Armed Forces _ Woodland _ RHS")) && (_VehName == "rhsusf_mrzr4_d") ) then {[CreatedVEH,["mud_olive",1]] call BIS_fnc_initVehicle;};

if (_VehName == "B_Slingload_01_Repair_F") then {
[CreatedVEH,[
	"<img size=2 color='#7CC2FF' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#7CC2FF'>UnPack OP",
	"Scripts\OPUNPACK.sqf",
	nil,
	0,
	true,
	true,
	"",
	"true", // _target, _this, _originalTarget
	40,
	false,
	"",
	""
]] remoteExec ["addAction",0,true];
};

if (_VehName == "B_CargoNet_01_ammo_F") then {
CreatedVEH addMagazineCargoGlobal  ["DemoCharge_Remote_Mag", 20];
CreatedVEH addMagazineCargoGlobal  ["APERSBoundingMine_Range_Mag", 7];
CreatedVEH addMagazineCargoGlobal  ["APERSMine_Range_Mag", 7];
CreatedVEH addMagazineCargoGlobal  ["ClaymoreDirectionalMine_Remote_Mag", 7];
CreatedVEH addMagazineCargoGlobal  ["SLAMDirectionalMine_Wire_Mag", 7];
CreatedVEH addMagazineCargoGlobal   ["B_IR_Grenade", 7];
CreatedVEH addMagazineCargoGlobal   ["SmokeShell", 7];
CreatedVEH addMagazineCargoGlobal   ["HandGrenade", 7];
CreatedVEH addBackpackCargoGlobal ["B_UAV_01_backpack_F", 2];
CreatedVEH addBackpackCargoGlobal ["B_Static_Designator_01_weapon_F", 2];
CreatedVEH addBackpackCargoGlobal ["B_W_Static_Designator_01_weapon_F", 2];
CreatedVEH addBackpackCargoGlobal ["B_UGV_02_Demining_backpack_F", 2];
CreatedVEH addBackpackCargoGlobal ["B_Patrol_Respawn_bag_F", 2];
CreatedVEH addWeaponCargoGlobal ["launch_B_Titan_tna_F", 5];
CreatedVEH addWeaponCargoGlobal ["launch_B_Titan_F", 5];
CreatedVEH addWeaponCargoGlobal ["launch_B_Titan_short_F", 5];
CreatedVEH addWeaponCargoGlobal ["launch_I_Titan_short_F", 5];
CreatedVEH addWeaponCargoGlobal ["launch_NLAW_F", 5];
CreatedVEH addMagazineCargoGlobal ["NLAW_F", 15];
CreatedVEH addMagazineCargoGlobal ["MRAWS_HEAT_F", 15];
CreatedVEH addMagazineCargoGlobal ["Titan_AT", 15];
CreatedVEH addMagazineCargoGlobal ["Titan_AA", 15];
CreatedVEH addMagazineCargoGlobal ["Titan_AP", 15];

[ CreatedVEH,
"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>ARSENAL",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
	
	if (isClass (configfile >> "ace_arsenal_loadoutsDisplay") == true ) then {
		[player, player, true] call ace_arsenal_fnc_openBox;
	} else {
		["Open", true] spawn BIS_fnc_arsenal;
	};
},
{},
[],
1,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

[ CreatedVEH,
"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>REARM Infantry",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
[(_this select 0)] execVM "Scripts\REARM.sqf" ;
},
{},
[],
1,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

};


_MOBSERName = missionNamespace getVariable "F_Truck_04";
if (_VehName == _MOBSERName) then {
[CreatedVEH, -1, west, "LIGHT"] execVM "R3F_LOG\USER_FUNCT\init_creation_factory.sqf" ;
[ CreatedVEH,
"<img size=2 color='#f37c00' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa'/><t font='PuristaBold' color='#f37c00'>REPAIR Vehicles",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
[(_this select 0)] execVM "Scripts\REPAIRVEH.sqf" ;
},
{},
[],
10,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true]; 
};
	
_MOBSERName = missionNamespace getVariable "F_Truck_03";
if (_VehName == _MOBSERName) then {
	
[ CreatedVEH,
"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>ARSENAL",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
	
	if (isClass (configfile >> "ace_arsenal_loadoutsDisplay") == true ) then {
		[player, player, true] call ace_arsenal_fnc_openBox;
	} else {
		["Open", true] spawn BIS_fnc_arsenal;
	};
},
{},
[],
1,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

[ CreatedVEH,
"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>REARM Infantry",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
[(_this select 0)] execVM "Scripts\REARM.sqf" ;
},
{},
[],
5,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

[ CreatedVEH,
"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>REARM Vehicles",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
[(_this select 0)] execVM "Scripts\REARMVEH.sqf" ;
},
{},
[],
10,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

};

CursorTracker = true ;
CreatedVEH enableSimulation false ;
CreatedVEH allowDammage false ;
CreatedVEHREF = createVehicle ["Sign_Sphere10cm_F",screenToWorld [ 0.5, 0.5 ],[],0,"NONE"] ;
CreatedVEHREF hideObjectGlobal true ;
CreatedVEHREF allowDammage false ;
CreatedVEH attachTo [CreatedVEHREF, [0, 0, 3]] ;
[] spawn {  
  while {CursorTracker == true} do {  
  CreatedVEHREF setVehiclePosition [ screenToWorld [ 0.5, 0.5 ], [], 0, "CAN_COLLIDE"];
  CreatedVEHREF setDir ((getDirVisual player) + 230);
  sleep 0.3;
  };
};


Ind01 = [ player,
"<t color='#FF0000'>CANCEL</t>",
'Screens\FOBA\iconRepairAt_ca.paa',
'Screens\FOBA\iconRepairAt_ca.paa',
'true',       
'true',  
{},
{},
{
detach CreatedVEH; 
CreatedVEH enableSimulation true;
deleteVehicle CreatedVEH;
_mrkrs = allMapMarkers select {markerColor _x == 'Color2_FD_F'};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  
_NewMoney = _Money + CostV; 
_mrkr setMarkerText str _NewMoney;
deleteVehicle CreatedVEHREF;
player removeAction Ind01;
player removeAction Ind02;
player removeAction Ind03;
},
{},
[],
3,
0,
false,
false
] call BIS_fnc_holdActionAdd; 

Ind02 = [ player,
"<t color='#FF0000'>PLACE (crew)</t>",
'Screens\FOBA\iconRepairAt_ca.paa',
'Screens\FOBA\iconRepairAt_ca.paa',
'true',       
'true',  
{},
{},
{
detach CreatedVEH; 
CreatedVEH setVehiclePosition [ getPos CreatedVEHREF, [], 0, "CAN_COLLIDE"];
CreatedVEH enableSimulation true;
CursorTracker = false ;
deleteVehicle CreatedVEHREF;
CreatedVEH enableSimulation true;
CreatedVEH allowDammage true ;
player removeAction Ind01;
player removeAction Ind02;
player removeAction Ind03;

_vehicleConfig = (configFile >> "CfgVehicles" >> typeOf CreatedVEH);
_crewType = [west, _vehicleConfig] call BIS_fnc_selectCrew;
_CrewFull = createVehicleCrew CreatedVEH ;
_CrewSelCnt = count (units _CrewFull) - 1; 
deleteVehicleCrew CreatedVEH;
_Group = createGroup West ; 
for "_x" from 0 to _CrewSelCnt do { _unit = _Group createunit [_crewType,[0,0,0], [], 0, "CAN_COLLIDE"]; }; 
{_x moveInAny CreatedVEH} foreach units _Group;  
	{ [_x] JoinSilent _Group } foreach units _Group;  
	
_H1Name = missionNamespace getVariable "F_Heli_01";
_H2Name = missionNamespace getVariable "F_Heli_02";
_H3Name = missionNamespace getVariable "F_Heli_03";
_H4Name = missionNamespace getVariable "F_Heli_04";
_H5Name = missionNamespace getVariable "F_Heli_05";
_H5Name = missionNamespace getVariable "F_Heli_05";

if (typeOf CreatedVEH == _H1Name or typeOf CreatedVEH == _H2Name or typeOf CreatedVEH == _H3Name or typeOf CreatedVEH == _H4Name or typeOf CreatedVEH == _H5Name) then {_Group setVariable ["Vcm_Disable",true]; };
TheCommander hcSetGroup [_Group];
},
{},
[],
3,
0,
false,
false
] call BIS_fnc_holdActionAdd; 

Ind03 = [ player,
"<t color='#FF0000'>PLACE </t>",
'Screens\FOBA\iconRepairAt_ca.paa',
'Screens\FOBA\iconRepairAt_ca.paa',
'true',       
'true',  
{},
{},
{
detach CreatedVEH; 
CreatedVEH setVehiclePosition [ getPos CreatedVEHREF, [], 0, "CAN_COLLIDE"];
CreatedVEH enableSimulation true;
CursorTracker = false ;
deleteVehicle CreatedVEHREF;
CreatedVEH enableSimulation true;
CreatedVEH allowDammage true ;
player removeAction Ind01;
player removeAction Ind02;
player removeAction Ind03;
},
{},
[],
3,
0,
false,
false
] call BIS_fnc_holdActionAdd; 

}else{hint "Not Enough Resources";};

	
	closeDialog 0;

};







































































   
