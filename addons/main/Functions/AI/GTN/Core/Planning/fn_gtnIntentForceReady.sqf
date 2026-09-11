/* Use current own strength and reported opposing strength, never hidden registry totals. */
params ["_commander", "_intent", ["_atStage", false]];
private _groups = call FLO_fnc_virtualizationGetGroupMap;
private _power = 0;
private _infantry = 0;
private _ready = 0;
private _antiArmor = false;
private _world = _commander get "_worldState";
private _objective = (_world get "_objectives") get (_intent get "objectiveId");
{
    if !(_x in _groups) then { continue };
    private _group = _groups get _x;
    if ((_group get "commanderIntent") != (_intent get "id") || {(_group get "unitCount") <= 0}) then { continue };
    if ((_group get "attachedTo") != "" || {(_group get "mountedIn") != ""}) then { continue };
    if (_atStage && {(_group get "position") distance2D (_intent get "stagePos") > 180}) then { continue };
    _ready = _ready + 1;
    private _profile = [_commander get "_capabilityAnalyzer", _group] call FLO_fnc_gtnAnalyzeManeuverGroup;
    _power = _power + (_profile get "power");
    _antiArmor = _antiArmor || {_profile get "antiArmor"};
    if ((_group get "groupType") == "infantry") then { _infantry = _infantry + (_group get "unitCount") };
} forEach (_intent get "groupIds");
private _requirement = [_commander, _intent get "objectiveId"] call FLO_fnc_gtnGetAssaultRequirement;
private _minimum = _requirement get "power";
createHashMapFromArray [
    ["ready", _ready >= 2 && {_infantry >= 3} && {_power >= _minimum} && {!(_requirement get "antiArmor") || {_antiArmor}}],
    ["groups", _ready], ["power", _power], ["required", _minimum]
]
