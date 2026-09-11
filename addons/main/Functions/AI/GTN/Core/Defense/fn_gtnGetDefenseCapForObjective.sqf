#pragma hemtt ignore_variables ["_self"]
/* _getDefenseCapForObjective implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
params ["_objectiveId"];

private _ws = _self get "_worldState";
private _objectives = _ws call ["_getObjectives", []];
if !(_objectiveId in _objectives) exitWith { 0 };

private _obj = _objectives get _objectiveId;
private _enemyCount = _obj get "enemyCount";
private _friendlyCount = _obj get "friendlyCount";
private _underAttack = _obj get "underAttack";
private _contested = _obj get "contested";
private _config = _self get "_config";
private _coverage = _config get "defenseCoverageMultiplier";

private _cap = (_config get "defenseObjectiveBaseMin") max (ceil (_enemyCount * (_config get "defenseObjectiveEnemyMultiplier")));
if (_underAttack) then { _cap = _cap + (_config get "defenseObjectiveUnderAttackBonus"); };
if (_contested) then { _cap = _cap + (_config get "defenseObjectiveContestedBonus"); };

private _deficit = (_enemyCount - _friendlyCount) max 0;
if (_deficit > 0) then {
    _cap = _cap + (ceil (_deficit * (_config get "defenseObjectiveDeficitMultiplier")));
};

_cap = ceil (_cap * _coverage);
_cap = (_cap max (_config get "defenseObjectiveBaseMin")) min (_config get "defenseObjectiveHardCap");

if (_contested && {_enemyCount > 0}) then {
    private _forceRatio = _friendlyCount / _enemyCount;
    if (_forceRatio < (_config get "defenseContestedCollapseForceRatio")) then {
        _cap = _cap min (_config get "defenseContestedCollapseCap");
    };
};

_cap
