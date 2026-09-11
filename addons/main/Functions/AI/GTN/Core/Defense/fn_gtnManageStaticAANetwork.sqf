#pragma hemtt ignore_variables ["_self"]
/* _manageStaticAANetwork implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _ownSide = _self get "_ownSide";
private _metrics = createHashMapFromArray [
    ["groupCount", count (keys _groups)],
    ["movingStaticAACount", 0],
    ["deployedCount", 0]
];

// Phase 1: finalize in-transit static AA deployments
{
    private _groupId = _x;
    private _gData = _groups get _groupId;
    if (isNil "_gData") then { continue };

    if ((_gData get "groupType") != "static_aa") then { continue };
    if ((_gData get "side") != _ownSide) then { continue };
    if (((_gData get "aaDeployState")) != "MOVING") then { continue };
    _metrics set ["movingStaticAACount", (_metrics get "movingStaticAACount") + 1];

    private _targetPos = (_gData get "aaDeployTargetPos");
    if (count _targetPos < 2) then { continue };
    if ((_gData get "position") distance2D _targetPos > 120) then { continue };

    if !([_groupId, [], true, "GTN_AA_DEPLOYED"] call FLO_fnc_updateVirtualGroupWaypoints) then {
        throw format ["Static AA %1 route clear was rejected", _groupId];
    };
    [
        _groupId,
        createHashMapFromArray [
            ["forceVirtual", false],
            ["noWaypoints", true],
            ["alwaysActive", false]
        ]
    ] call FLO_fnc_virtualizationPatchGroup;
    [_gData, "AA_HOLD"] call FLO_fnc_virtualizationClearReplacementTransit;
    [_gData, "DEPLOYED", _targetPos, (_gData get "aaDeployTargetObjective"), _gData get "isStrategicAA"] call FLO_fnc_virtualizationSetAADeployState;

    ["GTN", 3, format[
        "Static AA %1 deployed at %2 (objective %3)",
        _groupId,
        _targetPos,
        (_gData get "aaDeployTargetObjective")
    ]] call FLO_fnc_log;
    _metrics set ["deployedCount", (_metrics get "deployedCount") + 1];
} forEach (keys _groups);

_metrics
