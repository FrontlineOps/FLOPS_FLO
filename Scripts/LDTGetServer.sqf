



_UNTTypeName = str UNTTypeClass ;
_missionTag = missionName;
_missionTag = [_missionTag] call BIS_fnc_filterString;
private _LoadOutName = _missionTag + _UNTTypeName;

_LoadOutNameVal = profileNamespace getVariable _LoadOutName;

TheCommander setUnitLoadout _LoadOutNameVal;
