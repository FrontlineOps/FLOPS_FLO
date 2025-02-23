sleep 12 ;

_mrkrs = allMapMarkers select {markerColor _x == "Color4_FD_F"};
_mrkr = _mrkrs select 0;
_REPSCORE = parseNumber (markerText _mrkr) ;  

if (_REPSCORE != 0) then {


["showNotification", ["REPUTATION", "Decreased - - -", "success"]] call FLO_fnc_intelSystem;


_NewScore = _REPSCORE - 1; 
_mrkr setMarkerText str _NewScore;


};






















