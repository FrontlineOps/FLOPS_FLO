
_AMMBX = _this select 0 ;

_VEHSs = nearestObjects [_AMMBX,["Car","Tank", "Air", "Ship", "LandVehicle"], 70] select {(alive _x == true)} ;


	{
_x setdamage 0.2 ;
	} forEach _VEHSs ; 