/* One interpretation of reported resistance for force selection and commitment. */
params ["_commander", "_objectiveId"];
private _world = _commander get "_worldState";
private _objective = (_world get "_objectives") get _objectiveId;
private _power = (_objective get "enemyCount") max 0;
private _needsAntiArmor = false;
private _intel = _world call ["_getObjectiveIntel", [_objectiveId]];
if (_world call ["_isIntelFresh", [_objectiveId, 240]]) then {
    if ("groundPower" in _intel) then {_power = _power max (_intel get "groundPower")};
    if ("hasArmor" in _intel) then {_needsAntiArmor = _intel get "hasArmor"};
};
private _config = _commander get "_config";
createHashMapFromArray [["power", (_config get "assaultMinimumPower") max (_power * (_config get "assaultForceRatio"))], ["antiArmor", _needsAntiArmor]]
