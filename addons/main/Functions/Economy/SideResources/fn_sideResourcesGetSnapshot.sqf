if (canSuspend) exitWith { [_this, FLO_fnc_sideResourcesGetSnapshot] call FLO_fnc_economyRunAtomic };

params ["_treasury"];

private _ledger = _treasury get "_ledger";
private _publicLimit = _treasury get "PUBLIC_LEDGER_LIMIT";
private _startIndex = ((count _ledger) - _publicLimit) max 0;
private _commanderSpending = [_treasury] call FLO_fnc_commanderSpendingGetState;

+createHashMapFromArray [
    ["sideKey", _treasury get "_sideKey"],
    ["balance", _commanderSpending get "balance"],
    ["committed", _commanderSpending get "committed"],
    ["available", _commanderSpending get "available"],
    ["lastIncome", _treasury get "_lastIncome"],
    ["incomePerMinute", round (((_treasury get "_lastIncome") * 60) / (_treasury get "UPDATE_INTERVAL"))],
    ["lastUpdate", _treasury get "_lastUpdate"],
    ["commanderSpending", _commanderSpending],
    ["ledger", _ledger select [_startIndex]]
]
