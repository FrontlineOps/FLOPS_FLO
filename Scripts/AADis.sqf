
sleep 18 ;


_OAA = nearestObjects [position player, ["O_Radar_System_02_F", "O_SAM_System_04_F"], 40000];

{
deleteVehicleCrew vehicle _x ;
 } foreach _OAA;
 
 [parseText "<t color='#1AA3FF' font='PuristaBold' align = 'right' shadow = '1' size='2'>+ Enemy AntiAir Sites Disabled</t><br /><t  align = 'right' shadow = '1' size='1'>For the Next Hour</t>", [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];


sleep 3600 ;


{
_gRPcREW = createVehicleCrew _x ;
_Group = createGroup East; 
{[_x] join _Group} forEach units _gRPcREW;

 } foreach _OAA;