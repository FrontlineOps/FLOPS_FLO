/*
 * Function: FLO_fnc_logisticsNetworkPickDeliveryObjective
 * Author: Frontline Operations Development Group
 * Description:
 *   Chooses a friendly staging objective for a pressured sector so maneuver
 *   reinforcements are delivered near the front instead of directly into the
 *   hottest contested objective.
 *
 * Arguments:
 *   0: Logistics network object <HASHMAP>
 *   1: Requested objective ID <STRING>
 *   2: Required Local Supplies <NUMBER>
 *   3: Objective IDs that cannot act as sources <ARRAY>
 *
 * Return Value:
 *   STRING - Delivery objective ID
 */

params [
    "_net",
    "_requestedObjectiveId",
    ["_requiredThroughput", 0, [0]],
    ["_blockedObjectives", [], [[]]],
    ["_deliveryInbound", createHashMap, [createHashMap]]
];

if (_requestedObjectiveId == "") exitWith { "" };

private _deliveryCache = _net get "_dispatchDeliveryObjectiveCache";
private _sortedBlocked = +_blockedObjectives;
_sortedBlocked sort true;
private _saturated = (keys _deliveryInbound) select {(_deliveryInbound get _x) >= (_net get "REINFORCEMENT_DELIVERY_INBOUND_CAP")};
_saturated sort true;
private _cacheKey = format ["%1:%2:%3:%4", _requestedObjectiveId, _requiredThroughput, _sortedBlocked joinString ",", _saturated joinString ","];
if (_cacheKey in _deliveryCache) exitWith { _deliveryCache get _cacheKey };

private _objectives = FLO_Objectives;
private _requestedObjective = _objectives get _requestedObjectiveId;
private _requestedPos = _requestedObjective get "position";
private _managedSide = _net get "_managedSide";
private _enemySide = _net get "_enemySide";
private _friendlyCountKey = ["bluforCount", "opforCount"] select (_managedSide isEqualTo east);
private _enemyCountKey = ["opforCount", "bluforCount"] select (_managedSide isEqualTo east);
private _sourceableCache = _net get "_dispatchSourceableCache";
private _candidateIds = [];
{
    private _linkedId = _x;
    private _linkedObjective = _objectives get _linkedId;
    if ((_linkedObjective get "owner") isEqualTo _managedSide && {!(_linkedId in _candidateIds)}) then {
        _candidateIds pushBack _linkedId;
    };
} forEach (_requestedObjective get "linkedObjectives");

{
    private _linkedObjective = _objectives get _x;
    {
        private _secondHopId = _x;
        if (_secondHopId == _requestedObjectiveId) then { continue };

        private _secondHopObjective = _objectives get _secondHopId;
        if ((_secondHopObjective get "owner") isEqualTo _managedSide && {!(_secondHopId in _candidateIds)}) then {
            _candidateIds pushBack _secondHopId;
        };
    } forEach (_linkedObjective get "linkedObjectives");
} forEach (_requestedObjective get "linkedObjectives");

_candidateIds = _candidateIds - ([_requestedObjectiveId] + _saturated);
private _enemyObjectiveIds = (keys _objectives) select {
    ((_objectives get _x) get "owner") isEqualTo _enemySide
};
private _minEnemyDistance = _net get "REINFORCEMENT_DELIVERY_MIN_ENEMY_DISTANCE";
private _ranked = [];
private _enemyDistanceCache = _net get "_dispatchEnemyDistanceCache";

{
    private _candidateId = _x;
    private _candidateObjective = _objectives get _candidateId;
    private _candidatePos = _candidateObjective get "position";
    private _distToRequested = _candidatePos distance2D _requestedPos;
    private _friendlyCount = _candidateObjective get _friendlyCountKey;
    private _enemyCount = _candidateObjective get _enemyCountKey;
    private _priority = _candidateObjective get "priority";
    private _nearestEnemyDist = if (_candidateId in _enemyDistanceCache) then {
        _enemyDistanceCache get _candidateId
    } else {
        private _resolvedDist = 1e12;
        {
            private _enemyPos = (_objectives get _x) get "position";
            private _dist = _candidatePos distance2D _enemyPos;
            if (_dist < _resolvedDist) then {
                _resolvedDist = _dist;
            };
        } forEach _enemyObjectiveIds;
        _enemyDistanceCache set [_candidateId, _resolvedDist];
        _resolvedDist
    };

    private _quiet = _enemyCount == 0 && {_nearestEnemyDist >= _minEnemyDistance};
    private _score = (5000 - (_distToRequested min 5000))
        + ((_nearestEnemyDist min 3500) * 0.25)
        - (_friendlyCount * 35) - (_enemyCount * 450) + (_priority * 15);
    // Preserve the original first-candidate tie break and quiet-first policy.
    _ranked pushBack [[1, 0] select _quiet, -_score, _forEachIndex, _candidateId];
} forEach _candidateIds;

_ranked sort true;
private _ordered = _ranked apply { _x select 3 };
if (_enemyObjectiveIds isEqualTo []) then {
    _ordered = [_requestedObjectiveId] + _candidateIds;
} else {
    _ordered pushBack _requestedObjectiveId;
};
private _selected = "";
{
    if (_x in _saturated) then { continue };
    private _sourceKey = format ["%1:%2:%3", _x, _requiredThroughput, _sortedBlocked joinString ","];
    private _canSource = if (_sourceKey in _sourceableCache) then { _sourceableCache get _sourceKey } else {
        private _result = ([_net, _x, _blockedObjectives, _requiredThroughput] call FLO_fnc_logisticsNetworkFindSupplySourceObjective) != "";
        _sourceableCache set [_sourceKey, _result];
        _result
    };
    if (_canSource) exitWith { _selected = _x; };
} forEach _ordered;
_deliveryCache set [_cacheKey, _selected];
_selected
