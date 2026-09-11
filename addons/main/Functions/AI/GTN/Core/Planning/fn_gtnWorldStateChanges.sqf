/* One change detector for both planner queries and live track monitors. */
params ["_before", "_after", ["_casualtyThreshold", 0.2]];
if (isNil "_before") exitWith { ["NO_SNAPSHOT"] };
private _changes = [];
private _oldTotal = (_before get "forces") get "totalGroups";
private _newTotal = (_after get "forces") get "totalGroups";
if (_oldTotal > 0 && {(_oldTotal - _newTotal) / _oldTotal >= _casualtyThreshold}) then { _changes pushBack "CASUALTIES" };
private _old = _before get "objectives";
private _new = _after get "objectives";
if (count _old != count _new) then { _changes pushBack "OBJECTIVE_CHANGE" };
{
    if !(_x in _old) then { _changes pushBackUnique "OBJECTIVE_CHANGE"; continue };
    private _a = _old get _x;
    private _b = _y;
    if ((_a get "owner") != (_b get "owner") || {(_a get "contested") != (_b get "contested")}) then { _changes pushBackUnique "OBJECTIVE_CHANGE" };
    if (!(_a get "vulnerable") && {_b get "vulnerable"}) then { _changes pushBackUnique "OPPORTUNITY" };
} forEach _new;
private _oldAssets = _before get "assets";
private _newAssets = _after get "assets";
if ((_oldAssets get "artilleryAvailable") != (_newAssets get "artilleryAvailable") || {(_oldAssets get "casAvailable") != (_newAssets get "casAvailable")}) then { _changes pushBack "ASSET_CHANGE" };
_changes
