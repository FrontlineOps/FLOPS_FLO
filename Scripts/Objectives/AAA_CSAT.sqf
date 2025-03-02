params ["_trigger"];
private _triggerPos = getPos _trigger;
private _AGGRSCORE = parseNumber (markerText ((allMapMarkers select {markerColor _x == "Color6_FD_F"}) #0));

[_trigger, 100] execVM "Scripts\INTLitems.sqf";