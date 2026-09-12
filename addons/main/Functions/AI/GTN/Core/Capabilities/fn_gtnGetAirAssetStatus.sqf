#pragma hemtt ignore_variables ["_self"]
/* _getAirAssetStatus implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
params [["_side", east]];

private _result = createHashMapFromArray [
    ["casTotal", 0],
    ["casAvailable", 0],
    ["heloTotal", 0],
    ["heloAvailable", 0],
    ["totalOrdnance", 0],  // Weapons load estimate
    ["assets", []]
];

if (isNil "FLO_VirtualForceRegistry") exitWith { _result };

private _groups = call FLO_fnc_virtualizationGetGroupMap;

{
    private _gId = _x;
    private _gData = _groups get _gId;
    if (isNil "_gData") then { continue };
    if ((_gData getOrDefault ["side", sideUnknown]) != _side) then { continue };

    private _gType = _gData get "groupType";
    if !(_gType in ["cas", "sead", "bomber", "air", "helicopter", "jet"]) then { continue };

    private _assetInfo = createHashMapFromArray [
        ["groupId", _gId],
        ["type", _gType],
        ["isActive", false],
        ["missionLock", ""],
        ["supportEligible", false],
        ["ordnance", 0],
        ["ammoStatus", 1.0],
        ["position", _gData get "position"]
    ];

    private _missionLock = _gData get "missionLock";
    _assetInfo set ["missionLock", _missionLock];
    private _canSupport = [_gData] call FLO_fnc_gtnSupportAssetCanProvideAbstractSupport;
    _assetInfo set ["supportEligible", _canSupport];

    // Categorize and count
    private _typeKey = switch (_gType) do {
        case "helicopter": { "helo" };
        default { "cas" };  // Generic or specialized strike air = CAS
    };

    _result set [_typeKey + "Total", (_result get (_typeKey + "Total")) + 1];
    if (_canSupport) then {
        _result set [_typeKey + "Available", (_result get (_typeKey + "Available")) + 1];
    };

    private _isActive = _gData get "isActive";
    _assetInfo set ["isActive", _isActive];

    if (_isActive) then {
        // Get actual ordnance count from real group
        private _realGroup = _gData get "realGroup";
        if (!isNull _realGroup) then {
            private _groupOrdnance = 0;
            private _groupAmmo = 0;
            private _vehCount = 0;
            {
                private _veh = _x;
                if (alive _veh) then {
                    _vehCount = _vehCount + 1;
                    private _analysis = _self call ["_analyzeVehicle", [_veh]];
                    if (!isNil "_analysis") then {
                        _groupAmmo = _groupAmmo + (_analysis getOrDefault ["ammoStatus", 1.0]);
                        // Ordnance = missile/bomb count (rough estimate from ammo)
                        private _artyAmmo = _analysis getOrDefault ["artilleryAmmo", 0];
                        if (_artyAmmo > 0) then {
                            _groupOrdnance = _groupOrdnance + _artyAmmo;
                        } else {
                            // Estimate from ammo status - full load = ~8 missiles/bombs
                            _groupOrdnance = _groupOrdnance + round((_analysis getOrDefault ["ammoStatus", 1.0]) * 8);
                        };
                    };
                };
            } forEach ([_realGroup] call FLO_fnc_virtualizationCollectRealGroupVehicles);

            if (_vehCount > 0) then {
                _assetInfo set ["ammoStatus", _groupAmmo / _vehCount];
            };
            _assetInfo set ["ordnance", _groupOrdnance];
            _result set ["totalOrdnance", (_result get "totalOrdnance") + _groupOrdnance];
        };
    } else {
        // Virtual group - estimate typical loadout
        private _unitCount = _gData get "unitCount";
        private _estimatedOrdnance = _unitCount * 8;  // 8 missiles/bombs per aircraft
        _assetInfo set ["ordnance", _estimatedOrdnance];
        _result set ["totalOrdnance", (_result get "totalOrdnance") + _estimatedOrdnance];
    };

    (_result get "assets") pushBack _assetInfo;
} forEach (keys _groups);

_result
