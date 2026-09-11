/* Resolve and validate a route on a detached candidate; publish nothing. */
params ["_groupId", "_groupData", "_waypoints", "_allowTrails", "_requestSource", "_closeLoop", "_patrolConfig"];

private _groupType = _groupData get "groupType";
private _archetype = [_groupType] call FLO_fnc_virtualizationGetArchetype;
private _movementDomain = _archetype get "movementDomain";
private _autoPatrolRequested = _patrolConfig isNotEqualTo [];
if (_autoPatrolRequested && {!_closeLoop}) then {
    throw format ["Auto-patrol route for %1 must request closed-loop resolution", _groupId];
};
if (_autoPatrolRequested && {_movementDomain != "LAND"}) then {
    throw format ["Auto-patrol route for %1 requires LAND movement, got %2", _groupId, _movementDomain];
};
private _sanitizedWaypoints = [_movementDomain, _waypoints] call FLO_fnc_virtualizationSanitizeWaypoints;
if (_autoPatrolRequested && {_sanitizedWaypoints isEqualTo []}) then {
    throw format ["Auto-patrol route for %1 requires movement waypoints", _groupId];
};
private _sourceTag = ["VG_GENERIC", _requestSource] select (_requestSource != "");
private _routeWaypoints = _sanitizedWaypoints;
private _routeAllowed = true;
private _routeFailureReason = "";
private _routeDeferred = false;

if (_movementDomain == "LAND" && {_sanitizedWaypoints isNotEqualTo []}) then {
    private _currentPos = if (_groupData get "isActive") then {
        private _realGroup = _groupData get "realGroup";
        private _leader = leader _realGroup;
        if (isNull _leader) then {
            throw format ["Active LAND group %1 has no real leader", _groupId];
        };
        getPosATL _leader
    } else {
        +(_groupData get "position")
    };
    private _retryPending = (
        _groupData get "landRouteStartBlocked"
        && {diag_tickTime < (_groupData get "landRouteRetryAt")}
    );
    if (_retryPending && {surfaceIsWater _currentPos}) then {
        _routeDeferred = true;
    } else {
        private _routeResult = [_currentPos, _sanitizedWaypoints, _allowTrails, _sourceTag, _closeLoop] call FLO_fnc_virtualizationResolveLandWaypoints;
        _routeResult params ["_resolved", "_resolvedWaypoints", "_reason"];

        _routeAllowed = _resolved;
        _routeFailureReason = _reason;
        if (_resolved) then {
            _routeWaypoints = _resolvedWaypoints;
        };
    };
};

if (_routeDeferred) exitWith { false };

if (!_routeAllowed) exitWith {
    if (_routeFailureReason == "START_IN_WATER") then {
        private _alreadyBlocked = _groupData get "landRouteStartBlocked";
        private _retrySeconds = ["landRouteBlockedRetrySeconds"] call FLO_fnc_virtualizationGetConfigValue;
        _groupData set ["landRouteStartBlocked", true];
        _groupData set ["landRouteRetryAt", diag_tickTime + _retrySeconds];
        if (!_alreadyBlocked) then {
            ["VIRTUALIZATION", 2, format [
                "Rejected LAND route group=%1 source=%2 reason=%3 semanticWaypoints=%4 retrySeconds=%5",
                _groupId,
                _sourceTag,
                _routeFailureReason,
                count _sanitizedWaypoints,
                _retrySeconds
            ]] call FLO_fnc_log;
        };
    } else {
        private _level = [2, 5] select (_sourceTag in ["AUTO_PATROL", "GARRISON_PATROL", "GARRISON_BUILDING"]);
        ["VIRTUALIZATION", _level, format [
            "Rejected LAND route group=%1 source=%2 reason=%3 semanticWaypoints=%4",
            _groupId,
            _sourceTag,
            _routeFailureReason,
            count _sanitizedWaypoints
        ]] call FLO_fnc_log;
    };
    false
};

private _candidate = _groupData;
_candidate set ["autoPatrolRetry", []];
if (_movementDomain == "LAND" && {_routeWaypoints isNotEqualTo []}) then {
    _candidate set ["landRouteStartBlocked", false];
    _candidate set ["landRouteRetryAt", -1];
};
if (_routeWaypoints isNotEqualTo []) then {
    _candidate set ["waypoints", _routeWaypoints];
    _candidate set ["pathSource", _sourceTag];
    _candidate set ["patrolConfig", if (_autoPatrolRequested) then { [_patrolConfig] call FLO_fnc_virtualizationCloneValue } else { [] }];
    _candidate set ["autoPatrol", _autoPatrolRequested];
    _candidate set ["idleHelicopterParked", false];
    _candidate set ["currentWaypointIndex", 0];
    _candidate set ["lastMoveTime", diag_tickTime];
    _candidate set ["virtualMoveCarryMeters", 0];
    _candidate set ["nextProcessAt", 0];
    [_candidate] call FLO_fnc_virtualizationRefreshCurrentWaypointSpeed;
    [_candidate, "moving"] call FLO_fnc_virtualizationSetRuntimeState;
} else {
    _candidate set ["waypoints", []];
    _candidate set ["pathSource", _sourceTag];
    _candidate set ["patrolConfig", []];
    _candidate set ["autoPatrol", false];
    _candidate set ["currentWaypointIndex", 0];
    _candidate set ["virtualMoveCarryMeters", 0];
    _candidate set ["nextProcessAt", 0];
    [_candidate] call FLO_fnc_virtualizationRefreshCurrentWaypointSpeed;
    [_candidate, "idle"] call FLO_fnc_virtualizationSetRuntimeState;
};

[_candidate, _groupId] call FLO_fnc_virtualizationValidateGroup;
if (_autoPatrolRequested) then {
    private _routeValidation = [
        _groupId,
        _candidate get "position",
        _candidate get "waypoints",
        _candidate get "currentWaypointIndex",
        true,
        _candidate get "patrolConfig"
    ] call FLO_fnc_virtualizationValidateLandRoute;
    if !(_routeValidation select 0) then {
        ["VIRTUALIZATION", 1, format [
            "Resolved auto-patrol route failed exact validation group=%1 reason=%2",
            _groupId,
            _routeValidation select 1
        ]] call FLO_fnc_log;
        throw format ["Auto-patrol route for %1 rejected after resolution: %2", _groupId, _routeValidation select 1];
    };
};
true
