/* Logistics owns retrying foot deliveries, including those restored from saves.
 * Use dedicated ground reserves; do not steal combat vehicles or fly into AA.
 * The existing network worker owns cadence and lifetime; no extra PFH/script.
 */
params ["_net", "_pendingIds"];
private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _retryAt = _net get "_reinforcementPickupRetryAt";
private _live = createHashMap;
private _ranked = [];
private _now = diag_tickTime;
{
    private _id = _x;
    _live set [_id, true];
    private _data = _groups get _id;
    if ((_data get "groupType") != "infantry" || {_data get "inCombat"}) then { continue };
    if ((_data get "attachedTo") != "" || {(_data get "mountedIn") != ""}) then { continue };
    if ((_data get "missionLock") != "LOGISTICS") then { continue };
    private _readyAt = _retryAt getOrDefault [_id, 0];
    if (_now < _readyAt) then { continue };
    private _target = _data get "reinforcementTargetPos";
    private _distance = (_data get "position") distance2D _target;
    if (_distance < FLO_Transport_MinDistance) then { continue };
    _ranked pushBack [_readyAt, -_distance, _id];
} forEach _pendingIds;
{ if !(_x in _live) then { _retryAt deleteAt _x; }; } forEach (keys _retryAt);
_ranked sort true;
private _attempted = 0;
private _assigned = 0;
{
    if (_attempted >= 2 || {diag_tickTime - _now >= 0.1}) exitWith {};
    private _id = _x select 2;
    private _data = _groups get _id;
    private _objectiveId = _data get "reinforcementDeliveryObjective";
    if (((FLO_Objectives get _objectiveId) get "owner") != (_net get "_managedSide")) then { continue };
    _attempted = _attempted + 1;
    _retryAt set [_id, _now + 60];
    private _request = createHashMapFromArray [["forceMode", "GROUND"], ["dedicatedOnly", true], ["orderTag", "LOGI_REINF"]];
    if (([_id, _data get "reinforcementTargetPos", _request] call FLO_fnc_transportRequest) != "") then { _assigned = _assigned + 1; };
} forEach _ranked;
private _elapsed = (diag_tickTime - _now) * 1000;
if (_assigned > 0 || {_elapsed >= 50}) then {
    ["LOGISTICS", [4, 3] select (_assigned > 0), format ["Reinforcement pickup side=%1 pending=%2 candidates=%3 attempted=%4 assigned=%5 elapsed=%6ms", _net get "_managedSideKey", count _pendingIds, count _ranked, _attempted, _assigned, _elapsed]] call FLO_fnc_log;
};
_assigned
