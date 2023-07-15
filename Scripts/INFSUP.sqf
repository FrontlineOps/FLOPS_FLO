

 _ins = lineIntersectsSurfaces [ 
  AGLToASL positionCameraToWorld [0,0,0], 
  AGLToASL positionCameraToWorld [0,0,1000], 
  player 
 ]; 
 if (count _ins == 0) exitWith { hint "NO TARGET" }; 
			playSound3D [getMissionPath (selectRandom ["Sounds\SuppressiveFire.ogg"]), player];

(units player) doSuppressiveFire (_ins select 0 select 0) ;