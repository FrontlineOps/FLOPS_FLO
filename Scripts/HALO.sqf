
 
_PLYR = _this select 0 ;
_GRPPLYR = group _PLYR ;

{_x allowDammage false ; } forEach units _GRPPLYR ;


sleep 180 ;

{_x allowDammage true ; } forEach units _GRPPLYR ;