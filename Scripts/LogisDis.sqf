sleep 18 ;



[parseText "<t color='#1AA3FF' font='PuristaBold' align = 'right' shadow = '1' size='2'>+ Enemy Logistics Support Dismantled</t><br /><t  align = 'right' shadow = '1' size='1'>For the Next Hour</t>", [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];




LOGDIS = 1;
publicVariable "LOGDIS";

 _LOGs = nearestObjects [ player, East_Ground_Vehicles_Ambient, 40000];
{
_x setFuel 0;
_x setVehicleAmmo 0;
((crew _x) select 0) leaveVehicle _x;

} forEach _LOGs;

sleep 3600 ;

LOGDIS = 0;
publicVariable "LOGDIS";

