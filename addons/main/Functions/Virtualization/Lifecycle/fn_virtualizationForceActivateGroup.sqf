/* Strategic assets explicitly bypass the shared activation cap. */
params ["_groupId"];
[_groupId, true] call FLO_fnc_virtualizationTryActivateGroup
