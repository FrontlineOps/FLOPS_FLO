
hint "Select Objectives Type" ; 

n_support = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\Markers\NATO\n_support.paa'/><t color='#FF0000'>MIL Command Post</t>",
'\a3\Ui_f\data\Map\Markers\NATO\n_support.paa',
'\a3\Ui_f\data\Map\Markers\NATO\n_support.paa',
'true',       
'true',  
{},
{},
{ ["n_support"] execVM "Scripts\keyspressed_2.sqf" ; 
player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 

o_support = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\Markers\NATO\o_support.paa'/><t color='#FF0000'>MIL Out Post</t>",
'\a3\Ui_f\data\Map\Markers\NATO\o_support.paa',
'\a3\Ui_f\data\Map\Markers\NATO\o_support.paa',
'true',       
'true',  
{},
{},
{ ["o_support"] execVM "Scripts\keyspressed_2.sqf" ; 
player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 

o_maint = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\Markers\NATO\o_maint.paa'/><t color='#FF0000'>MIL Service Post</t>",
'\a3\Ui_f\data\Map\Markers\NATO\o_maint.paa',
'\a3\Ui_f\data\Map\Markers\NATO\o_maint.paa',
'true',       
'true',  
{},
{},
{ ["o_maint"] execVM "Scripts\keyspressed_2.sqf" ; 
player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 

o_service = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\Markers\NATO\o_service.paa'/><t color='#FF0000'>MIL Road Post</t>",
'\a3\Ui_f\data\Map\Markers\NATO\o_service.paa',
'\a3\Ui_f\data\Map\Markers\NATO\o_service.paa',
'true',       
'true',  
{},
{},
{ ["o_service"] execVM "Scripts\keyspressed_2.sqf" ;
player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation; },
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 



n_installation = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\Markers\NATO\n_installation.paa'/><t color='#FF0000'>CIV Capital</t>",
'\a3\Ui_f\data\Map\Markers\NATO\n_installation.paa',
'\a3\Ui_f\data\Map\Markers\NATO\n_installation.paa',
'true',       
'true',  
{},
{},
{ ["n_installation"] execVM "Scripts\keyspressed_2.sqf" ; 
player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 

o_installation = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\Markers\NATO\o_installation.paa'/><t color='#FF0000'>CIV City</t>",
'\a3\Ui_f\data\Map\Markers\NATO\o_installation.paa',
'\a3\Ui_f\data\Map\Markers\NATO\o_installation.paa',
'true',       
'true',  
{},
{},
{ ["o_installation"] execVM "Scripts\keyspressed_2.sqf" ; 
player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 

o_unknown = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\Markers\NATO\o_unknown.paa'/><t color='#FF0000'>CIV Town</t>",
'\a3\Ui_f\data\Map\Markers\NATO\o_unknown.paa',
'\a3\Ui_f\data\Map\Markers\NATO\o_unknown.paa',
'true',       
'true',  
{},
{},
{ ["o_unknown"] execVM "Scripts\keyspressed_2.sqf" ; 
player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 



o_antiair = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\Markers\NATO\o_antiair.paa'/><t color='#FF0000'>GZ AA Site",
'\a3\Ui_f\data\Map\Markers\NATO\o_antiair.paa',
'\a3\Ui_f\data\Map\Markers\NATO\o_antiair.paa',
'true',       
'true',  
{},
{},
{ ["o_antiair"] execVM "Scripts\keyspressed_2.sqf" ; 
player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 

loc_Transmitter = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\MapControl\transmitter_CA.paa'/><t color='#FF0000'>GZ Radio Tower</t>",
'\a3\Ui_f\data\Map\MapControl\transmitter_CA.paa',
'\a3\Ui_f\data\Map\MapControl\transmitter_CA.paa',
'true',       
'true',  
{},
{},
{ ["loc_Transmitter"] execVM "Scripts\keyspressed_2.sqf" ; 
player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 

loc_Ruin = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\MapControl\ruin_CA.paa'/><t color='#FF0000'>GZ Barracks</t>",
'\a3\Ui_f\data\Map\MapControl\ruin_CA.paa',
'\a3\Ui_f\data\Map\MapControl\ruin_CA.paa',
'true',       
'true',  
{},
{},
{ ["loc_Ruin"] execVM "Scripts\keyspressed_2.sqf" ; 
player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 

loc_Power = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\MapControl\power_CA.paa'/><t color='#FF0000'>GZ Radar Site</t>",
'\a3\Ui_f\data\Map\MapControl\power_CA.paa',
'\a3\Ui_f\data\Map\MapControl\power_CA.paa',
'true',       
'true',  
{},
{},
{ ["loc_Power"] execVM "Scripts\keyspressed_2.sqf" ; 
player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 



o_armor = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\Markers\NATO\o_armor.paa'/><t color='#FF0000'>Btl Armor</t>",
'\a3\Ui_f\data\Map\Markers\NATO\o_armor.paa',
'\a3\Ui_f\data\Map\Markers\NATO\o_armor.paa',
'true',       
'true',  
{},
{},
{ ["o_armor"] execVM "Scripts\keyspressed_2.sqf" ; 
player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 

o_air = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\Markers\NATO\o_air.paa'/><t color='#FF0000'>Btl Air</t>",
'\a3\Ui_f\data\Map\Markers\NATO\o_air.paa',
'\a3\Ui_f\data\Map\Markers\NATO\o_air.paa',
'true',       
'true',  
{},
{},
{ ["o_air"] execVM "Scripts\keyspressed_2.sqf" ; 

player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction u_installation;
},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 

o_naval = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\Markers\NATO\o_naval.paa'/><t color='#FF0000'>Btl Naval</t>",
'\a3\Ui_f\data\Map\Markers\NATO\o_naval.paa',
'\a3\Ui_f\data\Map\Markers\NATO\o_naval.paa',
'true',       
'true',  
{},
{},
{ ["o_naval"] execVM "Scripts\keyspressed_2.sqf" ; 
player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 

o_recon = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\Markers\NATO\o_recon.paa'/><t color='#FF0000'>Btl Recon</t>",
'\a3\Ui_f\data\Map\Markers\NATO\o_recon.paa',
'\a3\Ui_f\data\Map\Markers\NATO\o_recon.paa',
'true',       
'true',  
{},
{},
{ ["o_recon"] execVM "Scripts\keyspressed_2.sqf" ; 

player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;},

{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 



loc_mine = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\IGUI\Cfg\simpleTasks\types\mine_ca.paa'/><t color='#FF0000'>Obj Mine Field</t>",
'\a3\Ui_f\data\IGUI\Cfg\simpleTasks\types\mine_ca.paa',
'\a3\Ui_f\data\IGUI\Cfg\simpleTasks\types\mine_ca.paa',
'true',       
'true',  
{},
{},
{ ["loc_mine"] execVM "Scripts\keyspressed_2.sqf" ; 

player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;
},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 

mil_unknown = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\Markers\Military\unknown_CA.paa'/><t color='#FF0000'>Obj Crash Site</t>",
'\a3\Ui_f\data\Map\Markers\Military\unknown_CA.paa',
'\a3\Ui_f\data\Map\Markers\Military\unknown_CA.paa',
'true',       
'true',  
{},
{},
{ ["mil_unknown"] execVM "Scripts\keyspressed_2.sqf" ; 

player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;
},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 

mil_warning = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\Markers\Military\warning_CA.paa'/><t color='#FF0000'>Obj Missing Squad</t>",
'\a3\Ui_f\data\Map\Markers\Military\warning_CA.paa',
'\a3\Ui_f\data\Map\Markers\Military\warning_CA.paa',
'true',       
'true',  
{},
{},
{ ["mil_warning"] execVM "Scripts\keyspressed_2.sqf" ; 

player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 



u_installation = [ player,
"<img size=2 color='#FF0000' image='\a3\Ui_f\data\Map\Markers\NATO\u_installation.paa'/><t color='#FF0000'>CQB Garrison Building</t>",
'\a3\Ui_f\data\Map\Markers\NATO\u_installation.paa',
'\a3\Ui_f\data\Map\Markers\NATO\u_installation.paa',
'true',       
'true',  
{},
{},
{ ["u_installation"] execVM "Scripts\keyspressed_2.sqf" ; 

player removeAction n_support;
player removeAction o_support;
player removeAction o_maint;
player removeAction o_service;

player removeAction n_installation;
player removeAction o_installation;
player removeAction o_unknown;

player removeAction o_antiair;
player removeAction loc_Transmitter;
player removeAction loc_Ruin;
player removeAction loc_Power;

player removeAction o_armor;
player removeAction o_air;
player removeAction o_naval;
player removeAction o_recon;

player removeAction loc_mine;
player removeAction mil_unknown;
player removeAction mil_warning;
player removeAction u_installation;},
{},
[],
2,
999999,
false,
false
] call BIS_fnc_holdActionAdd; 

