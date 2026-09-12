/* Returns AA coverage from maintained reports only; never reads hidden groups. */
params ["_worldState"];

private _state = call FLO_fnc_gtnAirDefenseGetState;
private _analyzer = call FLO_fnc_gtnCapabilityAnalyzer;
private _now = diag_tickTime;
private _threats = createHashMap;
private _reports = _worldState get "_airDefenseContacts";
{
    private _age = _now - (_y get "lastSeen");
    if (_age < 0 || {_age > (_worldState get "_airDefenseContactMaxAgeSeconds")}) then {
        _reports deleteAt _x;
        continue;
    };
    private _range = [_state get "unidentifiedMobileThreatRange", _state get "unidentifiedStaticThreatRange"] select ((_y get "groupType") == "static_aa");
    // Cover the maximum error of the 500 m report grid.
    _threats set [_x, [_y get "position", _range + 354, _y get "lastSeen"]];
} forEach +_reports;

{
    private _entry = _y;
    private _type = _entry get "groupType";
    if !(_type in ["static_aa", "mobile_aa"]) then { continue };
    private _seenAt = _entry get "lastSeen";
    private _age = _now - _seenAt;
    if (_age < 0 || {_age > (_worldState get "_knownEnemyGroupFreshSeconds")}) then { continue };
    if ((_entry get "confidence") < 0.55) then { continue };
    if (_x in _threats && {((_threats get _x) select 2) > _seenAt}) then { continue };
    private _range = [_state get "unidentifiedMobileThreatRange", _state get "unidentifiedStaticThreatRange"] select (_type == "static_aa");
    // Only observed class reports refine coverage; never inspect hidden composition.
    private _reportedRange = 0;
    { _reportedRange = _reportedRange max (_analyzer call ["_getAirDefenseRange", [_x]]) } forEach (_entry get "observedClasses");
    if (_reportedRange > 0) then { _range = _reportedRange };
    _threats set [_x, [_entry get "position", _range, _seenAt]];
} forEach ((_worldState call ["_getKnownEnemyGroupPicture", []]) get "groups");

values _threats
