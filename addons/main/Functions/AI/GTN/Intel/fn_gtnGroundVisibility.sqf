/* Virtual perception checks terrain and view geometry within its local range. */
params ["_from", "_to", "_range"];
if (_from distance2D _to > _range) exitWith { false };
private _start = [_from select 0, _from select 1, (getTerrainHeightASL _from) + 1.8];
private _end = [_to select 0, _to select 1, (getTerrainHeightASL _to) + 1.2];
(lineIntersectsSurfaces [_start, _end, objNull, objNull, true, 1, "VIEW", "FIRE"]) isEqualTo []
