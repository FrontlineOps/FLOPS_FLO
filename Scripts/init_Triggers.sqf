private _mrkrs = allMapMarkers select {markerColor _x == "Color6_FD_F"};
private _mrkr = _mrkrs select 0;
private _AGGRSCORE = parseNumber (markerText _mrkr) ;  

// Init Minefields
[] execVM 'Scripts\Minefield_B.sqf';

// Init Intel Creation Items
[] spawn {
    private _markerTypes = [
        "o_antiair", "loc_Lighthouse", "loc_Transmitter", "o_service",
        "loc_Power", "o_support", "n_support", "loc_Ruin",
        "n_installation", "o_installation"
    ];

    while {true} do {
        sleep 10; // Check every 10 seconds

        private _markers = allMapMarkers select {
            (markerAlpha _x == 0.001 || markerAlpha _x == 0) &&
            ((markerPos _x) distance (getPos cursorObject) <= 50) &&
            (_x in _markerTypes)
        };

        if (count _markers > 0) then {
            ScouTPos = getPos cursorObject;
            private _MMarks = allMapMarkers select { _x in _markerTypes };
            private _M = [_MMarks, ScouTPos] call BIS_fnc_nearestPosition;

            if (markerAlpha _M in [0.001, 0]) then {
                _M setMarkerAlpha 1;
                [parseText "<t color='#FACE00' font='PuristaBold' align='right' shadow='1' size='2'>+ NEW INTEL</t><br /><t color='#959393' align='right' shadow='1' size='1'>Scout Intel Received</t>", [0, 0.5, 1, 1], nil, 5, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];

                private _attackingAtGrid = mapGridPosition getMarkerPos _M;
                [[west, "HQ"], "Enemy Presence Confirmed at grid " + _attackingAtGrid] remoteExec ["sideChat", 0];
            };
        };
    };
};

// Init Removal of Intel Creation Items (After Usage)
[] spawn {
    while {true} do {
        sleep 2; // Check every 2 seconds

        private _items = vestItems player + uniformItems player + backpackItems player;
        private _intelItems = ["FlashDisk", "FilesSecret", "SmartPhone", "MobilePhone", "DocumentsSecret"];

        //diag_log format ["Checking player inventory for intel items: %1", _items];

        if (_intelItems findIf { _x in _items } != -1) then {
            //diag_log "Intel item found in player inventory.";

            {
                if (_x in _items) then {
                    player removeItem _x;
                    //diag_log format ["Removed intel item: %1", _x];
                };
            } forEach _intelItems;

            [] execVM "Scripts\INTL.sqf";
            //diag_log "Executed INTL.sqf script.";
        };
    };
};
		
sleep 1;

["LOADING 100 % "] remoteExec ["hint", 0];
// Welcome to FrontlineOps
titleText ["<t color='#674ea7' size='2' font='PuristaBold'>FLO  |  FRONTLINE OPERATIONS</t>", "BLACK IN",7, true, true];

//Initialize the player
hintSilent "";

player hideObjectGlobal false;
player enableSimulationGlobal true;
player allowDamage true;

if (isMultiplayer) then {
	RESPAWN_IS_FORCED = true;
	forceRespawn player;
};

player linkItem "B_UavTerminal";

hintSilent