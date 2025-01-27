/*
    Author: [FLO]
    Description: Creates a zone around a trigger with watchposts and defensive positions
    
    Parameter(s):
        _this select 0: OBJECT - Trigger object
        _this select 1: NUMBER - Radius of the zone
    
    Returns: HASHMAP - Zone data structure
*/

params [
    ["_triggerObj", objNull, [objNull]],
    ["_radius", 1000, [0]]
];

if (isNull _triggerObj) exitWith {
    diag_log "[FLO] Error: Invalid trigger object passed to ZONEs.sqf";
    objNull
};

// Initialize zone data structure
private _zoneData = createHashMapObject [[
    ["position", getPos _triggerObj],
    ["radius", _radius],
    ["watchpostPositions", []],
    ["mounts", []],
    ["aggrScore", 0]
]];

// Get aggression score from marker
private _markers = allMapMarkers select {markerColor _x == "Color6_FD_F"};
if (count _markers > 0) then {
    _zoneData set ["aggrScore", parseNumber (markerText (_markers select 0))];
};

// Find suitable mount positions
private _allMounts = nearestLocations [_zoneData get "position", ["Mount"], _zoneData get "radius"];
private _allWatchposts = [
    "Watchpost_1", "Watchpost_2", "Watchpost_3", "Watchpost_4", 
    "Watchpost_5", "Watchpost_6", "Watchpost_7", "Watchpost_8",
    "Watchpost_9", "Watchpost_10"
];

// Function to check if position is suitable for watchpost
private _isSuitablePosition = {
    params ["_pos"];
    private _tooClose = false;
    {
        if (_pos distance2D _x < 500) exitWith {
            _tooClose = true;
        };
    } forEach (_zoneData get "watchpostPositions");
    !_tooClose
};

// Place initial watchposts
{
    private _mountPos = locationPosition _x;
    if ([_mountPos] call _isSuitablePosition) then {
        [_x, selectRandom _allWatchposts] execVM "Scripts\WatchPost.sqf";
        (_zoneData get "watchpostPositions") pushBack _mountPos;
    };
    if (count (_zoneData get "watchpostPositions") >= 3) exitWith {};
} forEach _allMounts;

// Add additional watchposts based on aggression score
if ((_zoneData get "aggrScore") > 5) then {
    if ((_zoneData get "radius") >= 2000) then {
        private _validMounts = _allMounts select {[locationPosition _x] call _isSuitablePosition};
        if !(_validMounts isEqualTo []) then {
            private _mount = selectRandom _validMounts;
            [_mount, selectRandom _allWatchposts] execVM "Scripts\WatchPost.sqf";
            (_zoneData get "watchpostPositions") pushBack (locationPosition _mount);
        };
    };

    if ((_zoneData get "radius") >= 1000) then {
        private _validMounts = _allMounts select {[locationPosition _x] call _isSuitablePosition};
        if !(_validMounts isEqualTo []) then {
            private _mount = selectRandom _validMounts;
            [_mount, selectRandom _allWatchposts] execVM "Scripts\WatchPost.sqf";
            (_zoneData get "watchpostPositions") pushBack (locationPosition _mount);
        };
    };
};

// Add even more watchposts for high aggression
if ((_zoneData get "aggrScore") > 10) then {
    {
        if (_x >= (_zoneData get "radius")) then {
            private _validMounts = _allMounts select {[locationPosition _x] call _isSuitablePosition};
            if !(_validMounts isEqualTo []) then {
                private _mount = selectRandom _validMounts;
                [_mount, selectRandom _allWatchposts] execVM "Scripts\WatchPost.sqf";
                (_zoneData get "watchpostPositions") pushBack (locationPosition _mount);
            };
        };
    } forEach [2000, 1500];
};

// Return the zone data
_zoneData
