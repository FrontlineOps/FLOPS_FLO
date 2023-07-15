

_Cost = 5;
_mrkrs = allMapMarkers select {markerColor _x == "Color2_FD_F"};
_mrkr = _mrkrs select 0;
_Money = parseNumber (markerText _mrkr) ;  
if (_Money >= _Cost) then {
_NewMoney = _Money - _Cost; 
_mrkr setMarkerText str _NewMoney;
[   
    _mrkr,   
    {   
        private _mrkr = _this;   
   
        // create marker data   
        private _markerData = [ALiVE_sys_marker,"addStandardMarker", [_mrkr,"west"]] call ALiVE_fnc_marker;   
        [ALiVE_sys_marker,"addMarkerToStore", [_mrkr,_markerData]] call ALiVE_fnc_marker;   
    }   
] remoteExecCall ["call", 2];

titleText ["Combat Crew Dispatching . . .", "BLACK IN",9999];

sleep 1;
_nearVehs = nearestObjects [Player,["Air","Ship","LandVehicle"],20] select 0; 
VFCC = createVehicleCrew _nearVehs; 
_Group = createGroup West;
{[_x] join _Group} forEach units VFCC;

VFCG = gunner _nearVehs;
VFCD = driver _nearVehs;


{removeAllItems _x;} foreach units _Group; 
{_x linkItem "B_UavTerminal";} foreach units _Group; 
if (isClass (configfile >> 'CfgVehicles' >> 'Box_cTab_items') == true ) then {{ _x addItem 'ItemAndroid'; _x addItem 'ItemcTabHCam'; _x addItem 'ItemcTab';} foreach units _Group; }; 

sleep 1 ;
_selection=[];  
_selection append (allGroups select {side _x == west}); 
{player hcSetGroup [_x]} foreach _selection;

titleText ["Combat Crew Dispatching . . .", "BLACK IN",1];

}else{hint "Not Enough Recources";};

