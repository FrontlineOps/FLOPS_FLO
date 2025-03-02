/*
    Function: FLO_fnc_TaskForceDefenseLine
    
    Description:
    Creates defense lines using Task Forces at strategic locations on the frontline.
    Deploys combinations of infantry, mechanized, armor, and fortifications.
    
    Parameters:
    _mode - The function mode to execute ["createDefenseLine", "reinforceDefenseLine"] (String)
    _params - Parameters based on mode (Array)
        createDefenseLine: [_frontlineMarker, _depth, _strength] - Create a defensive line
        reinforceDefenseLine: [_frontlineMarker, _strength] - Reinforce an existing line
    
    Returns:
    Based on mode:
        createDefenseLine: Array - IDs of created Task Forces
        reinforceDefenseLine: Number - Count of Task Forces added
*/

if (!isServer) exitWith {};

params [
    ["_mode", "", [""]],
    ["_params", [], [[]]]
];

private _result = [];

switch (_mode) do {
    case "createDefenseLine": {
        _params params [
            ["_frontlineMarker", "", [""]],
            ["_depth", 2, [0]],
            ["_strength", "medium", [""]]
        ];
        
        // Validate marker
        if (_frontlineMarker == "") exitWith {
            diag_log "[FLO][DefenseLine] Error: Empty frontline marker name";
            []
        };
        
        private _frontlinePos = getMarkerPos _frontlineMarker;
        if (_frontlinePos isEqualTo [0,0,0]) exitWith {
            diag_log "[FLO][DefenseLine] Error: Invalid frontline marker position";
            []
        };
        
        // Find nearest OPFOR installations to use as base markers
        private _opforMarkers = allMapMarkers select {
            markerColor _x in ["colorOPFOR", "ColorEAST"] && 
            markerType _x in ["o_support", "n_support", "o_installation", "n_installation"]
        };
        
        // Sort by distance to frontline
        _opforMarkers = [_opforMarkers, [], {getMarkerPos _x distance _frontlinePos}, "ASCEND"] call BIS_fnc_sortBy;
        
        // Take the closest marker as base
        private _baseMarker = _opforMarkers param [0, ""];
        if (_baseMarker == "") exitWith {
            diag_log "[FLO][DefenseLine] Error: No suitable OPFOR base marker found";
            []
        };
        
        // Check resource availability
        private _currentResources = ["get", []] call FLO_fnc_opforResources;
        private _minimumRequired = 15; // Minimum resources needed
        
        if (_currentResources < _minimumRequired) exitWith {
            diag_log format ["[FLO][DefenseLine] Error: Insufficient resources for defense line (needed %1, have %2)",
                _minimumRequired, _currentResources];
            []
        };
        
        // Determine strength-based parameters
        private _strengthParams = switch (toLower _strength) do {
            case "light": {
                [
                    ["infantry", "squad"],
                    ["infantry", "squad"], 
                    ["fortification", "fireteam"]
                ]
            };
            case "medium": {
                [
                    ["infantry", "platoon"],
                    ["mechanized", "squad"],
                    ["fortification", "squad"]
                ]
            };
            case "heavy": {
                [
                    ["infantry", "platoon"],
                    ["mechanized", "platoon"],
                    ["armored", "squad"],
                    ["fortification", "platoon"]
                ]
            };
            default {
                [
                    ["infantry", "squad"],
                    ["fortification", "squad"]
                ]
            };
        };
        
        // Find suitable positions for defense line
        private _linePositions = [];
        
        // Direction from OPFOR base to frontline
        private _basePos = getMarkerPos _baseMarker;
        private _direction = _basePos getDir _frontlinePos;
        
        // Calculate terrain-aware positions for the defense line
        private _totalWidth = 300; // Width of the defense line
        private _positionsPerLine = 3; // How many positions in each line
        private _spacing = _totalWidth / (_positionsPerLine - 1);
        
        // Create multiple lines based on depth
        for "_lineIndex" from 0 to (_depth - 1) do {
            // Calculate distance for this line (closer to frontline with each step)
            private _lineDistance = 300 + (_lineIndex * 150); // Staggered lines
            
            // Calculate base position for this line 
            private _lineBasePos = _frontlinePos getPos [_lineDistance, (_direction + 180) mod 360];
            
            // Calculate left edge position (perpendicular to frontline direction)
            private _leftPos = _lineBasePos getPos [_totalWidth / 2, (_direction - 90) mod 360];
            
            // Create positions along the line
            for "_i" from 0 to (_positionsPerLine - 1) do {
                private _posTemp = _leftPos getPos [_i * _spacing, (_direction + 90) mod 360];
                
                // Find suitable position near this point (check for roads, suitable terrain, etc.)
                // If elevated position, it's better
                private _nearestHills = nearestLocations [_posTemp, ["Hill"], 300];
                if (count _nearestHills > 0) then {
                    _posTemp = locationPosition (_nearestHills select 0);
                };
                
                // Find nearby buildings for possible cover
                private _nearBuildings = _posTemp nearObjects ["Building", 100];
                if (count _nearBuildings > 0) then {
                    // Adjust position to be near a building but not inside
                    _posTemp = (_nearBuildings select 0) getPos [15, random 360];
                };
                
                // Add position to list
                _linePositions pushBack _posTemp;
            };
        };
        
        // Create Task Forces at these positions
        private _taskForceIds = [];
        {
            // Select a composition from strength parameters
            private _composition = selectRandom _strengthParams;
            _composition params ["_type", "_size"];
            
            // Create Task Force
            private _taskForceId = ["createTaskForce", [_baseMarker, _type, _size, ""]] call FLO_fnc_TaskForceSystem;
            
            if (_taskForceId != "") then {
                // Deploy immediately at the position (defensive posture)
                ["deployTaskForce", [_taskForceId, _x, true]] call FLO_fnc_TaskForceSystem;
                
                // Add to result
                _taskForceIds pushBack _taskForceId;
                
                diag_log format ["[FLO][DefenseLine] Created %1 Task Force (%2) at position %3", 
                    _type, _size, _x];
            };
        } forEach _linePositions;
        
        diag_log format ["[FLO][DefenseLine] Created defense line at %1 with %2 Task Forces", 
            _frontlineMarker, count _taskForceIds];
            
        _result = _taskForceIds;
    };
    
    case "reinforceDefenseLine": {
        _params params [
            ["_frontlineMarker", "", [""]],
            ["_strength", "light", [""]]
        ];
        
        // Validate marker
        if (_frontlineMarker == "") exitWith {
            diag_log "[FLO][DefenseLine] Error: Empty frontline marker name";
            0
        };
        
        private _frontlinePos = getMarkerPos _frontlineMarker;
        if (_frontlinePos isEqualTo [0,0,0]) exitWith {
            diag_log "[FLO][DefenseLine] Error: Invalid frontline marker position";
            0
        };
        
        // Find nearest OPFOR installations to use as base markers
        private _opforMarkers = allMapMarkers select {
            markerColor _x in ["colorOPFOR", "ColorEAST"] && 
            markerType _x in ["o_support", "n_support", "o_installation", "n_installation"]
        };
        
        // Sort by distance to frontline
        _opforMarkers = [_opforMarkers, [], {getMarkerPos _x distance _frontlinePos}, "ASCEND"] call BIS_fnc_sortBy;
        
        // Take the closest marker as base
        private _baseMarker = _opforMarkers param [0, ""];
        if (_baseMarker == "") exitWith {
            diag_log "[FLO][DefenseLine] Error: No suitable OPFOR base marker found";
            0
        };
        
        // Look for existing Task Force markers near the frontline
        private _taskForceMarkers = allMapMarkers select {
            markerType _x == "mil_triangle" && 
            markerColor _x == "ColorEAST" &&
            markerAlpha _x == 0.6
        };
        
        // Filter to those near frontline
        private _nearFrontlineMarkers = _taskForceMarkers select {
            getMarkerPos _x distance _frontlinePos < 800
        };
        
        if (count _nearFrontlineMarkers == 0) exitWith {
            diag_log "[FLO][DefenseLine] No existing Task Forces found near frontline to reinforce";
            
            // Create a new defense line instead
            _result = ["createDefenseLine", [_frontlineMarker, 1, _strength]] call FLO_fnc_TaskForceDefenseLine;
            count _result
        };
        
        // Determine reinforcement type based on strength
        private _reinforcementParams = switch (toLower _strength) do {
            case "light": {
                [["infantry", "squad"]]
            };
            case "medium": {
                [["mechanized", "squad"], ["fortification", "squad"]]
            };
            case "heavy": {
                [["armored", "squad"], ["fortification", "platoon"]]
            };
            default {
                [["infantry", "squad"]]
            };
        };
        
        // Select reinforcement markers (near positions of existing Task Forces)
        private _reinforceCount = (count _nearFrontlineMarkers) min 3; // Reinforce up to 3 positions
        private _markersToReinforce = [];
        
        for "_i" from 0 to (_reinforceCount - 1) do {
            _markersToReinforce pushBack (selectRandom _nearFrontlineMarkers);
        };
        
        // Create reinforcement Task Forces
        private _reinforcementCount = 0;
        
        {
            // Select composition for this reinforcement
            private _composition = selectRandom _reinforcementParams;
            _composition params ["_type", "_size"];
            
            // Create Task Force
            private _taskForceId = ["createTaskForce", [_baseMarker, _type, _size, ""]] call FLO_fnc_TaskForceSystem;
            
            if (_taskForceId != "") then {
                // Get position from existing marker
                private _pos = getMarkerPos _x;
                
                // Add some randomness to position (dispersion)
                _pos = _pos getPos [10 + random 30, random 360];
                
                // Deploy at the position (defensive posture)
                ["deployTaskForce", [_taskForceId, _pos, true]] call FLO_fnc_TaskForceSystem;
                
                _reinforcementCount = _reinforcementCount + 1;
                
                diag_log format ["[FLO][DefenseLine] Reinforced with %1 Task Force (%2) at position %3", 
                    _type, _size, _pos];
            };
        } forEach _markersToReinforce;
        
        diag_log format ["[FLO][DefenseLine] Reinforced defense line at %1 with %2 Task Forces", 
            _frontlineMarker, _reinforcementCount];
            
        _result = _reinforcementCount;
    };
};

_result 