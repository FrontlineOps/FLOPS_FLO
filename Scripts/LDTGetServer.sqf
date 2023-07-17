

private _LoadOutName = missionName +"_"+ UNTTypeClass;

_LoadOutNameVal = profileNamespace getVariable _LoadOutName;

if !(isnil "_LoadOutNameVal") then {TheCommander setUnitLoadout _LoadOutNameVal;};
