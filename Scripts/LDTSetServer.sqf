



_UNTTypeName = str UNTTypeClass ;
_missionTag = missionName;
_missionTag = [_missionTag] call BIS_fnc_filterString;
private _LoadOutName = _missionTag + _UNTTypeName;

TheCommander setVariable ["_NEW_Saved_Loadout",getUnitLoadout TheCommander];

profileNamespace setVariable [_LoadOutName, (TheCommander getVariable ["_NEW_Saved_Loadout",[]])];
saveProfileNamespace;
