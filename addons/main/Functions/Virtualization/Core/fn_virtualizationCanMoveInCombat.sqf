/* Movement permission never removes the combat overlay or incoming attrition. */
params ["_groupData"];
private _order = _groupData get "commanderOrder";
if (_order == "MOVE" && {(_groupData get "orderMode") == "WITHDRAW"}) exitWith { true };
_order == "ATTACK" && {diag_tickTime < (_groupData get "combatAdvanceUntil")}
