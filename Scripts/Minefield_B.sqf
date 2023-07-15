
 _allAPMineMarks = allMapMarkers select {markerType _x == "mil_triangle" && markerColor _x == "colorBLUFOR" && markerText _x == "AP MineField"};  

	 {
_Mines = [ "APERSMine", "APERSBoundingMine" ]; 
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];
_mine = createMine [selectRandom _Mines,  getMarkerpos _x, [],200];



} forEach _allAPMineMarks ;

 _allATMineMarks = allMapMarkers select {markerType _x == "mil_triangle" && markerColor _x == "colorBLUFOR" && markerText _x == "AT MineField"};  

	 {
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];
_mine = createMine ["ATMine",  getMarkerpos _x, [], 200];


} forEach _allATMineMarks ;
