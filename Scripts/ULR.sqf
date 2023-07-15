sleep 180 ;

if ((!isMultiplayer) or (isServer)) then {
UNIT_LIMIT = 50 ;
	publicVariable "UNIT_LIMIT";
} ;

if (isDedicated) then {
UNIT_LIMIT = 100 ;
	publicVariable "UNIT_LIMIT";
};

if (!(isServer) && !(hasInterface)) then {
UNIT_LIMIT = 150 ;
	publicVariable "UNIT_LIMIT";
} ; 