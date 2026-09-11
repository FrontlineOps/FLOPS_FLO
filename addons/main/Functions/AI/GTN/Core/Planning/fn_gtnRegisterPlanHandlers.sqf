/* Intent owns durable orders across replans; executor owns only phase callbacks. */
params ["_executor"];
{
    _executor call ["_registerHandler", [_x, createHashMapFromArray [
        ["start", {params ["_context"]; (_context get "data") set ["phaseCompleted", false]; true}],
        ["poll", {_this call FLO_fnc_gtnPollIntentTask}],
        ["cancel", {}], ["finish", {}]
    ]]];
} forEach ["prim_intent_scout", "prim_intent_muster", "prim_intent_assemble", "prim_intent_assault", "prim_intent_secure", "prim_intent_dispatch", "prim_intent_arrive", "prim_intent_request"];
_executor call ["_registerHandler", ["prim_intent_confirm", createHashMapFromArray [
    ["start", {params ["_context"]; (_context get "data") set ["phaseCompleted", false]; true}],
    ["poll", {
        params ["_context"];
        private _commander = _context get "commander";
        private _id = (_context get "params") select 0;
        private _state = [_commander get "_worldState", _id] call FLO_fnc_gtnIntentSnapshot;
        if !([_state] call FLO_fnc_gtnCanExploitOpening) exitWith {_context set ["status", "FAILED"]};
        [_commander, (_commander get "_intents") get _id, "ASSAULT"] call FLO_fnc_gtnSetIntentPhase;
        (_context get "data") set ["phaseCompleted", true];
    }],
    ["cancel", {}], ["finish", {}]
]]];
true
