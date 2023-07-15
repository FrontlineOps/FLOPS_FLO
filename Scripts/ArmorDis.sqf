sleep 18 ;


[parseText "<t color='#1AA3FF' font='PuristaBold' align = 'right' shadow = '1' size='2'>+ Enemy Armored Support Dismantled </t><br /><t  align = 'right' shadow = '1' size='1'>For the Next Hour</t>", [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];




ARMDIS = 1;
publicVariable "ARMDIS";

_ARMs = nearestObjects [ player, East_Ground_Vehicles_Heavy, 40000];
{
_x setFuel 0;
_x setVehicleAmmo 0;
((crew _x) select 0) leaveVehicle _x;

} forEach _ARMs;
 
sleep 3600 ;

ARMDIS = 0;
publicVariable "ARMDIS";
