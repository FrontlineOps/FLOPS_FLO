#pragma hemtt ignore_variables ["_self"]
/* _senseEnemyIntel implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
private _intel = _self get "_enemyIntel";
private _contacts = _intel get "contactReports";
private _newContacts = [];
private _combatIntelAdded = 0;

// Remove old contacts
private _cutoffTime = diag_tickTime - 900;
_contacts = _contacts select { (_x select 1) > _cutoffTime };

private _ownSide = _self get "_ownSide";
private _enemySide = _self get "_enemySide";
private _scanLeaders = [];

if (!isNil "FLO_VirtualForceRegistry") then {
    private _groups = call FLO_fnc_virtualizationGetGroupMap;
    {
        private _gData = _y;
        if ((_gData get "side") != _ownSide) then { continue };
        if !(_gData get "isActive") then { continue };

        private _realGroup = _gData get "realGroup";
        if (isNull _realGroup) then { continue };

        private _leader = leader _realGroup;
        if (isNull _leader || {!alive _leader}) then { continue };
        _scanLeaders pushBack _leader;
    } forEach _groups;
};

// Human group knowledge feeds the same maintained contact picture as AI observers.
{
    if (!alive _x || {(side group _x) != _ownSide}) then { continue };
    private _leader = leader group _x;
    if (isNull _leader || {!alive _leader}) then { continue };
    _scanLeaders pushBackUnique _leader;
} forEach ([] call FLO_fnc_getConnectedHumanPlayers);

if (_scanLeaders isEqualTo []) then {
    {
        if (side _x != _ownSide) then { continue };
        private _leader = leader _x;
        if (isNull _leader || {!alive _leader}) then { continue };
        _scanLeaders pushBack _leader;
    } forEach allGroups;
};

private _scanTotal = count _scanLeaders;
private _scanCursor = _self get "_enemyIntelScanCursor";
private _scanBudget = _self get "_enemyIntelScanBudget";

if (_scanTotal > 0) then {
    if (_scanCursor >= _scanTotal) then { _scanCursor = 0; };
    if (_scanBudget < 1) then { _scanBudget = 1; };
    if (_scanBudget > _scanTotal) then { _scanBudget = _scanTotal; };

    for "_step" from 0 to (_scanBudget - 1) do {
        private _idx = (_scanCursor + _step) mod _scanTotal;
        private _leader = _scanLeaders select _idx;
        // nearTargets returns [pos, type, side, subjectiveCost, object, accuracy]
        private _targets = _leader nearTargets 1500;

        {
            _x params ["_pos", "_type", "_side", "_cost", "_obj", "_acc"];

            // Only report enemies for this side context.
            if (_side == _enemySide) then {
                if (isNull _obj) then { continue };
                // Refresh the observed entity, not every entity near its last position.
                private _existingIndex = _contacts findIf {
                    _x params ["_cPos", "_cTime", "_cStrength", "_cType", "_cConfidence", ["_cObject", objNull]];
                    _cObject isEqualTo _obj
                };
                private _sourceGroup = group (effectiveCommander _obj);
                private _sourceGroupId = _sourceGroup getVariable ["FLO_virtualGroupId", ""];
                // nearTargets accuracy is positional error; knowledge is documented 0..4.
                private _confidence = ((_leader knowsAbout _obj) / 4) max 0 min 1;
                private _report = [+_pos, diag_tickTime, 1, _type, _confidence, _obj, _sourceGroupId];
                if (_existingIndex >= 0) then {
                    _contacts set [_existingIndex, _report];
                } else {
                    _contacts pushBack _report;
                    _newContacts pushBack [_pos, _type];
                };
            };
        } forEach _targets;
    };

    _scanCursor = (_scanCursor + _scanBudget) mod _scanTotal;
} else {
    _scanCursor = 0;
};

_self set ["_enemyIntelScanCursor", _scanCursor];

private _combatIntelResult = [_self, _contacts] call FLO_fnc_gtnInjectCombatEventContacts;
_contacts = _combatIntelResult select 0;
_combatIntelAdded = _combatIntelResult select 1;
_self set ["_lastCombatIntelAdded", _combatIntelAdded];

// Cluster contacts into concentrations using 150m spatial buckets.
// This keeps complexity near O(n) instead of O(n^2) during large fights.
private _concentrations = [];
private _bucketSize = 150;
private _buckets = createHashMap;

{
    private _pos = _x select 0;
    private _bx = floor ((_pos select 0) / _bucketSize);
    private _by = floor ((_pos select 1) / _bucketSize);
    private _bKey = format ["%1_%2", _bx, _by];

    if !(_bKey in _buckets) then {
        _buckets set [_bKey, []];
    };
    private _bucket = _buckets get _bKey;
    _bucket pushBack _x;
    _buckets set [_bKey, _bucket];
} forEach _contacts;

{
    private _cluster = _y;
    if (count _cluster < 3) then { continue };

    private _centerPos = [0,0,0];
    private _clusStrength = 0;
    private _lastSeen = 0;
    {
        _centerPos = _centerPos vectorAdd (_x select 0);
        _clusStrength = _clusStrength + (_x select 2);
        if ((_x select 1) > _lastSeen) then {
            _lastSeen = _x select 1;
        };
    } forEach _cluster;
    _centerPos = _centerPos vectorMultiply (1 / count _cluster);

    _concentrations pushBack createHashMapFromArray [
        ["position", _centerPos],
        ["strength", _clusStrength],
        ["lastSeen", _lastSeen]
    ];
} forEach _buckets;

// Log significant new contacts
private _newContactTotal = (count _newContacts) + _combatIntelAdded;
if (_newContactTotal > 0) then {
     ["GTN", 3, format["New enemy contacts reported: %1 (observed=%2 combat=%3)", _newContactTotal, count _newContacts, _combatIntelAdded]] call FLO_fnc_log;
};

_intel set ["contactReports", _contacts];
_intel set ["concentrations", _concentrations];

// Estimate strength based on active reports
_intel set ["estimatedStrength", count _contacts]; // Rough estimate
_intel set ["lastContactTime", if (_contacts isNotEqualTo []) then {diag_tickTime} else { _intel get "lastContactTime" }];

// Threat level (0-10)
private _threatLevel = ((count _contacts) / 5) min 10;
_intel set ["threatLevel", _threatLevel];
_intel set [
    "knownGroupPicture",
    [
        _contacts,
        _self get "_objectives",
        _enemySide,
        _self get "_knownEnemyGroupFreshSeconds"
    ] call FLO_fnc_gtnBuildKnownEnemyGroupPicture
];

_self set ["_enemyIntel", _intel];
_intel
