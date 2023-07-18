

private _LoadOutName = missionName +"_"+ UNTTypeClass;

_LoadOutNameVal = profileNamespace getVariable _LoadOutName;

TheCommander setUnitLoadout _LoadOutNameVal;
