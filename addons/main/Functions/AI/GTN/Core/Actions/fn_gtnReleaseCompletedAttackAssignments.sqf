/* Releases direct ATTACK groups whose objective is missing or no longer enemy-held. */
params ["_cmdr"];
[_cmdr] call FLO_fnc_gtnCombatFinishWithdrawals;

private _metrics = createHashMapFromArray [
    ["taskedCount", 0],
    ["releasedCount", 0],
    ["withdrawnCount", 0]
];

private _attackGroupIds = +((_cmdr get "_objectiveAssignmentCache") get "attackGroupIds");
_metrics set ["taskedCount", count _attackGroupIds];
if (_attackGroupIds isEqualTo []) exitWith { _metrics };

private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _objectives = (_cmdr get "_worldState") call ["_getObjectives", []];
private _enemySide = _cmdr get "_enemySide";
private _releaseIds = [];
private _withdrawalAttempts = 0;
{
    private _groupData = _groups get _x;
    if (isNil "_groupData") then { continue };
    if ((_groupData get "commanderOrder") != "ATTACK") then { continue };

    private _objectiveId = _groupData get "attackObjective";
    if (_objectiveId == "") then {
        ["GTN", 1, format ["ATTACK group %1 has no objective", _x]] call FLO_fnc_log;
        throw format ["ATTACK group %1 has no objective", _x];
    };
    if !(_objectiveId in _objectives) then {
        private _message = format ["ATTACK group %1 references missing objective %2", _x, _objectiveId];
        ["GTN", 1, _message] call FLO_fnc_log;
        throw _message;
    };

    private _objective = _objectives get _objectiveId;
    if ((_objective get "owner") != _enemySide) then {
        _releaseIds pushBack _x;
    } else {
        if ((_groupData get "groupType") == "infantry" && {(_groupData get "unitCount") < 3} && {!(_groupData get "inCombat")} && {_withdrawalAttempts < 4}) then {
            _withdrawalAttempts = _withdrawalAttempts + 1;
            if ([_cmdr, _x, _groupData, _objective get "position"] call FLO_fnc_gtnCombatWithdrawGroup) then {
                _metrics set ["withdrawnCount", (_metrics get "withdrawnCount") + 1];
            };
        };
    };
} forEach _attackGroupIds;

{
    private _groupData = _groups get _x;
    [_groupData] call FLO_fnc_virtualizationClearCommanderOrder;
    [_groupData] call FLO_fnc_virtualizationClearMissionLock;
    if !([_x, [], true, "GTN_ATTACK_RELEASE"] call FLO_fnc_updateVirtualGroupWaypoints) then {
        ["GTN", 2, format ["Route clear was rejected while releasing completed ATTACK group %1", _x]] call FLO_fnc_log;
    };
} forEach _releaseIds;

if (_releaseIds isNotEqualTo []) then {
    _cmdr call ["_releaseGroups", [_releaseIds, ""]];
    _metrics set ["releasedCount", count _releaseIds];
    ["GTN", 3, format ["%1 released %2 completed direct attack assignments", _cmdr get "_sideKey", count _releaseIds]] call FLO_fnc_log;
};

if ((_metrics get "withdrawnCount") > 0) then {
    ["GTN", 3, format ["%1 withdrew %2 depleted attack groups to friendly cover", _cmdr get "_sideKey", _metrics get "withdrawnCount"]] call FLO_fnc_log;
};
_metrics
