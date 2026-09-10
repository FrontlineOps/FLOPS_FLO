/* Validates transport ownership in an isolated saved or live group map. */
params ["_groups", ["_checkManifests", true, [true]]];

{
    private _groupId = _x;
    private _groupData = _y;
    private _attachedTo = _groupData get "attachedTo";
    private _mountedIn = _groupData get "mountedIn";
    private _passengers = _groupData get "attachedGroups";
    if ((_attachedTo == "") != ((_groupData get "attachedType") == "")) then {
        throw format ["Virtual group %1 has incomplete transport attachment state", _groupId];
    };
    if (_mountedIn != "" && {_mountedIn != _attachedTo}) then {
        throw format ["Virtual group %1 mountedIn=%2 differs from attachedTo=%3", _groupId, _mountedIn, _attachedTo];
    };
    if (_attachedTo != "") then {
        if !(_attachedTo in _groups) then {
            throw format ["Virtual group %1 references missing carrier %2", _groupId, _attachedTo];
        };
        private _carrier = _groups get _attachedTo;
        if ((_carrier get "side") != (_groupData get "side")) then {
            throw format ["Virtual group %1 and carrier %2 have different sides", _groupId, _attachedTo];
        };
        if (_checkManifests && {!(_groupId in (_carrier get "attachedGroups"))}) then {
            throw format ["Carrier %1 does not reciprocate passenger %2", _attachedTo, _groupId];
        };
    };
    if ((count _passengers) != (count (_passengers arrayIntersect _passengers))) then {
        throw format ["Virtual group %1 has duplicate passenger references", _groupId];
    };
    {
        if !(_x isEqualType "" && {_x in _groups}) then {
            throw format ["Carrier %1 references missing or invalid passenger %2", _groupId, _x];
        };
        private _passenger = _groups get _x;
        if (_x == _groupId || {(_passenger get "side") != (_groupData get "side")}) then {
            throw format ["Carrier %1 has a self or foreign-side passenger %2", _groupId, _x];
        };
        if (_checkManifests && {(_passenger get "attachedTo") != _groupId}) then {
            throw format ["Passenger %1 does not reciprocate carrier %2", _x, _groupId];
        };
    } forEach _passengers;
    if (_checkManifests && {(_groupData get "isTransport") != (_passengers isNotEqualTo [])}) then {
        throw format ["Virtual group %1 carrier flag does not match its passenger manifest", _groupId];
    };
    private _organicParent = _groupData get "organicPackageParentGroupId";
    if (_organicParent != "" && {!(_organicParent in _groups)}) then {
        throw format ["Virtual group %1 references missing organic parent %2", _groupId, _organicParent];
    };
} forEach _groups;

// Complete each ancestry once, including nested carriers, without a live lookup.
private _complete = createHashMap;
{
    private _current = _x;
    private _visiting = createHashMap;
    while {_current != "" && {!(_current in _complete)}} do {
        if (_current in _visiting) then {
            throw format ["Transport relationship is cyclic at group %1", _current];
        };
        _visiting set [_current, true];
        _current = (_groups get _current) get "attachedTo";
    };
    { _complete set [_x, true]; } forEach _visiting;
} forEach _groups;

true
