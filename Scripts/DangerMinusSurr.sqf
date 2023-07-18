sleep 8 ;

_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_AGGRSCORE = parseNumber (markerText _mrkr) ;  

if (_AGGRSCORE > 0) then {

[parseText "<t color='#FF3619' font='PuristaBold' align = 'right' shadow = '1' size='2'>Aggression</t><br /><t  align = 'right' shadow = '1' size='1'>Decreased - </t>", [0, 0.5, 1, 1], nil, 4, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];


_NewScore = _AGGRSCORE - 0.5; 
_mrkr setMarkerText str _NewScore;


} else { 

_NewScore = 0 ; 
_mrkr setMarkerText str _NewScore;

};



