/* Current campaign restoration; called in Phase 5 ownership order. */
params ["_savedData"];

// Restore the current dual-commander state.
private _liveGtnManager = call FLO_fnc_gtnGetResourceManager;
if (isNil "_liveGtnManager") then {
    FLO_GTN_ResourceManager = [] call FLO_fnc_gtnResourceManager;
} else {
    FLO_GTN_ResourceManager = call FLO_fnc_gtnResourceManagerProxy;
};

private _cmd = _savedData get "aiCommanders";
private _commanderKeys = keys _cmd;
private _missingCommanderKeys = ["EAST", "WEST"] select {!(_x in _cmd)};
if (_missingCommanderKeys isNotEqualTo []) then {
    throw format ["Current save has invalid commander keys %1", _commanderKeys];
};
private _eastState = _cmd get "EAST";
private _westState = _cmd get "WEST";
{
    _x params ["_sideKey", "_state"];
    if !(_state isEqualType createHashMap) then {
        throw format ["Saved %1 commander state has invalid type %2", _sideKey, typeName _state];
    };
    if !("gtnEnabled" in _state) then {
        throw format ["Saved %1 commander state has invalid fields %2", _sideKey, keys _state];
    };
    if !((_state get "gtnEnabled") isEqualType true) then {
        throw format ["Saved %1 commander gtnEnabled has invalid type", _sideKey];
    };
} forEach [["EAST", _eastState], ["WEST", _westState]];
private _gtnWasEnabled = (_eastState get "gtnEnabled") || (_westState get "gtnEnabled");

if (_gtnWasEnabled) then {
    FLO_GTN_ResourceManager call ["_initializeGTN", []];
};
private _commanders = FLO_GTN_ResourceManager call ["_getAllCommanders", []];
{
    private _state = _cmd get _x;
    if (_state get "gtnEnabled") then {
        if !(_x in _commanders) then { throw format ["GTN saved side %1 was not initialized", _x] };
        [_commanders get _x, _state, call FLO_fnc_virtualizationGetGroupMap, FLO_Objectives] call FLO_fnc_gtnRestoreCommanderIntents;
    };
} forEach ["EAST", "WEST"];


["INIT", 3, "Dual GTN state restored"] call FLO_fnc_log;

true
