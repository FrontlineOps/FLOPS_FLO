/*
 * Function: FLO_fnc_logisticsNetworkBuildInboundObjectiveCounts
 * Author: Frontline Operations Development Group
 * Description:
 *   Counts currently reinforcing virtual groups by their requested objective
 *   so saturation gates operate on the actual pressured sector rather than the
 *   staging objective where the group is currently headed.
 *
 * Arguments:
 *   0: Logistics network object <HASHMAP>
 *
 * Return Value:
 *   HASHMAP - objectiveId -> inbound reinforcing group count
 */

params ["_net", ["_pendingIds", [], [[]]], ["_deliveryCounts", createHashMap, [createHashMap]]];

private _managedSide = _net get "_managedSide";
private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _counts = createHashMap;

{
    private _groupData = _y;
    if ((_groupData get "side") != _managedSide) then { continue };
    if ((_groupData get "replacementState") != "REINFORCE") then { continue };
    _pendingIds pushBack _x;
    private _deliveryId = _groupData get "reinforcementDeliveryObjective";
    _deliveryCounts set [_deliveryId, (_deliveryCounts getOrDefault [_deliveryId, 0]) + 1];

    private _objectiveId = _groupData get "reinforcementRequestedObjective";
    if (_objectiveId == "") then { continue };

    _counts set [_objectiveId, (_counts getOrDefault [_objectiveId, 0]) + 1];
} forEach _groups;

_counts
