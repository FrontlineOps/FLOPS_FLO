
if (cooldn == 0 ) then {

_CAST = screenToWorld [0.5,0.5];
if ((getPosATL laserTarget player) select 0 != 0) then { _CAST = getPosATL laserTarget player; };

_Type = _this select 0 ;
_Rnds = _this select 1 ;
_Rads = _Rnds * 4 ;


if (_Type == "G_40mm_HEDP") then { 

_ART= nearestobjects [_CAST,[F_Art_01],40000];
	if ({alive _x} count _ART != 0 ) then {

			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGArty.ogg"]), player];

	cooldn = 1 ;

_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "ColorOrange" ;
_CASD setMarkerAlpha 1;
_CASD setMarkerText "Artillery Strike";

sleep 5 ;

playSound3D ["A3\dubbing_f\modules\supports\artillery_acknowledged.ogg", player];
sleep 10 ;
  [_CAST,"G_40mm_HEDP",70 , [1,50], 5 ,{} ,0 , 100, 100, [""]] spawn BIS_fnc_fireSupportCluster; 



sleep 120;

	cooldn = 0 ;


sleep 10;
deleteMarker _CASD;

} else {

_Cost = 125;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  

if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;
	cooldn = 1 ;

			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGArty.ogg"]), player];


_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "ColorOrange" ;
_CASD setMarkerAlpha 1;
_CASD setMarkerText "Artillery Strike";

sleep 5 ;

playSound3D ["A3\dubbing_f\modules\supports\artillery_acknowledged.ogg", player];
sleep 10 ;
  [_CAST,"G_40mm_HEDP",70 , [1,50], 5 ,{} ,0 , 100, 100, [""]] spawn BIS_fnc_fireSupportCluster; 


sleep 120;

	cooldn = 0 ;


sleep 10;
deleteMarker _CASD;

}else{hint "Not enough Resources"; }; }; 



} else {
	
	
if (_Type == "Flare_82mm_AMOS_White") then {
	
_ART= nearestobjects [_CAST,[F_Art_00],4000];
	if ({alive _x} count _ART != 0 ) then {

	cooldn = 1 ;
			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGArty.ogg"]), player];


_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "ColorOrange" ;
_CASD setMarkerAlpha 1;
_CASD setMarkerText "Artillery Strike";

sleep 5 ;

playSound3D ["A3\dubbing_f\modules\supports\artillery_acknowledged.ogg", player];
sleep 5 ;

_flare = "F_20mm_White" createVehicle [((_CAST select 0) + random 100) , ((_CAST select 1) + random 100) , 120]; 
_flare setVelocity [0,0,-0.1];
sleep 7 ;
_flare = "F_20mm_White" createVehicle [((_CAST select 0) + random 100) , ((_CAST select 1) + random 100) , 120]; 
_flare setVelocity [0,0,-0.1];
sleep 7 ;
_flare = "F_20mm_White" createVehicle [((_CAST select 0) + random 100) , ((_CAST select 1) + random 100) , 120]; 
_flare setVelocity [0,0,-0.1];
sleep 7 ;
_flare = "F_20mm_White" createVehicle [((_CAST select 0) + random 100) , ((_CAST select 1) + random 100) , 120]; 
_flare setVelocity [0,0,-0.1];
sleep 7 ;
_flare = "F_20mm_White" createVehicle [((_CAST select 0) + random 100) , ((_CAST select 1) + random 100) , 120]; 
_flare setVelocity [0,0,-0.1];
sleep 7 ;
_flare = "F_20mm_White" createVehicle [((_CAST select 0) + random 100) , ((_CAST select 1) + random 100) , 120]; 
_flare setVelocity [0,0,-0.1];

sleep 120;

	cooldn = 0 ;


sleep 10;
deleteMarker _CASD;

} else {

_Cost = 95;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  

if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;
	cooldn = 1 ;

			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGArty.ogg"]), player];


_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "ColorOrange" ;
_CASD setMarkerAlpha 1;
_CASD setMarkerText "Artillery Strike";

sleep 5 ;

playSound3D ["A3\dubbing_f\modules\supports\artillery_acknowledged.ogg", player];
sleep 5 ;

_flare = "F_20mm_White" createVehicle [((_CAST select 0) + random 100) , ((_CAST select 1) + random 100) , 120]; 
_flare setVelocity [0,0,-0.1];
sleep 7 ;
_flare = "F_20mm_White" createVehicle [((_CAST select 0) + random 100) , ((_CAST select 1) + random 100) , 120]; 
_flare setVelocity [0,0,-0.1];
sleep 7 ;
_flare = "F_20mm_White" createVehicle [((_CAST select 0) + random 100) , ((_CAST select 1) + random 100) , 120]; 
_flare setVelocity [0,0,-0.1];
sleep 7 ;
_flare = "F_20mm_White" createVehicle [((_CAST select 0) + random 100) , ((_CAST select 1) + random 100) , 120]; 
_flare setVelocity [0,0,-0.1];
sleep 7 ;
_flare = "F_20mm_White" createVehicle [((_CAST select 0) + random 100) , ((_CAST select 1) + random 100) , 120]; 
_flare setVelocity [0,0,-0.1];
sleep 7 ;
_flare = "F_20mm_White" createVehicle [((_CAST select 0) + random 100) , ((_CAST select 1) + random 100) , 120]; 
_flare setVelocity [0,0,-0.1];


sleep 120;

	cooldn = 0 ;


sleep 10;
deleteMarker _CASD;

}else{hint "Not enough Resources"; }; }; };


	
	
if ((_Type == "Sh_82mm_AMOS") or (_Type == "Smoke_82mm_AMOS_White")) then {
	
_ART= nearestobjects [_CAST,[F_Art_00],4000];
	if ({alive _x} count _ART != 0 ) then {
	cooldn = 1 ;

			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGArty.ogg"]), player];


_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "ColorOrange" ;
_CASD setMarkerAlpha 1;
_CASD setMarkerText "Artillery Strike";

sleep 5 ;

playSound3D ["A3\dubbing_f\modules\supports\artillery_acknowledged.ogg", player];
sleep 10 ;
[_CAST, _Type, _Rads, _Rnds, 8] spawn BIS_fnc_fireSupportVirtual;
sleep 120;

	cooldn = 0 ;


sleep 10;
deleteMarker _CASD;
} else {

_Cost = 95;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  

if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;
	cooldn = 1 ;


			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGArty.ogg"]), player];


_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "ColorOrange" ;
_CASD setMarkerAlpha 1;
_CASD setMarkerText "Artillery Strike";

sleep 5 ;

playSound3D ["A3\dubbing_f\modules\supports\artillery_acknowledged.ogg", player];
sleep 10 ;
[_CAST, _Type, _Rads, _Rnds, 8] spawn BIS_fnc_fireSupportVirtual;
sleep 120;

	cooldn = 0 ;


sleep 10;
deleteMarker _CASD;

}else{hint "Not enough Resources"; }; }; };





if ((_Type != "Sh_82mm_AMOS") && (_Type != "Smoke_82mm_AMOS_White") && (_Type != "Flare_82mm_AMOS_White") && (_Type != "R_230mm_HE")) then {
	
_ART= nearestobjects [_CAST,[F_Art_01],40000];
	if ({alive _x} count _ART != 0 ) then {
	cooldn = 1 ;

			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGArty.ogg"]), player];


_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "ColorOrange" ;
_CASD setMarkerAlpha 1;
_CASD setMarkerText "Artillery Strike";

sleep 5 ;

playSound3D ["A3\dubbing_f\modules\supports\artillery_acknowledged.ogg", player];
sleep 10 ;
[_CAST, _Type, _Rads, _Rnds, 5] spawn BIS_fnc_fireSupportVirtual;
sleep 60;

	cooldn = 0 ;


sleep 10;

if ((_Type != "Mine_155mm_AMOS_range") && (_Type != "AT_Mine_155mm_AMOS_range")) then {
	deleteMarker _CASD;
} else {
	if (_Type == "Mine_155mm_AMOS_range") then {
	
	_CASD setMarkerType "mil_triangle";
	_CASD setMarkerText "AP MineField";
	
_markerName = "APMNF_W" + (str (getMarkerpos _CASD));    
_mrkr = createMarkerLocal [_markerName,getMarkerPos _CASD];   
_mrkr setMarkerTypeLocal "Unknown";  
_mrkr setMarkerColorLocal "colorBLUFOR";  
_mrkr setMarkerBrushLocal "FDiagonal";  
_mrkr setMarkerShapeLocal "ELLIPSE";   
_mrkr setMarkerSizeLocal [200, 200];  
_mrkr setMarkerAlpha 0.9 ;  		
		

	_Mines = [ "APERSMine", "APERSBoundingMine" ]; 
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];

	} else {
	_CASD setMarkerType "mil_triangle";
	_CASD setMarkerText "AT MineField";
	
_markerName = "ATMNF_W" + (str (getMarkerpos _CASD));    
_mrkr = createMarkerLocal [_markerName,getMarkerPos _CASD];   
_mrkr setMarkerTypeLocal "Unknown";  
_mrkr setMarkerColorLocal "colorBLUFOR";  
_mrkr setMarkerBrushLocal "FDiagonal";  
_mrkr setMarkerShapeLocal "ELLIPSE";   
_mrkr setMarkerSizeLocal [200, 200];  
_mrkr setMarkerAlpha 0.9 ; 	
		
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];


	
	};
};
	
} else {

_Cost = 125;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  

if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;
	cooldn = 1 ;


			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGArty.ogg"]), player];


_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "ColorOrange" ;
_CASD setMarkerAlpha 1;
_CASD setMarkerText "Artillery Strike";

sleep 5 ;

playSound3D ["A3\dubbing_f\modules\supports\artillery_acknowledged.ogg", player];
sleep 10 ;
[_CAST, _Type, _Rads, _Rnds, 5] spawn BIS_fnc_fireSupportVirtual;
sleep 60;

	cooldn = 0 ;


sleep 10;
if ((_Type != "Mine_155mm_AMOS_range") && (_Type != "AT_Mine_155mm_AMOS_range")) then {
	deleteMarker _CASD;
} else {
	if (_Type == "Mine_155mm_AMOS_range") then {
	
	_CASD setMarkerType "mil_triangle";
	_CASD setMarkerText "AP MineField";
	
_markerName = "APMNF_W" + (str (getMarkerpos _CASD));    
_mrkr = createMarkerLocal [_markerName,getMarkerPos _CASD];   
_mrkr setMarkerTypeLocal "Unknown";  
_mrkr setMarkerColorLocal "colorBLUFOR";  
_mrkr setMarkerBrushLocal "FDiagonal";  
_mrkr setMarkerShapeLocal "ELLIPSE";   
_mrkr setMarkerSizeLocal [200, 200];  
_mrkr setMarkerAlpha 0.9 ;  		
		

	_Mines = [ "APERSMine", "APERSBoundingMine" ]; 
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _CASD, [],200];

	} else {
	_CASD setMarkerType "mil_triangle";
	_CASD setMarkerText "AT MineField";
	
_markerName = "ATMNF_W" + (str (getMarkerpos _CASD));    
_mrkr = createMarkerLocal [_markerName,getMarkerPos _CASD];   
_mrkr setMarkerTypeLocal "Unknown";  
_mrkr setMarkerColorLocal "colorBLUFOR";  
_mrkr setMarkerBrushLocal "FDiagonal";  
_mrkr setMarkerShapeLocal "ELLIPSE";   
_mrkr setMarkerSizeLocal [200, 200];  
_mrkr setMarkerAlpha 0.9 ; 	
		
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _CASD, [], 200];


	
	
	};
};

}else{hint "Not enough Resources"; }; }; };





if (_Type == "R_230mm_HE") then {
	
_ART= nearestobjects [_CAST,[F_Art_02],40000];
	if ({alive _x} count _ART != 0 ) then {
	cooldn = 1 ;


			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGArty.ogg"]), player];


_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "ColorOrange" ;
_CASD setMarkerAlpha 1;
_CASD setMarkerText "Artillery Strike";

sleep 5 ;

playSound3D ["A3\dubbing_f\modules\supports\artillery_acknowledged.ogg", player];
sleep 10 ;
[ [((_CAST select 0) + random 0) , ((_CAST select 1) - 1020) , 0], _Type, _Rads * 2 , _Rnds, 1] spawn BIS_fnc_fireSupportVirtual;
sleep 120;

	cooldn = 0 ;


sleep 10;
deleteMarker _CASD;

} else {

_Cost = 225;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  

if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;
	cooldn = 1 ;


			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGArty.ogg"]), player];


_CASD = createMarker [str _CAST, _CAST];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "ColorOrange" ;
_CASD setMarkerAlpha 1;
_CASD setMarkerText "Artillery Strike";

sleep 5 ;

playSound3D ["A3\dubbing_f\modules\supports\artillery_acknowledged.ogg", player];
sleep 10 ;
[ [((_CAST select 0) + random 0) , ((_CAST select 1) - 1020) , 0], _Type, _Rads * 2, _Rnds, 1] spawn BIS_fnc_fireSupportVirtual;
sleep 120;

	cooldn = 0 ;


sleep 10;
deleteMarker _CASD;

}else{hint "Not enough Resources"; }; }; };



};

}else{hint "Combat Crew Preparing, Please Wait . . . ";};