/* Resolves nested parent references and, when requested, plan-owned outputs. */
params ["_values", "_parent", "_bindings", ["_resolveSelected", true], ["_depth", 0]];
if (_depth > 32) then { throw "GTN parameter nesting exceeds 32 levels" };
private _result = [];
private _valid = true;
{
    private _value = _x;
    if !(_value isEqualType []) then {
        if (_value isEqualType "") then {
            if (_value find "_PARAM_" == 0) then {
                private _suffix = _value select [7];
                private _index = parseNumber _suffix;
                if (_suffix != str _index || {_index < 0} || {_index >= count _parent}) then {
                    throw format ["GTN invalid parent parameter reference %1", _value];
                };
                _value = _parent select _index;
            };
            if (_resolveSelected && {_value isEqualType ""} && {_value find "_SELECTED_" == 0}) then {
                private _name = _value select [10];
                if !(_name in _bindings) then { _valid = false } else { _value = _bindings get _name };
            };
        };
    };
    if (!isNil "_value" && {_value isEqualType []}) then {
        _value = [_value, _parent, _bindings, _resolveSelected, _depth + 1] call FLO_fnc_gtnResolvePlanParams;
    };
    if (isNil "_value") then { _valid = false } else { _result pushBack _value };
    if (!_valid) exitWith {};
} forEach _values;
if (!_valid) exitWith { nil };
_result
