/* Standing local security outlives its arrival plan, but not territory ownership. */
params ["_commander"];
private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _objectives = (_commander get "_worldState") get "_objectives";
private _release = [];
{
    if !(_x in _groups) then { continue };
    private _group = _groups get _x;
    if ((_group get "commanderIntent") != "" || {(_group get "commanderOrder") != "GARRISON"}) then { continue };
    private _objectiveId = _group get "garrisonObjective";
    if !(_objectiveId in _objectives) then { throw format ["GTN garrison %1 has missing objective %2", _x, _objectiveId] };
    if (((_objectives get _objectiveId) get "owner") == (_commander get "_ownSide")) then { continue };
    [_group] call FLO_fnc_virtualizationClearCommanderOrder;
    if !([_x, [], true, "GTN_HOLD_LOST"] call FLO_fnc_updateVirtualGroupWaypoints) then { throw format ["GTN failed to clear obsolete hold %1", _x] };
    _release pushBack _x;
} forEach (_commander get "_gtnTaskedGroups");
if (_release isNotEqualTo []) then {
    _commander set ["_gtnTaskedGroups", (_commander get "_gtnTaskedGroups") - _release];
    ["GTN", 3, format ["%1 released %2 garrisons after territory loss", _commander get "_sideKey", count _release]] call FLO_fnc_log;
};
count _release
