sleep 2;
_chance23 = selectRandom [0, 1, 2, 3, 4, 5] ;
if (_chance23 > 1) then {		
			
	if (count (nearestObjects [ player, ["Land_Garbage_square3_F","Land_Garbage_square3_F","Land_Garbage_line_F","Land_Garbage_line_F", "Land_Garbage_line_F"], 1000]) > 0) then {
		_chance = selectRandom [0, 1, 2, 3, 4] ;
			if (_Chance > 2) then {		

							_IED = selectRandom nearestObjects [ player, ["Land_Garbage_square3_F","Land_Garbage_square3_F","Land_Garbage_line_F","Land_Garbage_line_F", "Land_Garbage_line_F"], 1000];
							_pos = _IED getPos [(5 + (random 5)),(0 + (random 350))] ; 
							_mrkr = createMarker [str _pos, _pos]; 
							_mrkr setMarkerType "hd_unknown";
							_mrkr setMarkerColor "colorCivilian";
							_mrkr setMarkerSize [0.8, 0.8];
							_mrkr setMarkerAlpha 0.6;
							
								sleep 1;
								[parseText "<t color='#FACE00' font='PuristaBold' align = 'right' shadow = '1' size='2'>+ NEW INTEL</t><br /><t  align = 'right' shadow = '1' size='1'>Civilian Intel Received </t>", [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];
									_attackingAtGrid = mapGridPosition getMarkerPos _mrkr;
								[[west,"HQ"], "Enemy Presence Confirmed at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];
			}else{

							_INTL = allMapMarkers select { (markerAlpha _x == 0.001 or markerAlpha _x == 0) && markerColor _x == "colorOPFOR" && markerType _x == "o_unknown" && markerType _x != "o_inf" && markerType _x != "o_Ordnance" && markerType _x != "o_maint" && markerShape _x != "RECTANGLE" && markerShape _x != "ELLIPSE"};
							_x = selectRandom _INTL;

							_pos = (getMarkerpos _x) getPos [(5 + (random 15)),(0 + (random 350))] ; 
							_mrkr = createMarker [str _pos, _pos]; 
							_mrkr setMarkerType "hd_unknown";
							_mrkr setMarkerColor "colorCivilian";
							_mrkr setMarkerSize [0.8, 0.8];
							_mrkr setMarkerAlpha 0.6;

								sleep 1;
								[parseText "<t color='#FACE00' font='PuristaBold' align = 'right' shadow = '1' size='2'>+ NEW INTEL</t><br /><t  align = 'right' shadow = '1' size='1'>Civilian Intel Received </t>", [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];
									_attackingAtGrid = mapGridPosition getMarkerPos _mrkr;
								[[west,"HQ"], "Enemy Presence Confirmed at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];
			};

	}else{

					_INTL = allMapMarkers select { (markerAlpha _x == 0.001 or markerAlpha _x == 0) && markerColor _x == "colorOPFOR" && markerType _x == "o_unknown" && markerType _x != "o_inf" && markerType _x != "o_Ordnance" && markerType _x != "o_maint" && markerShape _x != "RECTANGLE" && markerShape _x != "ELLIPSE"};
					_x = selectRandom _INTL;

					_pos = (getMarkerpos _x) getPos [(5 + (random 15)),(0 + (random 350))] ; 
					_mrkr = createMarker [str _pos, _pos]; 
					_mrkr setMarkerType "hd_unknown";
					_mrkr setMarkerColor "colorCivilian";
					_mrkr setMarkerSize [0.8, 0.8];
					_mrkr setMarkerAlpha 0.6;

								sleep 1;
								[parseText "<t color='#FACE00' font='PuristaBold' align = 'right' shadow = '1' size='2'>+ NEW INTEL</t><br /><t  align = 'right' shadow = '1' size='1'>Civilian Intel Received </t>", [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];
									_attackingAtGrid = mapGridPosition getMarkerPos _mrkr;
								[[west,"HQ"], "Enemy Presence Confirmed at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];
	};
	
	
}else{
	
		execVM "Scripts\INTL.sqf";
};