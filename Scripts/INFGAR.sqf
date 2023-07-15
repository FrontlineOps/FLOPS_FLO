


 _ins = lineIntersectsSurfaces [ 
  AGLToASL positionCameraToWorld [0,0,0], 
  AGLToASL positionCameraToWorld [0,0,1000], 
  player 
 ]; 
 if (count _ins == 0) exitWith { hint "NO BUILDING" }; 
 if (isNull cursorObject) exitWith { hint "NO BUILDING" }; 

_BLD = cursorObject;
(group player) setSpeedMode "LIMITED";

			playSound3D [getMissionPath (selectRandom ["Sounds\CombatOpenFire_4.ogg"]), player];
					sleep 0.4 ;
			playSound3D [getMissionPath (selectRandom ["Sounds\CombatOpenFire_4.ogg"]), player];
								sleep 0.4 ;
			playSound3D [getMissionPath (selectRandom ["Sounds\CombatOpenFire_4.ogg"]), player];



			{
				_Pos = selectRandom (_BLD buildingPos -1);
				_x doMove _Pos ; 
				} forEach units player ; 
		
		sleep 20 ;
(group player) setSpeedMode "NORMAL";		
		




