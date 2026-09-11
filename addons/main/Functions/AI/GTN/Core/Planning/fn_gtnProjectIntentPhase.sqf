params ["_state", "_phase"];
private _intent = _state get "intent";
_intent set ["phase", _phase];
if (_phase == "COMPLETE" && {(_intent get "kind") == "CAPTURE"}) then {
    private _objective = (_state get "objectives") get (_intent get "objectiveId");
    _objective set ["owner", _state get "ownSide"];
    _objective set ["integrated", true];
};
true
