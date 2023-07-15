_mrkrs = allMapMarkers select {markerColor _x == "Color4_FD_F"};
_mrkr = _mrkrs select 0;
_REPSCORE = parseNumber (markerText _mrkr) ;  
_Civl = _this select 0 ;

sleep 3 ;

	
				if (_REPSCORE > 10) then {
					
				NewGuerGroup = createGroup West; 

											_complMessage = selectRandom ["Sure, Let us Fight with you Captain !!","We appericiate your Efforts for our Homeland,We will Help you!","Hey Men, Gear Up, Lets get to work !!!"];
											["Militia", _complMessage] remoteExec ["BIS_fnc_showSubtitle"];

					{ {
							_x enableAI 'ANIM';
							_x enableAI 'PATH';
							_x switchMove '';
							[_x, ''] remoteExec ['playMove', _x];		
							_x setBehaviour 'AWARE';
							[_x] join NewGuerGroup; 
							_x removeAllEventHandlers "Killed";
							removeAllActions _x;
					} foreach (allUnits select {side _x == independent && captive _x == false && (getPos _x) distance (position player) < 200}); 
					} remoteExec ["call", 0];	


				} else {


												
											_complMessage = selectRandom ["We Dont talk to Strangers!","I don't know much about this Region!","Sorry but I dont Trust you Outsiders!","Maybe that Man there can Help you, He has been with the Army years ago !"];
											["Militia", _complMessage] remoteExec ["BIS_fnc_showSubtitle"];


				};

sleep 3 ;


			private _headlessClients = entities "HeadlessClient_F";
			private _humanPlayers = allPlayers - _headlessClients;
			hcRemoveAllGroups player;  
			 {player hcRemoveGroup _x ;} forEach (allGroups select {side _x == west}); 
			 _GRPs = (allGroups select {(side _x == (side player)) && !(((units _x) select 0) in switchableUnits)}); 
			if (count _humanPlayers == 1 ) then {
			{player hcSetGroup [_x];} forEach _GRPs;
			}else{
			{TheCommander hcSetGroup [_x];} forEach _GRPs;
			};