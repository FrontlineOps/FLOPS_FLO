/* Records terminal ownership at deployment, restore, or editor-base discovery. */
params ["_building", "_terminal"];
if (!isServer || {isNull _building}) exitWith { false };
if (!isNull _terminal) then {
    private _owner = _terminal getVariable ["FLO_BaseOwner", objNull];
    if (!isNull _owner && {_owner isNotEqualTo _building}) then {
        ["BASE", 1, format ["Terminal %1 already belongs to base %2", _terminal, _owner]] call FLO_fnc_log;
        throw "Base terminal cannot be shared by multiple bases";
    };
    _terminal setVariable ["FLO_BaseOwner", _building, true];
    _terminal setVariable ["FLO_BaseSide", _building getVariable "FLO_BaseSide", true];
    _terminal setVariable ["FLO_BaseType", _building getVariable "FLO_BaseType", true];
};
_building setVariable ["FLO_BaseTerminal", _terminal, true];
true
