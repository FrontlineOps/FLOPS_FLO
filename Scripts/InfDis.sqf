sleep 18 ;

[parseText "<t color='#1AA3FF' font='PuristaBold' align = 'right' shadow = '1' size='2.5'>+ Enemy Heavy Weapons Support Dismantled</t><br /><t  align = 'right' shadow = '1' size='1.5'>For the Next Hour</t>", [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];

				{ _x setDammage 1;} foreach (allUnits select {side _x == east && count (units group _x )> 5}); 


LnchOFF = 1 ;
publicVariable "LnchOFF";

[] spawn {  
  while {(LnchOFF == 1)} do{ 
 
		 { 

				{_x removeWeaponGlobal (secondaryWeapon _x);} foreach (allUnits select {side _x != west}); 

		 } remoteExec ["call", 0];			
 
 sleep 90;  
  };  
};



sleep 3600 ;

INFDIS = 0;
publicVariable "INFDIS";
LnchOFF = 0 ;
publicVariable "LnchOFF";
