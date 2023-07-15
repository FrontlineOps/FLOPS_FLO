sleep 2;
_INTL = allMapMarkers select { (markerAlpha _x == 0.001 or markerAlpha _x == 0) && markerColor _x == "colorOPFOR" && markerType _x == "o_antiair" && getMarkerPos _x distance player < 7000};              
{
_x setMarkerAlpha 1;
} forEach _INTL;

openMap true;
 [[7000, 7000], position player, 1.5] call BIS_fnc_zoomOnArea;
sleep 1;
[parseText "<t color='#FACE00' font='PuristaBold' align = 'right' shadow = '1' size='2'>+ NEW INTEL</t><br /><t color='#7c7c7c' align = 'right' shadow = '1' size='1'>Satellite Intel Received </t>", [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];

 
