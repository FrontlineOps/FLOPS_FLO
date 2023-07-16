




// private _UNTTypeName = str _UNTType ;
// private _missionTag = missionName;
// _missionTag = [_missionTag] call BIS_fnc_filterString;
private _LoadOutName = missionName +"_"+ _UNTType;

_LoadOutNameVal = profileNamespace getVariable _LoadOutName;

TheCommander setUnitLoadout _LoadOutNameVal;
