
_AMMBX = _this select 0 ;


	
	{
 _x setDamage 0; 
 
  [true] remoteExec ["showHud", _x]; 
 
  _x stop false; 
 _x enableAI "all";    

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
  
