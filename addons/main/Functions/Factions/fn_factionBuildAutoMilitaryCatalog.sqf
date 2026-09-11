/*
 * Function: FLO_fnc_factionBuildAutoMilitaryCatalog
 * Author: Frontline Operations Development Group
 * Description:
 *   Builds a FLO military faction catalog from loaded config data.
 *
 * Arguments:
 *   0: Faction classname <STRING>
 *
 * Return Value:
 *   HASHMAP matching a side entry in FLO_FactionCatalog
 */

params [["_factionClass", "", [""]]];

private _empty = createHashMap;
if (_factionClass == "") exitWith { _empty };

private _factionCfg = missionConfigFile >> "CfgFactionClasses" >> _factionClass;
if !(isClass _factionCfg) then {
    _factionCfg = configFile >> "CfgFactionClasses" >> _factionClass;
};
if !(isClass _factionCfg) exitWith { _empty };
private _expectedSide = getNumber (_factionCfg >> "side");
if !(_expectedSide in [0, 1]) then {
    throw format ["[FACTIONS] Auto military faction %1 has unsupported native side %2", _factionClass, _expectedSide];
};
private _started = diag_tickTime;

private _groups = [_factionClass] call FLO_fnc_factionGetGroupConfigs;
private _infantryGroups = _groups get "infantryGroups";
private _specOpsGroups = _groups get "specOpsGroups";
private _groupUnits = _groups get "infantryUnits";

private _units = [];
private _specOpsUnits = +(_groups get "specOpsUnits");
private _rejectedInfantry = [];
private _vehiclePools = createHashMapFromArray [
    ["groundMotorized", []],
    ["groundMechanized", []],
    ["groundArmor", []],
    ["groundTransport", []],
    ["groundArtillery", []],
    ["airHeli", []],
    ["airJet", []],
    ["airTransport", []],
    ["airDrone", []],
    ["groundDrone", []],
    ["mobileAA", []],
    ["staticAA", []],
    ["boat", []],
    ["radar", []]
];

private _factionLower = toLower _factionClass;

{
    private _vehCfg = _x;
    if ((toLower (getText (_vehCfg >> "faction"))) != _factionLower) then { continue };
    if (getNumber (_vehCfg >> "scope") < 2) then { continue };
    if (getNumber (_vehCfg >> "side") != _expectedSide) then { continue };

    private _className = configName _vehCfg;

    if (_className isKindOf "CAManBase") then {
        if ([_className, _factionClass, _expectedSide] call FLO_fnc_factionClassIsCombatInfantry) then {
            private _roles = [_className] call FLO_fnc_factionClassifyUnit;
            if ("recon" in _roles || {"sniper" in _roles} || {"diver" in _roles} || {_className in _specOpsUnits && {!(_className in _groupUnits)}}) then {
                _specOpsUnits pushBackUnique _className;
            } else {
                _units pushBackUnique _className;
            };
        } else {
            _rejectedInfantry pushBackUnique _className;
        };
        continue;
    };

    {
        private _pool = _vehiclePools get _x;
        _pool pushBackUnique _className;
        _vehiclePools set [_x, _pool];
    } forEach ([_className] call FLO_fnc_factionClassifyVehicle);

} forEach ("true" configClasses (configFile >> "CfgVehicles"));

_units = _units arrayIntersect _units;
// Category names are hints. A conventional category containing recon/divers
// must not leave a template that violates the conventional unit pool.
_infantryGroups = _infantryGroups select {
    private _group = _x;
    private _members = ("true" configClasses _group) apply {configName (configFile >> "CfgVehicles" >> getText (_x >> "vehicle"))};
    private _conventional = (_members findIf {!(_x in _units)}) < 0;
    if (!_conventional) then {
        _specOpsGroups pushBackUnique _group;
        { _specOpsUnits pushBackUnique _x; } forEach _members;
    };
    _conventional
};

// A faction consisting only of reconnaissance troops still has eligible ground
// infantry. Divers alone do not establish a conventional land-force pool.
if (_units isEqualTo []) then {
    _units = _specOpsUnits select { !("diver" in ([_x] call FLO_fnc_factionClassifyUnit)) };
};
private _rolePools = [_units] call FLO_fnc_factionBuildRolePools;
private _officers = +(_rolePools get "officer");
if (_officers isEqualTo []) then { _officers = +(_rolePools get "leader"); };
private _availableRoles = [];
{ if (_y isNotEqualTo []) then { _availableRoles pushBack [_x, count _y]; }; } forEach _rolePools;

["FACTIONS", 3, format [
    "Auto military catalog faction=%1 infantry=%2 groups=%3 specOps=%4 roles=%5 rejectedInfantry=%6 motorized=%7 mechanized=%8 armor=%9 mobileAA=%10 staticAA=%11 radar=%12 airJet=%13 timeMs=%14",
    _factionClass,
    count _units,
    count _infantryGroups,
    count _specOpsGroups,
    _availableRoles,
    count _rejectedInfantry,
    count (_vehiclePools get "groundMotorized"),
    count (_vehiclePools get "groundMechanized"),
    count (_vehiclePools get "groundArmor"),
    count (_vehiclePools get "mobileAA"),
    count (_vehiclePools get "staticAA"),
    count (_vehiclePools get "radar"),
    count (_vehiclePools get "airJet"),
    (diag_tickTime - _started) * 1000
]] call FLO_fnc_log;

private _compositionSide = ["OPFOR", "BLUFOR"] select (_expectedSide == 1);
private _compositionDefaults = [_compositionSide, "AUTO_STANDARD"] call FLO_fnc_factionGetCompositionDefaults;

createHashMapFromArray [
    ["source", "auto"],
    ["factionClass", _factionClass],
    ["groups", _infantryGroups],
    ["units", _units],
    ["officers", _officers],
    ["groundInfantryGroups", _infantryGroups],
    ["groundInfantryUnits", _units],
    ["infantryRoles", _rolePools],
    ["groundSpecOpsGroups", _specOpsGroups],
    ["groundSpecOpsUnits", _specOpsUnits],
    ["groundMotorized", _vehiclePools get "groundMotorized"],
    ["groundMechanized", _vehiclePools get "groundMechanized"],
    ["groundArmor", _vehiclePools get "groundArmor"],
    ["groundTransport", _vehiclePools get "groundTransport"],
    ["transportReserveGroundCount", _compositionDefaults get "transportReserveGroundCount"],
    ["groundArtillery", _vehiclePools get "groundArtillery"],
    ["airHeli", _vehiclePools get "airHeli"],
    ["airJet", _vehiclePools get "airJet"],
    ["airTransport", _vehiclePools get "airTransport"],
    ["transportReserveAirCount", _compositionDefaults get "transportReserveAirCount"],
    ["airDrone", _vehiclePools get "airDrone"],
    ["groundDrone", _vehiclePools get "groundDrone"],
    ["mobileAA", _vehiclePools get "mobileAA"],
    ["staticAA", _vehiclePools get "staticAA"],
    ["boat", _vehiclePools get "boat"],
    ["radar", _vehiclePools get "radar"],
    ["objectiveGroups", _compositionDefaults get "objectiveGroups"],
    ["objectiveGroupTypeCaps", _compositionDefaults get "objectiveGroupTypeCaps"],
    ["groupCounts", _compositionDefaults get "groupCounts"]
]
