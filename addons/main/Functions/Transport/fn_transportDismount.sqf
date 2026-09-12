/*
 * Function: FLO_fnc_transportDismount
 * Author: Frontline Operations Development Group
 * Description:
 *   Check and handle dismount for a transport group at waypoint.
 *   Called from both virtual waypoint advancement and active carrier sync.
 *
 * Arguments:
 *   0: Transport Group ID <STRING>
 *
 * Return Value:
 *   Dismount occurred <BOOLEAN>
 *
 * Example:
 *   [_groupId] call FLO_fnc_transportDismount;
 */

params [
    ["_transportGroupId", "", [""]],
    ["_forceNow", false, [false]]
];

if (_transportGroupId == "") exitWith { false };

private _transData = [_transportGroupId] call FLO_fnc_virtualizationGetGroup;

// Check if this is a transport
private _isTransport = [_transData] call FLO_fnc_virtualizationIsTransportCarrier;
if (!_isTransport) exitWith { false };

// Check dismount waypoint
private _dismountIdx = _transData get "dismountAtWaypoint";
if (_dismountIdx < 0) exitWith { false };

private _currentIdx = _transData get "currentWaypointIndex";
if (!_forceNow && {_currentIdx < _dismountIdx}) exitWith { false };

// Get attached groups before detaching
private _attachedIds = +([_transData] call FLO_fnc_virtualizationGetTransportPassengers);
private _insertMode = _transData get "transportInsertMode";
private _insertPos = _transData get "transportInsertPos";
private _realGroup = _transData get "realGroup";

private _virtualAirInsert = !(_transData get "isActive") && {
    (([_transData get "groupType"] call FLO_fnc_virtualizationGetArchetype) get "movementDomain") == "AIR"
};
if (_virtualAirInsert && {_forceNow}) exitWith { false };
if (_virtualAirInsert && {
    private _waypoint = (_transData get "waypoints") select _dismountIdx;
    ((_transData get "position") distance2D _insertPos) > (_waypoint select 6)
}) exitWith { false };
if (_virtualAirInsert) then {
    if (surfaceIsWater _insertPos) then {
        private _message = format ["Virtual air insert has no LAND dismount point carrier=%1", _transportGroupId];
        ["TRANSPORT", 1, _message] call FLO_fnc_log;
        throw _message;
    };
    // Arrival tolerance may still be offshore. Complete the abstract landing
    // at its planned endpoint before the passengers leave the carrier.
    [_transportGroupId, [_insertPos select 0, _insertPos select 1, 0]] call FLO_fnc_virtualizationUpdateGroupPosition;
};

// Detach all passengers
private _detached = if (_insertMode == "AIR_DROP" && {!isNull _realGroup}) then {
    private _transportVehicles = ([_realGroup] call FLO_fnc_virtualizationCollectRealGroupVehicles) select { !isNull _x && {alive _x} };
    private _dropPos = if (_forceNow || {count _insertPos < 2}) then {
        private _leader = leader _realGroup;
        if (isNull _leader || {!alive _leader}) then {
            _transData get "position"
        } else {
            getPosATL _leader
        }
    } else {
        _insertPos
    };
    private _dropCount = 0;

    {
        if ([_x, _dropPos, _transportVehicles] call FLO_fnc_transportParadropActivePassengerGroup) then {
            _dropCount = _dropCount + 1;
        };
    } forEach _attachedIds;

    _dropCount
} else {
    [_transportGroupId, false] call FLO_fnc_transportDetachAll
};

// Clear dismount config
[_transportGroupId] call FLO_fnc_transportClearInsertState;

[_transportGroupId] call FLO_fnc_transportPoolRelease;

// Apply post-dismount waypoints to infantry
{
    [_x, "TRANSPORT_DISMOUNT"] call FLO_fnc_transportApplyPostDismountWaypoint;
} forEach _attachedIds;

["TRANSPORT", 3, format["Transport %1 dismounted %2 groups at waypoint %3", 
    _transportGroupId, _detached, _dismountIdx]] call FLO_fnc_log;

true
