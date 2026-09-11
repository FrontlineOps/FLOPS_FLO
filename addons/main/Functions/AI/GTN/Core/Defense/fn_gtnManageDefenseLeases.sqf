#pragma hemtt ignore_variables ["_self"]
/* _manageDefenseLeases implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
private _tasked = +(_self get "_gtnTaskedGroups");
private _metrics = createHashMapFromArray [
    ["taskedCount", count _tasked],
    ["leaseIssuedCount", 0],
    ["holdRefreshCount", 0],
    ["lostObjectiveReleaseCount", 0],
    ["invalidObjectiveCount", 0],
    ["trimmedExcess", 0],
    ["releasedCount", 0]
];
if (_tasked isEqualTo []) exitWith { _metrics };

private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _ownSide = _self get "_ownSide";
private _ws = _self get "_worldState";
private _objectives = _ws call ["_getObjectives", []];
private _leaseSeconds = (_self get "_config") get "defenseLeaseSeconds";
private _now = diag_tickTime;
private _releaseIds = [];

{
    private _groupId = _x;
    private _gData = _groups get _groupId;

    if (isNil "_gData") then {
        _releaseIds pushBack _groupId;
        continue;
    };
    if ((_gData get "side") != _ownSide) then { continue };
    if ((_gData get "commanderIntent") != "") then { continue };
    if ((_gData get "groupType") == "static_aa") then { continue };
    if ((_gData get "commanderOrder") != "DEFEND") then { continue };
    if (_gData getOrDefault ["inCombat", false]) then { continue };

    private _objId = _gData get "defendObjective";
    if !(_objId in _objectives) then {
        _metrics set ["invalidObjectiveCount", (_metrics get "invalidObjectiveCount") + 1];
        ["GTN", 2, format["Defense lease: group %1 has invalid defendObjective (%2), releasing", _groupId, _objId]] call FLO_fnc_log;
        _releaseIds pushBack _groupId;
        continue;
    };

    private _obj = _objectives get _objId;
    if ((_obj get "owner") != _ownSide) then {
        _metrics set ["lostObjectiveReleaseCount", (_metrics get "lostObjectiveReleaseCount") + 1];
        ["GTN", 2, format["Defense lease: group %1 releasing from lost objective %2", _groupId, _objId]] call FLO_fnc_log;
        _releaseIds pushBack _groupId;
        continue;
    };

    private _leaseUntil = _gData get "defendLeaseUntil";
    if (_leaseUntil < 0) then {
        [_gData, _now, _now + _leaseSeconds] call FLO_fnc_virtualizationRefreshDefendLease;
        _metrics set ["leaseIssuedCount", (_metrics get "leaseIssuedCount") + 1];
        continue;
    };
    if (_now < _leaseUntil) then { continue };

    private _hold = false;
    _hold = (_obj get "contested") || (_obj get "underAttack");

    if (_hold) then {
        [_gData, _now, _now + _leaseSeconds] call FLO_fnc_virtualizationRefreshDefendLease;
        _metrics set ["holdRefreshCount", (_metrics get "holdRefreshCount") + 1];
    } else {
        _releaseIds pushBack _groupId;
    };
} forEach _tasked;

// Trim excess defenders above per-objective cap (idle only).
private _idleDefendersByObjective = createHashMap;
{
    private _groupId = _x;
    if (_groupId in _releaseIds) then { continue };

    private _gData = _groups get _groupId;
    if (isNil "_gData") then { continue };
    if ((_gData get "side") != _ownSide) then { continue };
    if ((_gData get "commanderIntent") != "") then { continue };
    if ((_gData get "groupType") == "static_aa") then { continue };
    if ((_gData get "commanderOrder") != "DEFEND") then { continue };
    if (_gData getOrDefault ["inCombat", false]) then { continue };

    private _objId = _gData get "defendObjective";
    if (_objId == "") then { continue };

    private _bucket = _idleDefendersByObjective getOrDefault [_objId, []];
    _bucket pushBack _groupId;
    _idleDefendersByObjective set [_objId, _bucket];
} forEach _tasked;

{
    private _objId = _x;
    private _bucket = +(_idleDefendersByObjective get _objId);
    private _cap = _self call ["_getDefenseCapForObjective", [_objId]];
    if (_cap <= 0) then { continue };

    private _excess = (count _bucket) - _cap;
    if (_excess <= 0) then { continue };

    _excess = _excess min count _bucket;
    if (_excess <= 0) then { continue };

    for "_i" from 1 to _excess do {
        if (_bucket isEqualTo []) exitWith {};
        _releaseIds pushBackUnique (_bucket deleteAt ((count _bucket) - 1));
    };
    _metrics set ["trimmedExcess", (_metrics get "trimmedExcess") + _excess];

    ["GTN", 3, format[
        "Defense cap trim at %1: released %2 excess defenders (cap=%3)",
        _objId,
        _excess,
        _cap
    ]] call FLO_fnc_log;
} forEach (keys _idleDefendersByObjective);

if (_releaseIds isEqualTo []) exitWith { _metrics };

{
    private _gData = _groups get _x;
    if (isNil "_gData") then { continue };
    [_gData] call FLO_fnc_virtualizationClearMissionLock;
            [_gData, "idle"] call FLO_fnc_virtualizationSetRuntimeState;
} forEach _releaseIds;

_self call ["_releaseGroups", [_releaseIds, ""]];
_metrics set ["releasedCount", count _releaseIds];
["GTN", 3, format["Defense lease release: %1 groups returned to pool", count _releaseIds]] call FLO_fnc_log;

_metrics
