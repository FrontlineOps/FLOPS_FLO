//Get an Objects attribute value
params[ "_cfg", "_type", "_default" ];

if (isNil "_cfg" || {_cfg isEqualTo configNull}) exitwith {_default};
private _data = _cfg call BIS_fnc_getCfgData;
[_data,_default] select (isNil "_data");
