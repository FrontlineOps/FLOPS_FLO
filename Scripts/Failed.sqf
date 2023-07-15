_allFOBMarks = allMapMarkers select {markerType _x == "b_installation" && markerText _x == "FOB"};  
if (count _allFOBMarks == 0 ) then {
	
	playMusic "EventTrack02_F_Curator";

	
 hint "_You Lost the Last FOB_";
sleep 4;	
 hint "_Emergency FOB Activated for The Commander_";



[ TheCommander,
"<img size=2 color='#7CC2FF' image='Screens\FOBA\b_hq.paa'/><t font='PuristaBold' color='#7CC2FF'>Emergency FOB",
"Screens\FOBA\b_hq.paa",
"Screens\FOBA\b_hq.paa",
"player == TheCommander",       
"_caller distance _target < 40",  
{},
{},
{
execVM "Scripts\SupplyDrop_FOB.sqf";
},
{},
[],
5,
2,
false,
false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];   

};