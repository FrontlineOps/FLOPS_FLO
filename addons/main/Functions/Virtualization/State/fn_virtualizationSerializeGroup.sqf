/*
 * Function: FLO_fnc_virtualizationSerializeGroup
 * Author: Frontline Operations Development Group
 * Description:
 *   Serializes the canonical virtual-group schema for persistence.
 *
 * Arguments:
 * 0: Group data <HASHMAP>
 *
 * Return Value:
 * HASHMAP - Serialized group record
 */

params ["_groupData", ["_capturedAtTick", diag_tickTime, [0]]];

private _groupId = _groupData get "id";
[_groupData, _groupId] call FLO_fnc_virtualizationValidateGroup;

private _savedData = createHashMap;
{
    _savedData set [
        _x,
        [_groupData get _x] call FLO_fnc_virtualizationCloneValue
    ];
} forEach (call FLO_fnc_virtualizationGetPersistentFields);

// Timer format 0 is the existing unanchored version-29 record. Format 1
// retains the sampling epoch and elapsed portions preceding this process.
_savedData set ["timerFormatVersion", 1];
_savedData set ["timerSampleTick", _capturedAtTick];
_savedData set ["timerElapsedOffsets", createHashMapFromArray [
    ["civilianLastIntelAt", _groupData get "civilianIntelElapsedOffset"],
    ["transportUnloadIssuedAt", _groupData get "transportUnloadElapsedOffset"]
]];

[_savedData, _groupId] call FLO_fnc_virtualizationValidateSavedGroup;
_savedData

