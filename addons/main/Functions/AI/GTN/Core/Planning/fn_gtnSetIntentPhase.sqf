/* The intent owns durable phase transitions; planner callbacks remain transient. */
params ["_commander", "_intent", "_phase"];
private _old = _intent get "phase";
if (_old == _phase) exitWith { false };
_intent set ["phase", _phase];
_intent set ["phaseStartedAt", diag_tickTime];
["GTN", 3, format ["%1 intent %2 objective=%3 %4 -> %5 groups=%6", _commander get "_sideKey", _intent get "id", _intent get "objectiveId", _old, _phase, count (_intent get "groupIds")]] call FLO_fnc_log;
true
