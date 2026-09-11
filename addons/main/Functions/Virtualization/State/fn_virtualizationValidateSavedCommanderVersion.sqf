/* Commander format 0 is the existing universe-29 order payload. Format 1 adds
 * WITHDRAW movement semantics without changing ordinary legacy order fields.
 */
params ["_savedData"];
private _version = if ("commanderOrderVersion" in _savedData) then { _savedData get "commanderOrderVersion" } else { 0 };
if !(_version isEqualType 0 && {_version in [0, 1]}) then {
    throw format ["Saved commander order has unsupported format %1", _version];
};
if ((_savedData get "orderMode") == "WITHDRAW") then {
    if (_version != 1 || {(_savedData get "commanderOrder") != "MOVE"}) then {
        throw "Saved WITHDRAW requires commander format 1 and a MOVE order";
    };
};
true
