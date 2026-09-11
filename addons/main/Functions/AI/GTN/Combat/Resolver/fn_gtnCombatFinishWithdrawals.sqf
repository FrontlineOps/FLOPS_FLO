/* Complete the commander's withdrawal orders in both physical and virtual play. */
params ["_commander"];
private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _arrived = [];
{
    if !(_x in _groups) then { continue };
    private _data = _groups get _x;
    if ((_data get "commanderOrder") != "MOVE" || {(_data get "orderMode") != "WITHDRAW"}) then { continue };
    if (_data get "inCombat" || {(_data get "missionLock") != ""}) then { continue };
    if ((_data get "position") distance2D (_data get "orderTargetPos") > 60) then { continue };
    _arrived pushBack _x;
} forEach (_commander get "_gtnTaskedGroups");
if (_arrived isNotEqualTo []) then {
    _commander call ["_releaseGroups", [_arrived, ""]];
    ["GTN_COMBAT", 3, format ["%1 completed withdrawals=%2", _commander get "_sideKey", count _arrived]] call FLO_fnc_log;
};
count _arrived
