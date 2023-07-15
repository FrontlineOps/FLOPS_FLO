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
_Cargo = createVehicle ["Box_NATO_AmmoVeh_F", _pos, [], 0, "FLY"]; 
_Cargo allowDamage false;

[ _Cargo,
"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>REARM Vehicles",
"Screens\FOBA\mg_ca.paa",
"Screens\FOBA\mg_ca.paa",
	"_this distance _target < 10",			
	"_caller distance _target < 10",	
{},
{},
{
[(_this select 0)] execVM "Scripts\REARMVEH.sqf" ;
},
{},
[],
10,
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

_SDM = createMarker [str (position _Cargo), position _Cargo];
_SDM setMarkerType "mil_marker_noShadow";
_SDM setMarkerColor "colorBLUFOR" ;
_SDM setMarkerAlpha 0.7;
_SDM setMarkerText "SupplyDrop";

sleep 300;

deleteMarker _SDM;

}else{ 
   
  hint "Not enough Resources"; 
   
  };