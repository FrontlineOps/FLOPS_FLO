
_GroupMarks = allMapMarkers select {markerType _x == "b_unknown" && markerColor _x == "Color6_FD_F"};
{deleteMarker _x; } forEach _GroupMarks;

sleep 1 ; 


_SaveGroups = allGroups select {(typeOf (units _x select 0) == F_Diver_Eod or  typeOf (units _x select 0) == F_Diver_Rfl or typeOf (units _x select 0) == F_Diver_TL or typeOf (units _x select 0) == F_Recon_Eod or  typeOf (units _x select 0) == F_Recon_Med or  typeOf (units _x select 0) == F_Recon_Eng or  typeOf (units _x select 0) == F_Recon_Mg or typeOf (units _x select 0) == F_Recon_AT or typeOf (units _x select 0) == F_Recon_Mrk or typeOf (units _x select 0) == F_Assault_AT or typeOf (units _x select 0) == F_Assault_Amm or  typeOf (units _x select 0) == F_Assault_Mg or typeOf (units _x select 0) == F_Recon_Snp or typeOf (units _x select 0) == F_Recon_Sct or  typeOf (units _x select 0) == F_Recon_TL or typeOf (units _x select 0) == F_Assault_SL or typeOf (units _x select 0) == F_Assault_TL or  typeOf (units _x select 0) == F_Assault_Eng or typeOf (units _x select 0) == F_Officer or typeOf (units _x select 0) == F_Assault_Eod or typeOf (units _x select 0) == F_Assault_Mrk  or typeOf (units _x select 0) == F_Assault_Uav or typeOf (units _x select 0) == F_Assault_Med or typeOf (units _x select 0) == F_Officer) && (captive (units _x select 0) == false) && (side (units _x select 0) == west)  && (alive (units _x select 0) == true)};
	{
		_GrpUntCnt = (count (units _x)) -1 ; 
		UnitsArray = [] ;
				for "_i" from 0 to _GrpUntCnt do {
				_Uclass = typeOf ((units _x) select _i);	
				UnitsArray append [_Uclass] ;			
				}; 

		PrvGrpID = groupId _x ; 
		publicVariable "PrvGrpID" ; 
				UnitsArray append [PrvGrpID] ;			
		

_Group = createGroup West; 
{[_x] join _Group} forEach units (group player);

_Group setGroupIdGlobal [PrvGrpID] ; 
if (isPlayer ((units _x) select 0)) then {UnitsArray deleteAt 0;};
_mrkr = createMarkerLocal [str(units _x select 0), getPos (units _x select 0)];   
_mrkr setMarkerType "b_unknown";  
_mrkr setMarkerSize [0.5, 0.5];   
_mrkr setMarkerColor "Color6_FD_F";   
_mrkr setMarkerAlpha 0.006;  
_mrkr setMarkerText str UnitsArray; 
  
	}forEach _SaveGroups;
	

