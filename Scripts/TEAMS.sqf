GNR = nil;
DVR = nil;


titleText ["Control System Initializing . . .", "BLACK IN",9999];

openMap [true, true]; 
sleep 1;
titleText ["", "BLACK IN",1];
hint "Select Target Unit"; 
onMapSingleClick {
onMapSingleClick {}; 


_side = side player;
_radius = 3000;
_Unts = nearestObjects [_pos,["Man","Car","Tank", "Air", "Ship", "LandVehicle"], 3000] select {((side _x == west) || (side (driver  _x) == west)) && (alive _x == true)} ;
_Unt = _Unts select 0 ;


if ((_Unt isKindOf  "Man") && (isPlayer _Unt)) then {

openMap [true, false]; 
openMap [false, false]; 

			private _headlessClients = entities "HeadlessClient_F";
			private _humanPlayers = allPlayers - _headlessClients;
			hcRemoveAllGroups player;  
			 {player hcRemoveGroup _x ;} forEach (allGroups select {side _x == west}); 
			 _GRPs = (allGroups select {(side _x == (side player)) && !(((units _x) select 0) in switchableUnits)}); 
			if (count _humanPlayers == 1 ) then {
							 _GRPs = (allGroups select {(side _x == (side player)) && !(((units _x) select 0) in switchableUnits)}); 
			{player hcSetGroup [_x];} forEach _GRPs;
			}else{
							 _GRPs = (allGroups select {(side _x == (side player)) && !(((units _x) select 0) in switchableUnits)}); 

			{TheCommander hcSetGroup [_x];} forEach _GRPs;
			};

group player selectLeader player;

if ((serverCommandAvailable "#kick")  &&  (serverCommandAvailable "#debug")) then {
	
	{unassignCurator ZEUS;} remoteExec ["call", 2];

ZEUSNetworkId = clientOwner;
publicVariable "ZEUSNetworkId";

	{		
		_ZEUSPLYOBJ = allPlayers select {owner _x == ZEUSNetworkId};	
		(_ZEUSPLYOBJ select 0) assignCurator ZEUS;
		
	} remoteExec ["call", 2]; 
  
 }; 


   if (markerText "Revive_Handle" == "Activate") then {  {[_x] call AIS_System_fnc_loadAIS;} forEach Units group player; };


hint "YOU CANT SWITCH TO HUMAN PLAYERS";
};

if ((_Unt isKindOf  "Man") && (!isPlayer _Unt)) then {


	if (getConnectedUAV player != objNull) then {player connectTerminalToUAV objNull;};
 removeAllActions player ;
hcRemoveAllGroups player; 

PrvGrpID = groupId (group player) ; 
publicVariable "PrvGrpID" ; 

_Group = createGroup West; 
{[_x] join _Group} forEach units (group player);

_Group setGroupIdGlobal [PrvGrpID] ; 

selectPlayer _Unt;

[] execVM "Scripts\TEAMS_SQD.sqf" ;	
};

if (!(_Unt isKindOf  "Man") && (!isPlayer _Unt)) then { 

	if (getConnectedUAV player != objNull) then {player connectTerminalToUAV objNull;};

[_Unt] execVM "Scripts\TEAMS_VEH.sqf" ;	
hint "";
};


};





































