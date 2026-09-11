/* Finds the closest stocked source along the maintained friendly supply graph.
 * A depot on another HQ branch is valid; hostile/blocked links are not shortcuts.
 */
params ["_network", ["_targetObjectiveId", "", [""]], ["_blockedObjectives", [], [[]]], ["_requiredThroughput", 0, [0]]];
if (_targetObjectiveId == "") exitWith { "" };
[_network] call FLO_fnc_logisticsNetworkEnsureSupplyChainFresh;
private _routeInfo = _network get "_supplyRouteInfo";
private _sources = _network get "_activeSupplyNodes";
if !(_targetObjectiveId in _routeInfo) exitWith { "" };
private _side = _network get "_managedSide";
private _enemyKey = ["opforCount", "bluforCount"] select (_side isEqualTo east);
private _distances = createHashMapFromArray [[_targetObjectiveId, 0]];
private _frontier = [[0, _targetObjectiveId]];
private _visited = createHashMap;
private _selected = "";
while {_frontier isNotEqualTo [] && {_selected == ""}} do {
    _frontier sort true;
    (_frontier deleteAt 0) params ["_distance", "_id"];
    if (_id in _visited) then { continue };
    _visited set [_id, true];
    private _objective = FLO_Objectives get _id;
    if (_id in _sources && {!(_id in _blockedObjectives)} && {(_objective get _enemyKey) == 0}) then {
        if (((_sources get _id) get "throughput") >= _requiredThroughput) then { _selected = _id; };
    };
    if (_selected != "") then { continue };
    private _position = _objective get "position";
    {
        private _next = _x;
        if (_next in _visited || {!(_next in _routeInfo)} || {_next in _blockedObjectives}) then { continue };
        private _linked = FLO_Objectives get _next;
        if ((_linked get "owner") != _side || {(_linked get _enemyKey) > 0}) then { continue };
        private _cost = _distance + (_position distance2D (_linked get "position"));
        if (_next in _distances && {_cost >= (_distances get _next)}) then { continue };
        _distances set [_next, _cost];
        _frontier pushBack [_cost, _next];
    } forEach (_objective get "linkedObjectives");
};
_selected
