
_LightClass = _this select 0 ; 

{			  
_lgt = _LightClass createVehicle [0,0,0]; 
_lgt attachTo [_x, [0,-0.04,0.08],"LeftShoulder"]; 
_lgt setVectorDirAndUp [[0,1,0], [0.5,0,0]];  
} forEach units player ; 

