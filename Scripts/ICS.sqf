 
 
 
 
 {  
 _objectLocT = allMapMarkers select { markerType _x == "loc_Transmitter" && markerColor _x == "colorBLUFOR"};  
 _NearFOBMark = [_objectLocT,  position _x] call BIS_fnc_nearestPosition ;  
    if ((getMarkerPos _NearFOBMark) distance (position _x) < 3500 ) then {   
_radius = 50 + (random 250) ;  
_markerName = "Enm_East" + (str (_x getPos [(5 + (random 15)),(0 + (random 360))]));    
_mrkr = createMarkerLocal [_markerName,_x getPos [(5 + (random 15)),(0 + (random 360))]];   
_mrkr setMarkerTypeLocal "Unknown";  
_mrkr setMarkerColorLocal "colorOPFOR";  
_mrkr setMarkerBrushLocal "FDiagonal";  
_mrkr setMarkerShapeLocal "RECTANGLE";   
_mrkr setMarkerSizeLocal [_radius, _radius];  
_mrkr setMarkerAlpha (0 + (random 0.4));} ;  
 } foreach (allUnits select {side _x == east && alive _x  && leader _x == _x});  

sleep 1 ; 

 {  
 _objectLocT = allMapMarkers select { markerType _x == "loc_Transmitter" && markerColor _x == "colorBLUFOR"};  
 _NearFOBMark = [_objectLocT,  position _x] call BIS_fnc_nearestPosition ;  
    if ((getMarkerPos _NearFOBMark) distance (position _x) < 3500 ) then {   
_radius = 50 + (random 100) ;  
_markerName = "Enm_Guer" + (str (_x getPos [(5 + (random 15)),(0 + (random 360))]));    
_mrkr = createMarkerLocal [_markerName,_x getPos [(5 + (random 15)),(0 + (random 360))]];   
_mrkr setMarkerTypeLocal "Unknown";  
_mrkr setMarkerColorLocal "colorIndependent";  
_mrkr setMarkerBrushLocal "FDiagonal";  
_mrkr setMarkerShapeLocal "RECTANGLE";   
_mrkr setMarkerSizeLocal [_radius, _radius];  
_mrkr setMarkerAlpha (0 + (random 0.4));} ;  
 } foreach (allUnits select {side _x == independent && alive _x  && leader _x == _x});  
 
sleep 1 ; 
 
  {  
 _objectLocT = allMapMarkers select { markerType _x == "loc_Transmitter" && markerColor _x == "colorBLUFOR"};  
 _NearFOBMark = [_objectLocT,  getMarkerPos _x] call BIS_fnc_nearestPosition ;  
    if ((getMarkerPos _NearFOBMark) distance (getMarkerPos _x) < 3500 ) then {   
_radius = 50 + (random 250) ;  
_markerName = "Enm_East" + (str ((getMarkerPos _x) getPos [(5 + (random 15)),(0 + (random 360))]));    
_mrkr = createMarkerLocal [_markerName,(getMarkerPos _x)];   
_mrkr setMarkerTypeLocal "Unknown";  
_mrkr setMarkerColorLocal "colorOPFOR";  
_mrkr setMarkerBrushLocal "FDiagonal";  
_mrkr setMarkerShapeLocal "RECTANGLE";   
_mrkr setMarkerSizeLocal [_radius, _radius];  
_mrkr setMarkerAlpha (0 + (random 0.4));} ;  
 } foreach (allMapMarkers select {markerType _x == "o_Ordnance" && markerColor _x == "colorOPFOR"});  

sleep 1 ; 

 {  
 _objectLocT = allMapMarkers select { markerType _x == "loc_Transmitter" && markerColor _x == "colorBLUFOR"};  
 _NearFOBMark = [_objectLocT,  (getMarkerPos _x)] call BIS_fnc_nearestPosition ;  
    if ((getMarkerPos _NearFOBMark) distance (getMarkerPos _x) < 3500 ) then {   
_radius = 50 + (random 100) ;  
_markerName = "Enm_Guer" + (str ((getMarkerPos _x) getPos [(5 + (random 15)),(0 + (random 360))]));    
_mrkr = createMarkerLocal [_markerName, (getMarkerPos _x)];   
_mrkr setMarkerTypeLocal "Unknown";  
_mrkr setMarkerColorLocal "colorIndependent";  
_mrkr setMarkerBrushLocal "FDiagonal";  
_mrkr setMarkerShapeLocal "RECTANGLE";   
_mrkr setMarkerSizeLocal [_radius, _radius];  
_mrkr setMarkerAlpha (0 + (random 0.4));} ;  
 } foreach (allMapMarkers select {markerType _x == "o_Ordnance" && markerColor _x == "colorIndependent"});  
 