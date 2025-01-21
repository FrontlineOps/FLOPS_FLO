//Get an Objects attribute value
params[ "_cfg", "_type", "_default" ];

if (isNil "_cfg" || {_cfg isEqualTo configNull}) exitWith {_default};
private _data = _cfg call BIS_fnc_getCfgData;

if (isNil "_data") exitWith {_default};

private _result = switch (_type) do {
    case "BOOL": {
        if (_data isEqualType true) exitWith {_data};
        if (_data isEqualType 0) exitWith {_data > 0};
        if (_data isEqualType "") exitWith {_data == "true"};
        _default
    };
    case "NUM": {
        if (_data isEqualType 0) exitWith {_data};
        if (_data isEqualType "") exitWith {parseNumber _data};
        _default
    };
    case "TXT": {
        if (_data isEqualType "") exitWith {_data};
        if (_data isEqualType 0) exitWith {str _data};
        _default
    };
    case "ARRAY": {
        if (_data isEqualType []) exitWith {_data};
        _default
    };
    default {_data};
};

if (isNil "_result") exitWith {_default};
_result
