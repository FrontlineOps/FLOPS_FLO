/* Scheduled setup progress. initClientFinalize owns player and respawn setup. */
hint "Initializing mission systems...";

private _startTime = diag_tickTime;
private _timeout = 600; // 10 minute timeout for full initialization

waitUntil {
    uiSleep 1;

    // Show progress to player
    if (!isNil "FLO_InitPhase") then {
        private _phaseName = switch (FLO_InitPhase) do {
            case 1: { "Loading factions..." };
            case 2: { "Configuring factions..." };
            case 3: { "Indexing objectives..." };
            case 4: { "Setting up campaign forces..." };
            case 5: { "Starting mission systems..." };
            case 99: { "Complete!" };
            case -1: { "ERROR - Check server log" };
            default { "Initializing..." };
        };
        hintSilent format ["Mission Setup: %1\nPhase %2", _phaseName, FLO_InitPhase];
    };

    (!isNil "FLO_MissionReady" && {FLO_MissionReady}) ||
    (!isNil "FLO_InitPhase" && {FLO_InitPhase == -1}) ||
    {diag_tickTime - _startTime > _timeout}
};

// Check result
if (!isNil "FLO_MissionReady" && {FLO_MissionReady}) then {
    ["UI", 3, "Mission initialization complete - ready to play"] call FLO_fnc_log;

    titleText ["Deploying...", "BLACK FADED", 0.1, true, true];
    hintSilent "Mission ready. Deploying...";

} else {
    private _errorMsg = if (!isNil "FLO_InitError") then { FLO_InitError } else { "Unknown error" };
    ["UI", 1, format["Mission initialization FAILED: %1", _errorMsg]] call FLO_fnc_log;
    hint format ["Mission initialization failed:\n%1\n\nCheck server RPT for details.", _errorMsg];
};

["UI", 3, "Faction dialog setup complete"] call FLO_fnc_log;
