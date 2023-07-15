if ((typeOf player == F_Officer) || (typeOf player == "B_G_officer_F")) then {

_Cost = 200;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  
if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;

_mrkrs = allMapMarkers select {markerColor _x == "Color4_FD_F"};
_mrkr = _mrkrs select 0;
_NewScore = 15; 
_mrkr setMarkerText str _NewScore;


[parseText "<t color='#00DB07' font='PuristaBold' align = 'right' shadow = '1' size='3'>REPUTATION</t><br /><t  align = 'right' shadow = '1' size='1.6'>Increased + + + </t><br /><t  align = 'right' shadow = '1' size='1.3'>200k $ Price paid for Civilian losses </t><br /><t  align = 'right' shadow = '1' size='1.3'>and Damages to the Infrastructures,</t><br /><t  align = 'right' shadow = '1' size='1.3'>Local militia agreed to the Cease Fire,</t>", [0, 0.5, 1, 1], nil, 13, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];


}else{hint "Not enough Resources"; };
}else{  hint "You are not authorized for this Request Soldier!"; };

