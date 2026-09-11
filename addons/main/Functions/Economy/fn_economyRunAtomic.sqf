/* Keep a bounded accounting transition and its linked records in one scheduler slice. */
params ["_arguments", "_function"];

private _result = false;
private _error = "";
isNil {
    try { _result = _arguments call _function; } catch { _error = _exception; };
};
if (_error != "") then { throw _error; };
_result
