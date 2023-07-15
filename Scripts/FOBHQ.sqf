if ((typeOf player == F_Officer) || (typeOf player == "B_G_officer_F")) then {

Cost = 1500 ;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  
if (_Money >= Cost) then {
_NewMoney = _Money - Cost; 
_mrkr setMarkerText str _NewMoney;


_pos = [getPosATL player select 0, getPosATL player select 1, (getPosATL player select 2) + 1000];
CreatedVEH = createVehicle ["B_Slingload_01_Cargo_F",_pos,[],0,"NONE"];
CreatedVEH allowDammage false;

CursorTracker = true ;
CreatedVEH enableSimulation false;
CreatedVEH allowDammage false ;

[] spawn {  
  while {CursorTracker == true} do{  
  CreatedVEH setVehiclePosition [ screenToWorld [ 0.5, 0.5 ], [], 0, "CAN_COLLIDE" ];
  CreatedVEH setDir ((getDirVisual player) + 230);
  sleep 0.3;
  }
};



Ind01 = [ CreatedVEH,
"<t color='#FF0000'>CANCEL</t>",
'Screens\FOBA\iconRepairAt_ca.paa',
'Screens\FOBA\iconRepairAt_ca.paa',
'true',       
'true',  
{},
{},
{
detach (_this select 0); 
(_this select 0) enableSimulation true;
deleteVehicle (_this select 0);
_mrkrs = allMapMarkers select {markerColor _x == 'Color2_FD_F'};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  
_NewMoney = _Money + Cost; 
_mrkr setMarkerText str _NewMoney;

},
{},
[],
3,
0,
false,
false
] call BIS_fnc_holdActionAdd; 

Ind02 = [ CreatedVEH,
"<t color='#FF0000'>PLACE</t>",
'Screens\FOBA\iconRepairAt_ca.paa',
'Screens\FOBA\iconRepairAt_ca.paa',
'true',       
'true',  
{},
{},
{
detach (_this select 0); 
(_this select 0) enableSimulation true;

CursorTracker = false ;
(_this select 0) enableSimulation true;
(_this select 0) allowDammage true ;
(_this select 0) removeAction Ind01;
(_this select 0) removeAction Ind02;
[(_this select 0),[
	"<img size=2 color='#7CC2FF' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#7CC2FF'>UnPack FOB",
	"Scripts\FOBUNPACK.sqf",
	nil,
	0,
	true,
	true,
	"",
	"player == TheCommander", // _target, _this, _originalTarget
	25,
	false,
	"",
	""
]] remoteExec ["addAction",0,true];
},
{},
[],
3,
0,
false,
false
] call BIS_fnc_holdActionAdd; 


}else{hint "Not enough Resources";};

}else{  hint "You are not authorized for this Request Soldier!"; };

	closeDialog 0;