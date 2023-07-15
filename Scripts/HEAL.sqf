
_AMMBX = _this select 0 ;


	
	{
 _x setDamage 0; 
  _x setVariable ["ais_stabilized", true, true];
  _x setVariable ["ais_unconscious", false, true];

  _x setVariable ["ais_fireDamage", 0]; 
 
 [_x] remoteExecCall ["AIS_System_fnc_restoreFaks", _x, false]; 
 
  [true] remoteExec ["showHud", _x]; 
   [true] remoteExecCall ["AIS_Effects_fnc_toggleRadio", _x, false]; 
 
  _x stop false; 
 _x enableAI "all";    

 
		_x call AIS_Effects_fnc_removeinjuredMarker;
			[_x, 50] call AIS_system_fnc_reveal;

 [_x, false] remoteExec ["setCaptive", 0, false]; 
  
 ["GetOutMan"] remoteExec ["removeAllEventHandlers", _x, false];
 
	[_x, _x] remoteExec ["ace_medical_treatment_fnc_fullHeal", _x, false]; 

	if ( animationState _x == "ainjppnemstpsnonwrfldnon" ) then {  [_x, "agonyStop"] remoteExec ["playActionNow", 0, false]; };
	if ( animationState _x == "unconscious" ) then {  [_x, "agonyStop"] remoteExec ["playActionNow", 0, false]; };
		_x enableAI "all";    
  } forEach (allUnits select {((side _x == civilian) || (side _x == west)) && ((getPos _x) distance (getPos _AMMBX) < 70)}) ; 

sleep 3 ; 


	{
		
	if ( animationState _x == "ainjppnemstpsnonwrfldnon" ) then {  [_x, "agonyStop"] remoteExec ["playActionNow", 0, false]; };
	if ( animationState _x == "unconscious" ) then {  [_x, "agonyStop"] remoteExec ["playActionNow", 0, false]; };
		_x enableAI "all";    

  } forEach (allUnits select {((side _x == civilian) || (side _x == west)) && ((getPos _x) distance (getPos _AMMBX) < 70)}) ; 	
  
