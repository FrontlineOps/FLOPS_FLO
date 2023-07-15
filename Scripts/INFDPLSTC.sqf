
StaticPartPairs = []; 
SqdWpnBPs = [] ;
UntWBP = nil; 
UntPBP = nil; 
StaticWP = nil;

 _ins = lineIntersectsSurfaces [ 
  AGLToASL positionCameraToWorld [0,0,0], 
  AGLToASL positionCameraToWorld [0,0,1000], 
  player 
 ]; 
 if (count _ins == 0) exitWith { hint "INVALID POSITION" }; 
 if ((_ins select 0 select 0) distance (position player) > 30 ) exitWith { hint "TOO FAR POSITION" }; 

 _cfgArray = "true" configClasses (configfile >> "CfgVehicles"); 
 { 
  _assembleInfo = getArray (configfile >> "CfgVehicles" >> configName _x >> "assembleInfo" >> "dissasembleTo"); 
  if (count _assembleInfo > 1) then { 
   StaticPartPairs append [[configName _x,_assembleInfo]]; 
  }; 
 } foreach _cfgArray;
 



		_GrpUntCnt = (count (units player)) -1 ;
		for "_i" from 0 to _GrpUntCnt do {
				_BPclass = toLower (backpack ((units player) select _i)) ;					
					SqdWpnBPs append [_BPclass] ;
					{
						if (_BPclass == toLower ((_x select 1) select 1) ) then {
						_pairclass = toLower ((_x select 1) select 0) ;
						if (_pairclass in SqdWpnBPs) then {
							UntWBP = (units player select {backpack _x == _BPclass}) select 0 ; 
							UntPBP = (units player select {backpack _x == _pairclass}) select 0 ; 
							StaticWP = _x select 0;
						if (StaticWP == "US85_M252_Stat") then {StaticWP = "B_Mortar_01_F";};					
						} else {};
						} else {};
						
						if (_BPclass == toLower ((_x select 1) select 0) ) then {
						_pairclass = toLower ((_x select 1) select 1) ;
						if (_pairclass in SqdWpnBPs) then {
							UntWBP = (units player select {backpack _x == _BPclass}) select 0 ; 
							UntPBP = (units player select {backpack _x == _pairclass}) select 0 ; 
							StaticWP = _x select 0;
						if (StaticWP == "US85_M252_Stat") then {StaticWP = "B_Mortar_01_F";};
						} else {};
						} else {};
					} forEach StaticPartPairs ; 


			} ; 

			if (isNil "StaticWP") exitWith {hint "NO WEAPONS AVAILABLE";} ;

			playSound3D [getMissionPath (selectRandom ["Sounds\AssembleThatWeapon.ogg"]), player];

			[UntWBP, "ainvpknlmstpslaywrfldnon_medic"] remoteExec ["playMove", UntWBP];	
			[UntPBP, "ainvpknlmstpslaywrfldnon_medic"] remoteExec ["playMove", UntPBP];	
			sleep 7 ; 
			removeBackpackGlobal UntWBP;
			removeBackpackGlobal UntPBP;
			
			_SWP = createVehicle [StaticWP, [0,0,0], [], 0, "NONE"]; 
			_SWP setPosASL (_ins select 0 select 0) ; 
			_SWP setDir (getDirVisual player ); 
			
			sleep 1 ; 
			if ((StaticWP == "B_HMG_01_A_F") or (StaticWP == "B_GMG_01_A_F")) then { _Group = createVehicleCrew _SWP; } else { UntWBP moveInGunner _SWP; } ;		















