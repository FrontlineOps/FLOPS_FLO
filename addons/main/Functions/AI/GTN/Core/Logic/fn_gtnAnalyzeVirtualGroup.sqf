/* Current canonical composition replaces abandoned template/strength payloads. */
params ["_analyzer", "_group"];
private _profile = [_analyzer, _group] call FLO_fnc_gtnAnalyzeManeuverGroup;
private _power = (_profile get "power") * (_analyzer call ["_getConfigCost", ["B_Soldier_F"]]);
private _capabilities = createHashMap;
if (_profile get "antiArmor") then { _capabilities set ["AT", 1] };
private _isAir = (_group get "groupType") in ["helicopter", "air"];
if (_isAir) then { _capabilities set ["AIR_POWER", 1] };
private _antiAir = (_group get "groupType") in ["static_aa", "mobile_aa"];
if (_antiAir) then {_capabilities set ["AA", 1]};
private _threat = createHashMapFromArray [["ANTI_INFANTRY", _power * 0.5]];
if (_profile get "antiArmor") then { _threat set ["ANTI_ARMOR", _power * 0.3] };
if (_antiAir) then {_threat set ["ANTI_AIR", _power * 0.25]};
createHashMapFromArray [
    ["groupId", _group get "id"], ["totalCombatPower", _power], ["unitCount", _group get "unitCount"],
    ["vehicleCount", [0, _group get "unitCount"] select ([(_group get "groupType")] call FLO_fnc_virtualizationUsesAssetStrength)], ["capabilities", _capabilities],
    ["specialists", createHashMap], ["vehicles", []], ["units", []], ["threatProfile", _threat],
    ["effectiveRange", createHashMap], ["leadership", 0], ["cohesion", 1],
    ["position", +(_group get "position")], ["canEngageArmor", _profile get "antiArmor"],
    ["canEngageAir", _antiAir],
    ["hasSupport", false], ["hasTransport", (_group get "groupType") in ["motorized", "mechanized"]]
]
