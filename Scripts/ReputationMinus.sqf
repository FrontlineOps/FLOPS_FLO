sleep 12 ;

_mrkrs = allMapMarkers select {markerColor _x == "Color4_FD_F"};
_mrkr = _mrkrs select 0;
_REPSCORE = parseNumber (markerText _mrkr) ;  

if (_REPSCORE != 0) then {


[parseText "<t color='#00DB07' font='PuristaBold' align = 'right' shadow = '1' size='2'>REPUTATION</t><br /><t  align = 'right' shadow = '1' size='1'>Decreased - - - </t>", [0, 0.5, 1, 1], nil, 4, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];


_NewScore = _REPSCORE - 1; 
_mrkr setMarkerText str _NewScore;


};






















