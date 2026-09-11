/*
 * Function: FLO_fnc_virtualizationValidateSavedGroup
 */

params [
    ["_savedData", createHashMap, [createHashMap]],
    ["_expectedId", "", [""]]
];

private _defaults = call FLO_fnc_virtualizationCreateGroupRecordDefaults;
private _persistentFields = call FLO_fnc_virtualizationGetPersistentFields;
{
    if !(_x in _savedData) then {
        throw format ["Saved virtual group %1 missing field %2", _expectedId, _x];
    };

    private _value = _savedData get _x;
    private _prototype = _defaults get _x;
    if !(_value isEqualType _prototype) then {
        throw format [
            "Saved virtual group %1 field %2 has type %3, expected %4",
            _expectedId,
            _x,
            typeName _value,
            typeName _prototype
        ];
    };
    _defaults set [_x, _value];
} forEach _persistentFields;

private _groupId = _savedData get "id";
if (_expectedId == "" || {_groupId != _expectedId}) then {
    throw format ["Saved virtual group key/id mismatch: key=%1 record=%2", _expectedId, _groupId];
};
// Saved domain fields obey the same invariants as an inactive runtime record.
[_defaults, _groupId] call FLO_fnc_virtualizationValidateGroup;
[createHashMap, _savedData, 0, false] call FLO_fnc_virtualizationRestoreTimerState;

true
