/* Check delivery reachability in sector-priority order. Lower ranked sectors do
 * not need a route search once the best serviceable sector has been found.
 */
params ["_net", "_candidates", "_type", "_throughput", "_blocked", "_inbound", "_deliveryInbound", "_recent", "_batch", "_rejections", "_perf"];
private _sources = [_net] call FLO_fnc_logisticsNetworkEnsureSupplyChainFresh;
private _enemyKey = ["opforCount", "bluforCount"] select ((_net get "_managedSide") isEqualTo east);
if ((keys _sources) findIf {
    !(_x in _blocked) && {((_sources get _x) get "throughput") >= _throughput} && {((FLO_Objectives get _x) get _enemyKey) == 0}
} < 0) exitWith { ["", ""] };
private _remaining = +_candidates;
private _result = ["", ""];
while {_remaining isNotEqualTo []} do {
    private _started = diag_tickTime;
    private _requested = [_net, _remaining, _type, _inbound, _recent, _batch, _rejections] call FLO_fnc_logisticsNetworkPickBestTarget;
    _perf set ["dispatchTargetPickMs", (_perf get "dispatchTargetPickMs") + (diag_tickTime - _started) * 1000];
    if (_requested == "") exitWith {};
    _remaining = _remaining - [_requested];
    _started = diag_tickTime;
    private _delivery = "";
    if (_type == "static_aa") then {
        if ((_deliveryInbound getOrDefault [_requested, 0]) < (_net get "REINFORCEMENT_DELIVERY_INBOUND_CAP") && {([_net, _requested, _blocked, _throughput] call FLO_fnc_logisticsNetworkFindSupplySourceObjective) != ""}) then { _delivery = _requested; };
    } else {
        _delivery = [_net, _requested, _throughput, _blocked, _deliveryInbound] call FLO_fnc_logisticsNetworkPickDeliveryObjective;
    };
    _perf set ["dispatchDeliveryPickMs", (_perf get "dispatchDeliveryPickMs") + (diag_tickTime - _started) * 1000];
    if (_delivery != "") exitWith { _result = [_requested, _delivery]; };
};
_result
