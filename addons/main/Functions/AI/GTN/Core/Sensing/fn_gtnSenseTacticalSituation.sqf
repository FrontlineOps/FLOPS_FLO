#pragma hemtt ignore_variables ["_self"]
/* _senseTacticalSituation implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
private _situation = _self get "_tacticalSituation";
private _objectives = _self get "_objectives";
private _forces = _self get "_ownForces";
private _intel = _self get "_enemyIntel";
private _ownSide = _self get "_ownSide";
private _enemySide = _self get "_enemySide";

// Time of day
private _hour = dayTime;
private _timeOfDay = switch (true) do {
    case (_hour >= 6 && _hour < 18): { "DAY" };
    case (_hour >= 18 && _hour < 21): { "DUSK" };
    case (_hour >= 21 || _hour < 5): { "NIGHT" };
    default { "DAWN" };
};
_situation set ["timeOfDay", _timeOfDay];

// Weather
private _overcast = overcast;
private _rain = rain;
private _weather = switch (true) do {
    case (_rain > 0.5): { "RAIN" };
    case (_overcast > 0.7): { "OVERCAST" };
    case (_overcast > 0.3): { "CLOUDY" };
    default { "CLEAR" };
};
_situation set ["weather", _weather];

// Overall threat
_situation set ["overallThreat", _intel get "threatLevel"];

// Calculate momentum (-100 to +100)
private _ownedByUs = 0;
private _ownedByEnemy = 0;
private _contested = 0;
{
    private _obj = _objectives get _x;
    if ((_obj get "owner") == _ownSide) then { _ownedByUs = _ownedByUs + 1 };
    if ((_obj get "owner") == _enemySide) then { _ownedByEnemy = _ownedByEnemy + 1 };
    if (_obj get "contested") then { _contested = _contested + 1 };
} forEach (keys _objectives);

private _totalObj = count (keys _objectives) max 1;
private _momentum = ((_ownedByUs - _ownedByEnemy) / _totalObj) * 100;
_situation set ["momentum", _momentum];

// Initiative holder
private _initiative = switch (true) do {
    case (_momentum > 30): { "OWN" };
    case (_momentum < -30): { "ENEMY" };
    default { "NEUTRAL" };
};
_situation set ["initiativeHolder", _initiative];

_self set ["_tacticalSituation", _situation];
_situation
