
_EXPpos = _this select 0 ; 

[_EXPpos, (selectRandom ['Sh_82mm_AMOS', 'Sh_155mm_AMOS']), 0, 1, 0, false, 0, 10, ['']] spawn BIS_fnc_fireSupportVirtual;


sleep 0.1 ; 
_Nearmen = _EXPpos nearEntities [["Man"], 10] ; 

{_x setDammage 1 ;} forEach _Nearmen ; 
