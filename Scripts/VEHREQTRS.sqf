

_Cost = _this select 1;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  

if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;	


_ARRVLOC = screenToWorld [0.5,0.5];
if ((getPosATL laserTarget player) select 0 != 0) then { _ARRVLOC = getPosATL laserTarget player; };

_INFCLSS = _this select 0 ;
if (_INFCLSS == 111) then {
	F_SQD = [F_Assault_SL, F_Assault_Eod, F_Assault_AT, F_Assault_Mg, F_Assault_Med, F_Assault_Amm, F_Assault_Eng, F_Assault_Mrk, F_Assault_AT, F_Assault_Mg, F_Assault_Med, F_Assault_Uav];
} else {
	F_SQD = [F_Recon_TL, F_Recon_AT, F_Recon_Eod, F_Recon_Mg, F_Recon_Eng, F_Recon_Mrk, F_Recon_Med, F_Recon_AT];	
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 _allFOBMarks = allMapMarkers select {markerType _x == "b_installation" && markerText _x == "FOB" && markerColor _x == "ColorYellow"};   
 _NRFMRK = [_allFOBMarks,  player] call BIS_fnc_nearestPosition;

 if ((position player) distance (getMarkerpos _NRFMRK) < 400) exitWith {hint "You are Near the FOB"} ;

_nearRoad2 =(getMarkerPos _NRFMRK) nearRoads 400 ; 
_nearRoad1 = (getMarkerPos _NRFMRK) nearRoads 300 ; 

_nearRoadleft = _nearRoad2 - _nearRoad1;

if (count _nearRoadleft > 0) then { nearRoadpos = getpos (selectRandom _nearRoadleft); } else { nearRoadpos = [ (getMarkerPos _NRFMRK), 300, 400, 20, 0, 1, 0 ] call BIS_fnc_findSafePos; } ; 

hint "GCE Deployed" ; 
_Veh = createVehicle [F_Truck_01, nearRoadpos, [], 0, "NONE"];

(driver _Veh) disableAI "LIGHTS"; 
_Veh setPilotLight true;



GRPReq = [[0,0,0], west, F_SQD] call BIS_fnc_spawnGroup;
{
[_x,'MENU_COMMS_UAV_RECON',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[_x,'MENU_COMMS_SUPPLYDROP',nil,nil,''] call BIS_fnc_addCommMenuItem;
[_x,'MENU_COMMS_INF',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[_x,'MENU_COMMS_GRD',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[_x,'MENU_COMMS_CAS_HELI',nil,nil,''] call BIS_fnc_addCommMenuItem;	
[_x,'MENU_COMMS_ARTI',nil,nil,''] call BIS_fnc_addCommMenuItem;	
} foreach Units GRPReq;

			private _headlessClients = entities "HeadlessClient_F";
			private _humanPlayers = allPlayers - _headlessClients;
			hcRemoveAllGroups player;  
			 {player hcRemoveGroup _x ;} forEach (allGroups select {side _x == west}); 
			 _GRPs = (allGroups select {(side _x == (side player)) && !(((units _x) select 0) in switchableUnits)}); 
			if (count _humanPlayers == 1 ) then {
			{player hcSetGroup [_x];} forEach _GRPs;
			}else{
			{TheCommander hcSetGroup [_x];} forEach _GRPs;
			};
			
{_x enableAI 'RADIOPROTOCOL';} foreach Units GRPReq;
if (markerText 'Revive_Handle' == 'Activate') then {{[_x] call AIS_System_fnc_loadAIS;} forEach Units GRPReq;};


{	{[_x] execVM "Scripts\LDTInit.sqf" ; } forEach Units GRPReq ;  } remoteExec ["call", 2];
{_x enableAI 'RADIOPROTOCOL'} foreach Units GRPReq;

// {
// [_x,[
// 	"<img size=2 color='#f37c00' image='\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa'/><t font='PuristaBold' color='#f37c00'>REPAIR Vehicles",
// {
// (_this select 0) playMove "AinvPknlMstpSnonWnonDnon_medic_1" ; 
// [(_this select 0)] execVM "Scripts\REPAIRVEH.sqf" ;
// },
// 	nil,
// 	9999,
// 	true,
// 	true,
// 	"",
// 	"_this distance _target < 5", // _target, _this, _originalTarget
// 	5,
// 	false,
// 	"",
// 	""
// ]] remoteExec ["addAction",0,true];
// } forEach (Units GRPReq select { (typeOf _x == F_Assault_Eng)  || (typeOf _x == "B_G_engineer_F")  || (typeOf _x == F_Recon_Eng)  || (typeOf _x == "B_CTRG_soldier_engineer_exp_F")} ) ;

// {
// [_x,[
// 	"<img size=2 color='#FFE258' image='Screens\FOBA\mg_ca.paa'/><t font='PuristaBold' color='#FFE258'>REARM Infantry",
// {
// (_this select 0) playMove "AinvPknlMstpSnonWnonDnon_medic_1" ; 
// [(_this select 0)] execVM "Scripts\REARM.sqf" ;
// },
// 	nil,
// 	9999,
// 	true,
// 	true,
// 	"",
// 	"_this distance _target < 5", // _target, _this, _originalTarget
// 	5,
// 	false,
// 	"",
// 	""
// ]] remoteExec ["addAction",0,true];
// } forEach (Units GRPReq select { (typeOf _x == F_Assault_Amm)  || (typeOf _x == "B_G_Soldier_A_F") } ) ;

// {
// [_x,[
// 	"<img size=2 color='#0bff00' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa'/><t font='PuristaBold' color='#0bff00'>HEAL Infantry",
// {
// (_this select 0) playMove "AinvPknlMstpSnonWnonDnon_medic_1" ; 
// [(_this select 0)] execVM "Scripts\HEAL.sqf" ;
// },
// 	nil,
// 	9999,
// 	true,
// 	true,
// 	"",
// 	"_this distance _target < 5", // _target, _this, _originalTarget
// 	5,
// 	false,
// 	"",
// 	""
// ]] remoteExec ["addAction",0,true];
// } forEach (Units GRPReq select { (typeOf _x == F_Recon_Med)  || (typeOf _x == F_Assault_Med)  || (typeOf _x == "B_G_medic_F")  || (typeOf _x == "B_CTRG_soldier_M_medic_F") } ) ;


{_x moveInAny _Veh} foreach units GRPReq;  


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





I1_WP_0 = GRPReq addWaypoint [_ARRVLOC, 0];
I1_WP_0 SetWaypointType "GETOUT";
I1_WP_0 setWaypointBehaviour "AWARE";



_CASD = createMarker [str _ARRVLOC, _ARRVLOC];
_CASD setMarkerType "mil_marker_noShadow";
_CASD setMarkerColor "colorBLUFOR" ;
_CASD setMarkerAlpha 0.7;
_CASD setMarkerText "Ground Support"; 


private _headlessClients = entities "HeadlessClient_F";
private _humanPlayers = allPlayers - _headlessClients;
hcRemoveAllGroups player;  
 {player hcRemoveGroup _x ;} forEach (allGroups select {side _x == west}); 
 _GRPs = (allGroups select {(side _x == (side player)) && !(((units _x) select 0) in switchableUnits)}); 
if (count _humanPlayers == 1 ) then {
{player hcSetGroup [_x];} forEach _GRPs;
}else{
{TheCommander hcSetGroup [_x];} forEach _GRPs;
};

sleep 60 ;




deleteMarker _CASD ; 

	}else{hint "Not enough Resources"; };