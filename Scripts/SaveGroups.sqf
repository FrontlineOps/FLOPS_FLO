
{ deleteVehicle _x } forEach allDeadMen;
sleep 1 ;

_SaveGroups = allGroups select { (typeOf (units _x select 0) == F_Diver_Rfl or typeOf (units _x select 0) == F_Diver_TL or typeOf (units _x select 0) == F_Recon_Mg or typeOf (units _x select 0) == F_Recon_AT or typeOf (units _x select 0) == F_Recon_Mrk or typeOf (units _x select 0) == F_Assault_AT or typeOf (units _x select 0) == F_Assault_Amm or  typeOf (units _x select 0) == F_Assault_Mg or typeOf (units _x select 0) == F_Recon_Snp or typeOf (units _x select 0) == F_Recon_Sct or  typeOf (units _x select 0) == F_Recon_TL or typeOf (units _x select 0) == F_Assault_SL or typeOf (units _x select 0) == F_Assault_TL or  typeOf (units _x select 0) == F_Assault_Eng or typeOf (units _x select 0) == F_Officer or typeOf (units _x select 0) == F_Assault_Eod or  typeOf (units _x select 0) == F_Assault_Mrk) && (captive (units _x select 0) == false)};
	{
	_U0 = typeOf ((units _x) select 0);
	_U1 = typeOf ((units _x) select 1);
	_U2 = typeOf ((units _x) select 2);
	_U3 = typeOf ((units _x) select 3);
	_U4 = typeOf ((units _x) select 4);
	_U5 = typeOf ((units _x) select 5);
	_U6 = typeOf ((units _x) select 6);
	_U7 = typeOf ((units _x) select 7);
	_U8 = typeOf ((units _x) select 8);
	_U9 = typeOf ((units _x) select 9);
	_U10 = typeOf ((units _x) select 10);
	_U11 = typeOf ((units _x) select 11);
	_U12 = typeOf ((units _x) select 12);	
_UnitsArray = [_U0,_U1,_U2,_U3,_U4,_U5,_U6,_U7,_U8,_U9,_U10,_U11,_U12];
if (isPlayer ((units _x) select 0)) then {_UnitsArray deleteAt 0;};
_mrkr = createMarkerLocal [str(units _x select 0), getPos (units _x select 0)];   
_mrkr setMarkerType "b_unknown";  
_mrkr setMarkerSize [0.5, 0.5];   
_mrkr setMarkerColor "Color6_FD_F";   
_mrkr setMarkerAlpha 0.006;  
_mrkr setMarkerText str _UnitsArray; 
  
	}forEach _SaveGroups;
	

