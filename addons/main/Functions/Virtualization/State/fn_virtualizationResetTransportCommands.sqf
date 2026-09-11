/* Engine commands belong to the current physical carrier, not its mission. */
params ["_groupData"];
_groupData set ["transportLandCommandIssued", false];
_groupData set ["transportUnloadCommandIssued", false];
_groupData set ["transportUnloadIssuedAt", -1];
_groupData set ["transportUnloadElapsedOffset", 0];
true
