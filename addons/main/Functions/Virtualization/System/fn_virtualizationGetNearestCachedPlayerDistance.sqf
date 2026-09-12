/*
 * Function: FLO_fnc_virtualizationGetNearestCachedPlayerDistance
 */

params ["_pos", ["_includeAirPlayers", false, [true]]];

private _cachedPlayers = FLO_VirtUpdate get "cachedPlayerPositions";
private _nearest = 999999;

{
    _x params ["_playerPos", "_inAir"];
    if (!_inAir || {_includeAirPlayers}) then {
        private _dist = _pos distance2D _playerPos;
        if (_dist < _nearest) then {
            _nearest = _dist;
        };
    };
} forEach _cachedPlayers;

_nearest
