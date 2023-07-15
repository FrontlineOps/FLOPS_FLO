
sleep 5 ;

_mrkrs = allMapMarkers select {markerColor _x == "Color4_FD_F"};
_mrkr = _mrkrs select 0;
_REPSCORE = parseNumber (markerText _mrkr) ;  

INDGRPER= _this select 0;


///////////////////////////////////////////////////////////////////////////////////
{ {			_x removeAllEventHandlers "Killed";
			removeAllActions _x;
} foreach units INDGRPER; 
} remoteExec ["call", 0];			


///////////////////////////////////////////////////////////////////////////////////


if (_REPSCORE > 10) then {
west setFriend [resistance, 1];
resistance setFriend [west, 1];
East setFriend [resistance, 0];
resistance setFriend [East, 0];

{ {			_x removeAllEventHandlers "Killed";
			removeAllActions _x;
} foreach units INDGRPER; 
} remoteExec ["call", 0];			


{
[_x,[
				"<img size=2 color='#7CC2FF' image='Screens\FOBA\talk_ca.paa'/><t font='PuristaBold' color='#7CC2FF'>Investigate",
				{
					[(_this select 0)] execVM "Scripts\INVEST.sqf";
					[(_this select 0), ( selectRandom ["Acts_CivilIdle_2", "Acts_CivilIdle_1"])] remoteExec ["playMove", (_this select 0)];					
					(_this select 0) setDir (position (_this select 0) getDir position player);
					(_this select 0) removeAction (_this select 2) ;			
				},
				nil,
				1.5,
				true,
				true,
				"",
				"alive _target", // _target, _this, _originalTarget
				6,
				false,
				"",
				""
]] remoteExec ["addAction",0,true];

[_x,[
				"<img size=2 color='#7CC2FF' image='Screens\FOBA\help_ca.paa'/><t font='PuristaBold' color='#7CC2FF'>Request Support",
				{
					[(_this select 0)] execVM "Scripts\GUERASS.sqf";
					[(_this select 0), ( selectRandom ["Acts_CivilIdle_2", "Acts_CivilIdle_1"])] remoteExec ["playMove", (_this select 0)];					
					(_this select 0) setDir (position (_this select 0) getDir position player);
	
				},
				nil,
				1.5,
				true,
				true,
				"",
				"alive _target", // _target, _this, _originalTarget
				6,
				false,
				"",
				""
]] remoteExec ["addAction",0,true];

} foreach units INDGRPER; 

};

if (_REPSCORE < 7) then {
west setFriend [resistance, 0];
resistance setFriend [west, 0];
East setFriend [resistance, 1];
resistance setFriend [East, 1];

{ {			_x removeAllEventHandlers "Killed";
			removeAllActions _x;
} foreach units INDGRPER; 
} remoteExec ["call", 0];			

 { 
_x removeAllEventHandlers "FiredNear";
_x addEventHandler ["FiredNear",{
_CivAnim = selectRandom [ 
 "ApanPknlMstpSnonWnonDnon_G01",
 "ApanPpneMstpSnonWnonDnon_G01" ]; 
(_this select 0) playMove _CivAnim;
(_this select 0) setSpeedMode "FULL";
_allBuildings = nearestObjects [(_this select 0), ["HOUSE"], 300];  
_allPositions = [];  
_allBuildings apply {_allPositions append (_x buildingPos -1)};  
_rndPosX = selectRandom _allPositions;  
for "_i" from count waypoints (group (_this select 0)) - 1 to 0 step -1 do
{deleteWaypoint [(group (_this select 0)), _i];};
_WP = (group (_this select 0)) addWaypoint [_rndPosX, 0];
_WP SetWaypointType "MOVE";
(_this select 0) removeAllEventHandlers "FiredNear";}];

} foreach units INDGRPER; 

};
///////////////////////////////////////////////////////////////////////////////////


	{ removeFromRemainsCollector [_x]; } foreach (allUnits select { side _x != west }) ;
	{ removeFromRemainsCollector [_x]; } foreach (vehicles select { side (driver  _x) != west }) ; 


sleep 3 ; 

	{ addToRemainsCollector [_x]; } foreach (allUnits select { side _x != west }) ;
	{ addToRemainsCollector [_x]; } foreach (vehicles select { side (driver  _x) != west }) ; 