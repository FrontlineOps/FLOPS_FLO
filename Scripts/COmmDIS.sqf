
sleep 18 ;


COMMSDIS = 1;
publicVariable "COMMSDIS";

 [parseText "<t color='#1AA3FF' font='PuristaBold' align = 'right' shadow = '1' size='2.5'>+ Enemy Communications Disabled</t><br /><t  align = 'right' shadow = '1' size='1.5'>For the Next Hour</t>", [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];


sleep 3600 ;

COMMSDIS = 0;
publicVariable "COMMSDIS";