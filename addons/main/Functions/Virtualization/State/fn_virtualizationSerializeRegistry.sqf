/*
 * Function: FLO_fnc_virtualizationSerializeRegistry
 * Description:
 *   Builds a complete validated virtual-force snapshot. Any invalid record
 *   throws so the mission save transaction cannot publish partial force data.
 */

params [["_snapshot", false, [false, createHashMap]], ["_capturedAtTick", diag_tickTime, [0]]];

// One engine deep copy freezes nested records before scheduled serialization.
// A detach between two live record reads must never enter the persisted graph.
private _captureStart = diag_tickTime;
if (_snapshot isEqualType false) then {
    call FLO_fnc_virtualizationValidateRegistry;
    private _captureFailure = [];
    isNil {
        try {
            _snapshot = call FLO_fnc_virtualizationCapturePersistentRegistry;
            _capturedAtTick = diag_tickTime;
        } catch { _captureFailure = [_exception] };
    };
    if (_captureFailure isNotEqualTo []) then { throw (_captureFailure select 0) };
};
private _captureMs = (diag_tickTime - _captureStart) * 1000;
if (_captureMs > 20) then {
    ["VIRTUALIZATION", 4, format ["[PERF] Save snapshot groups=%1 captureMs=%2", count _snapshot, _captureMs]] call FLO_fnc_log;
};
private _serialized = createHashMap;
{
    _serialized set [_x, [_y, _capturedAtTick] call FLO_fnc_virtualizationSerializeGroup];
} forEach _snapshot;
[_serialized] call FLO_fnc_virtualizationValidateTransportGraph;

_serialized
