

_RWRD = _this select 0;

_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  
_NewMoney = _Money + _RWRD; 
_mrkr setMarkerText str _NewMoney;

sleep 1 ; 

_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  

if (_Money > 2000) then {
	_mrkr setMarkerText "2000" ;
}; 
























