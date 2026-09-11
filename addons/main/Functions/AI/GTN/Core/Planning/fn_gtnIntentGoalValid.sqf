params ["_state", "_params"];
private _intent = _state get "intent";
private _objectives = _state get "objectives";
private _id = _intent get "objectiveId";
if !(_id in _objectives) exitWith { false };
private _owner = (_objectives get _id) get "owner";
private _ownSide = _state get "ownSide";
if ((_intent get "kind") in ["GARRISON", "DEFEND", "CAP", "MINEFIELD"]) exitWith { _owner == _ownSide };
if ((_intent get "kind") == "CAPTURE") exitWith {
    private _stage = _intent get "stageObjective";
    _stage in _objectives && {((_objectives get _stage) get "owner") == _ownSide}
    && {((_objectives get _stage) get "integrated")} && {((_objectives get _stage) get "supplied")}
};
_owner != _ownSide
