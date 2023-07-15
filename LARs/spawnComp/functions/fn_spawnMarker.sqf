
//Spawns a marker from a composition

params[ "_cfg" ];

private _position = getArray( _cfg >> "position" );
_position = [ objNull, _position ] call LARs_fnc_setPositionandRotation;
private _name = getText( _cfg >> "name" );
private _text = getText( _cfg >> "text" );
private _markerType = getText( _cfg >> "markerType" );
private _type = getText( _cfg >> "type" );
private _colorName = getText( _cfg >> "colorName" );
private _alpha = [ ( _cfg >> "alpha" ), "NUM", 1 ] call LARs_fnc_getCfgValue;

private _fill = getText( _cfg >> "fillName" );
private _sizeA = getNumber( _cfg >> "a" );
private _sizeB = getNumber( _cfg >> "b" );
private _angle = getNumber( _cfg >> "angle" );
private _id = getNumber( _cfg >> "id" );


private _mrk = createMarker[ _name, _position ];

_mrk setMarkerDir _angle;
_mrk setMarkerText _text;
_mrk setMarkerSize [ _sizeA, _sizeB ];
if !( _markerType isEqualTo "" ) then {
	_mrk setMarkerShape _markerType;
	if !( _fill isEqualTo "" ) then {
		_mrk setMarkerBrush _fill;
	};
}else{
	_mrk setMarkerShape "ICON";
	_mrk setMarkerType _type;
};
if !( _colorName isEqualTo "" ) then {
	_mrk setMarkerColor _colorName;
};
_mrk setMarkerAlpha _alpha;

_mrk
