/* Rebuild derived passenger positions and pool indexes from valid ownership. */
private _groups = call FLO_fnc_virtualizationGetGroupMap;
{ [_y, _x] call FLO_fnc_virtualizationValidateGroup } forEach _groups;
[_groups] call FLO_fnc_virtualizationValidateTransportGraph;

private _positionUpdates = 0;
{
    private _carrierId = _y get "attachedTo";
    if (_carrierId == "") then { continue };
    private _carrier = _groups get _carrierId;
    // Ownership is already acyclic; nested passengers share the root carrier.
    while {(_carrier get "attachedTo") != ""} do {
        _carrier = _groups get (_carrier get "attachedTo");
    };
    private _position = _carrier get "position";
    if ((_y get "position") isNotEqualTo _position) then {
        [_x, _position] call FLO_fnc_virtualizationUpdateGroupPosition;
        _positionUpdates = _positionUpdates + 1;
    };
} forEach _groups;

private _poolUpdates = [_groups] call FLO_fnc_transportReconcilePoolState;
if (_positionUpdates + _poolUpdates > 0) then {
    ["FLO_Virtualization_TransportRelationshipChanged", ["", "", "RECONCILE"]] call CBA_fnc_localEvent;
    ["VIRTUALIZATION", 3, format ["Rebuilt transport indexes: passengerPositions=%1 poolEntries=%2", _positionUpdates, _poolUpdates]] call FLO_fnc_log;
};
true
