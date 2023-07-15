

hint "Select Unit Type" ; 

F_Officer_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>HQ_Officer_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Officer] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;

},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Assault_Eng_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Assault_Engineer_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Assault_Eng] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;
},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Assault_TL_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Assault_SquadLeader_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Assault_TL] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;
},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Assault_SL_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Assault_PlatoonLeader_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Assault_SL] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;
},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Assault_Eod_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Assault_ExplosiveSpecialist_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Assault_Eod] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Assault_Mrk_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Assault_Marksman_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Assault_Mrk] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Assault_AT_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Assault_AntiTank_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Assault_AT] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Assault_Amm_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Assault_AmmoBearer_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Assault_Amm] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Assault_Mg_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Assault_MachineGunner_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Assault_Mg] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Assault_Med_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Assault_Medic_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Assault_Med] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Assault_Uav_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Assault_UAV Operator_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Assault_Uav] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 



F_Recon_Snp_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Recon_Sniper_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Recon_Snp] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Recon_Sct_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Recon_Spotter_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Recon_Sct] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 


F_Recon_TL_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Recon_SquadLeader_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Recon_TL] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Recon_Mrk_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Recon_Marksman_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Recon_Mrk] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Recon_AT_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Recon_AntiTank_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Recon_AT] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Recon_Mg_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Recon_MachineGunner_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Recon_Mg] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Recon_Eod_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Recon_ExplosiveSpecialist_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Recon_Eod] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Recon_Med_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Recon_Medic_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Recon_Med] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Recon_Eng_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Recon_Engineer_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Recon_Eng] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 



F_Diver_TL_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Diver_TeamLeader_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Diver_TL] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Diver_Rfl_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Diver_Operator_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Diver_Rfl] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 

F_Diver_Eod_Loadout_Action = [ player,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\mg_ca.paa'/><t color='#7CC2FF'>Diver_ExplosiveSpecialist_Loadout</t>",
'Screens\FOBA\mg_ca.paa',
'Screens\FOBA\mg_ca.paa',
'true',       
'true',  
{},
{},
{ [F_Diver_Eod] execVM "Scripts\LDTSet.sqf" ; 

player removeAction F_Officer_Loadout_Action;
player removeAction F_Assault_Eng_Loadout_Action;
player removeAction F_Assault_TL_Loadout_Action;
player removeAction F_Assault_SL_Loadout_Action;
player removeAction F_Assault_Eod_Loadout_Action;
player removeAction F_Assault_Mrk_Loadout_Action;
player removeAction F_Assault_AT_Loadout_Action;
player removeAction F_Assault_Amm_Loadout_Action;
player removeAction F_Assault_Mg_Loadout_Action;
player removeAction F_Assault_Med_Loadout_Action;
player removeAction F_Assault_Uav_Loadout_Action;

player removeAction F_Recon_Snp_Loadout_Action;
player removeAction F_Recon_Sct_Loadout_Action;
player removeAction F_Recon_TL_Loadout_Action;
player removeAction F_Recon_Mrk_Loadout_Action;
player removeAction F_Recon_AT_Loadout_Action;
player removeAction F_Recon_Mg_Loadout_Action;
player removeAction F_Recon_Eod_Loadout_Action;
player removeAction F_Recon_Med_Loadout_Action;
player removeAction F_Recon_Eng_Loadout_Action;

player removeAction F_Diver_TL_Loadout_Action;
player removeAction F_Diver_Rfl_Loadout_Action;
player removeAction F_Diver_Eod_Loadout_Action;},
{},
[],
3,
999999999,
false,
false
] call BIS_fnc_holdActionAdd; 


















