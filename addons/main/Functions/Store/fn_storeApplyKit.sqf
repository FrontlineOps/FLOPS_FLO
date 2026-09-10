params ["_gearEntries"];

if (!hasInterface) exitWith {};

if (isMultiplayer && {remoteExecutedOwner isNotEqualTo 2} && {remoteExecutedOwner isNotEqualTo 0}) exitWith {
    ["STORE", 2, format ["Rejected kit application from owner %1", remoteExecutedOwner]] call FLO_fnc_log;
};

if ((typeName _gearEntries) isNotEqualTo "ARRAY") exitWith {};

private _overflowDrops = [player, _gearEntries] call FLO_fnc_storeApplyGearItems;
["STORE", 3, format ["Applied %1 gear lines; %2 overflow items", count _gearEntries, count _overflowDrops]] call FLO_fnc_log;

if (_overflowDrops isEqualTo []) then {
    ["Purchased kit applied.", "success"] call FLO_fnc_displayNotification;
} else {
    private _dropped = [player, _overflowDrops] call FLO_fnc_storeDropGearItems;
    [format ["Purchased kit applied. Dropped %1 overflow items at your feet.", _dropped], "warning"] call FLO_fnc_displayNotification;
};
