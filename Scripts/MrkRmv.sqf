

sleep 2 ;

 _allMissMarks = allMapMarkers select {markerShape _x == "ELLIPSE" && markerBrush _x == "SolidBorder" && markerColor _x == "colorCivilian"};   
	{deleteMarker _x} forEach _allMissMarks ;
