#pragma hemtt ignore_variables ["_self"]
/* _getGarrisonCapForObjective implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
params ["_objectiveId"];
if (_objectiveId == "") exitWith { 0 };

private _ws = _self get "_worldState";
private _objectives = _ws call ["_getObjectives", []];
if !(_objectiveId in _objectives) exitWith { 0 };

private _obj = _objectives get _objectiveId;
private _ownSide = _self get "_ownSide";
if ((_obj get "owner") != _ownSide) exitWith { 0 };
if !([_ownSide, _objectiveId] call FLO_fnc_campaignCanSupportObjective) exitWith { 0 };

private _config = _self get "_config";
private _cap = _config get "garrisonRearBaseGroups";
private _enemyLinkedCount = 0;

{
    private _linkedObjective = _objectives get _x;
    if (isNil "_linkedObjective") then { continue };
    if ((_linkedObjective get "owner") == (_self get "_enemySide")) then {
        _enemyLinkedCount = _enemyLinkedCount + 1;
    };
} forEach (_obj get "linkedObjectives");

if (_enemyLinkedCount > 0) then {
    _cap = _config get "garrisonFrontlineBaseGroups";
};

if ((_obj get "priority") >= (_config get "garrisonPriorityBonusThreshold")) then {
    _cap = _cap + (_config get "garrisonPriorityBonusGroups");
};

if ((_obj get "underAttack") || (_obj get "contested")) then {
    _cap = _cap + (_config get "garrisonHotBonusGroups");
};

private _defenseCap = _self call ["_getDefenseCapForObjective", [_objectiveId]];
(_cap max 0) min ((_config get "garrisonObjectiveHardCap") min _defenseCap)
