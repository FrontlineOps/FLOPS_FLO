[ format['', PHOUR],0.2,0,9999,0,0,7537] spawn BIS_fnc_dynamicText; 
closeDialog 0;
titleText ["_Hours_Later_", "BLACK IN",10];
{ skipTime PHOUR;  } remoteExec ["call", 2];
playMusic "LeadTrack01_F_Curator";
closeDialog 0;
