/*
 * Function: FLO_fnc_gtnCommander
 * Author: Frontline Operations Development Group
 * 
 * Description:
 * Goal Task Network Commander - Main integration point for GTN-based AI Commander.
 * Creates and manages all GTN subsystems (World State, Goal Library, Planner, Executor, Monitor).
 * Provides the main update loop that drives goal-driven behavior.
 *
 * Arguments:
 * 0: Commander Host <HASHMAP> - Host object for GTN integration
 * 1: Side Context <HASHMAP> - Normalized own/enemy side context
 *
 * Return Value:
 * GTN Commander HashMap Object <HASHMAP>
 *
 * Example:
 * private _gtnCmdr = [_host, [east] call FLO_fnc_gtnSideContext] call FLO_fnc_gtnCommander;
 * _gtnCmdr call ["_start", []];
 */

params [
    ["_commander", nil],
    ["_sideContext", createHashMap]
];

if (isNil "_commander") exitWith {
    ["GTN", 1, "GTN Commander requires commander reference"] call FLO_fnc_log;
    nil
};

if (isNil "_sideContext" || {(!(_sideContext isEqualType createHashMap))} || {_sideContext isEqualTo []}) then {
    _sideContext = [east] call FLO_fnc_gtnSideContext;
};

private _ownSide = _sideContext get "ownSide";
private _enemySide = _sideContext get "enemySide";
private _sideKey = _sideContext get "sideKey";

["GTN", 3, format["Initializing GTN Commander System (%1)", _sideKey]] call FLO_fnc_log;

// Create all subsystems
private _worldState = [_sideContext] call FLO_fnc_gtnWorldState;
private _goalLibrary = call FLO_fnc_gtnGoalLibrary;
private _executor = [_commander, _sideContext] call FLO_fnc_gtnExecutor;
private _capabilityAnalyzer = call FLO_fnc_gtnCapabilityAnalyzer;
private _artilleryManager = call FLO_fnc_gtnArtilleryManager;

// Defense & Offensive Data
private _tempoInterval = ([_ownSide, "tempo"] call FLO_fnc_gtnGetSideCommanderHandle) get "value";
private _attackCoverage = ([_ownSide, "attackCoverage"] call FLO_fnc_gtnGetSideCommanderHandle) get "value";
private _defenseCoverage = ([_ownSide, "defenseCoverage"] call FLO_fnc_gtnGetSideCommanderHandle) get "value";
private _garrisonHandle = [_ownSide, "garrison"] call FLO_fnc_gtnGetSideCommanderHandle;
private _garrisonRearBaseGroups = _garrisonHandle get "rearBaseGroups";
private _garrisonFrontlineBaseGroups = _garrisonHandle get "frontlineBaseGroups";
private _garrisonPriorityBonusGroups = _garrisonHandle get "priorityBonusGroups";
private _garrisonHotBonusGroups = _garrisonHandle get "hotBonusGroups";

private _tracks = [];

_worldState set ["_updateInterval", _tempoInterval];

private _gtnCommander = createHashMapObject [[
    // Subsystem references
    ["_commander", _commander],
    ["_sideContext", _sideContext],
    ["_ownSide", _ownSide],
    ["_enemySide", _enemySide],
    ["_sideKey", _sideKey],
    ["_worldState", _worldState],
    ["_goalLibrary", _goalLibrary],
    ["_executor", _executor],
    ["_capabilityAnalyzer", _capabilityAnalyzer],
    ["_artilleryManager", _artilleryManager],
    
    // Lifecycle state
    ["_isRunning", 0],
    ["_updateInterval", _tempoInterval],
    ["_lastUpdate", 0],
    
    ["_tracks", _tracks],
    ["_intents", createHashMap], ["_nextIntentId", 0],
    ["_intentRetryAt", createHashMap], ["_goalAgenda", []],
    ["_nextTrackExecutionIndex", 0],
    ["_strategicOrderBudgetRemaining", 0],
    ["_strategicOrderBudgetIssued", 0],
    ["_strategicOrderBudgetSkipped", 0],
    ["_strategicOrderBudgetByType", createHashMap],
    ["_attackFrontlineObjectives", createHashMap],
    ["_attackFrontlineDirty", true],
    ["_attackSourceObjectivesCache", createHashMap],
    ["_lastFriendlyObjectiveOwnershipSignature", ""],
    ["_objectiveAssignmentCache", createHashMapFromArray [
        ["attackCounts", createHashMap],
        ["attackGroupIds", []],
        ["orderedGroupIds", []],
        ["garrisonCounts", createHashMap],
        ["defenderCounts", createHashMap],
        ["garrisonGroupsByObjective", createHashMap],
        ["garrisonPositionsByObjective", createHashMap],
        ["claimedPositionsByObjective", createHashMap]
    ]],
    ["_reserveBandsCache", createHashMap],
    ["_frontlineCAPLocks", createHashMap],
    ["_frontlineArtilleryLocks", createHashMap],
    ["_frontlineCASLocks", createHashMap],
    ["_frontlineSupportPicture", createHashMap],
    ["_frontlineSupportPictureBuiltAt", -1],
    ["_playerSupportRequests", []],
    ["_playerSupportPlayerCooldowns", createHashMap],
    ["_playerSupportObjectiveLocks", createHashMap],
    ["_intelDirty", true],
    ["_lastIntelPublishAt", -1],
    ["_lastIntelDirtyAt", -1],
    ["_lastIntelDirtyReason", ""],
    ["_lastCommanderIntelPublishSignature", ""],
    ["_lastCommanderIntelOwnerSignature", ""],
    ["_lastCommanderIntelPublishedAt", -1],
    ["_minefieldCandidates", createHashMap],
    ["_minefieldDirty", true],
    ["_lastMinefieldRunAt", -1],
    
    // Configuration
    ["_config", createHashMapFromArray [
        ["goalsAdmittedPerCycle", 12], ["maxActiveGoals", 64],
        ["operationalReserveShare", 0.15], ["assaultForceRatio", 2],
        ["assaultMinimumPower", 12], ["intentWithdrawalLossFraction", 0.4],
        ["replanInterval", 60],       // Minimum seconds between replans
        ["casualtyThreshold", 0.2],   // Force loss ratio to trigger replan
        ["defenseLeaseSeconds", 300], // Release long-idle DEFEND groups back into the task pool
        ["intelPublishMinInterval", 30], // Commander COP publishing is player-facing and does not need a full refresh every cycle
        ["intelPublishForceRefreshInterval", 180], // Re-send unchanged commander COP state periodically so late-joining clients catch up
        ["minefieldRefreshMinSeconds", 90], // Frontline obstacle fields are strategic shaping work and should not rebuild every commander cycle
        ["minefieldMaxFields", 4], // Limit tracked defensive fields per side so the commander shapes the front instead of blanketing the map
        ["minefieldPlacementsPerCycle", 2], // Limit how many new fields one commander can lay on a single strategic update
        ["attackCoverageMultiplier", _attackCoverage], // Selects the per-objective assault force cap
        ["defenseCoverageMultiplier", _defenseCoverage], // Scales friendly objective security demand
        ["defenseObjectiveBaseMin", 2], // Quiet or low-contact objectives should not automatically pull four-plus defenders
        ["defenseObjectiveEnemyMultiplier", 1.0], // Defense scaling should follow enemy strength more conservatively than before
        ["defenseObjectiveUnderAttackBonus", 2], // Active pressure raises the cap, but not by an entire extra squad stack
        ["defenseObjectiveContestedBonus", 1], // Contested ownership gets a small cap bump instead of a large dogpile bonus
        ["defenseObjectiveDeficitMultiplier", 0.25], // Local force deficits should raise defense demand gradually, not explosively
        ["defenseObjectiveHardCap", 8], // Hard ceiling for total defenders on one objective
        ["attackObjectiveGroupCap", 6], // Maximum force committed to one objective
        ["garrisonRearBaseGroups", _garrisonRearBaseGroups], // Minimum standing rear garrison on owned quiet objectives
        ["garrisonFrontlineBaseGroups", _garrisonFrontlineBaseGroups], // Minimum standing garrison on owned objectives exposed to enemy adjacency
        ["garrisonPriorityBonusThreshold", 60], // Important objectives receive one extra standing garrison group
        ["garrisonPriorityBonusGroups", _garrisonPriorityBonusGroups], // High-priority objectives keep one more standing holder before surge defense fills
        ["garrisonHotBonusGroups", _garrisonHotBonusGroups], // Objectives already under pressure keep an extra baseline holder even before reactive defense fills
        ["garrisonObjectiveHardCap", 4], // Baseline garrisons should stay lean so defense reserves can move instead of ossifying
        ["frontlineCAPMinThreatScore", 70], // Only spend CAP when recent enemy air contacts near a frontline sector are meaningful
        ["frontlineCAPContactFreshSeconds", 360], // Ignore stale air contacts for CAP scoring
        ["frontlineCAPContactRadiusMeters", 4000], // Friendly frontline sectors only count air contacts in their local airspace
        ["frontlineCAPObjectiveLockSeconds", 720], // CAP missions loiter for a while; keep sectors locked longer than CAS
        ["frontlineSupportPictureIntervalSeconds", 30], // Re-associate maintained contacts with the current direct frontline on a bounded cadence
        ["frontlineSupportMinimumConfidence", 0.25], // Autonomous fires require maintained contact confidence
        ["frontlineSupportContactMaxAgeSeconds", 900], // Match the maintained World State contact retention window
        ["frontlineSupportContactFreshSeconds", 240], // Exact virtual target identities require recent maintained contact
        ["frontlineSupportAssociationRadius", 2000], // Associate reported contacts with their nearest reachable frontline axis
        ["frontlineArtilleryMinScore", 55], // Avoid spending a battery mission on one weak, low-confidence report
        ["frontlineArtilleryObjectiveLockSeconds", 300], // Keep one axis from consuming every side-level artillery window
        ["frontlineArtilleryRetrySeconds", 60], // Failed authorization retries are paced instead of attempted every commander cycle
        ["frontlineArtilleryRounds", 6], // Autonomous frontline missions use the standard six-round battery package
        ["frontlineArtilleryFreshAccuracy", 100], // Fresh observed contacts receive ordinary dispersion
        ["frontlineArtilleryStaleAccuracy", 190], // Old contact areas widen as positional uncertainty grows
        ["frontlineCASMinAttackers", 0], // Maintained contacts remain eligible without an existing ground commitment; active attackers increase target score
        ["frontlineCASMinScore", 80], // Prevent trivial objectives from consuming air support
        ["frontlineCASObjectiveLockSeconds", 420], // Cooldown per objective so repeated cycles do not spam CAS on the same target
        ["frontlineCASRetrySeconds", 90], // Failed sortie authorization is retried on a bounded cadence
        ["playerSupportRequestExpireSeconds", 150], // Player support requests should expire instead of sitting forever in the queue
        ["playerSupportMaxQueuedRequests", 12], // Per-side player support queue cap so spam does not crowd out the commander
        ["playerSupportMaxAssignmentsPerCycle", 1], // One player support assignment per commander cycle keeps support spending paced
        ["playerSupportObjectiveSnapRadiusMeters", 600], // Free-point support requests still attach to a nearby sector for context when one is close enough
        ["playerSupportMapCooldownBucketMeters", 500], // Free-point support requests lock a coarse local map bucket when no sector context exists
        ["playerSupportArtilleryDangerCloseMeters", 250], // Artillery requests must clear a larger safety bubble
        ["playerSupportCASDangerCloseMeters", 175], // CAS requests still need a friendlies exclusion radius
        ["playerSupportArtilleryRounds", 6], // Default player-requested artillery salvo size
        ["playerSupportArtilleryAccuracy", 100], // Default player-requested artillery dispersion in meters
        ["playerSupportPlayerCooldownArtillerySeconds", 120], // Repeat artillery asks from one player should pace out
        ["playerSupportPlayerCooldownCASSeconds", 240], // Repeat CAS asks from one player should pace out
        ["playerSupportPlayerCooldownCAPSeconds", 300], // Repeat CAP asks from one player should pace out
        ["playerSupportObjectiveCooldownArtillerySeconds", 180], // Prevent repeated artillery hits on the same sector or map area from player spam
        ["playerSupportObjectiveCooldownCASSeconds", 300], // Prevent repeated CAS cycling on the same sector or map area from player spam
        ["playerSupportObjectiveCooldownCAPSeconds", 360], // Keep one sector or map area from monopolizing CAP coverage
        ["defenseContestedCollapseForceRatio", 0.65], // Below this friendly/enemy ratio on a contested owned objective, surge defense stops feeding a collapse
        ["defenseContestedCollapseCap", 5], // Collapse-level contested objectives are stabilized with a limited holding force instead of full-cap dogpiles
        ["strategicOrderAssignmentsPerCycle", 16], // Shared bounded order work after garrison ownership
        ["maxTrackTasksPerCycle", 2] // Primitive burst cap per track per commander update
    ]],
    
    // Statistics
    ["_stats", createHashMapFromArray [
        ["cyclesRun", 0],
        ["plansCreated", 0],
        ["tasksExecuted", 0],
        ["replans", 0],
        ["startTime", 0]
    ]],
    ["_perf", createHashMapFromArray [
        ["enabled", true],
        ["logThresholdMs", 20],
        ["orderLogThresholdMs", 8],
        ["lastCycleMs", 0],
        ["peakCycleMs", 0],
        ["slowCycles", 0],
        ["lastPhaseMs", createHashMapFromArray [
            ["normalizeTasked", 0],
            ["worldState", 0],
            ["intelPublish", 0],
            ["attackAssignments", 0],
            ["frontlineSupport", 0],
            ["garrisons", 0],
            ["allocateTracks", 0],
            ["executeTracks", 0],
            ["frontlineCAP", 0],
            ["frontlineArtillery", 0],
            ["frontlineCAS", 0],
            ["playerSupport", 0],
            ["defenseLeases", 0],
            ["minefields", 0],
            ["staticAA", 0]
        ]],
        ["lastMetrics", createHashMap]
    ]],
    
    // === MAIN CONTROL ===
    
    // Start the GTN commander
    ["_start", {
        if ((_self get "_isRunning") isEqualTo 1) exitWith {
            ["GTN", 3, "GTN Commander already running"] call FLO_fnc_log;
        };

        _self set ["_isRunning", 1];

        private _stats = _self get "_stats";
        _stats set ["startTime", diag_tickTime];

        // Initialize track system
        _self call ["_initializeTracks", []];

        private _restoredAssignmentCache = [_self] call FLO_fnc_gtnBuildObjectiveAssignmentCache;
        _self set ["_objectiveAssignmentCache", _restoredAssignmentCache];
        _self set ["_gtnTaskedGroups", +(_restoredAssignmentCache get "orderedGroupIds")];

        { _self call ["_taskGroups", [_y get "groupIds"]] } forEach (_self get "_intents");
        ["GTN", 3, format ["GTN %1 started: activeIntents=%2 tempo=%3s", _self get "_sideKey", count (_self get "_intents"), _self get "_updateInterval"]] call FLO_fnc_log;
    }],

    // Stop the GTN commander
    ["_stop", {
        private _intents = _self get "_intents";
        { [_self, _intents get _x, false, "COMMANDER_STOPPED"] call FLO_fnc_gtnRetireIntent } forEach (keys _intents);
        _self set ["_isRunning", 0];
        ["GTN", 3, format ["GTN commander %1 stopped", _self get "_sideKey"]] call FLO_fnc_log;
    }],

    // Main update cycle - call this from commander's update loop
    ["_update", {
        if ((_self get "_isRunning") isEqualTo 0 || {!FLO_MissionReady}) exitWith {};
        [_self] call FLO_fnc_gtnUpdateCommander
    }],
    
    // === TRACK SYSTEM ===
    
    // Initialize track planners
    ["_initializeTracks", {
        private _tracks = _self get "_tracks";
        {
            private _id = _x;
            if ((_tracks findIf { (_x get "id") == _id }) < 0) then { [_self, _y] call FLO_fnc_gtnCreateIntentTrack };
        } forEach (_self get "_intents");
    }],

    // Protect mobile defense, then assign the surviving pool directly to frontline attacks.

    
    // A ready track owns its planner/monitor. Rotate fairly without goal-name filters.
    ["_executeAllTracks", { [_self] call FLO_fnc_gtnExecuteIntents }],

    // Get groups from a track's pool

    
    // Set a track's goal dynamically


    // === CONFIGURATION ===

    ["_configure", {
        params ["_key", "_value"];
        private _config = _self get "_config";
        _config set [_key, _value];

        // Apply relevant config to subsystems
        if (_key == "replanInterval") then {
            { (_x get "monitor") call ["_setThresholds", [nil, _value]] } forEach (_self get "_tracks");
        };

        if (_key == "casualtyThreshold") then {
            { (_x get "monitor") call ["_setThresholds", [_value, nil]] } forEach (_self get "_tracks");
        };
    }],

    // === QUERY METHODS ===

    ["_getWorldState", {
        _self get "_worldState"
    }],



    ["_getStats", {
        _self get "_stats"
    }],

    ["_getPerf", {
        _self get "_perf"
    }],

    ["_getSideContext", {
        _self get "_sideContext"
    }],

    ["_getOwnSide", {
        _self get "_ownSide"
    }],

    ["_getEnemySide", {
        _self get "_enemySide"
    }],

    // === TACTICAL METHODS (used by executor handlers) ===





    ["_manageCompletedAttackAssignments", {
        [_self] call FLO_fnc_gtnReleaseCompletedAttackAssignments
    }],

    ["_resetStrategicOrderBudget", {
        private _limit = [_self, "strategicOrderAssignmentsPerCycle"] call FLO_fnc_gtnGetTempoScaledAssignmentLimit;
        _self set ["_strategicOrderBudgetRemaining", _limit];
        _self set ["_strategicOrderBudgetIssued", 0];
        _self set ["_strategicOrderBudgetSkipped", 0];
        _self set ["_strategicOrderBudgetByType", createHashMap];
    }],

    ["_hasStrategicOrderBudget", {
        (_self get "_strategicOrderBudgetRemaining") > 0
    }],

    ["_consumeStrategicOrderBudget", {
        params [["_orderType", "UNKNOWN", [""]]];

        private _remaining = _self get "_strategicOrderBudgetRemaining";
        if (_remaining <= 0) exitWith {
            _self set ["_strategicOrderBudgetSkipped", (_self get "_strategicOrderBudgetSkipped") + 1];
            false
        };

        _self set ["_strategicOrderBudgetRemaining", _remaining - 1];
        _self set ["_strategicOrderBudgetIssued", (_self get "_strategicOrderBudgetIssued") + 1];

        private _byType = _self get "_strategicOrderBudgetByType";
        private _count = if (_orderType in _byType) then { _byType get _orderType } else { 0 };
        _byType set [_orderType, _count + 1];
        true
    }],

    ["_refundStrategicOrderBudget", {
        params [["_orderType", "UNKNOWN", [""]]];

        private _issued = _self get "_strategicOrderBudgetIssued";
        private _byType = _self get "_strategicOrderBudgetByType";
        if (_issued <= 0 || {!(_orderType in _byType)} || {(_byType get _orderType) <= 0}) then {
            throw format ["Cannot refund unissued strategic %1 order budget", _orderType];
        };
        _self set ["_strategicOrderBudgetRemaining", (_self get "_strategicOrderBudgetRemaining") + 1];
        _self set ["_strategicOrderBudgetIssued", _issued - 1];
        private _typeCount = (_byType get _orderType) - 1;
        if (_typeCount == 0) then {
            _byType deleteAt _orderType;
        } else {
            _byType set [_orderType, _typeCount];
        };
        true
    }],

    ["_getStrategicOrderBudgetMetrics", {
        private _limit = [_self, "strategicOrderAssignmentsPerCycle"] call FLO_fnc_gtnGetTempoScaledAssignmentLimit;
        createHashMapFromArray [
            ["limit", _limit],
            ["issued", _self get "_strategicOrderBudgetIssued"],
            ["remaining", _self get "_strategicOrderBudgetRemaining"],
            ["skipped", _self get "_strategicOrderBudgetSkipped"],
            ["byType", _self get "_strategicOrderBudgetByType"]
        ]
    }],

    // Groups currently tasked by GTN (prevent AI Commander from using them)
    ["_gtnTaskedGroups", []],

    ["_normalizeTaskedGroups", {
        private _groups = call FLO_fnc_virtualizationGetGroupMap;
        private _tasked = _self get "_gtnTaskedGroups";
        private _before = count _tasked;
        _tasked = _tasked select { _x in _groups };
        _self set ["_gtnTaskedGroups", _tasked];
        createHashMapFromArray [["beforeCount", _before], ["afterCount", count _tasked], ["changed", _before != count _tasked]]
    }],

    // Mark groups as tasked by GTN
    ["_taskGroups", {
        params ["_groupIds"];
        private _tasked = _self get "_gtnTaskedGroups";
        { _tasked pushBackUnique _x; } forEach _groupIds;
        _self set ["_gtnTaskedGroups", _tasked];
    }],

    // Remove stale group references after virtualization removes a group entry.
    ["_onVirtualGroupRemoved", {
        params ["_groupId"];

        private _tasked = _self get "_gtnTaskedGroups";
        if (_groupId in _tasked) then {
            _self set ["_gtnTaskedGroups", _tasked - [_groupId]];
        };

        [_self, _groupId] call FLO_fnc_gtnHandleRemovedIntentGroup;

    }],

    // Release groups from GTN tasking and clear their orders
    ["_releaseGroups", {
        params [["_groupIds", []], ["_newOrder", ""]];
        private _tasked = _self get "_gtnTaskedGroups";
        private _groups = call FLO_fnc_virtualizationGetGroupMap;
        
        {
            private _groupId = _x;
            _tasked = _tasked - [_groupId];
            
            // Clear the group's commanderOrder so it becomes available again
            private _gData = _groups get _groupId;
            if (!isNil "_gData") then {
                [_gData] call FLO_fnc_virtualizationClearCommanderOrder;
                if (_newOrder != "") then {
                    [_gData, _newOrder] call FLO_fnc_virtualizationSetCommanderOrder;
                };
                ["GTN", 5, format["Released group %1, order reset to '%2'", _groupId, _newOrder]] call FLO_fnc_log;
            };
        } forEach _groupIds;
        
        _self set ["_gtnTaskedGroups", _tasked];
    }],

    // Dynamic cap for how many groups should defend a single objective.
    ["_getDefenseCapForObjective", {
        params ["_objectiveId"];

        private _ws = _self get "_worldState";
        private _objectives = _ws call ["_getObjectives", []];
        if !(_objectiveId in _objectives) exitWith { 0 };

        private _obj = _objectives get _objectiveId;
        private _enemyCount = _obj get "enemyCount";
        private _friendlyCount = _obj get "friendlyCount";
        private _underAttack = _obj get "underAttack";
        private _contested = _obj get "contested";
        private _config = _self get "_config";
        private _coverage = _config get "defenseCoverageMultiplier";

        private _cap = (_config get "defenseObjectiveBaseMin") max (ceil (_enemyCount * (_config get "defenseObjectiveEnemyMultiplier")));
        if (_underAttack) then { _cap = _cap + (_config get "defenseObjectiveUnderAttackBonus"); };
        if (_contested) then { _cap = _cap + (_config get "defenseObjectiveContestedBonus"); };

        private _deficit = (_enemyCount - _friendlyCount) max 0;
        if (_deficit > 0) then {
            _cap = _cap + (ceil (_deficit * (_config get "defenseObjectiveDeficitMultiplier")));
        };

        _cap = ceil (_cap * _coverage);
        _cap = (_cap max (_config get "defenseObjectiveBaseMin")) min (_config get "defenseObjectiveHardCap");

        if (_contested && {_enemyCount > 0}) then {
            private _forceRatio = _friendlyCount / _enemyCount;
            if (_forceRatio < (_config get "defenseContestedCollapseForceRatio")) then {
                _cap = _cap min (_config get "defenseContestedCollapseCap");
            };
        };

        _cap
    }],

    // Baseline standing garrison cap for owned objectives.
    ["_getGarrisonCapForObjective", {
        params ["_objectiveId"];
        if (_objectiveId == "") exitWith { 0 };

        private _ws = _self get "_worldState";
        private _objectives = _ws call ["_getObjectives", []];
        if !(_objectiveId in _objectives) exitWith { 0 };

        private _obj = _objectives get _objectiveId;
        private _ownSide = _self get "_ownSide";
        if ((_obj get "owner") != _ownSide) exitWith { 0 };
        if !([_ownSide, _objectiveId] call FLO_fnc_campaignCanSupportObjective) exitWith { 0 };

        private _config = _self get "_config";
        private _cap = _config get "garrisonRearBaseGroups";
        private _enemyLinkedCount = 0;

        {
            private _linkedObjective = _objectives get _x;
            if (isNil "_linkedObjective") then { continue };
            if ((_linkedObjective get "owner") == (_self get "_enemySide")) then {
                _enemyLinkedCount = _enemyLinkedCount + 1;
            };
        } forEach (_obj get "linkedObjectives");

        if (_enemyLinkedCount > 0) then {
            _cap = _config get "garrisonFrontlineBaseGroups";
        };

        if ((_obj get "priority") >= (_config get "garrisonPriorityBonusThreshold")) then {
            _cap = _cap + (_config get "garrisonPriorityBonusGroups");
        };

        if ((_obj get "underAttack") || (_obj get "contested")) then {
            _cap = _cap + (_config get "garrisonHotBonusGroups");
        };

        private _defenseCap = _self call ["_getDefenseCapForObjective", [_objectiveId]];
        (_cap max 0) min ((_config get "garrisonObjectiveHardCap") min _defenseCap)
    }],

    // Friendly-held linked objectives that can directly source an attack on this enemy objective.
    ["_getFriendlyAttackSourceObjectives", {
        params ["_objectiveId"];
        if (_objectiveId == "") exitWith { [] };

        private _ws = _self get "_worldState";
        private _objectives = _ws get "_objectives";
        private _objective = _objectives get _objectiveId;
        private _ownSide = _self get "_ownSide";
        private _linkedObjectives = _objective get "linkedObjectives";
        private _cache = _self get "_attackSourceObjectivesCache";

        if (_objectiveId in _cache) exitWith {
            _cache get _objectiveId
        };

        private _sourceObjectives = _linkedObjectives select {
            ((_objectives get _x) get "owner") isEqualTo _ownSide
            && {[_x] call FLO_fnc_campaignIsObjectiveIntegrated}
        };
        _cache set [_objectiveId, _sourceObjectives];

        _sourceObjectives
    }],

    ["_refreshAttackFrontline", {
        private _ws = _self get "_worldState";
        private _strictFrontlineObjectives = _ws call ["_getFrontlineEnemyObjectives", []];
        _self set ["_attackFrontlineObjectives", _strictFrontlineObjectives];
        _self set ["_attackFrontlineDirty", false];
        _strictFrontlineObjectives
    }],

    ["_getAttackFrontlineEnemyObjectives", {
        if (_self get "_attackFrontlineDirty") exitWith {
            _self call ["_refreshAttackFrontline", []]
        };

        _self get "_attackFrontlineObjectives"
    }],

    // Count current defenders assigned to a specific objective.
    ["_countObjectiveDefenders", {
        params ["_objectiveId"];
        if (_objectiveId == "") exitWith { 0 };

        private _groups = call FLO_fnc_virtualizationGetGroupMap;
        private _ownSide = _self get "_ownSide";
        private _count = 0;

        {
            private _gData = _y;
            if ((_gData get "side") != _ownSide) then { continue };
            if ((_gData get "commanderIntent") != "") then { continue };
            if ((_gData get "groupType") == "static_aa") then { continue };
            private _order = _gData get "commanderOrder";
            if (_order == "DEFEND") then {
                if ((_gData get "defendObjective") != _objectiveId) then { continue };
            } else {
                if (_order != "GARRISON") then { continue };
                if ((_gData get "garrisonObjective") != _objectiveId) then { continue };
            };
            _count = _count + 1;
        } forEach _groups;

        _count
    }],

    // Release DEFEND groups that are idle past lease expiry and not under pressure.
    ["_manageDefenseLeases", {
        private _tasked = +(_self get "_gtnTaskedGroups");
        private _metrics = createHashMapFromArray [
            ["taskedCount", count _tasked],
            ["leaseIssuedCount", 0],
            ["holdRefreshCount", 0],
            ["lostObjectiveReleaseCount", 0],
            ["invalidObjectiveCount", 0],
            ["trimmedExcess", 0],
            ["releasedCount", 0]
        ];
        if (_tasked isEqualTo []) exitWith { _metrics };

        private _groups = call FLO_fnc_virtualizationGetGroupMap;
        private _ownSide = _self get "_ownSide";
        private _ws = _self get "_worldState";
        private _objectives = _ws call ["_getObjectives", []];
        private _leaseSeconds = (_self get "_config") get "defenseLeaseSeconds";
        private _now = diag_tickTime;
        private _releaseIds = [];

        {
            private _groupId = _x;
            private _gData = _groups get _groupId;

            if (isNil "_gData") then {
                _releaseIds pushBack _groupId;
                continue;
            };
            if ((_gData get "side") != _ownSide) then { continue };
            if ((_gData get "commanderIntent") != "") then { continue };
            if ((_gData get "groupType") == "static_aa") then { continue };
            if ((_gData get "commanderOrder") != "DEFEND") then { continue };
            if (_gData getOrDefault ["inCombat", false]) then { continue };

            private _objId = _gData get "defendObjective";
            if !(_objId in _objectives) then {
                _metrics set ["invalidObjectiveCount", (_metrics get "invalidObjectiveCount") + 1];
                ["GTN", 2, format["Defense lease: group %1 has invalid defendObjective (%2), releasing", _groupId, _objId]] call FLO_fnc_log;
                _releaseIds pushBack _groupId;
                continue;
            };

            private _obj = _objectives get _objId;
            if ((_obj get "owner") != _ownSide) then {
                _metrics set ["lostObjectiveReleaseCount", (_metrics get "lostObjectiveReleaseCount") + 1];
                ["GTN", 2, format["Defense lease: group %1 releasing from lost objective %2", _groupId, _objId]] call FLO_fnc_log;
                _releaseIds pushBack _groupId;
                continue;
            };

            private _leaseUntil = _gData get "defendLeaseUntil";
            if (_leaseUntil < 0) then {
                [_gData, _now, _now + _leaseSeconds] call FLO_fnc_virtualizationRefreshDefendLease;
                _metrics set ["leaseIssuedCount", (_metrics get "leaseIssuedCount") + 1];
                continue;
            };
            if (_now < _leaseUntil) then { continue };

            private _hold = false;
            _hold = (_obj get "contested") || (_obj get "underAttack");

            if (_hold) then {
                [_gData, _now, _now + _leaseSeconds] call FLO_fnc_virtualizationRefreshDefendLease;
                _metrics set ["holdRefreshCount", (_metrics get "holdRefreshCount") + 1];
            } else {
                _releaseIds pushBack _groupId;
            };
        } forEach _tasked;

        // Trim excess defenders above per-objective cap (idle only).
        private _idleDefendersByObjective = createHashMap;
        {
            private _groupId = _x;
            if (_groupId in _releaseIds) then { continue };

            private _gData = _groups get _groupId;
            if (isNil "_gData") then { continue };
            if ((_gData get "side") != _ownSide) then { continue };
            if ((_gData get "commanderIntent") != "") then { continue };
            if ((_gData get "groupType") == "static_aa") then { continue };
            if ((_gData get "commanderOrder") != "DEFEND") then { continue };
            if (_gData getOrDefault ["inCombat", false]) then { continue };

            private _objId = _gData get "defendObjective";
            if (_objId == "") then { continue };

            private _bucket = _idleDefendersByObjective getOrDefault [_objId, []];
            _bucket pushBack _groupId;
            _idleDefendersByObjective set [_objId, _bucket];
        } forEach _tasked;

        {
            private _objId = _x;
            private _bucket = +(_idleDefendersByObjective get _objId);
            private _cap = _self call ["_getDefenseCapForObjective", [_objId]];
            if (_cap <= 0) then { continue };

            private _excess = (count _bucket) - _cap;
            if (_excess <= 0) then { continue };

            _excess = _excess min count _bucket;
            if (_excess <= 0) then { continue };

            for "_i" from 1 to _excess do {
                if (_bucket isEqualTo []) exitWith {};
                _releaseIds pushBackUnique (_bucket deleteAt ((count _bucket) - 1));
            };
            _metrics set ["trimmedExcess", (_metrics get "trimmedExcess") + _excess];

            ["GTN", 3, format[
                "Defense cap trim at %1: released %2 excess defenders (cap=%3)",
                _objId,
                _excess,
                _cap
            ]] call FLO_fnc_log;
        } forEach (keys _idleDefendersByObjective);

        if (_releaseIds isEqualTo []) exitWith { _metrics };

        {
            private _gData = _groups get _x;
            if (isNil "_gData") then { continue };
            [_gData] call FLO_fnc_virtualizationClearMissionLock;
                    [_gData, "idle"] call FLO_fnc_virtualizationSetRuntimeState;
        } forEach _releaseIds;

        _self call ["_releaseGroups", [_releaseIds, ""]];
        _metrics set ["releasedCount", count _releaseIds];
        ["GTN", 3, format["Defense lease release: %1 groups returned to pool", count _releaseIds]] call FLO_fnc_log;

        _metrics
    }],

    // Order group to move using virtualization waypoints
    ["_orderGroupMove", {
        params ["_groupId", "_pos", ["_mode", "AWARE"]];

        private _groups = call FLO_fnc_virtualizationGetGroupMap;
        private _gData = _groups get _groupId;
        if (isNil "_gData") exitWith {
            ["GTN", 2, format["Cannot order move - group %1 not found", _groupId]] call FLO_fnc_log;
            false
        };

        if (!(_pos isEqualType []) || {count _pos < 2}) exitWith {
            ["GTN", 2, format["Cannot order move - invalid destination for %1: %2", _groupId, _pos]] call FLO_fnc_log;
            false
        };

        private _existingTarget = _gData get "orderTargetPos";
        private _existingMode = _gData get "orderMode";
        private _hasRouteContext = ((_gData get "waypoints") isNotEqualTo []) || {(_gData get "pathToken") >= 0};
        if ((_gData get "commanderOrder") == "MOVE" && {_existingMode == _mode} && {_hasRouteContext} && {count _existingTarget >= 2} && {_existingTarget distance2D _pos < 35}) exitWith {
            if (isNil "FLO_GTN_OrderNoOps") then { FLO_GTN_OrderNoOps = createHashMap; };
            FLO_GTN_OrderNoOps set ["MOVE", (FLO_GTN_OrderNoOps getOrDefault ["MOVE", 0]) + 1];
            _self call ["_taskGroups", [[_groupId]]];
            true
        };

        private _formation = selectRandom ["STAG COLUMN", "WEDGE", "VEE", "DIAMOND", "LINE", "COLUMN"];

        private _waypoints = [
            [_pos, "MOVE", _mode, "FULL", _formation, "YELLOW", 30]
        ];

        private _commitResult = [_groupId, _gData, "MOVE", _waypoints, _pos, "GTN_MOVE", "", _mode] call FLO_fnc_virtualizationCommitCommanderOrder;
        if !(_commitResult select 0) exitWith { false };

        // Mark as tasked
        _self call ["_taskGroups", [[_groupId]]];

        ["GTN", 5, format["Ordered group %1 to move to %2 (%3)", _groupId, _pos, _mode]] call FLO_fnc_log;
        true
    }],

    // Order group to attack using virtualization waypoints
    ["_orderGroupAttack", {
        params [
            "_groupId",
            "_attackPos",
            ["_objectiveId", ""],
            ["_consumeAssignmentBudget", false, [true]]
        ];

        if (_objectiveId == "") then {
            throw "GTN ATTACK requires an objective";
        };

        private _groups = call FLO_fnc_virtualizationGetGroupMap;
        private _gData = _groups get _groupId;
        if (isNil "_gData") exitWith {
            ["GTN", 2, format["Cannot order attack - group %1 not found", _groupId]] call FLO_fnc_log;
            false
        };

        if (!(_attackPos isEqualType []) || {count _attackPos < 2}) then {
            throw format ["GTN ATTACK has invalid target position for %1: %2", _groupId, _attackPos];
        };

        private _ownSide = _self get "_ownSide";
        if !([_gData, _ownSide, ["infantry", "motorized", "mechanized", "armor"]] call FLO_fnc_gtnGroupIsStrategicallyAssignable) exitWith {
            ["GTN", 2, format[
                "Cannot order attack - group %1 not strategically assignable (type=%2 lock=%3 replacement=%4 transport=%5 attached=%6 mounted=%7)",
                _groupId,
                _gData get "groupType",
                _gData get "missionLock",
                _gData get "replacementState",
                _gData get "transportRole",
                _gData get "attachedTo",
                _gData get "mountedIn"
            ]] call FLO_fnc_log;
            false
        };

        private _existingAttackObjective = _gData get "attackObjective";
        private _hasRouteContext = ((_gData get "waypoints") isNotEqualTo []) || {(_gData get "pathToken") >= 0};
        if (
            (_gData get "commanderOrder") == "ATTACK"
            && {_hasRouteContext}
            && {_existingAttackObjective == _objectiveId}
        ) exitWith {
            if (isNil "FLO_GTN_OrderNoOps") then { FLO_GTN_OrderNoOps = createHashMap; };
            FLO_GTN_OrderNoOps set ["ATTACK", (FLO_GTN_OrderNoOps getOrDefault ["ATTACK", 0]) + 1];
            _self call ["_taskGroups", [[_groupId]]];
            true
        };

        if (_consumeAssignmentBudget && {!(_self call ["_consumeStrategicOrderBudget", ["ATTACK"]])}) exitWith {
            ["GTN", 4, format["Skipped ATTACK order for %1: strategic order budget exhausted", _groupId]] call FLO_fnc_log;
            false
        };

        private _formation = selectRandom ["STAG COLUMN", "WEDGE", "VEE", "DIAMOND", "LINE", "COLUMN"];

        private _waypoints = [
            [_attackPos, "MOVE", "AWARE", "FULL", _formation, "YELLOW", 75],
            [_attackPos, "MOVE", "AWARE", "FULL", _formation, "YELLOW", 50]
        ];

        private _commitResult = [
            _groupId,
            _gData,
            "ATTACK",
            _waypoints,
            _attackPos,
            "GTN_ATTACK",
            _objectiveId,
            "",
            -1,
            -1
        ] call FLO_fnc_virtualizationCommitCommanderOrder;
        _commitResult params ["_commitSuccess", "_routeMs", "_assignMs", "_transportMs", "_orderMs"];
        if (!_commitSuccess) exitWith {
            if (_consumeAssignmentBudget) then {
                _self call ["_refundStrategicOrderBudget", ["ATTACK"]];
            };
            false
        };

        [_self, "ATTACK", _groupId, _gData get "groupType", _objectiveId, _routeMs, _assignMs, _transportMs, _orderMs] call FLO_fnc_gtnLogStrategicOrderPerf;

        private _assignmentCache = _self get "_objectiveAssignmentCache";
        private _attackCounts = _assignmentCache get "attackCounts";
        private _count = if (_objectiveId in _attackCounts) then { _attackCounts get _objectiveId } else { 0 };
        _attackCounts set [_objectiveId, _count + 1];

        // Mark as tasked
        _self call ["_taskGroups", [[_groupId]]];

        ["GTN", 5, format["Ordered group %1 to attack %2 (%3)", _groupId, _attackPos, _objectiveId]] call FLO_fnc_log;
        true
    }],

    // Order group to defend using virtualization waypoints
    ["_orderGroupDefend", {
        params ["_groupId", "_pos", ["_objectiveId", ""], ["_skipSaturationCheck", false, [true]], ["_consumeAssignmentBudget", false, [true]]];

        private _groups = call FLO_fnc_virtualizationGetGroupMap;
        private _gData = _groups get _groupId;
        if (isNil "_gData") exitWith {
            ["GTN", 2, format["Cannot order defend - group %1 not found", _groupId]] call FLO_fnc_log;
            false
        };

        if (!(_pos isEqualType []) || {count _pos < 2}) exitWith {
            ["GTN", 2, format["Cannot order defend - invalid destination for %1: %2", _groupId, _pos]] call FLO_fnc_log;
            false
        };

        private _ownSide = _self get "_ownSide";
        if !([_gData, _ownSide, ["infantry", "motorized", "mechanized", "armor"], []] call FLO_fnc_gtnGroupIsStrategicallyAssignable) exitWith {
            ["GTN", 2, format[
                "Cannot order defend - group %1 not strategically assignable (type=%2 lock=%3 replacement=%4 transport=%5 attached=%6 mounted=%7)",
                _groupId,
                _gData get "groupType",
                _gData get "missionLock",
                _gData get "replacementState",
                _gData get "transportRole",
                _gData get "attachedTo",
                _gData get "mountedIn"
            ]] call FLO_fnc_log;
            false
        };

        private _alreadyAssigned = false;
        private _saturated = false;
        if (_objectiveId != "") then {
            private _hasRouteContext = ((_gData get "waypoints") isNotEqualTo []) || {(_gData get "pathToken") >= 0};
            private _sameObjectiveAssigned = ((_gData get "commanderOrder") == "DEFEND") && {(_gData get "defendObjective") == _objectiveId} && {_hasRouteContext};
            private _currentDefendPos = _gData get "orderTargetPos";
            private _sameHoldPos = _currentDefendPos isEqualType [] && {count _currentDefendPos >= 2} && {(_currentDefendPos distance2D _pos) < 20};
            _alreadyAssigned = _sameObjectiveAssigned && {_sameHoldPos};
            if (!_sameObjectiveAssigned && {!_skipSaturationCheck}) then {
                private _assigned = _self call ["_countObjectiveDefenders", [_objectiveId]];
                private _cap = _self call ["_getDefenseCapForObjective", [_objectiveId]];
                if (_cap > 0 && {_assigned >= _cap}) then {
                    ["GTN", 3, format[
                        "Defend order skipped for %1: %2 already saturated (%3/%4)",
                        _groupId,
                        _objectiveId,
                        _assigned,
                        _cap
                    ]] call FLO_fnc_log;
                    _saturated = true;
                };
            };
        };

        if (_alreadyAssigned) exitWith {
            if (isNil "FLO_GTN_OrderNoOps") then { FLO_GTN_OrderNoOps = createHashMap; };
            FLO_GTN_OrderNoOps set ["DEFEND", (FLO_GTN_OrderNoOps getOrDefault ["DEFEND", 0]) + 1];
            private _leaseSeconds = (_self get "_config") get "defenseLeaseSeconds";
            [_gData, diag_tickTime, diag_tickTime + _leaseSeconds] call FLO_fnc_virtualizationRefreshDefendLease;
            true
        };

        if (_saturated) exitWith { false };

        if (_consumeAssignmentBudget && {!(_self call ["_consumeStrategicOrderBudget", ["DEFEND"]])}) exitWith {
            ["GTN", 4, format["Skipped DEFEND order for %1: strategic order budget exhausted", _groupId]] call FLO_fnc_log;
            false
        };

        private _formation = selectRandom ["STAG COLUMN", "WEDGE", "VEE", "DIAMOND", "LINE", "COLUMN"];

        private _waypoints = [
            [_pos, "MOVE", "AWARE", "FULL", _formation, "YELLOW", 40],
            [_pos, "GUARD", "AWARE", "FULL", _formation, "YELLOW", 60]
        ];

        private _leaseSeconds = (_self get "_config") get "defenseLeaseSeconds";
        private _commitResult = [_groupId, _gData, "DEFEND", _waypoints, _pos, "GTN_DEFEND", _objectiveId, "", diag_tickTime, diag_tickTime + _leaseSeconds] call FLO_fnc_virtualizationCommitCommanderOrder;
        _commitResult params ["_commitSuccess", "_routeMs", "_assignMs", "_transportMs", "_orderMs"];
        if (!_commitSuccess) exitWith {
            if (_consumeAssignmentBudget) then {
                _self call ["_refundStrategicOrderBudget", ["DEFEND"]];
            };
            false
        };
        [_self, "DEFEND", _groupId, _gData get "groupType", _objectiveId, _routeMs, _assignMs, _transportMs, _orderMs] call FLO_fnc_gtnLogStrategicOrderPerf;

        if (_objectiveId != "") then {
            private _assignmentCache = _self get "_objectiveAssignmentCache";
            private _defenderCounts = _assignmentCache get "defenderCounts";
            private _claimedPositions = _assignmentCache get "claimedPositionsByObjective";

            private _count = if (_objectiveId in _defenderCounts) then {
                _defenderCounts get _objectiveId
            } else {
                0
            };
            _defenderCounts set [_objectiveId, _count + 1];

            private _bucket = if (_objectiveId in _claimedPositions) then {
                _claimedPositions get _objectiveId
            } else {
                []
            };
            _bucket pushBack _pos;
            _claimedPositions set [_objectiveId, _bucket];
        };

        // Mark as tasked
        _self call ["_taskGroups", [[_groupId]]];

        ["GTN", 5, format["Ordered group %1 to defend %2", _groupId, _pos]] call FLO_fnc_log;
        true
    }],

    // Order group to hold a standing garrison on an owned objective.
    ["_orderGroupGarrison", {
        params ["_groupId", "_routePlan", ["_objectiveId", ""], ["_consumeAssignmentBudget", false, [true]]];

        private _groups = call FLO_fnc_virtualizationGetGroupMap;
        private _gData = _groups get _groupId;
        if (isNil "_gData") exitWith {
            ["GTN", 2, format["Cannot order garrison - group %1 not found", _groupId]] call FLO_fnc_log;
            false
        };

        if !(_routePlan isEqualType createHashMap) then {
            throw format ["Cannot order garrison %1 with route-plan type %2", _groupId, typeName _routePlan];
        };
        private _pos = _routePlan get "targetPos";
        private _waypoints = _routePlan get "waypoints";
        private _orderMode = _routePlan get "orderMode";
        if (!(_pos isEqualType []) || {count _pos < 2}) exitWith {
            ["GTN", 2, format["Cannot order garrison - invalid destination for %1: %2", _groupId, _pos]] call FLO_fnc_log;
            false
        };
        if (_waypoints isEqualTo [] || {!(_orderMode in ["GARRISON_BUILDING", "GARRISON_PATROL"])}) then {
            throw format ["Cannot order garrison %1 with invalid route mode/topology %2/%3", _groupId, _orderMode, count _waypoints];
        };

        private _ownSide = _self get "_ownSide";
        if !([_gData, _ownSide, ["infantry", "motorized", "mechanized", "armor"], []] call FLO_fnc_gtnGroupIsStrategicallyAssignable) exitWith {
            ["GTN", 2, format[
                "Cannot order garrison - group %1 not strategically assignable (type=%2 lock=%3 replacement=%4 transport=%5 attached=%6 mounted=%7)",
                _groupId,
                _gData get "groupType",
                _gData get "missionLock",
                _gData get "replacementState",
                _gData get "transportRole",
                _gData get "attachedTo",
                _gData get "mountedIn"
            ]] call FLO_fnc_log;
            false
        };

        private _hasRouteContext = ((_gData get "waypoints") isNotEqualTo []) || {(_gData get "pathToken") >= 0};
        private _currentGarrisonPos = _gData get "garrisonPosition";
        private _sameHoldPos = _currentGarrisonPos isEqualType [] && {count _currentGarrisonPos >= 2} && {(_currentGarrisonPos distance2D _pos) < 20};
        if (
            (_gData get "commanderOrder") == "GARRISON"
            && {(_gData get "garrisonObjective") == _objectiveId}
            && {(_gData get "orderMode") == _orderMode}
            && {_hasRouteContext}
            && {_sameHoldPos}
        ) exitWith {
            if (isNil "FLO_GTN_OrderNoOps") then { FLO_GTN_OrderNoOps = createHashMap; };
            FLO_GTN_OrderNoOps set ["GARRISON", (FLO_GTN_OrderNoOps getOrDefault ["GARRISON", 0]) + 1];
            _self call ["_taskGroups", [[_groupId]]];
            true
        };

        if (_consumeAssignmentBudget && {!(_self call ["_consumeStrategicOrderBudget", ["GARRISON"]])}) exitWith {
            ["GTN", 4, format["Skipped GARRISON order for %1: strategic order budget exhausted", _groupId]] call FLO_fnc_log;
            false
        };

        private _commitResult = [
            _groupId,
            _gData,
            "GARRISON",
            _waypoints,
            _pos,
            _orderMode,
            _objectiveId,
            _orderMode
        ] call FLO_fnc_virtualizationCommitCommanderOrder;
        _commitResult params ["_commitSuccess", "_routeMs", "_assignMs", "_transportMs", "_orderMs"];
        if (!_commitSuccess) exitWith {
            if (_consumeAssignmentBudget) then {
                _self call ["_refundStrategicOrderBudget", ["GARRISON"]];
            };
            false
        };
        [_self, "GARRISON", _groupId, _gData get "groupType", _objectiveId, _routeMs, _assignMs, _transportMs, _orderMs] call FLO_fnc_gtnLogStrategicOrderPerf;

        if (_objectiveId != "") then {
            private _assignmentCache = _self get "_objectiveAssignmentCache";
            private _garrisonCounts = _assignmentCache get "garrisonCounts";
            private _defenderCounts = _assignmentCache get "defenderCounts";
            private _claimedPositions = _assignmentCache get "claimedPositionsByObjective";

            private _garrisonCount = if (_objectiveId in _garrisonCounts) then {
                _garrisonCounts get _objectiveId
            } else {
                0
            };
            _garrisonCounts set [_objectiveId, _garrisonCount + 1];

            private _defenderCount = if (_objectiveId in _defenderCounts) then {
                _defenderCounts get _objectiveId
            } else {
                0
            };
            _defenderCounts set [_objectiveId, _defenderCount + 1];

            private _bucket = if (_objectiveId in _claimedPositions) then {
                _claimedPositions get _objectiveId
            } else {
                []
            };
            _bucket pushBack _pos;
            _claimedPositions set [_objectiveId, _bucket];
        };

        _self call ["_taskGroups", [[_groupId]]];

        ["GTN", 5, format["Ordered group %1 to garrison %2 mode=%3", _groupId, _objectiveId, _orderMode]] call FLO_fnc_log;
        true
    }],

    // Request an air mission using the GTN air support system.
    ["_requestAirMission", {
        params ["_pos", ["_missionType", "CAS"], ["_meta", createHashMap]];
        private _ownSide = _self get "_ownSide";

        private _ato = call FLO_fnc_gtnAirTaskOrder;
        private _altitude = 150;

        _ato call ["_addTask", [_pos, _missionType, "", _altitude, _ownSide, _meta]];
        private _assignedCount = _ato call ["_processTasks", []];
        private _success = _assignedCount > 0;

        if (_success) then {
            ["GTN", 3, format["Air mission queued: %1 at %2", _missionType, _pos]] call FLO_fnc_log;
        } else {
            ["GTN", 4, format["Air mission request rejected for %1 at %2; reason recorded by ATO", _missionType, _pos]] call FLO_fnc_log;
        };

        _success
    }],

    // Request CAS using the GTN air support system
    ["_requestCAS", {
        params ["_pos", ["_missionType", "CAS"], ["_meta", createHashMap]];
        _self call ["_requestAirMission", [_pos, _missionType, _meta]]
    }],

    // Request CAP using the GTN air support system
    ["_requestCAP", {
        params ["_pos", ["_meta", createHashMap]];
        _self call ["_requestAirMission", [_pos, "CAP", _meta]]
    }],

    // Static AA deployment finalization
    // - Static AA groups are created by logistics network
    // - Commander only finalizes deployment when movers reach target
    ["_manageStaticAANetwork", {
        private _groups = call FLO_fnc_virtualizationGetGroupMap;
        private _ownSide = _self get "_ownSide";
        private _metrics = createHashMapFromArray [
            ["groupCount", count (keys _groups)],
            ["movingStaticAACount", 0],
            ["deployedCount", 0]
        ];

        // Phase 1: finalize in-transit static AA deployments
        {
            private _groupId = _x;
            private _gData = _groups get _groupId;
            if (isNil "_gData") then { continue };

            if ((_gData get "groupType") != "static_aa") then { continue };
            if ((_gData get "side") != _ownSide) then { continue };
            if (([_gData] call FLO_fnc_virtualizationGetAADeployState) != "MOVING") then { continue };
            _metrics set ["movingStaticAACount", (_metrics get "movingStaticAACount") + 1];

            private _targetPos = [_gData] call FLO_fnc_virtualizationGetAATargetPos;
            if (count _targetPos < 2) then { continue };
            if ((_gData get "position") distance2D _targetPos > 120) then { continue };

            if !([_groupId, [], true, "GTN_AA_DEPLOYED"] call FLO_fnc_updateVirtualGroupWaypoints) then {
                throw format ["Static AA %1 route clear was rejected", _groupId];
            };
            [
                _groupId,
                createHashMapFromArray [
                    ["forceVirtual", false],
                    ["noWaypoints", true],
                    ["alwaysActive", false]
                ]
            ] call FLO_fnc_virtualizationPatchGroup;
            [_gData, "AA_HOLD"] call FLO_fnc_virtualizationClearReplacementTransit;
            [_gData, "DEPLOYED", _targetPos, [_gData] call FLO_fnc_virtualizationGetAATargetObjective, _gData get "isStrategicAA"] call FLO_fnc_virtualizationSetAADeployState;

            ["GTN", 3, format[
                "Static AA %1 deployed at %2 (objective %3)",
                _groupId,
                _targetPos,
                [_gData] call FLO_fnc_virtualizationGetAATargetObjective
            ]] call FLO_fnc_log;
            _metrics set ["deployedCount", (_metrics get "deployedCount") + 1];
        } forEach (keys _groups);

        _metrics
    }],

    // === DEBUG ===
    
    // Per-cycle decision summary - single line showing all track states
    ["_logDecisionSummary", {
        private _tracks = _self get "_tracks";
        private _tasked = _self get "_gtnTaskedGroups";
        private _summary = [];
        
        {
            private _track = _x;
            private _trackId = _track get "id";
            private _goal = _track get "goal";
            private _pool = count (_track get "groupPool");
            private _planner = _track get "planner";
            
            private _planStatus = if (!isNil "_planner") then {
                _planner call ["_getPlanStatus", []]
            } else { "NO_PLAN" };
            
            private _taskInfo = if (!isNil "_planner") then {
                private _task = _planner call ["_getCurrentTask", []];
                if (!isNil "_task") then {
                    _task get "taskId"
                } else { "-" }
            } else { "-" };
            
            private _shortGoal = _goal select [0, 12]; // First 12 chars
            _summary pushBack format["%1(%2):%3|p=%4|t=%5",
                _trackId, _shortGoal, _planStatus, _pool, _taskInfo];
        } forEach _tracks;
        
        ["GTN", 3, format["DECISION[tasked=%1]: %2", count _tasked, _summary joinString " | "]] call FLO_fnc_log;
    }],
    
    // Debug why groups aren't available - call this when commander seems stuck
    ["_debugGroupAvailability", {
        private _groups = call FLO_fnc_virtualizationGetGroupMap;
        private _gtnTasked = _self get "_gtnTaskedGroups";
        private _ownSide = _self get "_ownSide";
        
        private _stats = createHashMapFromArray [
            ["total", 0],
            ["wrongSide", 0],
            ["wrongType", 0],
            ["airArtillery", 0],
            ["inCombat", 0],
            ["gtnTasked", 0],
            ["busyOrder", 0],
            ["available", 0]
        ];
        
        private _orderBreakdown = createHashMap;
        
        {
            private _groupId = _x;
            private _gData = _y;
            
            _stats set ["total", (_stats get "total") + 1];
            
            private _groupType = _gData get "groupType";
            private _currentOrder = _gData get "commanderOrder";
            private _side = _gData get "side";
            private _inCombat = _gData getOrDefault ["inCombat", false];
            
            // Track order distribution
            private _orderKey = [_currentOrder, "IDLE"] select (_currentOrder == "");
            private _orderCount = if (_orderKey in _orderBreakdown) then {
                _orderBreakdown get _orderKey
            } else {
                0
            };
            _orderBreakdown set [_orderKey, _orderCount + 1];
            
            // Check filters
            if (_side != _ownSide) exitWith { _stats set ["wrongSide", (_stats get "wrongSide") + 1] };
            if (_groupType in ["civilian", "ambient"]) exitWith { _stats set ["wrongType", (_stats get "wrongType") + 1] };
            if (_groupType in ["helicopter", "jet", "air", "artillery"]) exitWith { _stats set ["airArtillery", (_stats get "airArtillery") + 1] };
            if (_inCombat) exitWith { _stats set ["inCombat", (_stats get "inCombat") + 1] };
            if (_groupId in _gtnTasked) exitWith { _stats set ["gtnTasked", (_stats get "gtnTasked") + 1] };
            if (_currentOrder != "" && {!(_currentOrder in ["PATROL", "GARRISON", "DEFEND", ""])}) exitWith { 
                _stats set ["busyOrder", (_stats get "busyOrder") + 1] 
            };
            
            _stats set ["available", (_stats get "available") + 1];
        } forEach _groups;
        
        // Build order breakdown string
        private _orderStr = [];
        { _orderStr pushBack format["%1=%2", _x, _y]; } forEach _orderBreakdown;
        
        ["GTN", 3, format["GROUP AVAILABILITY: total=%1—wrongSide=%2,wrongType=%3,air/arty=%4,gtnTasked=%5,busyOrder=%6—AVAILABLE=%7",
            _stats get "total",
            _stats get "wrongSide",
            _stats get "wrongType",
            _stats get "airArtillery",
            _stats get "gtnTasked",
            _stats get "busyOrder",
            _stats get "available"
        ]] call FLO_fnc_log;
        
        ["GTN", 3, format["GROUP AVAILABILITY DETAIL: inCombat=%1", _stats get "inCombat"]] call FLO_fnc_log;
        ["GTN", 3, format["ORDER BREAKDOWN: %1", _orderStr joinString ", "]] call FLO_fnc_log;
        
        // Return stats for programmatic use
        _stats
    }],
    
    // List all groups with their current orders
    ["_debugListOrders", {
        private _groups = call FLO_fnc_virtualizationGetGroupMap;
        private _gtnTasked = _self get "_gtnTaskedGroups";
        private _ownSide = _self get "_ownSide";
        
        ["GTN", 3, "=== GROUP ORDER LISTING ==="] call FLO_fnc_log;
        
        {
            private _groupId = _x;
            private _gData = _y;
            
            private _side = _gData get "side";
            if (_side != _ownSide) then { continue };
            
            private _groupType = _gData get "groupType";
            private _currentOrder = _gData get "commanderOrder";
            private _unitCount = _gData get "unitCount";
            private _isTasked = _groupId in _gtnTasked;
            
            private _shortId = _groupId select [7, 8];
            ["GTN", 3, format["  %1: type=%2, order=%3, units=%4, gtnTasked=%5",
                _shortId, _groupType, _currentOrder, _unitCount, _isTasked
            ]] call FLO_fnc_log;
        } forEach _groups;
    }],

    ["_debugPrint", {
        format ["GTN %1 running=%2 stats=%3 activeIntents=%4 agenda=%5", _self get "_sideKey", _self get "_isRunning", _self get "_stats", count (_self get "_intents"), count (_self get "_goalAgenda")]
    }],

    // Full status dump for debugging
    ["_dumpStatus", {
        ["GTN", 3, "========== GTN COMMANDER DEBUG DUMP =========="] call FLO_fnc_log;
        
        // Core stats
        private _debug = _self call ["_debugPrint", []];
        ["GTN", 3, _debug] call FLO_fnc_log;
        
        // Group availability analysis
        _self call ["_debugGroupAvailability", []];
        
        // Track details
        private _tracks = _self get "_tracks";
        {
            private _track = _x;
            ["GTN", 3, format["TRACK %1: goal=%2, status=%3, poolSize=%4",
                _track get "id",
                _track get "goal",
                _track get "status",
                count (_track get "groupPool")
            ]] call FLO_fnc_log;
        } forEach _tracks;
        
        // List all group orders
        _self call ["_debugListOrders", []];
        
        ["GTN", 3, "========== END DEBUG DUMP =========="] call FLO_fnc_log;
        
        _debug
    }]
]];

// Link executor back to GTN commander (circular reference needed for handlers)
_executor call ["_setGTNCommander", [_gtnCommander]];
_worldState call ["_setCommander", [_gtnCommander]];
_gtnCommander call ["_initializeTracks", []];

["GTN", 3, "GTN Commander System initialized"] call FLO_fnc_log;

_gtnCommander
