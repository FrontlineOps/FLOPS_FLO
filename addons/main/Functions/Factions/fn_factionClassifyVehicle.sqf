/* Maps public vehicle classes to usable faction roles. Dedicated AA, artillery,
 * drones and support assets cannot leak into ordinary maneuver/CAS pools.
 */
params [["_className", "", [""]]];
private _cfg = configFile >> "CfgVehicles" >> _className;
if !(isClass _cfg && {getNumber (_cfg >> "scope") == 2}) exitWith { [] };
if (_className isKindOf "Man") exitWith { [] };
if !(_className isKindOf "AllVehicles") exitWith { [] };

private _tokens = (toLower format ["%1 %2 %3 %4", _className, getText (_cfg >> "displayName"), getText (_cfg >> "vehicleClass"), getText (_cfg >> "editorSubcategory")]) splitString " _-/().,[]";
private _capabilities = [_className] call FLO_fnc_factionGetVehicleCapabilities;
private _armed = _capabilities get "armed";
private _threat = getArray (_cfg >> "threat");
private _airThreat = count _threat >= 3 && {(_threat select 2) > 0.5} && {(_threat select 2) > (_threat select 1)};
private _aaHint = (_tokens arrayIntersect ["aa", "sam", "antiair", "zu23", "zsu", "2s6", "tunguska", "shilka", "igla", "stinger", "tor"]) isNotEqualTo [] || {"zu" in _tokens && {"23" in _tokens}};
private _isAA = _armed && {(_capabilities get "antiAir") || {_airThreat && {_aaHint || {_className isKindOf "Tank"}}} || {_aaHint}};
private _isArtillery = getNumber (_cfg >> "artilleryScanner") > 0;
private _isDrone = getNumber (_cfg >> "isUav") > 0;
private _transport = getNumber (_cfg >> "transportSoldier");
private _isRadar = !_armed && {getNumber (_cfg >> "radarType") > 0 || {getNumber (_cfg >> "reportRemoteTargets") > 0}} && {"radar" in _tokens};

if (_className isKindOf "StaticWeapon") exitWith {
    private _roles = [];
    if (_isAA) then { _roles pushBack "staticAA"; };
    if (_isArtillery) then { _roles pushBack "groundArtillery"; };
    if (_isRadar) then { _roles pushBack "radar"; };
    _roles
};
if (_isRadar && {_className isKindOf "LandVehicle"}) exitWith { ["radar"] };
if (_isDrone) exitWith {
    if (_className isKindOf "Air") exitWith { ["airDrone"] };
    if (_className isKindOf "LandVehicle") exitWith { ["groundDrone"] };
    []
};
if (_className isKindOf "Helicopter") exitWith {
    private _roles = [];
    if (_transport >= 4) then { _roles pushBack "airTransport"; };
    if (_armed) then { _roles pushBack "airHeli"; };
    _roles
};
if (_className isKindOf "Plane") exitWith {
    if (_armed) then { ["airJet"] } else { [] }
};
if (_className isKindOf "Ship") exitWith { ["boat"] };
if !(_className isKindOf "LandVehicle") exitWith { [] };
if (_isArtillery) exitWith { ["groundArtillery"] };
if (_isAA) exitWith { ["mobileAA"] };

private _isAPC = _className isKindOf "Wheeled_APC_F" ||
    {(_tokens arrayIntersect ["apc", "ifv", "aav", "bmd", "bmp", "btr", "lav", "lav25", "stryker", "m113", "mtlb"]) isNotEqualTo []};
if (_className isKindOf "Tank") exitWith {
    if (_isAPC || {_transport > 0 && {!("mbt" in _tokens)} && {!(_capabilities get "tankCannon")}}) then { ["groundMechanized"] } else { ["groundArmor"] }
};
if (_isAPC && {_className isKindOf "Car"}) exitWith { ["groundMechanized"] };
if ((_capabilities get "tankCannon") && {getNumber (_cfg >> "armor") >= 100}) exitWith { ["groundArmor"] };
private _isSupport = getNumber (_cfg >> "transportAmmo") > 0 || {getNumber (_cfg >> "transportRepair") > 0} || {getNumber (_cfg >> "transportFuel") > 0};
private _roles = [];
if (_className isKindOf "Car") then {
    if (_transport >= 4) then { _roles pushBack "groundTransport"; };
    if (_armed && {!_isSupport}) then { _roles pushBack "groundMotorized"; };
};
_roles
