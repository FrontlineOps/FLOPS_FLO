/*
 * Function: FLO_fnc_virtualizationRestoreReplacementState
 */

params ["_groupData", "_savedData"];

private _replacementState = _savedData get "replacementState";
if !(_replacementState in ["", "REINFORCE", "AA_DEPLOY"]) then {
    throw format ["Saved virtual group %1 has unsupported replacement state %2", _groupData get "id", _replacementState];
};

// Hydration does not own the mission, commander, execution or AA state already
// restored by their owners. Transit transition helpers deliberately clear it.
{
    _groupData set [_x, _savedData get _x];
} forEach ["replacementState", "reinforcementTargetPos", "reinforcementRequestedObjective", "reinforcementDeliveryObjective"];

true
