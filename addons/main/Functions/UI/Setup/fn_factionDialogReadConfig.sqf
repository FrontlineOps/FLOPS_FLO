/* Reads and validates the current setup form. Empty map means rejected input. */
disableSerialization;
params ["_display"];

// Get all selections using numeric IDCs
private _bluforFactionSelections = [_display, 1955] call FLO_fnc_factionDialogGetSelections;
private _opforFactionSelections = [_display, 1956] call FLO_fnc_factionDialogGetSelections;
private _civilianFactionSelections = [_display, 1957] call FLO_fnc_factionDialogGetSelections;
private _bluforFaction = [_bluforFactionSelections] call FLO_fnc_factionDialogJoinSelectionNames;
private _opforFaction = [_opforFactionSelections] call FLO_fnc_factionDialogJoinSelectionNames;
private _civilianFaction = [_civilianFactionSelections] call FLO_fnc_factionDialogJoinSelectionNames;
private _westAttackCoverage = ([_display, 1958] call FLO_fnc_factionDialogGetSelection) select 0;
private _playerSide = ([_display, 1959] call FLO_fnc_factionDialogGetSelection) select 0;
private _reputation = ([_display, 1960] call FLO_fnc_factionDialogGetSelection) select 0;
private _westDifficulty = ([_display, 1961] call FLO_fnc_factionDialogGetSelection) select 0;
private _westDefenseCoverage = ([_display, 1962] call FLO_fnc_factionDialogGetSelection) select 0;
private _westTempo = ([_display, 1963] call FLO_fnc_factionDialogGetSelection) select 0;
private _objectiveSize = ([_display, 1964] call FLO_fnc_factionDialogGetSelection) select 0;
private _virtualizationDistance = ([_display, 1965] call FLO_fnc_factionDialogGetSelection) select 0;
private _westForceGrowth = ([_display, 1966] call FLO_fnc_factionDialogGetSelection) select 0;
private _westGarrison = ([_display, 1967] call FLO_fnc_factionDialogGetSelection) select 0;
private _virtualizationUnitCap = ([_display, 1968] call FLO_fnc_factionDialogGetSelection) select 0;
private _territoryRatio = ([_display, 1969] call FLO_fnc_factionDialogGetSelection) select 0;
private _eastAttackCoverage = ([_display, 1970] call FLO_fnc_factionDialogGetSelection) select 0;
private _eastDefenseCoverage = ([_display, 1971] call FLO_fnc_factionDialogGetSelection) select 0;
private _eastDifficulty = ([_display, 1972] call FLO_fnc_factionDialogGetSelection) select 0;
private _eastTempo = ([_display, 1973] call FLO_fnc_factionDialogGetSelection) select 0;
private _eastForceGrowth = ([_display, 1974] call FLO_fnc_factionDialogGetSelection) select 0;
private _eastGarrison = ([_display, 1975] call FLO_fnc_factionDialogGetSelection) select 0;
private _objectiveSizeThresholdMap = createHashMapFromArray [
    ["Small", 4],
    ["Medium", 8],
    ["Large", 12],
    ["Huge", 24]
];

private _selectionErrors =
    (["BLUFOR", _bluforFactionSelections] call FLO_fnc_factionDialogValidateFactionSelections) +
    (["OPFOR", _opforFactionSelections] call FLO_fnc_factionDialogValidateFactionSelections) +
    (["Civilian", _civilianFactionSelections] call FLO_fnc_factionDialogValidateFactionSelections);

if (_selectionErrors isNotEqualTo []) exitWith {
    ["UI", 2, format ["Faction dialog validation failed: %1", _selectionErrors]] call FLO_fnc_log;
    hint format ["Faction selection is invalid:\n%1", _selectionErrors joinString "\n"];
    createHashMap
};

// Validate selections
if (_bluforFaction isEqualTo "" ||
    _opforFaction isEqualTo "" ||
    _civilianFaction isEqualTo "" ||
    !(_playerSide in ["BLUFOR", "OPFOR"]) ||
    _westAttackCoverage isEqualTo "" ||
    _reputation isEqualTo "" ||
    _westDifficulty isEqualTo "" ||
    _westDefenseCoverage isEqualTo "" ||
    _westTempo isEqualTo "" ||
    _objectiveSize isEqualTo "" ||
    _virtualizationDistance isEqualTo "" ||
    _westForceGrowth isEqualTo "" ||
    _westGarrison isEqualTo "" ||
    _virtualizationUnitCap isEqualTo "" ||
    _eastAttackCoverage isEqualTo "" ||
    _eastDefenseCoverage isEqualTo "" ||
    _eastDifficulty isEqualTo "" ||
    _eastTempo isEqualTo "" ||
    _eastForceGrowth isEqualTo "" ||
    _eastGarrison isEqualTo "" ||
    _territoryRatio isEqualTo "") exitWith {

    ["UI", 2, "Faction dialog validation failed - empty selections"] call FLO_fnc_log;
    hint "Please select all options before starting the mission.";
    createHashMap
};

if !(_objectiveSize in _objectiveSizeThresholdMap) exitWith {
    ["UI", 2, format ["Faction dialog validation failed - unsupported objective size %1", _objectiveSize]] call FLO_fnc_log;
    hint "Objective size selection is invalid.";
    createHashMap
};

private _objectiveSizeThreshold = _objectiveSizeThresholdMap get _objectiveSize;

private _westFactionTuningSpecs = ["BLUFOR"] call FLO_fnc_factionGetTuningFieldSpecs;
private _eastFactionTuningSpecs = ["OPFOR"] call FLO_fnc_factionGetTuningFieldSpecs;

private _westFactionTuningParse = [_display, "BLUFOR", _westFactionTuningSpecs] call FLO_fnc_factionBuildTuningHandle;
private _eastFactionTuningParse = [_display, "OPFOR", _eastFactionTuningSpecs] call FLO_fnc_factionBuildTuningHandle;

if (!(_westFactionTuningParse get "valid") || {!(_eastFactionTuningParse get "valid")}) exitWith {
    private _errors = (_westFactionTuningParse get "errors") + (_eastFactionTuningParse get "errors");
    ["UI", 2, format ["Force composition validation failed: %1", _errors]] call FLO_fnc_log;
    hint format ["Force composition is invalid:\n%1", _errors joinString "\n"];
    createHashMap
};

private _westFactionTuningHandle = _westFactionTuningParse get "overrides";
private _eastFactionTuningHandle = _eastFactionTuningParse get "overrides";

// Process reputation
private _reputationValue = switch (_reputation) do {
    case "Hostile _ Civilians Distrust Players": {2};
    case "Neutral _ Civilians Tolerate Players": {9};
    case "Friendly _ Civilians Support Players": {16};
    default {9};
};

private _difficultyMap = createHashMapFromArray [
    ["LOW _ Cautious Commander", 0.5],
    ["MEDIUM _ Balanced Commander", 1],
    ["HIGH _ Aggressive Commander", 1.5]
];

private _coverageMap = createHashMapFromArray [
    ["Minimal Coverage", 0.5],
    ["Balanced Coverage", 0.75],
    ["Layered Coverage", 1],
    ["Maximum Coverage", 1.25]
];

private _tempoMap = createHashMapFromArray [
    ["10s", 10],
    ["14s", 14],
    ["20s", 20],
    ["28s", 28]
];

private _forceGrowthMap = createHashMapFromArray [
    ["Low _ 1 Group Per Capture", 1],
    ["Standard _ 2 Groups Per Capture", 2],
    ["High _ 3 Groups Per Capture", 3]
];

private _westDifficultyHandle = [_westDifficulty, _difficultyMap] call FLO_fnc_factionDialogBuildScalarHandle;
private _eastDifficultyHandle = [_eastDifficulty, _difficultyMap] call FLO_fnc_factionDialogBuildScalarHandle;
private _westAttackCoverageHandle = [_westAttackCoverage, _coverageMap] call FLO_fnc_factionDialogBuildScalarHandle;
private _eastAttackCoverageHandle = [_eastAttackCoverage, _coverageMap] call FLO_fnc_factionDialogBuildScalarHandle;
private _westDefenseCoverageHandle = [_westDefenseCoverage, _coverageMap] call FLO_fnc_factionDialogBuildScalarHandle;
private _eastDefenseCoverageHandle = [_eastDefenseCoverage, _coverageMap] call FLO_fnc_factionDialogBuildScalarHandle;
private _westTempoHandle = [_westTempo, _tempoMap] call FLO_fnc_factionDialogBuildScalarHandle;
private _eastTempoHandle = [_eastTempo, _tempoMap] call FLO_fnc_factionDialogBuildScalarHandle;
private _westForceGrowthHandle = [_westForceGrowth, _forceGrowthMap] call FLO_fnc_factionDialogBuildScalarHandle;
private _eastForceGrowthHandle = [_eastForceGrowth, _forceGrowthMap] call FLO_fnc_factionDialogBuildScalarHandle;
private _westGarrisonHandle = [_westGarrison] call FLO_fnc_factionDialogBuildGarrisonHandle;
private _eastGarrisonHandle = [_eastGarrison] call FLO_fnc_factionDialogBuildGarrisonHandle;

private _virtualizationDistanceValue = parseNumber _virtualizationDistance;
private _virtualizationUnitCapValue = parseNumber _virtualizationUnitCap;
private _territoryRatioWestValue = (parseNumber ((_territoryRatio splitString "%") select 0)) / 100;

private _playerSideKey = ["WEST", "EAST"] select (_playerSide isEqualTo "OPFOR");
createHashMapFromArray [
    ["bluforHandle", [_bluforFactionSelections, 1] call FLO_fnc_factionDialogBuildFactionHandle],
    ["opforHandle", [_opforFactionSelections, 0] call FLO_fnc_factionDialogBuildFactionHandle],
    ["civilianHandle", [_civilianFactionSelections, 3] call FLO_fnc_factionDialogBuildFactionHandle],
    ["playerSideKey", _playerSideKey],
    ["reputationHandle", createHashMapFromArray [["value", _reputationValue], ["name", _reputation]]],
    ["westDifficultyHandle", _westDifficultyHandle],
    ["eastDifficultyHandle", _eastDifficultyHandle],
    ["westGTNAttackCoverageHandle", _westAttackCoverageHandle],
    ["eastGTNAttackCoverageHandle", _eastAttackCoverageHandle],
    ["westGTNDefenseCoverageHandle", _westDefenseCoverageHandle],
    ["eastGTNDefenseCoverageHandle", _eastDefenseCoverageHandle],
    ["westGTNTempoHandle", _westTempoHandle],
    ["eastGTNTempoHandle", _eastTempoHandle],
    ["westGTNForceGrowthHandle", _westForceGrowthHandle],
    ["eastGTNForceGrowthHandle", _eastForceGrowthHandle],
    ["westGTNGarrisonHandle", _westGarrisonHandle],
    ["eastGTNGarrisonHandle", _eastGarrisonHandle],
    ["westFactionTuningHandle", _westFactionTuningHandle],
    ["eastFactionTuningHandle", _eastFactionTuningHandle],
    ["startingResources", 5000],
    ["objectiveSizeThreshold", _objectiveSizeThreshold],
    ["virtualizationDistance", _virtualizationDistanceValue],
    ["virtualizationUnitCap", _virtualizationUnitCapValue],
    ["startingTerritoryWestRatio", _territoryRatioWestValue]
];
