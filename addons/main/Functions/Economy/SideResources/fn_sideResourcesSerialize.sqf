params ["_treasury"];

private _snapshot = createHashMap;
isNil {
_snapshot = +createHashMapFromArray [
    ["balance", _treasury get "_balance"],
    ["reservations", _treasury get "_reservations"],
    ["ledger", _treasury get "_ledger"],
    ["transactionSequence", _treasury get "_transactionSequence"],
    ["lastIncome", _treasury get "_lastIncome"]
];
};
[_snapshot, _treasury get "_sideKey", _treasury get "LEDGER_LIMIT"] call FLO_fnc_sideResourcesValidateSavedState;
_snapshot
