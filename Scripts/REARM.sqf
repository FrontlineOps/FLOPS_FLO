
_AMMBX = _this select 0 ;


	{
_unitWeapon = primaryWeapon _x;
_unitWeaponMagazines = getArray (configFile / "CfgWeapons" / _unitWeapon / "magazines"); 
_unitWeaponMagazine = selectRandom _unitWeaponMagazines; 

_unitMagazineFits = _x canAdd [_unitWeaponMagazine, 3]; 
if (_unitMagazineFits) then {
	_x addMagazines [_unitWeaponMagazine, 3]; 
};

_unitWeapon0 = secondaryWeapon _x;
_unitWeapon0Magazines = getArray (configFile / "CfgWeapons" / _unitWeapon0 / "magazines"); 
_unitWeapon0Magazine = selectRandom _unitWeapon0Magazines ; 

_unitMagazineFits0 = _x canAdd [_unitWeapon0Magazine, 1]; 
if (_unitMagazineFits0) then {
	_x addMagazines [_unitWeapon0Magazine, 1]; 
};

_unitWeapon1 = handgunWeapon _x;
_unitWeapon1Magazines = getArray (configFile / "CfgWeapons" / _unitWeapon1 / "magazines"); 
_unitWeapon1Magazine = selectRandom _unitWeapon1Magazines ; 

_unitMagazineFits1 = _x canAdd [_unitWeapon1Magazine, 1]; 
if (_unitMagazineFits1) then {
	_x addMagazines [_unitWeapon1Magazine, 1]; 
};

  } forEach (allUnits select {((side _x == civilian) || (side _x == west)) && ((getPos _x) distance (getPos _AMMBX) < 70)}) ; 
	
	
	
