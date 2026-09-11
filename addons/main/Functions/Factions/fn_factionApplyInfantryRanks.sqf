/* Preserves native template ranks on auto spawning; generated personnel derive
 * leadership from the catalog's known roles. The existing save shape is still
 * class composition, so arbitrary runtime rank edits are not serialized here.
 */
params ["_realGroup", "_groupData", "_catalog"];
private _roles = _catalog get "infantryRoles";
private _template = _groupData get "groupCfg";
private _members = if (_template isEqualType configNull && {isClass _template}) then {
    "true" configClasses _template
} else { [] };
{
    private _unit = _x;
    private _class = typeOf _unit;
    private _rank = if (_class in (_roles get "officer")) then {"LIEUTENANT"} else {
        if (_class in (_roles get "leader")) then {"SERGEANT"} else {"PRIVATE"}
    };
    if (_forEachIndex < count _members) then {
        private _member = _members select _forEachIndex;
        if (toLower getText (_member >> "vehicle") == toLower _class) then {
            private _authoredRank = toUpper getText (_member >> "rank");
            if (_authoredRank in ["PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"]) then {
                _rank = _authoredRank;
            };
        };
    };
    _unit setRank _rank;
} forEach units _realGroup;
