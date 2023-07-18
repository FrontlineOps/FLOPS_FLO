

private _LoadOutName = missionName +"_"+ UNTTypeClass;

_LoadOutNameVal = profileNamespace getVariable _LoadOutName;

if !(isNil "_LoadOutNameVal") then {TheCommander setUnitLoadout _LoadOutNameVal;};
