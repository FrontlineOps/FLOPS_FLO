/* Rebuilds the inverse carrier index from validated passenger ownership. */
params ["_savedGroups"];

// Only reciprocal index mismatches are repairable. Missing carriers, malformed
// attachment state, foreign sides and cycles must still reject the save.
[_savedGroups, false] call FLO_fnc_virtualizationValidateTransportGraph;
private _manifests = createHashMap;
{ _manifests set [_x, []]; } forEach _savedGroups;
{
    private _carrierId = _y get "attachedTo";
    if (_carrierId != "") then {
        (_manifests get _carrierId) pushBack _x;
    };
} forEach _savedGroups;

private _repairs = 0;
{
    private _expected = _manifests get _x;
    private _existing = _y get "attachedGroups";
    if ((_existing - _expected) isNotEqualTo [] || {(_expected - _existing) isNotEqualTo []}) then {
        // Retain the saved load order for surviving passengers.
        private _manifest = _existing select { _x in _expected };
        _manifest append (_expected - _existing);
        [_y, _manifest] call FLO_fnc_virtualizationSetTransportPassengers;
        if (_manifest isEqualTo []) then {
            [_y, _x] call FLO_fnc_virtualizationResetCarrierInsertState;
        };
        _repairs = _repairs + 1;
    };
} forEach _savedGroups;
[_savedGroups] call FLO_fnc_virtualizationValidateTransportGraph;
if (_repairs > 0) then {
    ["VIRTUALIZATION", 2, format ["Rebuilt saved carrier manifests from passenger ownership carriers=%1 groups=%2", _repairs, count _savedGroups]] call FLO_fnc_log;
};
_repairs
