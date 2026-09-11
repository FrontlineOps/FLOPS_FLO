/* Goal definitions separate projected effects from verified runtime outcomes. */
private _library = createHashMapObject [[
    ["_goals", createHashMap], ["_primitives", createHashMap],
    ["_registerGoal", {
        params ["_definition"];
        [_definition, false] call FLO_fnc_gtnValidatePlanDefinition;
        (_self get "_goals") set [_definition get "id", _definition];
    }],
    ["_registerPrimitive", {
        params ["_definition"];
        [_definition, true] call FLO_fnc_gtnValidatePlanDefinition;
        (_self get "_primitives") set [_definition get "id", _definition];
    }],
    ["_getGoal", { params ["_id"]; (_self get "_goals") get _id }],
    ["_getPrimitive", { params ["_id"]; (_self get "_primitives") get _id }],
    ["_isPrimitive", { params ["_id"]; _id in (_self get "_primitives") }],
    ["_isGoal", { params ["_id"]; _id in (_self get "_goals") }],
    ["_getGoalsByType", {
        params ["_type"];
        private _goals = _self get "_goals";
        (keys _goals select { ((_goals get _x) get "type") == _type }) apply { _goals get _x }
    }]
]];
_library call ["_registerGoal", [createHashMapFromArray [
    ["id", "capture_objective"], ["type", "STRATEGIC"], ["repeat", false],
    ["description", "capture objective"],
    ["preconditions", { _this call FLO_fnc_gtnIntentGoalValid }],
    ["satisfied", { _this call FLO_fnc_gtnIntentGoalSatisfied }],
    ["methods", [
        createHashMapFromArray [
            ["id", "exploit_verified_opening"], ["score", {120}],
            ["conditions", {_this call FLO_fnc_gtnCanExploitOpening}],
            ["subtasks", [["prim_intent_confirm", ["_PARAM_0"]], ["prim_intent_assault", ["_PARAM_0"]], ["prim_intent_secure", ["_PARAM_0"]]]]
        ],
        createHashMapFromArray [
            ["id", "resume_muster"], ["score", {100}],
            ["conditions", {params ["_state"]; ((_state get "intent") get "phase") == "MUSTER"}],
            ["subtasks", [["prim_intent_muster", ["_PARAM_0"]], ["prim_intent_assemble", ["_PARAM_0"]], ["prim_intent_scout", ["_PARAM_0"]], ["prim_intent_assault", ["_PARAM_0"]], ["prim_intent_secure", ["_PARAM_0"]]]]
        ],
        createHashMapFromArray [
            ["id", "resume_assemble"], ["score", {100}],
            ["conditions", {params ["_state"]; ((_state get "intent") get "phase") == "ASSEMBLE"}],
            ["subtasks", [["prim_intent_assemble", ["_PARAM_0"]], ["prim_intent_scout", ["_PARAM_0"]], ["prim_intent_assault", ["_PARAM_0"]], ["prim_intent_secure", ["_PARAM_0"]]]]
        ],
        createHashMapFromArray [
            ["id", "resume_scout"], ["score", {100}],
            ["conditions", {params ["_state"]; ((_state get "intent") get "phase") == "SCOUT"}],
            ["subtasks", [["prim_intent_scout", ["_PARAM_0"]], ["prim_intent_assault", ["_PARAM_0"]], ["prim_intent_secure", ["_PARAM_0"]]]]
        ],
        createHashMapFromArray [
            ["id", "resume_assault"], ["score", {100}],
            ["conditions", {params ["_state"]; ((_state get "intent") get "phase") == "ASSAULT"}],
            ["subtasks", [["prim_intent_assault", ["_PARAM_0"]], ["prim_intent_secure", ["_PARAM_0"]]]]
        ],
        createHashMapFromArray [
            ["id", "resume_secure"], ["score", {100}],
            ["conditions", {params ["_state"]; ((_state get "intent") get "phase") == "SECURE"}],
            ["subtasks", [["prim_intent_secure", ["_PARAM_0"]]]]
        ]
    ]]
]]];
_library call ["_registerPrimitive", [createHashMapFromArray [
    ["id", "prim_intent_confirm"], ["timeout", 1800],
    ["preconditions", { _this call FLO_fnc_gtnIntentGoalValid && {_this call FLO_fnc_gtnCanExploitOpening} }],
    ["effects", {params ["_state"]; [_state, "ASSAULT"] call FLO_fnc_gtnProjectIntentPhase}],
    ["completionCheck", {params ["_ctx"]; (_ctx get "data") get "phaseCompleted"}]
]]];
_library call ["_registerPrimitive", [createHashMapFromArray [
    ["id", "prim_intent_scout"], ["timeout", 1800],
    ["preconditions", { params ["_state", "_args"]; [_state, _args] call FLO_fnc_gtnIntentGoalValid && {((_state get "intent") get "phase") == "SCOUT"} }],
    ["effects", { params ["_state"]; [_state, "ASSAULT"] call FLO_fnc_gtnProjectIntentPhase }],
    ["completionCheck", { params ["_ctx"]; (_ctx get "data") get "phaseCompleted" }]
]]];
_library call ["_registerPrimitive", [createHashMapFromArray [
    ["id", "prim_intent_muster"], ["timeout", 1800],
    ["preconditions", { params ["_state", "_args"]; [_state, _args] call FLO_fnc_gtnIntentGoalValid && {((_state get "intent") get "phase") == "MUSTER"} }],
    ["effects", { params ["_state"]; [_state, "ASSEMBLE"] call FLO_fnc_gtnProjectIntentPhase }],
    ["completionCheck", { params ["_ctx"]; (_ctx get "data") get "phaseCompleted" }]
]]];
_library call ["_registerPrimitive", [createHashMapFromArray [
    ["id", "prim_intent_assemble"], ["timeout", 1800],
    ["preconditions", { params ["_state", "_args"]; [_state, _args] call FLO_fnc_gtnIntentGoalValid && {((_state get "intent") get "phase") == "ASSEMBLE"} }],
    ["effects", { params ["_state"]; [_state, "SCOUT"] call FLO_fnc_gtnProjectIntentPhase }],
    ["completionCheck", { params ["_ctx"]; (_ctx get "data") get "phaseCompleted" }]
]]];
_library call ["_registerPrimitive", [createHashMapFromArray [
    ["id", "prim_intent_assault"], ["timeout", 1800],
    ["preconditions", { params ["_state", "_args"]; [_state, _args] call FLO_fnc_gtnIntentGoalValid && {((_state get "intent") get "phase") == "ASSAULT"} }],
    ["effects", { params ["_state"]; [_state, "SECURE"] call FLO_fnc_gtnProjectIntentPhase }],
    ["completionCheck", { params ["_ctx"]; (_ctx get "data") get "phaseCompleted" }]
]]];
_library call ["_registerPrimitive", [createHashMapFromArray [
    ["id", "prim_intent_secure"], ["timeout", 3600],
    ["preconditions", { params ["_state", "_args"]; [_state, _args] call FLO_fnc_gtnIntentGoalValid && {((_state get "intent") get "phase") == "SECURE"} }],
    ["effects", { params ["_state"]; [_state, "COMPLETE"] call FLO_fnc_gtnProjectIntentPhase }],
    ["completionCheck", { params ["_ctx"]; (_ctx get "data") get "phaseCompleted" }]
]]];
_library call ["_registerGoal", [createHashMapFromArray [
    ["id", "secure_friendly_objective"], ["type", "STRATEGIC"], ["repeat", false],
    ["description", "secure friendly objective"],
    ["preconditions", { _this call FLO_fnc_gtnIntentGoalValid }],
    ["satisfied", { _this call FLO_fnc_gtnIntentGoalSatisfied }],
    ["methods", [
        createHashMapFromArray [
            ["id", "resume_dispatch"], ["score", {100}],
            ["conditions", {params ["_state"]; ((_state get "intent") get "phase") == "DISPATCH"}],
            ["subtasks", [["prim_intent_dispatch", ["_PARAM_0"]], ["prim_intent_arrive", ["_PARAM_0"]]]]
        ],
        createHashMapFromArray [
            ["id", "resume_arrive"], ["score", {100}],
            ["conditions", {params ["_state"]; ((_state get "intent") get "phase") == "ARRIVE"}],
            ["subtasks", [["prim_intent_arrive", ["_PARAM_0"]]]]
        ]
    ]]
]]];
_library call ["_registerPrimitive", [createHashMapFromArray [
    ["id", "prim_intent_dispatch"], ["timeout", 1800],
    ["preconditions", { params ["_state", "_args"]; [_state, _args] call FLO_fnc_gtnIntentGoalValid && {((_state get "intent") get "phase") == "DISPATCH"} }],
    ["effects", { params ["_state"]; [_state, "ARRIVE"] call FLO_fnc_gtnProjectIntentPhase }],
    ["completionCheck", { params ["_ctx"]; (_ctx get "data") get "phaseCompleted" }]
]]];
_library call ["_registerPrimitive", [createHashMapFromArray [
    ["id", "prim_intent_arrive"], ["timeout", 1800],
    ["preconditions", { params ["_state", "_args"]; [_state, _args] call FLO_fnc_gtnIntentGoalValid && {((_state get "intent") get "phase") == "ARRIVE"} }],
    ["effects", { params ["_state"]; [_state, "COMPLETE"] call FLO_fnc_gtnProjectIntentPhase }],
    ["completionCheck", { params ["_ctx"]; (_ctx get "data") get "phaseCompleted" }]
]]];
_library call ["_registerGoal", [createHashMapFromArray [
    ["id", "support_objective"], ["type", "STRATEGIC"], ["repeat", false],
    ["description", "support objective"],
    ["preconditions", { _this call FLO_fnc_gtnIntentGoalValid }],
    ["satisfied", { _this call FLO_fnc_gtnIntentGoalSatisfied }],
    ["methods", [
        createHashMapFromArray [
            ["id", "resume_request"], ["score", {100}],
            ["conditions", {params ["_state"]; ((_state get "intent") get "phase") == "REQUEST"}],
            ["subtasks", [["prim_intent_request", ["_PARAM_0"]]]]
        ]
    ]]
]]];
_library call ["_registerPrimitive", [createHashMapFromArray [
    ["id", "prim_intent_request"], ["timeout", 1800],
    ["preconditions", { params ["_state", "_args"]; [_state, _args] call FLO_fnc_gtnIntentGoalValid && {((_state get "intent") get "phase") == "REQUEST"} }],
    ["effects", { params ["_state"]; [_state, "COMPLETE"] call FLO_fnc_gtnProjectIntentPhase }],
    ["completionCheck", { params ["_ctx"]; (_ctx get "data") get "phaseCompleted" }]
]]];
["GTN", 3, format ["Goal library ready: goals=%1 primitives=%2", count (_library get "_goals"), count (_library get "_primitives")]] call FLO_fnc_log;
_library
