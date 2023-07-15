

StaticPartPairs = [] ; 
BPCLSS1 = nil; 
BPCLSS2 = nil; 


_NearStatics = nearestObjects [player, ["StaticWeapon"], 40] select {(alive _x) && (count (getArray (configfile >> "CfgVehicles" >> typeOf _x >> "assembleInfo" >> "dissasembleTo")) > 1)} ; 
if (count _NearStatics == 0) exitWith {hint "NO WEAPONS AVAILABLE";} ;

_NearstStatic = _NearStatics select 0 ;





 _cfgArray = "true" configClasses (configfile >> "CfgVehicles"); 
 { 
  _assembleInfo = getArray (configfile >> "CfgVehicles" >> configName _x >> "assembleInfo" >> "dissasembleTo"); 
  if (count _assembleInfo > 1) then { 
   StaticPartPairs append [[configName _x,_assembleInfo]]; 
  }; 
 } foreach _cfgArray;
 
	 {
			 if ((typeOf _NearstStatic) == _x select 0 ) then {
				 BPCLSS1 = _x select 1 select 0 ; 
				 BPCLSS2 = _x select 1 select 1 ; 
			};
	 } foreach StaticPartPairs;

_noBPUNTs = (units player) select {backpack _x == ""} ;
if (count _noBPUNTs < 2) exitWith {hint "NO FREE UNITS AVAILABLE";} ;

			playSound3D [getMissionPath (selectRandom ["Sounds\DisassembleThatWeapon.ogg"]), player];

_UNT1 = _noBPUNTs select 0 ;
_UNT2 = _noBPUNTs select 1 ;

			[_UNT1, "ainvpknlmstpslaywrfldnon_medic"] remoteExec ["playMove", _UNT1];	
			[_UNT2, "ainvpknlmstpslaywrfldnon_medic"] remoteExec ["playMove", _UNT2];
sleep 7 ; 
deleteVehicle _NearstStatic ; 
_UNT1 addBackpackGlobal BPCLSS1 ; 
_UNT2 addBackpackGlobal BPCLSS2 ; 



