/* Returns the runtime-only air-defense contact state. */
if (isNil "FLO_GTN_AirDefenseState") then {
    FLO_GTN_AirDefenseState = createHashMapFromArray [
        ["contactWorkerPfhId", -1],
        ["pairReadyAt", createHashMap],
        ["aaReadyAt", createHashMap],
        ["lastLiveContactAt", createHashMap],
        ["virtualExposureByAircraft", createHashMap],
        ["pairCooldownSeconds", 120],
        ["aaCooldownSeconds", 30],
        ["virtualExposureResetSeconds", 1800],
        ["staticLossExposureThreshold", 3],
        ["mobileLossExposureThreshold", 4],
        ["jetExposureThresholdBonus", 2],
        ["liveContactGraceSeconds", 90],
        ["unidentifiedStaticThreatRange", 8000],
        ["unidentifiedMobileThreatRange", 5000]
    ];
};

FLO_GTN_AirDefenseState
