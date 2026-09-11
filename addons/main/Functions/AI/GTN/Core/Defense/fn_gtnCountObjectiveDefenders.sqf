#pragma hemtt ignore_variables ["_self"]
/* _countObjectiveDefenders implementation, bound directly to its GTN owner.
 * Native HashMapObject method dispatch supplies _self and the original arguments.
 */
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
