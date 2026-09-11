/* World State owns graph-derived pressure and supply exposure once per decision cycle. */
params ["_commander"];
private _world = _commander get "_worldState";
private _objectives = _world get "_objectives";
private _ownSide = _commander get "_ownSide";
private _enemySide = _commander get "_enemySide";
private _picture = createHashMap;
private _network = FLO_Logistics_Networks get (_commander get "_sideKey");
private _routes = _network get "_supplyRouteInfo";
{
    private _id = _x;
    private _objective = _y;
    private _friendlyLinks = 0;
    private _hostileLinks = 0;
    private _exposedFlanks = 0;
    private _sources = [];
    {
        private _neighbor = _objectives get _x;
        if ((_neighbor get "owner") == _ownSide) then {
            _friendlyLinks = _friendlyLinks + 1;
            if (_neighbor get "integrated" && {_x in _routes}) then { _sources pushBack _x };
            {
                if (((_objectives get _x) get "owner") == _enemySide) then { _exposedFlanks = _exposedFlanks + 1 };
            } forEach ((_neighbor get "linkedObjectives") - [_id]);
        } else { _hostileLinks = _hostileLinks + 1 };
    } forEach (_objective get "linkedObjectives");
    private _enemy = _objective get "enemyCount";
    private _friendly = _objective get "friendlyCount";
    private _supplyExposure = parseNumber (_friendlyLinks <= 1);
    _objective set ["supplied", _id in _routes];
    if ((_objective get "owner") == _ownSide && {!(_id in _routes)}) then { _supplyExposure = _supplyExposure + 1 };
    private _freshness = if (_objective get "enemyStrengthKnown") then {
        (1 - (((diag_tickTime - (_objective get "enemyIntelTime")) max 0) / 240)) max 0
    } else { 0 };
    private _pressure = ((_enemy max 0) - _friendly) max 0;
    private _value = (_objective get "priority") + (count (_objective get "linkedObjectives") * 3);
    private _threat = _hostileLinks * 4 + _pressure * 2 + (20 * parseNumber (_objective get "underAttack")) + (12 * parseNumber (_objective get "contested"));
    _picture set [_id, createHashMapFromArray [
        ["value", _value], ["threat", _threat], ["pressure", _pressure],
        ["friendlyLinks", _friendlyLinks], ["enemyLinks", _hostileLinks],
        ["exposedFlanks", _exposedFlanks], ["supplyExposure", _supplyExposure],
        ["freshness", _freshness], ["sources", _sources],
        ["defenseScore", _value + _threat + _supplyExposure * 12],
        ["attackScore", _value + _friendlyLinks * 8 + _freshness * 10 - _hostileLinks * 4 - _exposedFlanks * 4 - _supplyExposure * 10 - _pressure]
    ]];
} forEach _objectives;
_world set ["_strategicPicture", _picture];
[_world, _commander get "_config"] call FLO_fnc_gtnBuildAirThreatPicture;
_picture
