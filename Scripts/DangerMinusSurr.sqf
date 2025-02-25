sleep 8;

["showNotification", ["AGGRESSION", "Decreased - - -", "warning"]] call FLO_fnc_intelSystem;

_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_AGGRSCORE = parseNumber (markerText _mrkr);  

if (_AGGRSCORE > 0) then {
    _NewScore = _AGGRSCORE - 0.5; 
    _mrkr setMarkerText str _NewScore;
} else { 
    _NewScore = 0; 
    _mrkr setMarkerText str _NewScore;
};



