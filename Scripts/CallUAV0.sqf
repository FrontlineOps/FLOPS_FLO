

_Cost = 80;
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

_UAV = createMarker ["UAV", position player];
"UAV" setMarkerType "mil_marker_noShadow";
"UAV" setMarkerColor "colorBLUFOR" ;
"UAV" setMarkerAlpha 0.7;
"UAV" setMarkerText "UAV Drone";

playSound3D ["A3\dubbing_f\modules\supports\uav_request.ogg", player];
sleep 10;
playSound3D ["A3\Sounds_F\ambient\battlefield\battlefield_jet1.wss", player];

sleep 5;

_UAV = createVehicle ["B_UAV_01_F",(getMarkerpos "UAV"), [], 0, "FLY"];

_Group = createVehicleCrew _UAV; 
_VC = createGroup West;
{[_x] join _VC} forEach units _Group;


_UAV flyInHeight 100; 
_UAV disableAI "LIGHTS"; 
_UAV setPilotLight false;
_UAV setCollisionLight false; 


playSound3D ["A3\dubbing_f\modules\supports\uav_acknowledged.ogg", player];

sleep 5;
_GRPs = (allGroups select {side _x == west});
{player hcSetGroup [_x];} forEach _GRPs;
sleep 180;

deleteMarker "UAV";
         }else{hint "Not enough Resources"; };
