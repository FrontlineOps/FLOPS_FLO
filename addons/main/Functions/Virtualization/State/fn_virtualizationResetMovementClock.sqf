/* Discards elapsed movement credit across a pause or movement-owner change. */
params ["_groupData"];

_groupData set ["lastMoveTime", diag_tickTime];
_groupData set ["virtualMoveCarryMeters", 0];

true
