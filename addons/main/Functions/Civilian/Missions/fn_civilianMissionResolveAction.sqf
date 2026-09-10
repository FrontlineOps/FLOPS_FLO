/*
 * Function: FLO_fnc_civilianMissionResolveAction
 * Author: Frontline Operations Development Group
 * Description:
 *   Resolves civilian mission world interactions on the server and clears the
 *   active civilian mission state through the mission manager.
 *
 * Arguments:
 * 0: Mode <STRING>
 * 1: Arguments <ARRAY>
 *
 * Return Value:
 * BOOL - True when the action resolved
 */

params [
    ["_mode", "", [""]],
    ["_args", [], [[]]]
];

if (!isServer) exitWith {
    [_mode, _args] remoteExecCall ["FLO_fnc_civilianMissionResolveAction", 2, false];
    false
};

private _modeKey = toUpper _mode;
private _missionType = switch (_modeKey) do {
    case "REPAIR_COMPLETE";
    case "REPAIR_FAILED": { "repair_vehicle" };
    case "DELIVERY_COMPLETE": { "deliver_supplies" };
    case "MINEFIELD_COMPLETE": { "clear_minefield" };
    case "CHECKPOINT_COMPLETE": { "establish_checkpoint" };
    default { "" };
};
if (_missionType == "") exitWith { false };
_args params [["_source", objNull, [objNull]]];
if (isNull _source) exitWith { false };
private _missionId = _source getVariable ["missionTaskId", ""];
private _resolution = ["MISSION_COMPLETE", "MISSION_FAILED"] select (_modeKey == "REPAIR_FAILED");

// Claim the active mission before side effects; duplicate and stale callbacks stop here.
if !([_resolution, [_missionId, _missionType, _source]] call FLO_fnc_civilianMissionManager) exitWith { false };

if (_missionType == "repair_vehicle") then {
    _source setVariable ["FLO_CivilianMissionResolved", true, true];
    _source removeEventHandler ["Killed", _source getVariable "FLO_CivilianRepairKilledEH"];
    _source setVariable ["FLO_CivilianRepairKilledEH", -1];
    [_source, false] remoteExecCall ["FLO_fnc_civilianRepairActionLocal", 0, _source];
};

switch (_modeKey) do {
    case "REPAIR_COMPLETE": {
        _args params [["_vehicle", objNull, [objNull]]];
        if (isNull _vehicle) exitWith { false };

        _vehicle setDamage 0;

        private _taskId = _vehicle getVariable ["missionTaskId", ""];
        if (_taskId != "") then {
            [_taskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;
        };

        [0.35, "increase"] call FLO_fnc_adjustReputation;
        ["ScoreAdded", ["Vehicle Repaired", 0]] remoteExec ["BIS_fnc_showNotification", 0];
        true
    };

    case "REPAIR_FAILED": {
        _args params [["_vehicle", objNull, [objNull]]];
        if (isNull _vehicle) exitWith { false };

        private _taskId = _vehicle getVariable ["missionTaskId", ""];
        if (_taskId != "") then {
            [_taskId, "FAILED", true] call BIS_fnc_taskSetState;
        };

        [-0.35, "decrease"] call FLO_fnc_adjustReputation;
        true
    };

    case "DELIVERY_COMPLETE": {
        _args params [["_trigger", objNull, [objNull]]];
        if (isNull _trigger) exitWith { false };

        private _taskId = _trigger getVariable ["missionTaskId", ""];
        private _box = _trigger getVariable ["supplyBox", objNull];
        if (_taskId != "") then {
            [_taskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;
        };
        if (!isNull _box) then {
            deleteVehicle _box;
        };
        deleteVehicle _trigger;

        [0.35, "increase"] call FLO_fnc_adjustReputation;
        ["ScoreAdded", ["Resources Delivered", 0]] remoteExec ["BIS_fnc_showNotification", 0];
        true
    };

    case "MINEFIELD_COMPLETE": {
        _args params [["_trigger", objNull, [objNull]]];
        if (isNull _trigger) exitWith { false };

        private _taskId = _trigger getVariable ["missionTaskId", ""];
        private _decorVehicle = _trigger getVariable ["decorVehicle", objNull];
        if (_taskId != "") then {
            [_taskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;
        };
        if (!isNull _decorVehicle) then {
            deleteVehicle _decorVehicle;
        };
        deleteVehicle _trigger;

        [0.35, "increase"] call FLO_fnc_adjustReputation;
        ["ScoreAdded", ["Minefield Cleared", 0]] remoteExec ["BIS_fnc_showNotification", 0];
        true
    };

    case "CHECKPOINT_COMPLETE": {
        _args params [["_trigger", objNull, [objNull]]];
        if (isNull _trigger) exitWith { false };

        private _taskId = _trigger getVariable ["missionTaskId", ""];
        private _pos = _trigger getVariable ["targetPos", getPosATL _trigger];
        if (_taskId != "") then {
            [_taskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;
        };
        deleteVehicle _trigger;

        [0.35, "increase"] call FLO_fnc_adjustReputation;
        ["ScoreAdded", ["Checkpoint Established", 0]] remoteExec ["BIS_fnc_showNotification", 0];

        if ((FLO_ReputationHandle get "value") < 7) then {
            private _hostileForce = call FLO_fnc_civilianGetHostileForcePool;
            _hostileForce params ["_hostileSide", "_hostileUnits"];
            for "_i" from 1 to 2 do {
                private _spawnPos = [_pos, 300, 400, 3, 0, 20, 0] call BIS_fnc_findSafePos;
                private _grp = createGroup [_hostileSide, true];

                for "_j" from 1 to 4 do {
                    _grp createUnit [selectRandom _hostileUnits, _spawnPos, [], 0, "NONE"];
                };

                private _routeInstalled = [
                    _grp,
                    [[_pos, "SAD", "AWARE", "NORMAL", "WEDGE", "YELLOW", 0]],
                    "LAND",
                    "CIV_CHECKPOINT_ATTACK",
                    false,
                    true
                ] call FLO_fnc_taskApplyRoute;
                if (!_routeInstalled) then {
                    { deleteVehicle _x; } forEach units _grp;
                    deleteGroup _grp;
                    continue;
                };
                { _x setUnitPos "MIDDLE"; } forEach units _grp;
            };
        };

        true
    };
    default { false };
}
