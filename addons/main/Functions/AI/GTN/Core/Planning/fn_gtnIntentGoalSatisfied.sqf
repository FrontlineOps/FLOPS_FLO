params ["_state", "_params"];
private _intent = _state get "intent";
if ((_intent get "phase") != "COMPLETE") exitWith { false };
if ((_intent get "kind") != "CAPTURE") exitWith { true };
private _objective = (_state get "objectives") get (_intent get "objectiveId");
(_objective get "owner") == (_state get "ownSide") && {_objective get "integrated"}
