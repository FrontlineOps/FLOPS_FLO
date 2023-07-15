
sleep 5 ;

_mrkrs = allMapMarkers select {markerColor _x == "Color4_FD_F"};
_mrkr = _mrkrs select 0;
_REPSCORE = parseNumber (markerText _mrkr) ;  

///////////////////////////////////////////////////////////////////////////////////
{ {			_x removeAllEventHandlers "Killed";
			removeAllActions _x;
} foreach (allUnits select {captive _x == false && (typeOf _x) in CivMenArray}); 
} remoteExec ["call", 0];			

{ 

			_x addEventHandler ["Killed", {
			if (side (_this select 1) == west) then {
			[playerSide, "HQ"] commandChat "WATCH for CIVILIAN CASUALITY Corporal !"; 

			removeAllActions (_this select 0);
			{(_this select 0) playMove "";  } remoteExec ["call", 0];

			[] execVM "Scripts\ReputationMinus.sqf";
			[] execVM "Scripts\Civ_Relations.sqf";

			};
			}]; 


[_x,[
				"<img size=2 color='#7CC2FF' image='Screens\FOBA\talk_ca.paa'/><t font='PuristaBold' color='#7CC2FF'>Investigate",
				{
					[(_this select 0)] execVM "Scripts\INVEST.sqf";
							(_this select 0) disableAI "PATH";
							(_this select 0) disableAI "MOVE";					
					(_this select 0) setDir (position (_this select 0) getDir position player);
					(_this select 0) removeAction (_this select 2) ;		
					[(_this select 0), ( selectRandom ["Acts_CivilIdle_2", "Acts_CivilIdle_1"])] remoteExec ["playMove", (_this select 0)];					
				},
				nil,
				1.5,
				true,
				true,
				"",
				"alive _target", // _target, _this, _originalTarget
				4,
				false,
				"",
				""
]] remoteExec ["addAction",0,true];

[_x,[
				"<img size=2 color='#7CC2FF' image='Screens\FOBA\defend_ca.paa'/><t font='PuristaBold' color='#7CC2FF'>Offer Help",
				{
					[(_this select 0)] execVM "Scripts\HELP.sqf";
							(_this select 0) disableAI "PATH";
							(_this select 0) disableAI "MOVE";							
					(_this select 0) setDir (position (_this select 0) getDir position player);
					(_this select 0) removeAction (_this select 2) ;	
					[(_this select 0), ( selectRandom ["Acts_CivilIdle_2", "Acts_CivilIdle_1"])] remoteExec ["playMove", (_this select 0)];					
					
				},
				nil,
				1.5,
				true,
				true,
				"",
				"alive _target", // _target, _this, _originalTarget
				4,
				false,
				"",
				""
]] remoteExec ["addAction",0,true];

[_x,[
				"<img size=2 color='#7CC2FF' image='Screens\FOBA\holdAction_secure_ca.paa'/><t font='PuristaBold' color='#7CC2FF'>Detain",
				{
			playSound3D [getMissionPath (selectRandom ["Sounds\GoProne_1.ogg", "Sounds\Halt.ogg", "Sounds\Stop.ogg", "Sounds\VehStop_2.ogg"]), player];
					(_this select 0) removeAction (_this select 2) ;			
					(_this select 0) removeAllEventHandlers "FiredNear";
					_chance = selectRandom [0, 1, 2, 3] ;	
					if ((_this select 0) getUnitTrait "engineer" != true) then {		
					[(_this select 0), ""] remoteExec ["playMove", (_this select 0)];							
					[(_this select 0), "ApanPercMstpSnonWnonDnon_ApanPpneMstpSnonWnonDnon"] remoteExec ["playMove", (_this select 0)];		
							(_this select 0) setUnitPos "DOWN";					
							(_this select 0) disableAI "PATH";
							(_this select 0) disableAI "MOVE";
							(_this select 0) setCaptive true;
							(_this select 0) setDir ((position (_this select 0) getDir position player) + 180);	
															[(_this select 0),
										"<img size=3 color='#FFE258' image='Screens\FOBA\holdAction_secure_ca.paa'/><t font='PuristaBold' color='#FFE258'>ARREST",
										'Screens\FOBA\holdAction_secure_ca.paa',
										'Screens\FOBA\holdAction_secure_ca.paa',
										'_this distance _target < 4',       
										'_caller distance _target < 4',  
										{player playMove "AinvPknlMstpSnonWnonDnon_medic_1" ; },
										{},
										{
										(_this select 0) disableAI 'MOVE';
										(_this select 0) setCaptive true;
										(_this select 0) disableAI 'PATH';
										removeAllWeapons (_this select 0);
										removeBackpack (_this select 0);
										(_this select 0) switchMove 'AmovPercMstpSsurWnonDnon';
										removeAllActions (_this select 0);
												[(_this select 0),[
																"<img size=2 color='#7CC2FF' image='Screens\FOBA\holdAction_secure_ca.paa'/><t font='PuristaBold' color='#7CC2FF'>Move",
																{(_this select 0) attachTo [player, [0, 0.7, 0]];	},
																nil,
																0,
																true,
																true,
																"",
																"true", // _target, _this, _originalTarget
																3,
																false,
																"",
																""
															]] remoteExec ["addAction",0,true];
												[(_this select 0),[
																"<img size=2 color='#7CC2FF' image='Screens\FOBA\holdAction_secure_ca.paa'/><t font='PuristaBold' color='#7CC2FF'>Stop",
																{detach (_this select 0) ;},
																nil,
																0,
																true,
																true,
																"",
																"true", // _target, _this, _originalTarget
																3,
																false,
																"",
																""
															]] remoteExec ["addAction",0,true];							
												[(_this select 0),[
																"<img size=2 color='#7CC2FF' image='Screens\FOBA\holdAction_secure_ca.paa'/><t font='PuristaBold' color='#7CC2FF'>Mount",
																{
																	detach (_this select 0) ;
																	_vh = nearestObjects [(_this select 0), ['Air', 'Ship', 'LandVehicle'],15] select 0 ;
																	(_this select 0) moveInCargo _vh ;
																										[_vh,[
																										"<img size=2 color='#7CC2FF' image='Screens\FOBA\holdAction_secure_ca.paa'/><t font='PuristaBold' color='#7CC2FF'>UnMount",
																										{
																											_pow = (crew (_this select 0) select {side _x == civilian && captive _x == true && alive _x} ) select 0 ;
																										 detach _pow ;
																										 [_pow] ordergetin false; 
																										  [_pow] allowGetIn false; 
																										  unassignvehicle _pow;  
																										 doGetOut _pow; 
																										 _pow switchMove 'AmovPercMstpSsurWnonDnon';
																										(_this select 0) removeAction (_this select 2) ;																							 
																											},
																										nil,
																										0,
																										true,
																										true,
																										"",
																										"true", // _target, _this, _originalTarget
																										5,
																										false,
																										"",
																										""
																									]] remoteExec ["addAction",0,true];		
																	},
																nil,
																0,
																true,
																true,
																"",
																"count (nearestObjects [_target, ['Air', 'Ship', 'LandVehicle'],15] ) > 0", // _target, _this, _originalTarget
																5,
																false,
																"",
																""
															]] remoteExec ["addAction",0,true];				
														
										},
										{},
										[],
										7,
										0,
										true,
										false
										] remoteExec ['BIS_fnc_holdActionAdd', 0, (_this select 0)]; 
					};		
					if (((_this select 0) getUnitTrait "engineer" == true) && (_chance < 2)) then {	
										[(_this select 0), ""] remoteExec ["playMove", (_this select 0)];				
					[(_this select 0), "ApanPercMstpSnonWnonDnon_ApanPpneMstpSnonWnonDnon"] remoteExec ["playMove", (_this select 0)];					
							(_this select 0) disableAI "PATH";
							(_this select 0) disableAI "MOVE";				
							(_this select 0) setCaptive true;
							(_this select 0) setDir ((position (_this select 0) getDir position player) + 180);	
									[(_this select 0),
										"<img size=2 color='#FFE258' image='Screens\FOBA\holdAction_secure_ca.paa'/><t font='PuristaBold' color='#FFE258'>ARREST",
										'Screens\FOBA\holdAction_secure_ca.paa',
										'Screens\FOBA\holdAction_secure_ca.paa',
										'_this distance _target < 4',       
										'_caller distance _target < 4',  
										{player playMove "AinvPknlMstpSnonWnonDnon_medic_1" ; },
										{},
										{
										(_this select 0) disableAI 'MOVE';
										(_this select 0) setCaptive true;
										(_this select 0) disableAI 'PATH';
										removeAllWeapons (_this select 0);
										removeBackpack (_this select 0);
										(_this select 0) switchMove 'AmovPercMstpSsurWnonDnon';
										removeAllActions (_this select 0);
												[(_this select 0),[
																"<img size=2 color='#7CC2FF' image='Screens\FOBA\holdAction_secure_ca.paa'/><t font='PuristaBold' color='#7CC2FF'>Move",
																{(_this select 0) attachTo [player, [0, 0.7, 0]];	(_this select 0) switchMove 'AmovPercMstpSsurWnonDnon';},
																nil,
																0,
																true,
																true,
																"",
																"true", // _target, _this, _originalTarget
																3,
																false,
																"",
																""
															]] remoteExec ["addAction",0,true];
												[(_this select 0),[
																"<img size=2 color='#7CC2FF' image='Screens\FOBA\holdAction_secure_ca.paa'/><t font='PuristaBold' color='#7CC2FF'>Stop",
																{detach (_this select 0) ;
																(_this select 0) switchMove 'AmovPercMstpSsurWnonDnon';	},
																nil,
																0,
																true,
																true,
																"",
																"true", // _target, _this, _originalTarget
																3,
																false,
																"",
																""
															]] remoteExec ["addAction",0,true];							
												[(_this select 0),[
																"<img size=2 color='#7CC2FF' image='Screens\FOBA\holdAction_secure_ca.paa'/><t font='PuristaBold' color='#7CC2FF'>Mount",
																{detach (_this select 0) ;
																	_vh = nearestObjects [(_this select 0), ['Air', 'Ship', 'LandVehicle'],15] select 0 ;
																	(_this select 0) moveInCargo _vh ;
																										[_vh,[
																										"<img size=2 color='#7CC2FF' image='Screens\FOBA\holdAction_secure_ca.paa'/><t font='PuristaBold' color='#7CC2FF'>UnMount",
																										{
																											_pow = (crew (_this select 0) select {side _x == civilian && captive _x == true && alive _x} ) select 0 ;
																											detach _pow ;
																										  [_pow] ordergetin false; 
																										  [_pow] allowGetIn false; 
																										  unassignvehicle _pow;  
																										 doGetOut _pow; 
																										 _pow switchMove 'AmovPercMstpSsurWnonDnon';
																										(_this select 0) removeAction (_this select 2) ;	
																										_pow switchMove 'AmovPercMstpSsurWnonDnon';																							
																											},
																										nil,
																										0,
																										true,
																										true,
																										"",
																										"true", // _target, _this, _originalTarget
																										5,
																										false,
																										"",
																										""
																									]] remoteExec ["addAction",0,true];		
																	},
																nil,
																0,
																true,
																true,
																"",
																"count (nearestObjects [_target, ['Air', 'Ship', 'LandVehicle'],15] ) > 0", // _target, _this, _originalTarget
																5,
																false,
																"",
																""
															]] remoteExec ["addAction",0,true];				
														
										},
										{},
										[],
										7,
										0,
										true,
										false
										] remoteExec ['BIS_fnc_holdActionAdd', 0, (_this select 0)]; 
					};
					if (((_this select 0) getUnitTrait "engineer" == true) && (_chance > 1)) then {	
												[(_this select 0), ""] remoteExec ["playMove", (_this select 0)];		
							_WPN =  selectRandom ["hgun_PDW2000_Holo_snds_F", "hgun_Rook40_snds_F", "hgun_P07_blk_F", "hgun_P07_khk_F", "hgun_Rook40_F", "hgun_Pistol_heavy_01_snds_F", "hgun_P07_snds_F", "hgun_ACPC2_F"] ;
							[(_this select 0), _WPN, 4] call BIS_fnc_addWeapon;
							(_this select 0) enableAI "PATH";
							(_this select 0) enableAI "MOVE";
							(_this select 0) enableAI "all";
										
							_Group = createGroup east; 
							[(_this select 0)] join _Group;
							(_this select 0) doTarget player;
							(_this select 0) removeAllEventHandlers "Killed";
					};
				},
				nil,
				0,
				true,
				true,
				"",
				"true", // _target, _this, _originalTarget
				5,
				false,
				"",
				""
]] remoteExec ["addAction",0,true];

} foreach (allUnits select {captive _x == false && (typeOf _x) in CivMenArray}); 
	

///////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////


if (_REPSCORE > 10) then {
west setFriend [resistance, 1];
resistance setFriend [west, 1];
East setFriend [resistance, 0];
resistance setFriend [East, 0];

{ {			_x removeAllEventHandlers "Killed";
			removeAllActions _x;
} foreach (allUnits select {side _x == independent  && (typeOf _x) in GuerMenArray}); 
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

} foreach (allUnits select {side _x == independent  && (typeOf _x) in GuerMenArray}); 

};

if (_REPSCORE < 7) then {
west setFriend [resistance, 0];
resistance setFriend [west, 0];
East setFriend [resistance, 1];
resistance setFriend [East, 1];

{ {			_x removeAllEventHandlers "Killed";
			removeAllActions _x;
} foreach (allUnits select {side _x == independent  && (typeOf _x) in GuerMenArray}); 
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

} foreach (allUnits select {captive _x == false && (typeOf _x) in CivMenArray}); 

};
///////////////////////////////////////////////////////////////////////////////////


	{ removeFromRemainsCollector [_x]; } foreach (allUnits select { side _x != west }) ;
	{ removeFromRemainsCollector [_x]; } foreach (vehicles select { side (driver  _x) != west }) ; 


sleep 3 ; 

	{ addToRemainsCollector [_x]; } foreach (allUnits select { side _x != west }) ;
	{ addToRemainsCollector [_x]; } foreach (vehicles select { side (driver  _x) != west }) ; 