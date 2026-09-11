#pragma hemtt ignore_variables ["_self"]
/* _revealIntelToUnits implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
params [
    "_position",
    ["_radius", 1500],
    "_unitsOrGroup",
    ["_enemySide", west]
];

if (isNil "_position" || _position isEqualTo [0,0,0]) exitWith {
    ["GTN", 2, "RevealIntel: Invalid position"] call FLO_fnc_log;
    0
};

// Get units to reveal to
private _revealTo = [];
if (_unitsOrGroup isEqualType grpNull) then {
    _revealTo = units _unitsOrGroup;
} else {
    if (_unitsOrGroup isEqualType objNull) then {
        _revealTo = [_unitsOrGroup];
    } else {
        _revealTo = _unitsOrGroup;
    };
};

if (_revealTo isEqualTo []) exitWith {
    ["GTN", 2, "RevealIntel: No units to reveal to"] call FLO_fnc_log;
    0
};

// Find enemies at position
private _nearEntities = _position nearEntities [["Man", "AllVehicles"], _radius];
private _enemies = _nearEntities select {
    alive _x &&
    (side _x == _enemySide || side group _x == _enemySide)
};

if (_enemies isEqualTo []) exitWith {
    ["GTN", 4, format["RevealIntel: No enemies found at position within %1m", _radius]] call FLO_fnc_log;
    0
};

// Reveal each enemy to all receiving units
{
    private _enemy = _x;
    {
        _x reveal [_enemy, 1];
    } forEach _revealTo;
} forEach _enemies;

["GTN", 3, format["RevealIntel: Revealed %1 enemies to %2 units at %3",
    count _enemies, count _revealTo, _position]] call FLO_fnc_log;

count _enemies
