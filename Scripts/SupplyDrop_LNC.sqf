_Cost= 15;
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


playSound3D ["A3\dubbing_f\modules\supports\drop_request.ogg", player];
sleep 10;
playSound3D ["A3\Sounds_F\ambient\battlefield\battlefield_jet1.wss", player];

sleep 5;

_parachute = createVehicle ["B_Parachute_02_F",(getMarkerpos _SDM), [], 0, "FLY"];
_parachute setPosATL [getPosATL _parachute select 0, getPosATL _parachute select 1, 80];

 _pos = [getPosATL player select 0, getPosATL player select 1, (getPosATL player select 2) + 1000];
_Cargo = createVehicle [F_Lnch_01, _pos, [], 0, "FLY"]; 
_Cargo allowDamage false;
_Cargo addWeaponCargoGlobal ["launch_B_Titan_tna_F", 5];
_Cargo addWeaponCargoGlobal ["launch_B_Titan_F", 5];
_Cargo addWeaponCargoGlobal ["launch_B_Titan_short_F", 5];
_Cargo addWeaponCargoGlobal ["launch_I_Titan_short_F", 5];
_Cargo addWeaponCargoGlobal ["launch_NLAW_F", 5];

_Cargo addMagazineCargo ["NLAW_F", 15];
_Cargo addMagazineCargo ["MRAWS_HEAT_F", 15];
_Cargo addMagazineCargo ["Titan_AT", 15];
_Cargo addMagazineCargo ["Titan_AA", 15];
_Cargo addMagazineCargo ["Titan_AP", 15];

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


sleep 60;

deleteMarker _SDM;

}else{ 
   
  hint "Not enough Resources"; 
   
  };