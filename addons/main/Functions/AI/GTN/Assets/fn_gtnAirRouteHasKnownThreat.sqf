/* Tests a proposed ingress against a caller's reported AA coverage. */
params ["_start", "_end", "_threats"];
(_threats findIf {
    _x params ["_position", "_range"];
    ([_position, _start, _end] call FLO_fnc_gtnAirDistancePointToSegment2D) <= _range
}) >= 0
