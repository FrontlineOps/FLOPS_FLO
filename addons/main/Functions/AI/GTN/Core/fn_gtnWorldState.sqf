/*
 * Function: FLO_fnc_gtnWorldState
 * Author: Frontline Operations Development Group
 * 
 * Description:
 * Goal Task Network World State - Blackboard pattern implementation.
 * Maintains a centralized world state that all GTN components can query.
 * Sensors update the state, conditions query it, actions modify it.
 *
 * Arguments:
 * 0: Side Context <HASHMAP> - Normalized own/enemy side context
 *
 * Return Value:
 * World State HashMap Object <HASHMAP>
 *
 * Example:
 * private _worldState = [[east] call FLO_fnc_gtnSideContext] call FLO_fnc_gtnWorldState;
 * _worldState call ["_update", []];
 * private _objectives = _worldState call ["_getObjectives", []];
 */

params [["_sideContext", createHashMap]];

if (isNil "_sideContext" || {(!(_sideContext isEqualType createHashMap))} || {_sideContext isEqualTo []}) then {
    _sideContext = [east] call FLO_fnc_gtnSideContext;
};

private _ownSide = _sideContext get "ownSide";
private _enemySide = _sideContext get "enemySide";
private _sideKey = _sideContext get "sideKey";

["GTN", 3, "Initializing GTN World State System"] call FLO_fnc_log;

private _worldState = createHashMapObject [[
    // === STATE DATA ===
    
    // Objective state - keyed by objective ID
    ["_objectives", createHashMap],
    ["_objectiveIntel", createHashMap],
    ["_objectiveIntelMaxAge", 240],
    ["_objectiveObservationMetrics", createHashMap],
    ["_ownGroupFacts", createHashMap],
    ["_airThreatPicture", createHashMap],
    ["_scoutCursor", 0],
    ["_strategicPicture", createHashMap],
    
    // Force disposition
    ["_ownForces", createHashMapFromArray [
        ["totalGroups", 0],
        ["availableGroups", 0],
        ["attackingGroups", 0],
        ["defendingGroups", 0],
        ["garrisonedGroups", 0],
        ["infantryGroups", 0],
        ["armorGroups", 0],
        ["mechanizedGroups", 0],
        ["motorizedGroups", 0],
        ["artilleryGroups", 0],
        ["airGroups", 0]
    ]],
    
    // Support assets
    ["_supportAssets", createHashMapFromArray [
        ["artilleryAvailable", false],
        ["artilleryCooldown", 0],
        ["artilleryAmmo", 0],
        ["casAvailable", false],
        ["casCooldown", 0]
    ]],
    
    // Enemy intel
    ["_enemyIntel", createHashMapFromArray [
        ["knownPositions", []],
        ["contactReports", []],    // [Pos, Time, Strength, Type, Confidence, SourceObject?, SourceGroupId?, CombatZoneId?]
        ["estimatedStrength", 0],
        ["lastContactTime", 0],
        ["threatLevel", 0],
        ["concentrations", []],
        ["knownGroupPicture", createHashMapFromArray [
            ["groups", createHashMap],
            ["objectiveGroups", createHashMap],
            ["freshContactCount", 0],
            ["groupCount", 0],
            ["objectiveCount", 0],
            ["builtAt", -1]
        ]]
    ]],
    
    // Tactical situation
    ["_tacticalSituation", createHashMapFromArray [
        ["timeOfDay", "DAY"],
        ["weather", "CLEAR"],
        ["overallThreat", 0],
        ["momentum", 0],           // -100 (losing) to +100 (winning)
        ["initiativeHolder", "NEUTRAL"]
    ]],
    
    // State metadata
    ["_lastUpdate", 0],
    ["_updateInterval", 10],      // Seconds between full updates
    ["_lastSupportAssetsSense", -1],
    ["_supportAssetSenseInterval", 20],
    ["_lastEnemyIntelSense", -1],
    ["_enemyIntelSenseInterval", 30],
    ["_enemyIntelScanCursor", 0],
    ["_enemyIntelScanBudget", 24], // Max leaders to scan per intel pass
    ["_knownEnemyGroupFreshSeconds", 180],
    ["_airDefenseContacts", createHashMap], // Runtime reports; positions do not follow hidden AA movement.
    ["_airDefenseContactMaxAgeSeconds", 900],
    ["_combatIntelFreshSeconds", 240],
    ["_combatIntelLastProcessedAt", -1],
    ["_lastCombatIntelAdded", 0],
    ["_sideContext", _sideContext],
    ["_ownSide", _ownSide],
    ["_enemySide", _enemySide],
    ["_sideKey", _sideKey],
    ["_perf", createHashMapFromArray [
        ["lastUpdateMs", 0],
        ["peakUpdateMs", 0],
        ["slowUpdates", 0],
        ["lastRanAt", -1],
        ["lastPhaseMs", createHashMapFromArray [
            ["objectives", 0],
            ["forces", 0],
            ["supportAssets", 0],
            ["enemyIntel", 0],
            ["tacticalSituation", 0]
        ]],
        ["lastMeta", createHashMapFromArray [
            ["objectiveCount", 0],
            ["availableGroups", 0],
            ["contactCount", 0],
            ["combatContactCount", 0],
            ["concentrationCount", 0],
            ["knownGroupCount", 0],
            ["knownGroupObjectiveCount", 0],
            ["supportSenseRan", false],
            ["enemyIntelSenseRan", false]
        ]]
    ]],
    
    // Reference to AI Commander for integration
    ["_commander", nil],
    
    // === SENSOR METHODS ===
    
    // Update objective states from FLO_Objectives
    ["_senseObjectives", FLO_fnc_gtnSenseObjectives],
    
    // Update force disposition from virtualization system
    ["_senseForces", FLO_fnc_gtnSenseForces],

    // Update support asset availability
    ["_senseSupportAssets", FLO_fnc_gtnSenseSupportAssets],

    // Sense enemy intel from known contacts via actual reports
    ["_senseEnemyIntel", FLO_fnc_gtnSenseEnemyIntel],

    // Update tactical situation assessment
    ["_senseTacticalSituation", FLO_fnc_gtnSenseTacticalSituation],

    // === QUERY METHODS ===

    // Get all objectives
    ["_getObjectives", {
        _self get "_objectives"
    }],

    // Get objectives by filter
    ["_getObjectivesWhere", {
        params [["_filterFn", {true}]];
        private _result = createHashMap;
        private _objectives = _self get "_objectives";

        {
            private _obj = _objectives get _x;
            if ([_x, _obj] call _filterFn) then {
                _result set [_x, _obj];
            };
        } forEach (keys _objectives);

        _result
    }],

    // Get enemy objectives (not owned by us)
    ["_getEnemyObjectives", {
        _self call ["_getObjectivesWhere", [{
            params ["_id", "_obj"];
            (_obj get "owner") == (_self get "_enemySide")
        }]]
    }],

    // True when an enemy objective touches at least one friendly-held linked objective.
    ["_isFrontlineEnemyObjective", {
        params ["_objectiveId"];
        private _objectives = _self get "_objectives";
        private _obj = _objectives get _objectiveId;
        private _links = _obj get "linkedObjectives";
        private _ownSide = _self get "_ownSide";

        ({((_objectives get _x) get "owner") isEqualTo _ownSide} count _links) > 0
    }],

    // Enemy objectives currently on the front line (adjacent to friendly ownership).
    ["_getFrontlineEnemyObjectives", {
        _self call ["_getObjectivesWhere", [{
            params ["_id", "_obj"];
            (_obj get "owner") == (_self get "_enemySide")
            && { _self call ["_isFrontlineEnemyObjective", [_id]] }
        }]]
    }],

    ["_segmentCrossesWater", {
        params ["_fromPos", "_toPos"];
        private _dist = _fromPos distance2D _toPos;
        private _steps = ceil (_dist / 150);
        if (_steps < 1) then { _steps = 1 };

        private _crosses = false;
        for "_i" from 0 to _steps do {
            private _t = _i / _steps;
            private _samplePos = [
                (_fromPos select 0) + (((_toPos select 0) - (_fromPos select 0)) * _t),
                (_fromPos select 1) + (((_toPos select 1) - (_fromPos select 1)) * _t),
                0
            ];
            if (surfaceIsWater _samplePos) exitWith {
                _crosses = true;
            };
        };

        _crosses
    }],

    ["_getObjectiveLinkRouteInfo", {
        params ["_fromObjectiveId", "_toObjectiveId"];

        private _pair = [_fromObjectiveId, _toObjectiveId];
        _pair sort true;
        private _linkKey = format ["%1_%2", _pair select 0, _pair select 1];
        private _linkData = FLO_ObjectiveLinks get _linkKey;

        private _routeDistance = _linkData get "routeDistance";
        private _crossesWater = _linkData get "crossesWater";

        if (isNil "_routeDistance") then {
            private _fromPos = ((FLO_Objectives get _fromObjectiveId) get "position");
            private _toPos = ((FLO_Objectives get _toObjectiveId) get "position");
            _routeDistance = _fromPos distance2D _toPos;
            _crossesWater = _self call ["_segmentCrossesWater", [_fromPos, _toPos]];

            _linkData set ["routeDistance", _routeDistance];
            _linkData set ["crossesWater", _crossesWater];
            FLO_ObjectiveLinks set [_linkKey, _linkData];
        };

        createHashMapFromArray [
            ["distance", _routeDistance],
            ["crossesWater", _crossesWater]
        ]
    }],

    // Get friendly objectives (owned by us - OPFOR)
    ["_getFriendlyObjectives", {
        _self call ["_getObjectivesWhere", [{
            params ["_id", "_obj"];
            (_obj get "owner") == (_self get "_ownSide")
        }]]
    }],

    // Get force counts
    ["_getForces", {
        _self get "_ownForces"
    }],

    // Check if support asset is available
    ["_isAssetAvailable", {
        params ["_assetType"];
        private _assets = _self get "_supportAssets";

        switch (toLower _assetType) do {
            case "artillery": { _assets get "artilleryAvailable" };
            case "cas": { _assets get "casAvailable" };
            case "cap": { _assets get "casAvailable" };
            default { false };
        }
    }],

    ["_getTacticalSituation", {
        _self get "_tacticalSituation"
    }],

    ["_getEnemyIntel", {
        _self get "_enemyIntel"
    }],

    ["_getKnownEnemyGroupPicture", {
        (_self get "_enemyIntel") get "knownGroupPicture"
    }],

    ["_reportAirDefenseContact", {
        params ["_contactId", "_position", "_groupType"];
        [_self, _contactId, _position, _groupType] call FLO_fnc_gtnRecordAirDefenseContact
    }],

    ["_getKnownAirDefenseThreats", {
        [_self] call FLO_fnc_gtnGetKnownAirDefenseThreats
    }],

    ["_getPerf", {
        _self get "_perf"
    }],

    ["_getObjectiveIntel", {
        params ["_objId"];
        private _intelCache = _self get "_objectiveIntel";
        _intelCache getOrDefault [_objId, createHashMapFromArray [
            ["lastReconTime", 0],
            ["intelQuality", 0],
            ["confirmedStrength", 0],
            ["totalCombatPower", 0],
            ["hasArmor", false],
            ["hasAA", false],
            ["hasStatic", false],
            ["fortificationLevel", 0],
            ["recommendedForce", 0],
            ["defensePosture", "UNKNOWN"]
        ]]
    }],

    ["_isIntelFresh", {
        params ["_objId", ["_maxAge", 300]];
        private _intel = _self call ["_getObjectiveIntel", [_objId]];
        private _lastRecon = _intel get "lastReconTime";
        (_intel get "intelQuality") > 0 && {_lastRecon >= 0} && {diag_tickTime >= _lastRecon} && {(diag_tickTime - _lastRecon) < _maxAge}
    }],

    ["_updateObjectiveIntel", {
        params ["_objId", "_intelData", ["_deferObservations", false]];
        if !(_objId in (_self get "_objectives")) then { throw format ["GTN intel references unknown objective %1", _objId] };
        if !(_intelData isEqualType createHashMap) then { throw "GTN objective intel must be a HashMap" };
        private _existing = +(_self call ["_getObjectiveIntel", [_objId]]);
        { _existing set [_x, _y] } forEach _intelData;
        private _quality = _existing get "intelQuality";
        if !(_quality isEqualType 0 && {_quality >= 0} && {_quality <= 1}) then { throw "GTN intel quality must be in [0,1]" };
        if ("observedUnits" in _intelData || {"areaObserved" in _intelData}) then {
            if !("observedUnits" in _intelData && {"areaObserved" in _intelData}) then { throw "GTN area observation requires units and coverage" };
            private _units = _existing get "observedUnits";
            if !(_units isEqualType 0 && {_units >= 0} && {(_existing get "areaObserved") isEqualType true}) then { throw "GTN invalid area observation" };
            _existing set ["areaObservationTime", diag_tickTime];
            _existing set ["areaObservationConfidence", _quality];
        };
        _existing set ["lastReconTime", diag_tickTime];
        (_self get "_objectiveIntel") set [_objId, _existing];
        if (!_deferObservations) then { [_self] call FLO_fnc_gtnApplyObjectiveObservations };
        true
    }],

    // === MAIN UPDATE ===

    // Full state update from all sensors
    ["_update", FLO_fnc_gtnUpdateWorldState],

    // Set commander reference
    ["_setCommander", {
        params ["_cmdr"];
        _self set ["_commander", _cmdr];
    }],

    // Get state snapshot for comparison (used by replan detection)
    ["_getSnapshot", {
        createHashMapFromArray [
            ["objectives", +(_self get "_objectives")],
            ["groups", +(_self get "_ownGroupFacts")],
            ["ownSide", _self get "_ownSide"],
            ["forces", +(_self get "_ownForces")],
            ["assets", +(_self get "_supportAssets")],
            ["intel", +(_self get "_enemyIntel")],
            ["situation", +(_self get "_tacticalSituation")],
            ["time", diag_tickTime]
        ]
    }],

    // Compare two snapshots for significant changes
    ["_hasSignificantChange", {
        params ["_oldSnapshot"];
        ([_oldSnapshot, _self call ["_getSnapshot", []]] call FLO_fnc_gtnWorldStateChanges) isNotEqualTo []
    }],

    // Debug output
    ["_debugPrint", {
        private _forces = _self get "_ownForces";
        private _situation = _self get "_tacticalSituation";
        private _objectives = _self get "_objectives";
        private _assets = _self get "_supportAssets";

        format[
            "GTN World State:\n  Forces: %1 total (%2 available, %3 attacking, %4 defending)\n  Objectives: %5 total, Momentum: %6\n  Assets: Arty=%7, CAS=%8\n  Time: %9, Weather: %10",
            _forces get "totalGroups",
            _forces get "availableGroups",
            _forces get "attackingGroups",
            _forces get "defendingGroups",
            count (keys _objectives),
            _situation get "momentum",
            _assets get "artilleryAvailable",
            _assets get "casAvailable",
            _situation get "timeOfDay",
            _situation get "weather"
        ]
    }]
]];

["GTN", 3, "GTN World State System initialized"] call FLO_fnc_log;

_worldState
