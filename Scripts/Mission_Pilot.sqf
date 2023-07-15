
_thisPilotsTrigger = _this select 0;

_mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
_mrkr = _mrkrs select 0;
_DANSCORE = parseNumber (markerText _mrkr) ;  

_anim =  selectRandom [
"Acts_AidlPsitMstpSsurWnonDnon01",
"Acts_AidlPsitMstpSsurWnonDnon02",
"Acts_AidlPsitMstpSsurWnonDnon03",
"Acts_AidlPsitMstpSsurWnonDnon04",
"Acts_AidlPsitMstpSsurWnonDnon05"
];


_CRT = [
"Box_IND_WpsSpecial_F",
"Box_East_WpsSpecial_F",
"Box_IND_Support_F",
"Box_East_Support_F",
"Box_CSAT_Equip_F",
"Box_AAF_Equip_F",
"Box_East_WpsLaunch_F",
"Box_IND_WpsLaunch_F",
"Box_East_AmmoOrd_F",
"Box_East_Ammo_F",
"Box_IND_Ammo_F",
"Box_IND_AmmoOrd_F",
"Box_East_Wps_F",
"Box_IND_Wps_F"
];


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

_allMarks = allMapMarkers select {(markerType _x == "b_installation") or (markerType _x == "o_installation") or (markerType _x == "n_installation") or (markerType _x == "o_support") or (markerType _x == "n_support") or  (markerType _x == "loc_Power") or  (markerType _x == "loc_Ruin")};  
_NOSHs = [] ;
{
_NOSH = nearestObjects [getMarkerPos _x , ["HOUSE"], 400] ; 
_NOSHs append _NOSH ;	
} forEach _allMarks ;

_SHs = nearestObjects [_thisPilotsTrigger , ["HOUSE"], 7000] select {count (_x buildingPos -1) > 2};
_SH = _SHs - _NOSHs ;


_HQB = _SH select 0 ;
_dir = getDirVisual _HQB;

[ "Intel_CS_01", (selectRandom (_HQB buildingPos -1)), [0,0,0], _dir, false, false, true ] call LARs_fnc_spawnComp; 
_V = createVehicle [(selectRandom _CRT), (selectRandom (_HQB buildingPos -1)), [], 15, "NONE"]; 
_V = createVehicle [(selectRandom _CRT), (selectRandom (_HQB buildingPos -1)), [], 15, "NONE"]; 
_G = [ (selectRandom (_HQB buildingPos -1)), East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units _G) select 0) disableAI "PATH"; 
_G = [ (selectRandom (_HQB buildingPos -1)), East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
((units _G) select 0) disableAI "PATH";   
_G = [ (selectRandom (_HQB buildingPos -1)), East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 
_G = [ (selectRandom (_HQB buildingPos -1)), East,[selectRandom East_Units]] call BIS_fnc_spawnGroup; 


PRL = [getPos _HQB, East, [selectRandom East_Units, selectRandom East_Units, selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, getPos _HQB, 300] call BIS_fnc_taskPatrol;

if (_DANSCORE > 10) then {
PRL = [getPos _HQB, East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, getPos _HQB, 300] call BIS_fnc_taskPatrol;
};

//////Gaurds/////////////////////////////////////////////////////////////////////////////////////////

_poss = [(getpos _HQB), 30, 50, 5, 1 , 0] call BIS_fnc_findSafePos; 
G = [_poss, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
((units G) select 0) disableAI "PATH"; 


_poss = [(getpos _HQB), 30, 50, 5, 1 , 0] call BIS_fnc_findSafePos; 
G = [_poss, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  


if (_DANSCORE > 5) then {
_poss = [(getpos _HQB), 30, 50, 5, 1 , 0] call BIS_fnc_findSafePos; 
G = [_poss, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  
((units G) select 0) disableAI "PATH"; 
}; 

if (_DANSCORE > 10) then {
_poss = [(getpos _HQB), 30, 50, 5, 1 , 0] call BIS_fnc_findSafePos; 
G = [_poss, East,[selectRandom East_Units]] call BIS_fnc_spawnGroup;  

}; 

//////GROUPS/////////////////////////////////////////////////////////////////////////////////////////

if (_DANSCORE > 5) then {
PRL = [_HQB getPos [(300 +(random 1000)), (0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, getPos _HQB, 300] call BIS_fnc_taskPatrol;
};

if (_DANSCORE > 10) then {
PRL = [_SHB getPos [(300 +(random 1000)), (0 + (random 360))], East, [selectRandom East_Units, selectRandom East_Units]] call BIS_fnc_spawnGroup;
[PRL, getPos _SHB, 1000] call BIS_fnc_taskPatrol;
};


sleep 2 ;

