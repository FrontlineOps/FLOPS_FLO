#pragma hemtt ignore_variables ["_self"]
/* _senseObjectives implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
params [["_deferObservations", false]];
private _objectives = createHashMap;

if (isNil "FLO_Objectives") exitWith { _objectives };

private _ownSide = _self get "_ownSide";
private _enemySide = _self get "_enemySide";
private _friendlyCountKey = ["bluforCount", "opforCount"] select (_ownSide isEqualTo east);
private _intelCache = _self get "_objectiveIntel";

{
    private _id = _x;
    private _data = FLO_Objectives get _id;
    if (isNil "_data") then { continue };

    private _pos = _data get "position";
    private _priority = _data get "priority";
    private _owner = _data get "owner";

    private _nearFriendly = _data get _friendlyCountKey;
    // Enemy presence belongs to the observed picture, not capture truth.

    private _cachedIntel = _intelCache getOrDefault [_id, createHashMapFromArray [
        ["lastReconTime", 0],
        ["intelQuality", 0],
        ["confirmedStrength", 0],
        ["hasArmor", false],
        ["hasAA", false],
        ["defensePosture", "UNKNOWN"]
    ]];

    private _objState = createHashMapFromArray [
        ["position", _pos],
        ["radius", _data get "radius"],
        ["integrated", (_data get "campaignIntegrationState") == "INTEGRATED"],
        ["priority", _priority],
        ["owner", _owner], ["supplied", false],
        ["enemyCount", -1], ["enemyStrengthKnown", false], ["enemyIntelTime", -1], ["enemyIntelConfidence", 0],
        ["friendlyCount", _nearFriendly],
        ["contested", false],
        ["underAttack", false],
        ["vulnerable", false],
        ["forceRatio", -1],
        ["linkedObjectives", _data get "linkedObjectives"],
        ["intel", _cachedIntel]
    ];

    _objectives set [_id, _objState];
} forEach (keys FLO_Objectives);

_self set ["_objectives", _objectives];
if (!_deferObservations) then { [_self] call FLO_fnc_gtnApplyObjectiveObservations };
_objectives
