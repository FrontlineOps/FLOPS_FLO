sleep 18 ;

[parseText "<t color='#1AA3FF' font='PuristaBold' align = 'right' shadow = '1' size='2.5'>+ Enemy Air Support Dismantled</t><br /><t  align = 'right' shadow = '1' size='1.5'>For the Next Hour</t>", [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];




HELIDIS = 1;
publicVariable "HELIDIS";


 _Helis = nearestObjects [ player, East_Air_Heli, 40000];
{
_x setFuel 0;
_x setVehicleAmmo 0;
((crew _x) select 0) leaveVehicle _x;

} forEach _Helis;

sleep 3600 ;

HELIDIS = 0;
publicVariable "HELIDIS";
