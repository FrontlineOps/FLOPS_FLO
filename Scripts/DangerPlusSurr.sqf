sleep 8 ;


_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_DANSCORE = parseNumber (markerText _mrkr) ;  

if (_DANSCORE < 16) then {

[parseText "<t color='#FF3619' font='PuristaBold' align = 'right' shadow = '1' size='2'>Aggression</t><br /><t  align = 'right' shadow = '1' size='1'>Increased + </t>", [0, 0.5, 1, 1], nil, 4, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];


_NewScore = _DANSCORE + 0.35; 
_mrkr setMarkerText str _NewScore;


} else { 

_NewScore = 15 ; 
_mrkr setMarkerText str _NewScore;

};

