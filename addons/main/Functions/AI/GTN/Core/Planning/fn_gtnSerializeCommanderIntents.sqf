params ["_commander", "_groups", "_objectives", "_capturedAt"];
private _intents = +(_commander get "_intents");
{
    _y set ["phaseElapsed", (_capturedAt - (_y get "phaseStartedAt")) max 0];
    _y deleteAt "phaseStartedAt";
} forEach _intents;
private _state = createHashMapFromArray [["gtnEnabled", true], ["nextIntentId", _commander get "_nextIntentId"], ["intents", _intents]];
[_state, _commander get "_sideKey", _groups, _objectives] call FLO_fnc_gtnValidateSavedIntents;
_state
