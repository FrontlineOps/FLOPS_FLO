/*
 * Function: FLO_fnc_gtnCombatSidePower
 * Author: Frontline Operations Development Group
 * Description:
 *   Aggregates weighted combat power and force composition data for one side of
 *   an engagement.
 *
 * Arguments:
 *   0: Side group references <ARRAY>
 *
 * Return Value:
 *   Combat power summary <HASHMAP>
 */

params ["_sideRefs"];

private _power = 0;
private _units = 0;
private _inf = 0;
private _armor = 0;
private _analyzer = call FLO_fnc_gtnCapabilityAnalyzer;
private _riflemanPower = _analyzer call ["_getConfigCost", ["B_Soldier_F"]];

{
    private _groupId = _x select 0;
    private _gData = _x select 1;
    private _count = _gData get "unitCount";
    if (_count <= 0) then { continue };

    private _type = _gData get "groupType";
    private _weight = [_type] call FLO_fnc_gtnCombatTypeWeight;
    if (([_type] call FLO_fnc_virtualizationGetArchetype) get "initialGroundComposition") then {
        private _composition = _gData get "comp";
        if (count _composition != _count) then {
            throw format ["GTN combat asset composition mismatch group=%1 assets=%2 classes=%3", _groupId, _count, count _composition];
        };
        // Compare vehicle assets with personnel using the maintained capability
        // analyzer's cached config power, not one tank == one infantryman.
        private _assetPower = 0;
        { _assetPower = _assetPower + (_analyzer call ["_getConfigCost", [_x]]); } forEach _composition;
        _weight = _weight * (_assetPower / (_count * _riflemanPower));
    };
    private _experienceMultiplier = [_gData get "combatExperience"] call FLO_fnc_gtnCombatGetExperienceMultiplier;
    _power = _power + (_count * _weight * _experienceMultiplier);
    _units = _units + _count;

    if (_type isEqualTo "infantry") then { _inf = _inf + _count };
    if (_type in ["armor", "mechanized"]) then { _armor = _armor + _count };
} forEach _sideRefs;

createHashMapFromArray [
    ["power", _power],
    ["units", _units],
    ["infantry", _inf],
    ["armor", _armor]
]
