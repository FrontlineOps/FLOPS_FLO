//TODO - This entire function could be replaced with BIS_fnc_getConfigEntry
//Get an Objects attribute value
params[ "_cfg", "_type", "_default" ];

if (isNil "_cfg" || {_cfg isEqualTo configNull}) exitwith {_default};
private _data = _cfg call BIS_fnc_getCfgData;
_data = [_data,_default] select (isNil "_data");
if (_type isEqualTo "BOOL") exitwith {[true,false] select (_data isEqualTo 0 || {_data IsEqualType true && {!_data}})};
_data;
