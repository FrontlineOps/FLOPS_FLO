#pragma hemtt ignore_variables ["_self"]
/* _getArtilleryStatus implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
params [["_side", east]];

private _result = createHashMapFromArray [
    ["totalBatteries", 0],
    ["availableBatteries", 0],
    ["totalRounds", 0],      // Estimated total capacity
    ["activeRounds", 0],     // Actual ammo from active groups
    ["estimatedRounds", 0],  // Combined actual + estimated
    ["batteries", []]
];

if (isNil "FLO_VirtualForceRegistry") exitWith { _result };

private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _missions = if (!isNil "FLO_GTNArtilleryManager") then {
    FLO_GTNArtilleryManager get "missions"
} else {
    createHashMap
};

{
    private _gId = _x;
    private _gData = _groups get _gId;
    if (isNil "_gData") then { continue };
    if ((_gData getOrDefault ["side", sideUnknown]) != _side) then { continue };
    if ((_gData get "groupType") != "artillery") then { continue };

    private _batteryInfo = createHashMapFromArray [
        ["groupId", _gId],
        ["isActive", false],
        ["missionLock", ""],
        ["supportEligible", false],
        ["rounds", 0],
        ["position", _gData get "position"]
    ];

    _result set ["totalBatteries", (_result get "totalBatteries") + 1];

    private _missionLocked = _gId in _missions;
    _batteryInfo set ["missionLock", ["", "ARTILLERY"] select (_missionLocked)];
    private _canSupport = [_gData] call FLO_fnc_gtnSupportAssetCanProvideAbstractSupport;
    _batteryInfo set ["supportEligible", _canSupport];

    if (_canSupport) then {
        _result set ["availableBatteries", (_result get "availableBatteries") + 1];
    };

    private _isActive = _gData get "isActive";
    _batteryInfo set ["isActive", _isActive];

    if (_isActive) then {
        // Get actual ammo count from real group
        private _realGroup = _gData get "realGroup";
        if (!isNull _realGroup) then {
            private _groupRounds = 0;
            {
                private _veh = vehicle _x;
                if (_veh != _x && alive _veh) then {
                    // Check for artillery ammo directly
                    private _artyAmmo = getArtilleryAmmo [_veh];
                    {
                        private _magClass = _x;
                        private _magsAmmo = magazinesAmmo _veh;
                        {
                            if ((_x select 0) == _magClass) then {
                                _groupRounds = _groupRounds + (_x select 1);
                            };
                        } forEach _magsAmmo;
                    } forEach _artyAmmo;
                };
            } forEach (units _realGroup);

            _batteryInfo set ["rounds", _groupRounds];
            _result set ["activeRounds", (_result get "activeRounds") + _groupRounds];
        };
    } else {
        // Virtual group - estimate based on unit count and typical loadout
        // Typical artillery piece has ~20-30 rounds
        private _unitCount = _gData get "unitCount";
        private _estimatedRounds = _unitCount * 24;  // Conservative estimate
        _batteryInfo set ["rounds", _estimatedRounds];
        _result set ["totalRounds", (_result get "totalRounds") + _estimatedRounds];
    };

    (_result get "batteries") pushBack _batteryInfo;
} forEach (keys _groups);

// Combined estimate: actual from active + estimated from virtual
_result set ["estimatedRounds", (_result get "activeRounds") + (_result get "totalRounds")];

_result
