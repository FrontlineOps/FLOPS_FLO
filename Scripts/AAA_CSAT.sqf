params ["_trigger"];
private _triggerPos = getPos _trigger;
private _AGGRSCORE = parseNumber (markerText ((allMapMarkers select {markerColor _x == "Color6_FD_F"}) #0));

// Building position collection (fixed)
private _Buildings = nearestObjects [_triggerPos, ["House", "Strategic"], 70];
private _allPositions = [];
{
    private _bldgPos = _x buildingPos -1;
    if (count _bldgPos > 0) then {
        _allPositions append _bldgPos;
    };
} forEach _Buildings;

// Fallback if no positions found
if (_allPositions isEqualTo []) then {
    _allPositions = [_triggerPos];
};

// Spawn garrison units with position safety check
_spawnGarrison = {
    params ["_position", "_disableAI"];
    if (count _position == 0) then {
        _position = [_triggerPos];
    };
    private _grp = [selectRandom _position, east, [selectRandom (FLO_configCache get "units")]] call BIS_fnc_spawnGroup;
    if (_disableAI) then { (units _grp # 0) disableAI "PATH" };
    _grp deleteGroupWhenEmpty true;
    _grp
};

// Spawn patrol function
_spawnPatrol = {
    params ["_center", "_radius", "_unitCount"];
    private _pos = _center getPos [_radius, random 360];
    private _grp = [_pos, east, [selectRandom (FLO_configCache get "units"), selectRandom (FLO_configCache get "units")]] call BIS_fnc_spawnGroup;
    [_grp, _pos, _radius] call BIS_fnc_taskPatrol;
    _grp deleteGroupWhenEmpty true;
    _grp
};

// Base spawns (always present)
for "_i" from 1 to 4 do {
    private _disableAI = _i in [1,2,4];
    [_allPositions, _disableAI] call _spawnGarrison;
};

[_triggerPos, 20, 50] call _spawnPatrol;

// Aggression-based spawning
switch (true) do {
    case (_AGGRSCORE > 10): {
        [_triggerPos, 20, 200] call _spawnPatrol;
        for "_i" from 1 to 2 do {
            [_allPositions, _i == 2] call _spawnGarrison;
        };
    };
    case (_AGGRSCORE > 5): {
        [_triggerPos, 20, 150] call _spawnPatrol;
        for "_i" from 1 to 2 do {
            [_allPositions, _i == 2] call _spawnGarrison;
        };
    };
};

[_trigger, 100] execVM "Scripts\INTLitems.sqf";