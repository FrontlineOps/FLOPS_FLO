_Cost= 75;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  
if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;


_SDM = createMarker [str (position player), position player];
_SDM setMarkerType "mil_marker_noShadow";
_SDM setMarkerColor "colorBLUFOR" ;
_SDM setMarkerAlpha 0.7;
_SDM setMarkerText "SupplyDrop";



			playSound3D [getMissionPath (selectRandom ["Sounds\SupportRequestRGSupplyDrop.ogg"]), player];
sleep 10;
playSound3D ["A3\Sounds_F\ambient\battlefield\battlefield_jet1.wss", player];

sleep 5;

_parachute = createVehicle ["B_Parachute_02_F",(getMarkerpos _SDM), [], 0, "FLY"];
_parachute setPosATL [getPosATL _parachute select 0, getPosATL _parachute select 1, 80];

 _pos = [getPosATL player select 0, getPosATL player select 1, (getPosATL player select 2) + 1000];
_Cargo = createVehicle ["B_CargoNet_01_ammo_F", _pos, [], 0, "FLY"]; 
_Cargo allowDamage false;
_Cargo addMagazineCargoGlobal  ["DemoCharge_Remote_Mag", 20];
_Cargo addMagazineCargoGlobal  ["APERSBoundingMine_Range_Mag", 7];
_Cargo addMagazineCargoGlobal  ["APERSMine_Range_Mag", 7];
_Cargo addMagazineCargoGlobal  ["ClaymoreDirectionalMine_Remote_Mag", 7];
_Cargo addMagazineCargoGlobal  ["SLAMDirectionalMine_Wire_Mag", 7];
_Cargo addMagazineCargoGlobal   ["B_IR_Grenade", 7];
_Cargo addMagazineCargoGlobal   ["SmokeShell", 7];
_Cargo addMagazineCargoGlobal   ["HandGrenade", 7];
_Cargo addBackpackCargoGlobal ["B_UAV_01_backpack_F", 2];
_Cargo addBackpackCargoGlobal ["B_Static_Designator_01_weapon_F", 2];
_Cargo addBackpackCargoGlobal ["B_W_Static_Designator_01_weapon_F", 2];
_Cargo addBackpackCargoGlobal ["B_UGV_02_Demining_backpack_F", 2];
_Cargo addBackpackCargoGlobal ["B_Patrol_Respawn_bag_F", 2];
_Cargo addWeaponCargoGlobal ["launch_B_Titan_tna_F", 5];
_Cargo addWeaponCargoGlobal ["launch_B_Titan_F", 5];
_Cargo addWeaponCargoGlobal ["launch_B_Titan_short_F", 5];
_Cargo addWeaponCargoGlobal ["launch_I_Titan_short_F", 5];
_Cargo addWeaponCargoGlobal ["launch_NLAW_F", 5];
_Cargo addMagazineCargoGlobal ["NLAW_F", 15];
_Cargo addMagazineCargoGlobal ["MRAWS_HEAT_F", 15];
_Cargo addMagazineCargoGlobal ["Titan_AT", 15];
_Cargo addMagazineCargoGlobal ["Titan_AA", 15];
_Cargo addMagazineCargoGlobal ["Titan_AP", 15];

[ _Cargo,
"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>ARSENAL",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
	
	if (isClass (configfile >> "ace_arsenal_loadoutsDisplay") == true ) then {
		[player, player, true] call ace_arsenal_fnc_openBox;
	} else {
		["Open", true] spawn BIS_fnc_arsenal;
	};
},
{},
[],
1,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

[ _Cargo,
"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>REARM Infantry",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
[(_this select 0)] execVM "Scripts\REARM.sqf" ;
},
{},
[],
5,
1,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

_Cargo attachTo [_parachute,[0,0,0]];
     
_Cargo enableSimulation false;

_Chemlight_1 = "Chemlight_blue" createVehicle (position _Cargo);
_Chemlight_1 attachTo [_Cargo, [0,0.1,-0.1]];
_Chemlight_2 = "Chemlight_blue" createVehicle (position _Cargo);
_Chemlight_2 attachTo [_Cargo, [0,-0.1,-0.1]];
_Smoke = "SmokeShellBlue" createVehicle (position _Cargo);
_Smoke attachTo [_Cargo, [0,0,0]];


waitUntil {getPos _Cargo select 2 < 1};
           
detach _Cargo;
_parachute disableCollisionWith _Cargo;   
sleep 5 ;
if (!isNull _parachute) then {deleteVehicle _parachute};
_Cargo enableSimulation true;

playSound3D ["A3\dubbing_f\modules\supports\drop_accomplished.ogg", player];

_SDM setmarkerpos [str (position _Cargo), position _Cargo];


sleep 300;

deleteMarker _SDM;

}else{ 
   
  hint "Not enough Resources"; 
   
  };