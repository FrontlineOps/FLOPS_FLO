/* Queue the intent's candidate after rechecking capacity at the owning boundary. */
params ["_commander", "_objectiveId"];
private _result = createHashMapFromArray [["enqueuedFields", 0]];
private _candidates = _commander get "_minefieldCandidates";
if !(_objectiveId in _candidates) exitWith {_result};
private _sideKey = _commander get "_sideKey";
private _occupied = 0;
{if ((_y get "sideKey") == _sideKey) then {_occupied = _occupied + 1}} forEach FLO_Minefields;
{if ((_y get "sideKey") == _sideKey) then {_occupied = _occupied + 1}} forEach (FLO_MinefieldBuild get "jobs");
if (_occupied >= ((_commander get "_config") get "minefieldMaxFields")) exitWith {_result};
private _seed = [_objectiveId, _commander get "_ownSide", _commander] call FLO_fnc_minefieldBuildObjectiveCandidateSeed;
if (_seed isEqualTo createHashMap) exitWith {_result};
private _queued = [_seed] call FLO_fnc_minefieldQueueObjectiveBuild;
if (_queued get "queued") then {
    _result set ["enqueuedFields", 1];
    _candidates deleteAt _objectiveId;
    ["GTN", 3, format ["%1 committed minefield construction at %2", _sideKey, _objectiveId]] call FLO_fnc_log;
};
_result
