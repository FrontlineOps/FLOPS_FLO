#pragma hemtt ignore_variables ["_self"]
/* _senseForces implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
private _forces = _self get "_ownForces";

if (isNil "FLO_VirtualForceRegistry") exitWith { _forces };

private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _allGroupIds = keys _groups;
_self set ["_ownGroupFacts", createHashMap];

// Count by type and status
private _counts = createHashMapFromArray [
    ["total", 0], ["available", 0], ["attacking", 0], ["defending", 0], ["garrisoned", 0],
    ["infantry", 0], ["armor", 0], ["mechanized", 0], ["motorized", 0], ["artillery", 0], ["air", 0]
];

private _ownSide = _self get "_ownSide";

{
    private _gData = _groups get _x;
    if (isNil "_gData") then { continue };
    if ((_gData get "side") != _ownSide) then { continue };
    [_self, _x, _gData] call FLO_fnc_gtnObserveOwnGroup;

    private _groupType = _gData get "groupType";

    // Count total
    _counts set ["total", (_counts get "total") + 1];

    // Count by type
    private _typeKey = switch (_groupType) do {
        case "armor": { "armor" };
        case "mechanized": { "mechanized" };
        case "motorized": { "motorized" };
        case "artillery": { "artillery" };
        case "air": { "air" };
        default { "infantry" };
    };
    _counts set [_typeKey, (_counts get _typeKey) + 1];

    // Count by status using commanderOrder
    private _currentOrder = _gData get "commanderOrder";
    private _missionLock = _gData get "missionLock";

    switch (_currentOrder) do {
        case "ATTACK": { _counts set ["attacking", (_counts get "attacking") + 1]; };
        case "DEFEND": { _counts set ["defending", (_counts get "defending") + 1]; };
        case "GARRISON": { _counts set ["garrisoned", (_counts get "garrisoned") + 1]; };
        default { _counts set ["garrisoned", (_counts get "garrisoned") + 1]; };
    };

    // A group is "available" if it's not on an active mission
    if (_missionLock == "") then {
        if ((_gData get "attachedTo") == "" && {(_gData get "mountedIn") == ""} && {!(_currentOrder in ["ATTACK", "DEFEND", "MOVE"])}) then {
            _counts set ["available", (_counts get "available") + 1];
        };
    };
} forEach _allGroupIds;

// Update forces HashMap
_forces set ["totalGroups", _counts get "total"];
_forces set ["availableGroups", _counts get "available"];
_forces set ["attackingGroups", _counts get "attacking"];
_forces set ["defendingGroups", _counts get "defending"];
_forces set ["garrisonedGroups", _counts get "garrisoned"];
_forces set ["infantryGroups", _counts get "infantry"];
_forces set ["armorGroups", _counts get "armor"];
_forces set ["mechanizedGroups", _counts get "mechanized"];
_forces set ["motorizedGroups", _counts get "motorized"];
_forces set ["artilleryGroups", _counts get "artillery"];
_forces set ["airGroups", _counts get "air"];

_self set ["_ownForces", _forces];
_forces
