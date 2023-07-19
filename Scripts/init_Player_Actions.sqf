
//////////////////////////////////////////////////////////////////////////////////////////////

//TODO: This file might be obsolete

sleep 2;


	titleText ["<t color='#0188FE' size='2' font='PuristaBold'>B.S.P  |  CONVENTIONAL OPERATIONS</t>", "BLACK IN",7, true, true];

hintSilent "" ;

player hideObjectGlobal false;
player enableSimulationGlobal true;
player allowDammage true;

if (isMultiplayer) then {
	RESPAWN_IS_FORCED = true;
	forceRespawn player;
};

player linkItem "B_UavTerminal";