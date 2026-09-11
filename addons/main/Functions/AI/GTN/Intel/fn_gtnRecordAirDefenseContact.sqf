/* Records a firing AA contact reported by an intercepted aircraft. */
params ["_worldState", "_contactId", "_position", "_groupType"];

if !(_groupType in ["static_aa", "mobile_aa"]) then {
    throw format ["Air-defense report %1 has invalid type %2", _contactId, _groupType];
};
// An engagement reports an approximate firing position, not a live target track.
private _reportedPos = [round ((_position select 0) / 500) * 500, round ((_position select 1) / 500) * 500, 0];
(_worldState get "_airDefenseContacts") set [_contactId, createHashMapFromArray [
    ["position", _reportedPos],
    ["groupType", _groupType],
    ["lastSeen", diag_tickTime]
]];
true
