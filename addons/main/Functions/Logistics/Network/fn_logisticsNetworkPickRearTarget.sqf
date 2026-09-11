/* Distributes maneuver replacements across front-adjacent supply branches.
 * Incoming groups count before arrival, preventing a deep quiet queue sink.
 */
params ["_net", "_candidates", ["_inbound", createHashMap], ["_recent", createHashMap], ["_branchInbound", createHashMap]];
if (_candidates isEqualTo []) exitWith { "" };
private _side = _net get "_managedSide";
private _friendlyKey = ["bluforCount", "opforCount"] select (_side isEqualTo east);
private _ranked = [];
{
    private _id = _x;
    private _objective = FLO_Objectives get _id;
    private _role = [_net, _id] call FLO_fnc_logisticsNetworkDescribeObjectiveSupplyRole;
    if ((_role get "depth") < 0) then { continue };
    private _enemyLinks = { ((FLO_Objectives get _x) get "owner") isEqualTo (_net get "_enemySide") } count (_objective get "linkedObjectives");
    private _branch = [_net, _id] call FLO_fnc_logisticsNetworkGetObjectiveSupplyBranch;
    _ranked pushBack [
        -(_enemyLinks min 1),
        _inbound getOrDefault [_id, 0],
        _branchInbound getOrDefault [_branch, 0],
        _recent getOrDefault [_id, 0],
        _objective get _friendlyKey,
        -(_objective get "priority"),
        -(_role get "depth"),
        _id
    ];
} forEach _candidates;
if (_ranked isEqualTo []) exitWith { "" };
_ranked sort true;
(_ranked select 0) select 7
