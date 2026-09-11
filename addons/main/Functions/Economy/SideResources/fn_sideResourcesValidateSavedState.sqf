/* One current treasury contract, shared by capture and restore. No live state is changed. */
params ["_saved", "_sideKey", "_ledgerLimit"];

if !(_saved isEqualType createHashMap) then { throw format ["ECONOMY %1 treasury payload must be a HashMap", _sideKey]; };
private _missing = ["balance", "reservations", "ledger", "transactionSequence", "lastIncome"] select { !(_x in _saved) };
if (_missing isNotEqualTo []) then { throw format ["ECONOMY %1 treasury is missing fields %2", _sideKey, _missing]; };
{
    private _value = _saved get _x;
    if !(_value isEqualType 0 && {finite _value} && {_value >= 0}) then {
        throw format ["ECONOMY %1 treasury has invalid %2", _sideKey, _x];
    };
} forEach ["balance", "transactionSequence", "lastIncome"];
private _sequence = _saved get "transactionSequence";
if (_sequence != floor _sequence) then { throw format ["ECONOMY %1 treasury sequence must be an integer", _sideKey]; };
private _reservations = _saved get "reservations";
if !(_reservations isEqualType createHashMap) then { throw format ["ECONOMY %1 treasury reservations must be a HashMap", _sideKey]; };
private _committed = 0;
{
    private _id = _x;
    private _reservation = _y;
    if !(_id isEqualType "" && {_id != ""} && {_reservation isEqualType createHashMap}) then {
        throw format ["ECONOMY %1 treasury has an invalid reservation record", _sideKey];
    };
    _missing = ["id", "initial", "remaining", "category", "reason", "actor", "referenceId", "createdAtDateNum"] select { !(_x in _reservation) };
    if (_missing isNotEqualTo []) then { throw format ["ECONOMY %1 reservation %2 is missing fields %3", _sideKey, _id, _missing]; };
    {
        if !((_reservation get _x) isEqualType "") then { throw format ["ECONOMY %1 reservation %2 has invalid %3", _sideKey, _id, _x]; };
    } forEach ["id", "category", "reason", "actor", "referenceId"];
    if ((_reservation get "id") != _id) then { throw format ["ECONOMY %1 reservation %2 has mismatched identity", _sideKey, _id]; };
    {
        private _value = _reservation get _x;
        if !(_value isEqualType 0 && {finite _value} && {_value >= 0}) then { throw format ["ECONOMY %1 reservation %2 has invalid %3", _sideKey, _id, _x]; };
    } forEach ["initial", "remaining", "createdAtDateNum"];
    private _remaining = _reservation get "remaining";
    if (_remaining <= 0 || {_remaining > (_reservation get "initial")}) then { throw format ["ECONOMY %1 reservation %2 has invalid remaining amount", _sideKey, _id]; };
    _committed = _committed + _remaining;
} forEach _reservations;
if (_committed > (_saved get "balance")) then { throw format ["ECONOMY %1 treasury commitments exceed balance", _sideKey]; };
if (_committed > 0 && {_sequence == 0}) then { throw format ["ECONOMY %1 treasury reservations have no transaction history", _sideKey]; };

private _ledger = _saved get "ledger";
if !(_ledger isEqualType []) then { throw format ["ECONOMY %1 treasury ledger must be an array", _sideKey]; };
if (count _ledger != (_sequence min _ledgerLimit)) then { throw format ["ECONOMY %1 treasury ledger length does not match sequence and limit", _sideKey]; };
{
    private _entry = _x;
    private _entrySequence = _sequence - count _ledger + _forEachIndex + 1;
    if !(_entry isEqualType createHashMap) then { throw format ["ECONOMY %1 ledger entry %2 must be a HashMap", _sideKey, _entrySequence]; };
    _missing = ["id", "dateNum", "kind", "amount", "category", "reason", "actor", "referenceId", "balance", "committed", "available"] select { !(_x in _entry) };
    if (_missing isNotEqualTo []) then { throw format ["ECONOMY %1 ledger entry %2 is missing fields %3", _sideKey, _entrySequence, _missing]; };
    {
        if !((_entry get _x) isEqualType "") then { throw format ["ECONOMY %1 ledger entry %2 has invalid %3", _sideKey, _entrySequence, _x]; };
    } forEach ["id", "kind", "category", "reason", "actor", "referenceId"];
    if ((_entry get "id") != format ["%1:%2", _sideKey, _entrySequence]) then { throw format ["ECONOMY %1 ledger sequence identity mismatch", _sideKey]; };
    if !((_entry get "kind") in ["CREDIT", "DEBIT", "RESERVE", "COMMIT", "RELEASE"]) then { throw format ["ECONOMY %1 ledger has invalid transaction kind", _sideKey]; };
    {
        private _value = _entry get _x;
        if !(_value isEqualType 0 && {finite _value} && {_value >= 0}) then { throw format ["ECONOMY %1 ledger entry %2 has invalid %3", _sideKey, _entrySequence, _x]; };
    } forEach ["dateNum", "amount", "balance", "committed", "available"];
    if ((_entry get "amount") <= 0 || {(_entry get "committed") > (_entry get "balance")} || {
        abs ((_entry get "available") - ((_entry get "balance") - (_entry get "committed"))) > 0.001
    }) then { throw format ["ECONOMY %1 ledger entry %2 does not balance", _sideKey, _entrySequence]; };
} forEach _ledger;
if (_ledger isNotEqualTo []) then {
    private _last = _ledger select -1;
    if ((_last get "balance") != (_saved get "balance") || {abs ((_last get "committed") - _committed) > 0.001}) then {
        throw format ["ECONOMY %1 treasury does not match its final ledger entry", _sideKey];
    };
};
true
