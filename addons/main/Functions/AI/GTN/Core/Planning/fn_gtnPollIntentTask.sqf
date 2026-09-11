/* Execute one bounded phase through the owning movement/support systems. */
params ["_context"];
private _commander = _context get "commander";
private _intentId = (_context get "params") select 0;
private _intent = (_commander get "_intents") get _intentId;
private _world = _commander get "_worldState";
private _objective = (_world get "_objectives") get (_intent get "objectiveId");
private _phase = _intent get "phase";
private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _ids = _intent get "groupIds";
private _kind = _intent get "kind";
private _next = "";
private _failed = false;
switch (_phase) do {
    case "SCOUT": {
        if (_objective get "enemyStrengthKnown" && {(_objective get "enemyIntelConfidence") >= 0.5}) then {
            private _force = [_commander, _intent] call FLO_fnc_gtnIntentForceReady;
            if !(_force get "ready") then { _failed = true } else { _next = "ASSAULT" };
        } else {
            private _scoutId = _ids select 0;
            private _scout = _groups get _scoutId;
            private _issued = _intent get "issued";
            if !(_scoutId in _issued) then {
                if (_commander call ["_hasStrategicOrderBudget", []] && {(_scout get "attachedTo") == ""} && {(_scout get "mountedIn") == ""}) then {
                    private _heading = (_intent get "targetPos") getDir (_intent get "stagePos");
                    private _attempt = _intent get "scoutAttempt";
                    private _scoutPos = (_intent get "targetPos") getPos [((_objective get "radius") + 150) min 700, _heading + ([0, 45, -45] select _attempt)];
                    if (surfaceIsWater _scoutPos) then { _failed = true } else {
                        _failed = !([_commander, _intent, _scoutId, "MOVE", _scoutPos] call FLO_fnc_gtnIssueIntentOrder);
                    };
                };
            } else {
                if ((_scout get "position") distance2D (_scout get "orderTargetPos") < 80 && {diag_tickTime - (_intent get "phaseStartedAt") > 45}) then {
                    if ((_intent get "scoutAttempt") >= 2) then { _failed = true } else {
                        _intent set ["scoutAttempt", (_intent get "scoutAttempt") + 1];
                        _intent set ["issued", []];
                        _intent set ["phaseStartedAt", diag_tickTime];
                    };
                };
            };
        };
    };
    case "MUSTER";
    case "DISPATCH";
    case "ASSAULT": {
        if (_phase == "ASSAULT") then {
            if ((_objective get "owner") == (_commander get "_ownSide")) then { _next = "SECURE" } else {
                // A force must remain adequate at the commitment point.
                if !(([_commander, _intent] call FLO_fnc_gtnIntentForceReady) get "ready") then { _failed = true };
            };
        };
        // Do not launch one fragment because other goals consumed the remaining budget.
        private _openingBudget = _phase != "ASSAULT" || {
            (_commander get "_strategicOrderBudgetRemaining") >= count (_ids - (_intent get "issued"))
            && {(_ids findIf { private _group = _groups get _x; (_group get "inCombat") || {(_group get "attachedTo") != ""} || {(_group get "mountedIn") != ""} }) < 0}
        };
        if (!_failed && {_next == ""} && {_openingBudget}) then {
            private _order = switch (_phase) do {
                case "MUSTER": { "MOVE" };
                case "ASSAULT": { "ATTACK" };
                default { _kind };
            };
            private _pos = if (_phase == "MUSTER") then { _intent get "stagePos" } else { _intent get "targetPos" };
            {
                if !(_commander call ["_hasStrategicOrderBudget", []]) exitWith {};
                if (_x in (_intent get "issued")) then { continue };
                private _group = _groups get _x;
                if (_group get "inCombat") then { continue };
                if ((_group get "attachedTo") != "" || {(_group get "mountedIn") != ""}) then { continue };
                if !([_commander, _intent, _x, _order, _pos] call FLO_fnc_gtnIssueIntentOrder) exitWith { _failed = true };
            } forEach _ids;
            if (!_failed && {count (_intent get "issued") == count _ids}) then {
                _next = switch (_phase) do { case "MUSTER": {"ASSEMBLE"}; case "DISPATCH": {"ARRIVE"}; default {"SECURE"} };
            };
        };
    };
    case "ASSEMBLE": {
        private _force = [_commander, _intent, true] call FLO_fnc_gtnIntentForceReady;
        if ((_force get "groups") == count _ids) then {
            if (_force get "ready") then {_next = "SCOUT"} else {_failed = true};
        };
    };
    case "ARRIVE": {
        private _arrived = true;
        {
            private _group = _groups get _x;
            private _pos = if (_kind == "GARRISON") then { _group get "garrisonPosition" } else { _intent get "targetPos" };
            if ((_group get "position") distance2D _pos > ((_objective get "radius") max 80)
                || {(_group get "attachedTo") != ""} || {(_group get "mountedIn") != ""}) then { _arrived = false };
        } forEach _ids;
        if (_arrived) then { _next = "COMPLETE" };
    };
    case "SECURE": {
        if ((_objective get "owner") == (_commander get "_ownSide")) then {
            // Keep a real holding force throughout territory integration.
            {
                if !(_commander call ["_hasStrategicOrderBudget", []]) exitWith {};
                private _group = _groups get _x;
                if ((_group get "commanderOrder") == "DEFEND") then { continue };
                if (_group get "inCombat") then { continue };
                if ((_group get "attachedTo") != "" || {(_group get "mountedIn") != ""}) then { continue };
                if !([_commander, _intent, _x, "DEFEND", _intent get "targetPos"] call FLO_fnc_gtnIssueIntentOrder) exitWith { _failed = true };
            } forEach _ids;
            private _holding = (_ids findIf {
                private _group = _groups get _x;
                (_group get "commanderOrder") != "DEFEND" || {(_group get "position") distance2D (_intent get "targetPos") > ((_objective get "radius") max 80)}
                || {(_group get "attachedTo") != ""} || {(_group get "mountedIn") != ""}
            }) < 0;
            if (_objective get "integrated" && {_holding} && {!_failed}) then { _next = "COMPLETE" };
        } else {
            // A fresh unfavorable report can terminate an attack before total loss.
            if (_objective get "enemyStrengthKnown" && {(([_commander, _intent] call FLO_fnc_gtnIntentForceReady) get "power") < ((_objective get "enemyCount") * 0.8)}) then { _failed = true };
        };
    };
    case "REQUEST": {
        private _objectiveId = _intent get "objectiveId";
        private _accepted = switch (_kind) do {
            case "ARTILLERY": { ([_commander, _objectiveId] call FLO_fnc_gtnRequestFrontlineArtillery) get "authorized" };
            case "CAS": { ([_commander, _objectiveId] call FLO_fnc_gtnRequestFrontlineCAS) get "authorized" };
            case "CAP": { (([_commander, _objectiveId] call FLO_fnc_gtnRequestFrontlineCAP) get "requestedCount") > 0 };
            case "MINEFIELD": { (([_commander, _objectiveId] call FLO_fnc_gtnRequestObjectiveMinefield) get "enqueuedFields") > 0 };
            default { throw format ["GTN unknown support intent %1", _kind] };
        };
        if (_accepted) then { _next = "COMPLETE" } else { _failed = true };
    };
    default { throw format ["GTN cannot execute phase %1", _phase] };
};
if (_failed) then { _context set ["status", "FAILED"] };
if (_next != "" && {!_failed}) then {
    _intent set ["issued", []];
    [_commander, _intent, _next] call FLO_fnc_gtnSetIntentPhase;
    (_context get "data") set ["phaseCompleted", true];
};
true
