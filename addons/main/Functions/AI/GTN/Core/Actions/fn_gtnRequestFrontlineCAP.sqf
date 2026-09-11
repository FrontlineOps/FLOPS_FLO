/* Authorize CAP for the selected objective using maintained air threat. */
params ["_commander", "_objectiveId"];
private _result = createHashMapFromArray [["requestedCount", 0], ["selectedObjective", ""], ["selectedScore", 0]];
private _world = _commander get "_worldState";
private _picture = _world get "_airThreatPicture";
if !(_objectiveId in _picture) exitWith {_result};
private _config = _commander get "_config";
private _score = _picture get _objectiveId;
if (_score < (_config get "frontlineCAPMinThreatScore")) exitWith {_result};
private _locks = _commander get "_frontlineCAPLocks";
if (diag_tickTime < (_locks getOrDefault [_objectiveId, -1])) exitWith {_result};
if !(_world call ["_isAssetAvailable", ["cap"]]) exitWith {_result};
private _objective = (_world get "_objectives") get _objectiveId;
if ((_objective get "owner") != (_commander get "_ownSide")) exitWith {_result};
if (_commander call ["_requestCAP", [_objective get "position"]]) then {
    _locks set [_objectiveId, diag_tickTime + (_config get "frontlineCAPObjectiveLockSeconds")];
    _result set ["requestedCount", 1];
    _result set ["selectedObjective", _objectiveId];
    _result set ["selectedScore", _score];
    ["GTN", 3, format ["%1 authorized CAP at %2 (threat=%3)", _commander get "_sideKey", _objectiveId, _score]] call FLO_fnc_log;
};
_result
