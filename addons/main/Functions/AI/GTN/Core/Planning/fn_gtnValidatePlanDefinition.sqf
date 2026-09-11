/* Registration is the boundary for external/custom planning definitions. */
params ["_definition", "_primitive"];
if !(_definition isEqualType createHashMap) then { throw "GTN definition must be a HashMap" };
if !("id" in _definition && {(_definition get "id") isEqualType ""} && {(_definition get "id") != ""}) then { throw "GTN definition requires a nonempty id" };
private _id = _definition get "id";
private _codeFields = if (_primitive) then { ["preconditions", "effects", "completionCheck"] } else { ["preconditions", "satisfied"] };
{
    if !(_x in _definition && {(_definition get _x) isEqualType {}}) then { throw format ["GTN definition %1 requires %2 code", _id, _x] };
} forEach _codeFields;
if (_primitive) exitWith {
    if !("timeout" in _definition && {(_definition get "timeout") isEqualType 0} && {(_definition get "timeout") > 0}) then { throw format ["GTN primitive %1 requires a positive timeout", _id] };
    true
};
if !("repeat" in _definition && {(_definition get "repeat") isEqualType true}) then { throw format ["GTN goal %1 requires repeat BOOL", _id] };
if !("type" in _definition && {(_definition get "type") isEqualType ""}) then { throw format ["GTN goal %1 requires type STRING", _id] };
if !("methods" in _definition && {(_definition get "methods") isEqualType []}) then { throw format ["GTN goal %1 requires methods ARRAY", _id] };
private _ids = [];
{
    private _method = _x;
    if !(_method isEqualType createHashMap && {"id" in _method} && {(_method get "id") isEqualType ""} && {(_method get "id") != ""}) then { throw format ["GTN goal %1 has invalid method id", _id] };
    if ((_method get "id") in _ids) then { throw format ["GTN goal %1 has duplicate method %2", _id, _method get "id"] };
    _ids pushBack (_method get "id");
    {
        if !(_x in _method && {(_method get _x) isEqualType {}}) then { throw format ["GTN method %1 requires %2 code", _method get "id", _x] };
    } forEach ["conditions", "score"];
    if !("subtasks" in _method && {(_method get "subtasks") isEqualType []}) then { throw format ["GTN method %1 requires subtasks", _method get "id"] };
    {
        if !(_x isEqualType [] && {count _x == 2} && {(_x select 0) isEqualType ""} && {(_x select 1) isEqualType []}) then { throw format ["GTN method %1 has malformed subtask", _method get "id"] };
    } forEach (_method get "subtasks");
} forEach (_definition get "methods");
true
