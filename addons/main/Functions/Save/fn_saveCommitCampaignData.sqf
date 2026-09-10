/* Commits one validated campaign payload. The storage callback is synchronous
 * and returns the native write result; it also permits isolated failure tests.
 */
params ["_data", ["_writeProfile", { saveMissionProfileNamespace }, [{}]]];
if (!isServer) exitWith { false };
if (remoteExecutedOwner > 2 && {admin remoteExecutedOwner <= 0}) exitWith {
    ["SAVE", 2, "Rejected direct campaign write from a non-admin remote caller"] call FLO_fnc_log;
    false
};

private _writeSucceeded = false;
isNil {
    private _previousData = missionProfileNamespace getVariable ["FLO_MissionData", nil];
    try {
        missionProfileNamespace setVariable ["FLO_MissionData", _data];
        private _result = call _writeProfile;
        if (isNil "_result") then { throw "Campaign profile writer returned no result" };
        if !(_result isEqualType true) then { throw "Campaign profile writer returned a non-Boolean result" };
        _writeSucceeded = _result;
        if (!_writeSucceeded) then {
            ["SAVE", 1, "Campaign profile write returned false; retaining previous save"] call FLO_fnc_log;
        };
    } catch {
        ["SAVE", 1, format ["Write failed: %1", _exception]] call FLO_fnc_log;
    };
    if (!_writeSucceeded) then {
        missionProfileNamespace setVariable ["FLO_MissionData", if (isNil "_previousData") then { nil } else { _previousData }];
    };
};
_writeSucceeded
