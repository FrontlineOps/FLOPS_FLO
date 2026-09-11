/* The registry removal event owns removal of durable references before saving can run. */
params ["_commander", "_groupId"];
private _intents = _commander get "_intents";
{
    private _intent = _intents get _x;
    if !(_groupId in (_intent get "groupIds")) then {continue};
    _intent set ["groupIds", (_intent get "groupIds") - [_groupId]];
    _intent set ["issued", (_intent get "issued") - [_groupId]];
    private _tracks = _commander get "_tracks";
    private _track = _tracks select (_tracks findIf {(_x get "id") == (_intent get "id")});
    _track set ["groupPool", +(_intent get "groupIds")];
    if ((_intent get "groupIds") isEqualTo []) then {
        [_commander, _intent, false, "FORCE_DESTROYED"] call FLO_fnc_gtnRetireIntent;
    };
} forEach +(keys _intents);
((_commander get "_worldState") get "_ownGroupFacts") deleteAt _groupId;
true
