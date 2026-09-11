params ["_commander", "_state", "_groups", "_objectives"];
[_state, _commander get "_sideKey", _groups, _objectives] call FLO_fnc_gtnValidateSavedIntents;
if (count (_commander get "_intents") > 0 || {count (_commander get "_tracks") > 0}) then { throw "GTN cannot restore over active intents" };
private _intents = +(_state get "intents");
{
    _y set ["phaseStartedAt", diag_tickTime - (_y get "phaseElapsed")];
    _y deleteAt "phaseElapsed";
} forEach _intents;
_commander set ["_nextIntentId", _state get "nextIntentId"];
_commander set ["_intents", _intents];
{
    _commander call ["_taskGroups", [_y get "groupIds"]];
    [_commander, _y] call FLO_fnc_gtnCreateIntentTrack;
} forEach _intents;
["GTN", 3, format ["%1 restored %2 durable intents; runtime plans will be rebuilt", _commander get "_sideKey", count _intents]] call FLO_fnc_log;
true
