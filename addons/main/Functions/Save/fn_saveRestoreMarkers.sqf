/* Current campaign restoration; called in Phase 5 ownership order. */
params ["_savedData"];

private _combatMarkerPrefix = "FLO_GTN_COMBAT_";
private _staleCombatMarkers = allMapMarkers select { _x find _combatMarkerPrefix == 0 };
{
    deleteMarker _x;
} forEach _staleCombatMarkers;
FLO_GTN_CombatDebugMarkers = createHashMap;
FLO_GTN_CombatDebugMarkerOrder = [];
if (_staleCombatMarkers isNotEqualTo []) then {
    ["INIT", 3, format ["Cleared %1 stale combat debug markers before marker restore", count _staleCombatMarkers]] call FLO_fnc_log;
};

// Restore markers
private _markerHash = _savedData get "markers";
private _requiredMarkerTypes = [
    ["pos", []], ["type", ""], ["brush", ""], ["shape", ""],
    ["size", []], ["text", ""], ["dir", 0], ["color", ""], ["alpha", 0]
];
private _loadedMarkers = 0;
{
    private _markerName = _x;
    private _attr = _markerHash get _markerName;
    if !(_markerName isEqualType "" && {_markerName != ""}) then {
        throw format ["Current save has invalid marker key %1", _markerName];
    };
    if !(_attr isEqualType createHashMap) then {
        throw format ["Saved marker %1 has invalid record type %2", _markerName, typeName _attr];
    };
    {
        _x params ["_field", "_prototype"];
        if !(_field in _attr) then {
            throw format ["Saved marker %1 is missing required field %2", _markerName, _field];
        };
        private _value = _attr get _field;
        if !(_value isEqualType _prototype) then {
            throw format ["Saved marker %1 field %2 has invalid type %3", _markerName, _field, typeName _value];
        };
    } forEach _requiredMarkerTypes;

    if ((_markerName find _combatMarkerPrefix) != 0) then {
        if (getMarkerColor _markerName != "") then { deleteMarker _markerName };
        private _marker = createMarker [_markerName, [0,0,0]];
        _marker setMarkerPosLocal (_attr get "pos");
        _marker setMarkerTypeLocal (_attr get "type");
        _marker setMarkerBrushLocal (_attr get "brush");
        _marker setMarkerShapeLocal (_attr get "shape");
        _marker setMarkerSizeLocal (_attr get "size");
        _marker setMarkerTextLocal (_attr get "text");
        _marker setMarkerDirLocal (_attr get "dir");
        _marker setMarkerColorLocal (_attr get "color");
        _marker setMarkerAlpha (_attr get "alpha");
        _loadedMarkers = _loadedMarkers + 1;
    };
} forEach (keys _markerHash);
["INIT", 3, format ["Restored %1 markers from current save", _loadedMarkers]] call FLO_fnc_log;

_loadedMarkers
