/* A decisive result creates movement, while both sides remain subject to fire. */
params ["_groups", "_eastRefs", "_westRefs", "_outcome", "_contactPos"];
private _withdrawn = 0;
private _advanced = 0;
{
    _x params ["_side", "_refs"];
    private _commander = [_side] call FLO_fnc_gtnGetCommanderBySide;
    if (isNil "_commander") then { continue };
    private _lost = (_outcome get "decisive") && {(_outcome get "winner") != _side};
    {
        private _id = _x select 0;
        if !(_id in _groups) then { continue };
        private _data = _groups get _id;
        private _depleted = (_data get "groupType") == "infantry" && {(_data get "unitCount") < 3} && {(_data get "commanderOrder") == "ATTACK"};
        if (_lost || {_depleted}) then {
            _data set ["combatAdvanceUntil", 0];
            if ([_commander, _id, _data, _contactPos] call FLO_fnc_gtnCombatWithdrawGroup) then { _withdrawn = _withdrawn + 1; };
        } else {
            if ((_outcome get "decisive") && {(_data get "commanderOrder") == "ATTACK"}) then {
                _data set ["combatAdvanceUntil", diag_tickTime + 60];
                _advanced = _advanced + 1;
            };
        };
    } forEach _refs;
} forEach [[east, _eastRefs], [west, _westRefs]];
if (_withdrawn > 0 || {_advanced > 0}) then {
    ["GTN_COMBAT", 3, format ["Combat maneuver: withdrew=%1 advancing=%2", _withdrawn, _advanced]] call FLO_fnc_log;
};
[_withdrawn, _advanced]
