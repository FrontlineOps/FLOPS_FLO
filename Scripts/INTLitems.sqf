
_CNTR = _this select 0;
_RADS = _this select 1;

_INTSTF = [
"FlashDisk",
"FilesSecret",
"SmartPhone",
"MobilePhone",
"DocumentsSecret"
];

_INTENMALL = allUnits select {(side _x == east or side _x == independent) && getPos _x distance _CNTR < _RADS};
_INTENMCNT = count _INTENMALL;
_INTENMCNTNEW = round ( _INTENMCNT / 2 );
_INTENMALLNEW = _INTENMALL call BIS_fnc_arrayShuffle;
_INTENMSEL = _INTENMALLNEW select [0, _INTENMCNTNEW];

{_x addItem selectRandom _INTSTF ;} foreach _INTENMSEL;

	{ removeFromRemainsCollector [_x]; } foreach (allUnits select { side _x != west }) ;
	{ removeFromRemainsCollector [_x]; } foreach (vehicles select { side (driver  _x) != west }) ; 


sleep 3 ; 

	{ addToRemainsCollector [_x]; } foreach (allUnits select { side _x != west }) ;
	{ addToRemainsCollector [_x]; } foreach (vehicles select { side (driver  _x) != west }) ; 