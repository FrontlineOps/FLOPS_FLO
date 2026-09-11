/* World State aggregates reported air threats for strategic selection and CAP authorization. */
params ["_world", "_config"];
private _now = diag_tickTime;
private _fresh = _config get "frontlineCAPContactFreshSeconds";
private _range = _config get "frontlineCAPContactRadiusMeters";
private _contacts = (((_world get "_enemyIntel") get "contactReports") select {
    _now - (_x select 1) <= _fresh && {(_x select 3) isKindOf ["Air", configFile >> "CfgVehicles"]}
});
private _picture = createHashMap;
{
    private _objective = _y;
    if ((_objective get "owner") != (_world get "_ownSide")) then {continue};
    private _frontline = (((_world get "_strategicPicture") get _x) get "enemyLinks") > 0;
    if !(_frontline || {_objective get "underAttack"} || {_objective get "contested"}) then {continue};
    private _score = 0;
    private _count = 0;
    {
        _x params ["_pos", "_time", "_strength", "_type", "_confidence"];
        private _distance = (_objective get "position") distance2D _pos;
        if (_distance > _range) then {continue};
        _count = _count + 1;
        _score = _score + (((_strength max 1) * 12) + ((_confidence max 0) * 25))
            * linearConversion [0, _fresh, _now - _time, 1, 0.2, true]
            * linearConversion [0, _range, _distance, 1, 0.25, true];
    } forEach _contacts;
    if (_count > 0) then {
        _picture set [_x, _score + (_objective get "priority") * 0.4 + ((_objective get "enemyCount") max 0) * 6
            + 25 * parseNumber (_objective get "underAttack") + 20 * parseNumber (_objective get "contested") + 10 * parseNumber _frontline];
    };
} forEach (_world get "_objectives");
_world set ["_airThreatPicture", _picture];
_picture
