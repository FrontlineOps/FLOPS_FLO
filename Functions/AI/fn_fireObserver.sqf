/*
    Function: FLO_fnc_fireObserver
    
    Description:
    Handles the AI Fire Observer system for artillery control
    Only works with units manually defined as Fire Observer
    
    Parameters:
    _unit - The Radio Operator unit [Object]
    _side - Side of the Fire Observer [Side]
    
    Returns:
    Boolean - Success of initialization
*/

params ["_unit", "_side"];

// Exit if not a Radio Operator
// Change I_RadioOperator_F to whatever unit you want to manually define as Fire Observer
// QuickRF.sqf reference for the unit that will call this function 
if (typeOf _unit != "I_RadioOperator_F") exitWith { false };

// Initialize global Fire Observer tracking if not exists
if (isNil "FLO_fireObservers") then {
    FLO_fireObservers = createHashMap;
};

// Configuration values
private _observationTime = 15;  // Time needed to maintain vision
private _cooldownTime = 300;    // 5 minutes between fire missions
private _minRange = 100;        // Minimum range for artillery
private _maxRange = 4000;       // Maximum range for artillery
private _scanRadius = 1000;     // How far the observer looks for targets

// Setup the Fire Observer
private _observerId = str _unit;
private _observerData = createHashMapFromArray [
    ["unit", _unit],
    ["side", _side],
    ["lastMission", -_cooldownTime],
    ["observingTarget", objNull],
    ["observationStartTime", 0],
    ["isObserving", false]
];

FLO_fireObservers set [_observerId, _observerData];

// Add PFH to check for targets and manage observation
[{
    params ["_args", "_handle"];
    _args params ["_observerId"];
    
    private _observer = FLO_fireObservers get _observerId;
    private _unit = _observer get "unit";
    
    // Remove handler if unit is dead or null
    if (isNull _unit || !alive _unit) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
        FLO_fireObservers deleteAt _observerId;
    };
    
    private _currentTime = time;
    
    // If not observing, look for new targets
    if !(_observer get "isObserving") then {
        // Only search if cooldown is over
        if (_currentTime - (_observer get "lastMission") >= _cooldownTime) then {
            private _nearTargets = _unit nearEntities [["Man", "Car", "Tank", "LandVehicle"], _scanRadius];
            _nearTargets = _nearTargets select {
                side _x != (_observer get "side") && 
                {!(lineIntersects [eyePos _unit, getPosASL _x, _unit, _x])}
            };
            
            if (count _nearTargets > 0) then {
                private _target = selectRandom _nearTargets;
                _observer set ["observingTarget", _target];
                _observer set ["isObserving", true];
                _observer set ["observationStartTime", _currentTime];
            };
        };
    } else {
        private _target = _observer get "observingTarget";
        
        // Check if still has vision
        if (!(lineIntersects [eyePos _unit, getPosASL _target, _unit, _target]) && 
            {alive _target} && 
            {_unit distance2D _target <= _scanRadius}) then {
            
            if (_currentTime - (_observer get "observationStartTime") >= _observationTime) then {
                // Execute fire mission
                [getPosASL _target, 3] call FLO_fnc_artilleryPrep;
                _observer set ["lastMission", _currentTime];
                _observer set ["isObserving", false];
                _observer set ["observingTarget", objNull];
            };
        } else {
            // Lost vision or target invalid, reset observation
            _observer set ["isObserving", false];
            _observer set ["observingTarget", objNull];
        };
    };
}, 2, [_observerId]] call CBA_fnc_addPerFrameHandler;

true