

_thisINSURGTrigger = _this select 0;


	
	if (count (_thisINSURGTrigger nearRoads 10) > 0 ) then {
		_chance = selectRandom [0, 1, 2, 3, 4] ;
			if (_Chance == 0) then {			
			 _nearRoad = selectRandom ((getpos _thisINSURGTrigger) nearRoads 20 ) ; 
			_pos = _nearRoad getRelPos [6, selectRandom [90, -90]];
			_V = createVehicle [selectRandom ["I_G_Offroad_01_AT_F", "I_C_Offroad_02_LMG_F", "I_G_Offroad_01_armed_F", "I_C_Offroad_02_AT_F"], [_pos select 0, _pos select 1, (_pos select 2) + 5], [], 0, "CAN_COLLIDE"]; 
			_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
			_dir = _nearRoad getDir _nextRoad;
			_V setDir _dir;
			_G = [_pos, east,[selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;
					  [ ((units _G) select 1),            
 "<img size=2 color='#FFE496' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#FFE496'>Search Insurgent",           
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",  
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",  
 "(_this distance _target)<3",       
 "(_this distance _target)<3",       
 { 
 playSound3D [ "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_02.wss", (_this select 0)];  
  
 },             
 {},              
 {_chance = selectRandom [1, 1, 1, 2, 2] ;
	if (_chance == 1) then {
	execVM "Scripts\INTL_Civ.sqf"; 
	}else{
	execVM "Scripts\INTL.sqf"; 	
	};
  },    
 {},              
 [],             
 3,            
 0,             
 true,             
 false             
] remoteExec ["BIS_fnc_holdActionAdd",0,true];  			
			((units _G) select 2) moveInGunner _V ;			
			};

			if (_Chance == 1) then {
			_IEDs = ["IEDUrbanSmall_F","IEDUrbanBig_F","IEDLandSmall_F","IEDLandBig_F"] ;
			_Clutters = ["Land_Garbage_square3_F","Land_Garbage_square3_F","Land_Garbage_line_F","Land_Garbage_line_F", "Land_Garbage_line_F"] ;
			_nearRoad = selectRandom ((getpos _thisINSURGTrigger) nearRoads 15 ) ; 
			_RoadSide =  selectRandom [90, -90] ;
			_pos = _nearRoad getRelPos [6, _RoadSide];
			_Clutter = createVehicle [selectRandom _Clutters, _pos, [], (0 + (random 3)), "CAN_COLLIDE"] ;
			_IED = createMine [selectRandom _IEDs,  _pos, [], 0];
			_Clutter setVectorUp [0,0,1];
			_trg = createTrigger ["EmptyDetector", _pos];  
			_trg setTriggerArea [10, 10, 0, false, 4];  
			_trg setTriggerActivation ["WEST", "PRESENT", false];  
			_trg setTriggerStatements [  
			"this && stance player != 'PRONE' ", " [thisTrigger, 'Sh_82mm_AMOS', 0, 1, 0, false, 0, 10, ['']] spawn BIS_fnc_fireSupportVirtual; ", ""]; 
			};
			
			if (_Chance == 2) then {			
			 _nearRoad = selectRandom ((getpos _thisINSURGTrigger) nearRoads 20 ) ; 
			_pos = _nearRoad getRelPos [6, selectRandom [90, -90]];
			_V = createVehicle [selectRandom CivVehArray, [_pos select 0, _pos select 1, (_pos select 2) + 5], [], 0, "CAN_COLLIDE"]; 
			_nextRoad = ( roadsConnectedTo _nearRoad ) select 0;
			_dir = _nearRoad getDir _nextRoad;
			_V setDir _dir;
			_trg = createTrigger ["EmptyDetector", getPos _V];  
			_trg setTriggerArea [15, 15, 0, false, 6];  
			_trg setTriggerActivation ["WEST", "PRESENT", false];  
			_trg setTriggerStatements [  
			"this or (vehicle player) inArea thisTrigger",  " [thisTrigger, 'Sh_155mm_AMOS', 0, 1, 0] spawn BIS_fnc_fireSupportVirtual;", ""]; 
			_V addEventHandler ["Killed", { [(_this select 0), "Sh_155mm_AMOS", 0, 1, 0] spawn BIS_fnc_fireSupportVirtual;}]; 
			_trg attachTo [_V, [0, 0, 0]]; 	
			};
			
			if (_Chance == 3) then {	
			_G = [(getpos _thisINSURGTrigger), east,[selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
			sleep 2 ;
			[_G,(getpos _thisINSURGTrigger), 20] call BIS_fnc_taskPatrol;
			{_x setUnitPos "MIDDLE";} forEach Units _G ;
					  [ ((units _G) select 1),            
 "<img size=2 color='#FFE496' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#FFE496'>Search Insurgent",           
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",  
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",  
 "(_this distance _target)<3",       
 "(_this distance _target)<3",       
 { 
 playSound3D [ "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_02.wss", (_this select 0)];  
  
 },             
 {},              
 {_chance = selectRandom [1, 1, 1, 2, 2] ;
	if (_chance == 1) then {
	execVM "Scripts\INTL_Civ.sqf"; 
	}else{
	execVM "Scripts\INTL.sqf"; 	
	};
  },    
 {},              
 [],             
 3,            
 0,             
 true,             
 false             
] remoteExec ["BIS_fnc_holdActionAdd",0,true];  			
					  [ ((units _G) select 2),            
 "<img size=2 color='#FFE496' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#FFE496'>Search Insurgent",           
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",  
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",  
 "(_this distance _target)<3",       
 "(_this distance _target)<3",       
 { 
 playSound3D [ "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_02.wss", (_this select 0)];  
  
 },             
 {},              
 {_chance = selectRandom [1, 1, 1, 2, 2] ;
	if (_chance == 1) then {
	execVM "Scripts\INTL_Civ.sqf"; 
	}else{
	execVM "Scripts\INTL.sqf"; 	
	};
  },    
 {},              
 [],             
 3,            
 0,             
 true,             
 false             
] remoteExec ["BIS_fnc_holdActionAdd",0,true];  		
			[((units _G) select 2), "launch_RPG7_F", 4] call BIS_fnc_addWeapon;
			[((units _G) select 4), "launch_RPG7_F", 4] call BIS_fnc_addWeapon;
			[((units _G) select 6), "launch_RPG7_F", 4] call BIS_fnc_addWeapon;
			};			
			
			if (_Chance == 4) then {	
			_trg = createTrigger ["EmptyDetector", getPos _thisINSURGTrigger];  
			_trg setTriggerArea [50, 50, 0, false, 6];  
			_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];  
			_trg setTriggerStatements [  
			"this",  "
			_pos = player getPos [(250 +(random 50)), (0 + (random 360))] ;
			_G = [_pos, east,[selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
			MortarRoad = createVehicle ['O_Mortar_01_F', _pos, [], 0, 'CAN_COLLIDE']; 			
			((units _G) select 2) moveInGunner MortarRoad ;
					  [ ((units _G) select 1),            
 'Search Insurgent',           
 '\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa',  
 '\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa',  
	'(_this distance _target)<3',       
	'(_this distance _target)<3',       
 { 
 playSound3D [ 'a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_02.wss', (_this select 0)];  
  
 },             
 {},              
 {_chance = selectRandom [1, 1, 1, 2, 2] ;
	if (_chance == 1) then {
	execVM 'Scripts\INTL_Civ.sqf'; 
	}else{
	execVM 'Scripts\INTL.sqf' ; 	
	};
  },    
 {},              
 [],             
 3,            
 0,             
 true,             
 false             
] remoteExec ['BIS_fnc_holdActionAdd',0,true];  			
			[(getPos player), 'Sh_82mm_AMOS', 200, 100, 10, {!alive MortarRoad}, 5] spawn BIS_fnc_fireSupportVirtual;
			", ""]; 
			};	
			
	}else{
		
		_TERR = nearestTerrainObjects [(getPos _thisINSURGTrigger), ['FOREST', 'House', 'TREE', 'SMALL TREE', 'BUSH', 'ROCK', 'ROCKS'], 15]; 
		{_x hideObjectGlobal true;} forEach _TERR ;
		
		_chance = selectRandom [1, 2, 3, 4] ;	

			if (_Chance == 1) then {			
			_pos = (getpos _thisINSURGTrigger) ;
			_V = createVehicle [selectRandom ["I_G_Offroad_01_AT_F", "I_C_Offroad_02_LMG_F", "I_G_Offroad_01_armed_F", "I_C_Offroad_02_AT_F"], [_pos select 0, _pos select 1, (_pos select 2) + 5], [], 0, "CAN_COLLIDE"]; 
			sleep 2 ;			
			_G = [_pos, east,[selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;   
					  [ ((units _G) select 1),            
 "<img size=2 color='#FFE496' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#FFE496'>Search Insurgent",           
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",  
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",  
 "(_this distance _target)<3",       
 "(_this distance _target)<3",       
 { 
 playSound3D [ "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_02.wss", (_this select 0)];  
  
 },             
 {},              
 {_chance = selectRandom [1, 1, 1, 2, 2] ;
	if (_chance == 1) then {
	execVM "Scripts\INTL_Civ.sqf"; 
	}else{
	execVM "Scripts\INTL.sqf"; 	
	};
  },    
 {},              
 [],             
 3,            
 0,             
 true,             
 false             
] remoteExec ["BIS_fnc_holdActionAdd",0,true];  					
			((units _G) select 2) moveInGunner _V ;			
			};
			
			if (_Chance == 2) then {	
			_G = [(getpos _thisINSURGTrigger), east,[selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
			_V = createVehicle ['O_G_HMG_02_high_F', (getpos _thisINSURGTrigger), [], 0, 'CAN_COLLIDE']; 	
					  [ ((units _G) select 1),            
 "<img size=2 color='#FFE496' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#FFE496'>Search Insurgent",           
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",  
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",  
 "(_this distance _target)<3",       
 "(_this distance _target)<3",       
 { 
 playSound3D [ "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_02.wss", (_this select 0)];  
  
 },             
 {},              
 {_chance = selectRandom [1, 1, 1, 2, 2] ;
	if (_chance == 1) then {
	execVM "Scripts\INTL_Civ.sqf"; 
	}else{
	execVM "Scripts\INTL.sqf"; 	
	};
  },    
 {},              
 [],             
 3,            
 0,             
 true,             
 false             
] remoteExec ["BIS_fnc_holdActionAdd",0,true];  					
			((units _G) select 2) moveInGunner _V ;
			};
		
			if (_Chance == 3) then {	
			_trg = createTrigger ["EmptyDetector", getPos _thisINSURGTrigger];  
			_trg setTriggerArea [200, 200, 0, false, 50];  
			_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];  
			_trg setTriggerStatements [  
			"this",  "
			_pos = player getPos [(250 +(random 50)), (0 + (random 360))] ;
			_G = [_pos, east,[selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
			MortarMount = createVehicle ['O_Mortar_01_F', _pos, [], 0, 'CAN_COLLIDE']; 	
					  [ ((units _G) select 1),            
  'Search Insurgent',           
 '\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa',  
 '\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa',  
	'(_this distance _target)<3',       
	'(_this distance _target)<3',       
 { 
 playSound3D [ 'a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_02.wss', (_this select 0)];  
  
 },             
 {},              
 {_chance = selectRandom [1, 1, 1, 2, 2] ;
	if (_chance == 1) then {
	execVM 'Scripts\INTL_Civ.sqf'; 
	}else{
	execVM 'Scripts\INTL.sqf' ; 	
	};
  },    
 {},              
 [],             
 3,            
 0,             
 true,             
 false             
] remoteExec ['BIS_fnc_holdActionAdd',0,true];  			
			((units _G) select 2) moveInGunner MortarMount ;
			
			[(getPos player) , 'Sh_82mm_AMOS', 200, 100, 10, {!alive MortarMount}, 5] spawn BIS_fnc_fireSupportVirtual;
			", ""]; 
			};							
		
			if (_Chance == 4) then {	
			_G = [(getpos _thisINSURGTrigger), east,[selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray, selectRandom GuerMenArray]] call BIS_fnc_spawnGroup;     
			[_G,(getpos _thisINSURGTrigger), 20] call BIS_fnc_taskPatrol;
			{_x setUnitPos "MIDDLE";} forEach Units _G ;
					  [ ((units _G) select 1),            
 "<img size=2 color='#FFE496' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#FFE496'>Search Insurgent",           
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",  
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",  
 "(_this distance _target)<3",       
 "(_this distance _target)<3",       
 { 
 playSound3D [ "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_02.wss", (_this select 0)];  
  
 },             
 {},              
 {_chance = selectRandom [1, 1, 1, 2, 2] ;
	if (_chance == 1) then {
	execVM "Scripts\INTL_Civ.sqf"; 
	}else{
	execVM "Scripts\INTL.sqf"; 	
	};
  },    
 {},              
 [],             
 3,            
 0,             
 true,             
 false             
] remoteExec ["BIS_fnc_holdActionAdd",0,true];  			
					  [ ((units _G) select 2),            
 "<img size=2 color='#FFE496' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#FFE496'>Search Insurgent",           
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",  
 "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",  
 "(_this distance _target)<3",       
 "(_this distance _target)<3",       
 { 
 playSound3D [ "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_02.wss", (_this select 0)];  
  
 },             
 {},              
 {_chance = selectRandom [1, 1, 1, 2, 2] ;
	if (_chance == 1) then {
	execVM "Scripts\INTL_Civ.sqf"; 
	}else{
	execVM "Scripts\INTL.sqf"; 	
	};
  },    
 {},              
 [],             
 3,            
 0,             
 true,             
 false             
] remoteExec ["BIS_fnc_holdActionAdd",0,true];  		

			[((units _G) select 2), "launch_RPG7_F", 4] call BIS_fnc_addWeapon;
			[((units _G) select 4), "launch_RPG7_F", 4] call BIS_fnc_addWeapon;
			[((units _G) select 6), "launch_RPG7_F", 4] call BIS_fnc_addWeapon;
			};					
	};
	
	
	

	
	
	
	
	
	

	
	
