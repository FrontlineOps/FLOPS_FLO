/*
 * Function: FLO_fnc_factionBuildMergedAutoMilitaryCatalog
 * Author: Frontline Operations Development Group
 * Description:
 *   Builds one FLO military faction catalog from multiple auto-detected
 *   CfgFactionClasses entries.
 *
 * Arguments:
 *   0: Faction classnames <ARRAY>
 *
 * Return Value:
 *   HASHMAP matching a side entry in FLO_FactionCatalog
 */

params [["_factionClasses", [], [[]]]];

if ((_factionClasses findIf {!(_x isEqualType "" && {_x != ""})}) >= 0) then {
    throw "[FACTIONS] Auto military selection requires non-empty faction classnames";
};
private _classes = +_factionClasses;
_classes = _classes arrayIntersect _classes;

private _empty = createHashMap;
if (_classes isEqualTo []) exitWith { _empty };

private _arrayFields = [
    "groups",
    "units",
    "officers",
    "groundInfantryGroups",
    "groundInfantryUnits",
    "groundSpecOpsGroups",
    "groundSpecOpsUnits",
    "groundMotorized",
    "groundMechanized",
    "groundArmor",
    "groundTransport",
    "groundArtillery",
    "airHeli",
    "airJet",
    "airTransport",
    "airDrone",
    "groundDrone",
    "mobileAA",
    "staticAA",
    "boat",
    "radar"
];

private _mergedPairs = [
    ["source", "auto_multi"],
    ["factionClass", _classes select 0],
    ["factionClasses", _classes]
];

{
    _mergedPairs pushBack [_x, []];
} forEach _arrayFields;

private _merged = createHashMapFromArray _mergedPairs;
private _catalogs = [];

{
    private _catalog = [_x] call FLO_fnc_factionBuildAutoMilitaryCatalog;
    if ((keys _catalog) isEqualTo []) then {
        throw format ["[FACTIONS] Selected auto military faction %1 has no catalog", _x];
    };

    _catalogs pushBack _catalog;

    {
        private _field = _x;
        private _values = _merged get _field;
        {
            _values pushBackUnique _x;
        } forEach (_catalog get _field);
        _merged set [_field, _values];
    } forEach _arrayFields;
} forEach _classes;

if (_catalogs isEqualTo []) exitWith { _empty };

private _baseCatalog = _catalogs select 0;
if ((_baseCatalog get "groundInfantryUnits") isEqualTo []) then { throw "[FACTIONS] Cannot merge a faction without infantry"; };
private _nativeSide = getNumber (configFile >> "CfgVehicles" >> ((_baseCatalog get "groundInfantryUnits") select 0) >> "side");
{
    if ((_x get "groundInfantryUnits") isEqualTo []) then { throw "[FACTIONS] Cannot merge a faction without infantry"; };
    if (getNumber (configFile >> "CfgVehicles" >> ((_x get "groundInfantryUnits") select 0) >> "side") != _nativeSide) then {
        throw "[FACTIONS] Cannot merge military factions from different native sides";
    };
} forEach _catalogs;
_merged set ["infantryRoles", [_merged get "groundInfantryUnits"] call FLO_fnc_factionBuildRolePools];
_merged set ["infantrySources", _catalogs apply {
    createHashMapFromArray [["source", "auto"], ["factionClass", _x get "factionClass"], ["groundInfantryUnits", _x get "groundInfantryUnits"], ["groundInfantryGroups", _x get "groundInfantryGroups"], ["infantryRoles", _x get "infantryRoles"]]
}];
{
    _merged set [_x, _baseCatalog get _x];
} forEach [
    "transportReserveGroundCount",
    "transportReserveAirCount",
    "objectiveGroups",
    "objectiveGroupTypeCaps",
    "groupCounts"
];

["FACTIONS", 3, format [
    "Merged auto military factions %1: units=%2 groups=%3 motorized=%4 mechanized=%5 armor=%6 mobileAA=%7 staticAA=%8 air=%9",
    _classes,
    count (_merged get "groundInfantryUnits"),
    count (_merged get "groundInfantryGroups"),
    count (_merged get "groundMotorized"),
    count (_merged get "groundMechanized"),
    count (_merged get "groundArmor"),
    count (_merged get "mobileAA"),
    count (_merged get "staticAA"),
    count ((_merged get "airHeli") + (_merged get "airJet"))
]] call FLO_fnc_log;

_merged
