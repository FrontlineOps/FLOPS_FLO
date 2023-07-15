

_Cost = 250;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  
if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;

titleText ["Select HALO Target Location . . .", "BLACK IN",9999];


openMap [true, true]; 
sleep 2;
titleText ["", "BLACK IN",1];
hint "Select HALO Target Location"; 
onMapSingleClick {
onMapSingleClick {}; 

titleText ["Green Light  . . .", "BLACK IN",9999];
playSound3D ["A3\Sounds_F\ambient\battlefield\battlefield_jet3.wss", player];
playMusic "LeadTrack02_F_Mark" ;

openMap [true, false]; 
openMap [false, false]; 



{_x setPos _pos ; } forEach units group player;

{[_x, 5000]  spawn BIS_fnc_halo} forEach units group player;

titleText ["Green Light  . . .", "BLACK IN",4];

hint "Open Parachute : Double Press V Button "; 

};

{_x allowDammage false ; } forEach units group player ;

sleep 100 ;

{_x setPos _pos ; } forEach units group player;
sleep 50 ;


{_x allowDammage true ; } forEach units group player ;

}else{hint "Not enough Resources"; };