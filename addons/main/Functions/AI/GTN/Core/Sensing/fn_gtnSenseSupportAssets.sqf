#pragma hemtt ignore_variables ["_self"]
/* _senseSupportAssets implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
private _assets = _self get "_supportAssets";
private _cmdr = _self get "_commander";
private _ownSide = _self get "_ownSide";

if (isNil "_cmdr") exitWith { _assets };

// Check artillery using Capability Analyzer for accurate ammo counts
private _artyAvailable = false;
private _artyAmmo = 0;
private _artyBatteries = 0;

if (!isNil "FLO_GTN_CapabilityAnalyzer") then {
    private _artyStatus = FLO_GTN_CapabilityAnalyzer call ["_getArtilleryStatus", [_ownSide]];
    _artyBatteries = _artyStatus get "availableBatteries";
    _artyAvailable = _artyBatteries > 0;
    // Use estimated rounds which combines actual (active) + estimated (virtual)
    _artyAmmo = _artyStatus get "estimatedRounds";

    ["GTN", 4, format["Artillery sense: batteries=%1/%2, rounds=%3 (active=%4, virtual=%5)",
        _artyBatteries,
        _artyStatus get "totalBatteries",
        _artyAmmo,
        _artyStatus get "activeRounds",
        _artyStatus get "totalRounds"]] call FLO_fnc_log;
} else {
    // Fallback if analyzer not initialized
    private _groups = call FLO_fnc_virtualizationGetGroupMap;
    {
        private _gData = _groups get _x;
        if ((_gData getOrDefault ["side", sideUnknown]) != _ownSide) then { continue };
        if ((_gData get "groupType") == "artillery" && {[_gData] call FLO_fnc_gtnSupportAssetCanProvideAbstractSupport}) exitWith {
            _artyAvailable = true;
        };
    } forEach (keys _groups);
    ["GTN", 4, format["Artillery sense (fallback): available=%1", _artyAvailable]] call FLO_fnc_log;
};

_assets set ["artilleryAvailable", _artyAvailable];
_assets set ["artilleryAmmo", _artyAmmo];

// Check air assets using Capability Analyzer for accurate status
private _casAvailable = false;
private _casOrdnance = 0;

if (!isNil "FLO_GTN_CapabilityAnalyzer") then {
    private _airStatus = FLO_GTN_CapabilityAnalyzer call ["_getAirAssetStatus", [_ownSide]];
    _casAvailable = (_airStatus get "casAvailable") > 0 || (_airStatus get "heloAvailable") > 0;
    _casOrdnance = _airStatus get "totalOrdnance";

    ["GTN", 4, format["Air sense: CAS=%1/%2, Helo=%3/%4, ordnance=%5",
        _airStatus get "casAvailable", _airStatus get "casTotal",
        _airStatus get "heloAvailable", _airStatus get "heloTotal",
        _casOrdnance]] call FLO_fnc_log;
} else {
    // Fallback if analyzer not initialized
    private _groups = call FLO_fnc_virtualizationGetGroupMap;
    {
        private _gData = _groups get _x;
        if ((_gData getOrDefault ["side", sideUnknown]) != _ownSide) then { continue };
        private _gType = _gData get "groupType";
        if (_gType in ["cas", "sead", "bomber", "air", "helicopter"] && {[_gData] call FLO_fnc_gtnSupportAssetCanProvideAbstractSupport}) then {
            _casAvailable = true;
        };
    } forEach (keys _groups);
    ["GTN", 4, format["Air sense (fallback): CAS=%1", _casAvailable]] call FLO_fnc_log;
};

_assets set ["casAvailable", _casAvailable];
_assets set ["casOrdnance", _casOrdnance];

_self set ["_supportAssets", _assets];
_assets
