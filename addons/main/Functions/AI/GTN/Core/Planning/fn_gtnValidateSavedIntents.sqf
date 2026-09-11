/* Validate current durable ownership before rebuilding any planner or runtime index. */
params ["_state", "_sideKey", "_groups", "_objectives"];
private _side = [west, east] select (_sideKey == "EAST");
if !(_state isEqualType createHashMap) then { throw format ["GTN saved %1 state must be a HashMap", _sideKey] };
{
    _x params ["_key", "_type"];
    if !(_key in _state && {(_state get _key) isEqualType _type}) then { throw format ["GTN saved %1 missing or malformed %2", _sideKey, _key] };
} forEach [["gtnEnabled", true], ["nextIntentId", 0], ["intents", createHashMap]];
private _serial = _state get "nextIntentId";
if (!finite _serial || {_serial < 0} || {_serial != floor _serial}) then { throw format ["GTN saved %1 invalid intent serial", _sideKey] };
private _intents = _state get "intents";
if (!(_state get "gtnEnabled") && {count _intents > 0}) then { throw "GTN disabled commander has active intents" };
{
    if !(_y isEqualType createHashMap && {"side" in _y} && {(_y get "side") isEqualType sideUnknown}
        && {"commanderIntent" in _y} && {(_y get "commanderIntent") isEqualType ""}) then {
        throw format ["GTN saved group %1 is missing current ownership state", _x];
    };
} forEach _groups;
private _owned = createHashMap;
{
    private _id = _x;
    private _intent = _y;
    if !(_id isEqualType "" && {_id != ""} && {_intent isEqualType createHashMap}) then { throw "GTN malformed saved intent entry" };
    {
        _x params ["_key", "_type"];
        if !(_key in _intent && {(_intent get _key) isEqualType _type}) then { throw format ["GTN saved intent %1 missing or malformed %2", _id, _key] };
    } forEach [["id",""], ["kind",""], ["objectiveId",""], ["stageObjective",""], ["stagePos",[]], ["targetPos",[]], ["groupIds",[]], ["issued",[]], ["phase",""], ["phaseElapsed",0], ["initialUnits",0], ["initialPower",0], ["score",0], ["scoutAttempt",0]];
    if ((_intent get "id") != _id) then { throw format ["GTN saved intent %1 key mismatch", _id] };
    private _number = parseNumber (_id select [count _sideKey + 1]);
    if (_id != format ["%1_%2", _sideKey, _number] || {_number < 1} || {_number > _serial}) then { throw format ["GTN saved intent %1 has invalid serial ownership", _id] };
    private _kind = _intent get "kind";
    private _phases = switch (_kind) do {
        case "CAPTURE": {["MUSTER", "ASSEMBLE", "SCOUT", "ASSAULT", "SECURE", "COMPLETE"]};
        case "GARRISON";
        case "DEFEND": {["DISPATCH", "ARRIVE", "COMPLETE"]};
        case "ARTILLERY";
        case "CAS";
        case "CAP";
        case "MINEFIELD": {["REQUEST", "COMPLETE"]};
        default { throw format ["GTN saved intent %1 unsupported kind %2", _id, _kind] };
    };
    if !((_intent get "phase") in _phases) then { throw format ["GTN saved intent %1 invalid phase", _id] };
    {
        if !((_intent get _x) in _objectives) then { throw format ["GTN saved intent %1 missing objective reference %2", _id, _x] };
    } forEach ["objectiveId", "stageObjective"];
    {
        private _position = _intent get _x;
        if !([_position] call FLO_fnc_validateGroupPosition) then { throw format ["GTN saved intent %1 invalid %2", _id, _x] };
    } forEach ["stagePos", "targetPos"];
    {
        private _value = _intent get _x;
        if (!finite _value || {_value < 0}) then { throw format ["GTN saved intent %1 invalid %2", _id, _x] };
    } forEach ["phaseElapsed", "initialUnits", "initialPower", "scoutAttempt"];
    if (!finite (_intent get "score") || {!((_intent get "scoutAttempt") in [0,1,2])}) then { throw format ["GTN saved intent %1 invalid scoring/scouting state", _id] };
    private _groupIds = _intent get "groupIds";
    if (_kind in ["CAPTURE", "GARRISON", "DEFEND"]) then {
        if (_groupIds isEqualTo [] || {(_intent get "initialUnits") <= 0}) then { throw format ["GTN saved ground intent %1 has no force", _id] };
    } else {
        if (_groupIds isNotEqualTo [] || {(_intent get "initialUnits") != 0}) then { throw format ["GTN saved support intent %1 reserves ground forces", _id] };
    };
    if (count _groupIds != count (_groupIds arrayIntersect _groupIds)) then { throw format ["GTN saved intent %1 duplicates a group", _id] };
    {
        if !(_x isEqualType "" && {_x in _groups}) then { throw format ["GTN saved intent %1 has missing group reference", _id] };
        private _group = _groups get _x;
        if (_x in _owned || {(_group get "side") != _side} || {(_group get "commanderIntent") != _id}) then { throw format ["GTN saved intent %1 group %2 ownership mismatch", _id, _x] };
        _owned set [_x, _id];
    } forEach _groupIds;
    if (((_intent get "issued") - _groupIds) isNotEqualTo []) then { throw format ["GTN saved intent %1 issued an unreserved group", _id] };
} forEach _intents;
{
    if ((_y get "side") == _side && {(_y get "commanderIntent") != ""} && {!(_x in _owned)}) then {
        throw format ["GTN saved group %1 has orphaned intent ownership", _x];
    };
} forEach _groups;
true
