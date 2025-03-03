sleep 8 ;

_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_AGGRSCORE = parseNumber (markerText _mrkr) ;  

if (_AGGRSCORE > 0) then {

["showNotification", ["AGGRESSION", "Decreased - - -", "warning"]] call FLO_fnc_intelSystem;

_NewScore = _AGGRSCORE - 1; 
_mrkr setMarkerText str _NewScore;

} else { 

_NewScore = 0 ; 
_mrkr setMarkerText str _NewScore;

};

