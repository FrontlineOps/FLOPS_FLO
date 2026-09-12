/* Share fresh, identified World State reports with an assigned aircraft crew. */
params ["_position", "_radius", "_unitsOrGroup", "_worldState"];
private _receivers = if (_unitsOrGroup isEqualType grpNull) then {units _unitsOrGroup} else {
    if (_unitsOrGroup isEqualType objNull) then {[_unitsOrGroup]} else {_unitsOrGroup}
};
private _targets = createHashMap;
private _now = diag_tickTime;
{
    _x params ["_reportedPos", "_seenAt", "_strength", "_class", "_confidence", ["_source", objNull]];
    if (isNull _source || {!alive _source} || {_confidence <= 0}) then {continue};
    private _age = _now - _seenAt;
    if (_age < 0 || {_age > (_worldState get "_knownEnemyGroupFreshSeconds")}) then {continue};
    if ((_reportedPos distance2D _position) > _radius) then {continue};
    private _key = netId _source;
    private _previous = _targets getOrDefault [_key, [_source, 0]];
    _targets set [_key, [_source, ((_confidence * 4) min 1) max (_previous select 1)]];
} forEach ((_worldState get "_enemyIntel") get "contactReports");
{
    _y params ["_target", "_knowledge"];
    {if (alive _x) then {_x reveal [_target, _knowledge]}} forEach _receivers;
} forEach _targets;
count _targets
