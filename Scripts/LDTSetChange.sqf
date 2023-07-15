


{[_x] execVM "Scripts\LDTInit.sqf" ;} forEach Units west ;  

sleep 0.5 ;

{	{[_x] execVM "Scripts\LDTInit.sqf" ;} forEach allPlayers ;  } remoteExec ["call", 0];
