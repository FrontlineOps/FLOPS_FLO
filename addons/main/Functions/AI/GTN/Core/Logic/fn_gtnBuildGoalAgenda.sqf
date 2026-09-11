/* Rank concrete goals; execution managers never select a different objective. */
params ["_commander"];
private _world = _commander get "_worldState";
private _objectives = _world get "_objectives";
private _picture = _world get "_strategicPicture";
private _side = _commander get "_ownSide";
private _cache = _commander get "_objectiveAssignmentCache";
private _active = createHashMap;
{ _active set [format ["%1:%2", _y get "kind", _y get "objectiveId"], true] } forEach (_commander get "_intents");
private _agenda = [];
private _config = _commander get "_config";
private _airPicture = _world get "_airThreatPicture";
private _minefieldCandidates = _commander get "_minefieldCandidates";
private _now = diag_tickTime;
private _supportPicture = _commander get "_frontlineSupportPicture";
{
    private _id = _x;
    private _objective = _y;
    private _strategic = _picture get _id;
    private _candidates = [];
    if ((_objective get "owner") == _side) then {
        private _garrisons = (_cache get "garrisonCounts") getOrDefault [_id, 0];
        private _defenders = (_cache get "defenderCounts") getOrDefault [_id, 0];
        private _garrisonCap = _commander call ["_getGarrisonCapForObjective", [_id]];
        private _defenseCap = _commander call ["_getDefenseCapForObjective", [_id]];
        if (_garrisons < _garrisonCap) then {
            _candidates pushBack ["GARRISON", 25 + (_strategic get "defenseScore") + 10 * (_garrisonCap - _garrisons)];
        };
        if ((_objective get "underAttack" || {_objective get "contested"}) && {_defenders < _defenseCap}) then {
            _candidates pushBack ["DEFEND", 170 + (_strategic get "defenseScore") + 8 * (_defenseCap - _defenders)];
        };
        if ((_strategic get "enemyLinks") > 0) then {
            if (_id in _airPicture && {(_airPicture get _id) >= (_config get "frontlineCAPMinThreatScore")} && {_now >= ((_commander get "_frontlineCAPLocks") getOrDefault [_id, -1])} && {_world call ["_isAssetAvailable", ["cap"]]}) then {
                _candidates pushBack ["CAP", (_strategic get "defenseScore") + (_airPicture get _id)];
            };
            if (_id in _minefieldCandidates) then { _candidates pushBack ["MINEFIELD", (_strategic get "defenseScore") - 20] };
        };
    } else {
        if ((_strategic get "sources") isNotEqualTo []) then {
            _candidates pushBack ["CAPTURE", (_strategic get "attackScore") + 50];
            if (_id in _supportPicture) then {
                private _contact = _supportPicture get _id;
                if ((_contact get "confidence") >= ((_commander get "_config") get "frontlineSupportMinimumConfidence")) then {
                    private _supportScore = (_strategic get "attackScore") + (_contact get "score");
                    private _attackers = (_cache get "attackCounts") getOrDefault [_id, 0];
                    if ((_contact get "score") + 3 * _attackers >= (_config get "frontlineArtilleryMinScore") && {_now >= ((_commander get "_frontlineArtilleryLocks") getOrDefault [_id, -1])} && {_world call ["_isAssetAvailable", ["artillery"]]}) then { _candidates pushBack ["ARTILLERY", _supportScore] };
                    if (_attackers >= (_config get "frontlineCASMinAttackers") && {(_contact get "score") + 5 * _attackers >= (_config get "frontlineCASMinScore")} && {_now >= ((_commander get "_frontlineCASLocks") getOrDefault [_id, -1])} && {_world call ["_isAssetAvailable", ["cas"]]}) then { _candidates pushBack ["CAS", _supportScore] };
                };
            };
        };
    };
    {
        _x params ["_kind", "_score"];
        private _key = format ["%1:%2", _kind, _id];
        if (_key in _active) then { continue };
        private _retry = (_commander get "_intentRetryAt") getOrDefault [_key, -1];
        if (diag_tickTime < _retry) then { continue };
        _agenda pushBack [-_score, _id, _kind];
    } forEach _candidates;
} forEach _objectives;
_agenda sort true;
_commander set ["_goalAgenda", _agenda];
_agenda
