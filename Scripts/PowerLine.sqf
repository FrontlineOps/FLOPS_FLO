

_PL = selectRandom nearestObjects [ player, ["Land_spp_Transformer_F", "Land_dp_transformer_F","Land_TBox_F"], 1000];  
_PL allowDamage true ; 
_PL addEventHandler ["Killed", { 
["ScoreAdded", ["Power Generator Sabotaged", 10]] call BIS_fnc_showNotification; 
_faction = "rhs_faction_usarmy_d"; 
_value = 10; 
_currentForcepool = [ALIVE_globalForcePool, _faction] call ALIVE_fnc_hashGet; 
_newForcepool = _currentForcepool + _value;
[ALIVE_globalForcePool, _faction,_newForcepool] call ALIVE_fnc_hashSet;     
[playerSide, "HQ"] commandChat "Nice Job Captain. Crossroad out";
execVM "Scripts\Sabotage.sqf";  
playMusic "EventTrack01_F_Curator"; 
 }];
 

