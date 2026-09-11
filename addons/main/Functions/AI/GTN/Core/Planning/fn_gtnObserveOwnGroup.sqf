/* World State maintains only the own-force facts required by planning. */
params ["_worldState", "_id", "_group"];
private _facts = _worldState get "_ownGroupFacts";
if ((_group get "side") != (_worldState get "_ownSide")) exitWith { _facts deleteAt _id; false };
private _commander = _worldState get "_commander";
private _tasked = if (isNil "_commander") then { [] } else { _commander get "_gtnTaskedGroups" };
private _entry = createHashMapFromArray [
    ["commanderIntent", _group get "commanderIntent"], ["homeObjective", _group get "homeObjective"],
    ["attackObjective", _group get "attackObjective"], ["garrisonObjective", _group get "garrisonObjective"],
    ["position", +(_group get "position")], ["unitCount", _group get "unitCount"],
    ["groupType", _group get "groupType"], ["commanderOrder", _group get "commanderOrder"],
    ["defendObjective", _group get "defendObjective"], ["attachedTo", _group get "attachedTo"],
    ["mountedIn", _group get "mountedIn"], ["assignable", !(_id in _tasked) && {[_group, _worldState get "_ownSide", ["infantry", "motorized", "mechanized", "armor"], ["PATROL", "DEFEND", ""]] call FLO_fnc_gtnGroupIsStrategicallyAssignable}]
];
_facts set [_id, _entry];
true
