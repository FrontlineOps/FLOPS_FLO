
_AMMBX = _this select 0 ;

_VEHSs = nearestObjects [_AMMBX,["Car","Tank", "Air", "Ship", "LandVehicle"], 70] select {(alive _x == true)} ;


	{
_x setVehicleAmmo 1;
	} forEach _VEHSs ; 