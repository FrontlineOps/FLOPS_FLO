if (COMMSDIS == 0) then {
    private _thisHeliInsertTrigger = _this select 0;
    private _allZoneMarks = allMapMarkers select {
        ((getMarkerPos _x) distance (getPos _thisHeliInsertTrigger) > 2000) &&
        (markerType _x in ["n_installation", "o_installation", "o_antiair", "o_service", "o_armor", "loc_Power", "o_recon", "o_support", "n_support", "loc_Ruin"])
    };
    private _MM = [_allZoneMarks, _thisHeliInsertTrigger] call BIS_fnc_nearestPosition;
    private _allZoneMarksNew = _allZoneMarks - [_MM];
    private _M = [_allZoneMarksNew, _MM] call BIS_fnc_nearestPosition;

    private _poss = getMarkerPos _M;
    private _chance = selectRandom [0, 1, 2];

    if (HELIDIS == 0) then {
        if (_chance != 2) then {
            private _poss1 = [_thisHeliInsertTrigger, 50, 200, 1, 0, 1, 0] call BIS_fnc_findSafePos;
            private _Heli_1 = createVehicle [selectRandom East_Air_Transport, _poss, [], 100, "FLY"];
            private _Group = createGroup East;
            private Heli_1_crew = createVehicleCrew _Heli_1;
            {[_x] join _Group} forEach units Heli_1_crew;

            private GroupQRF = createGroup East;
            private _SCount = [(typeOf _Heli_1), true] call BIS_fnc_crewCount;
            private _CREWC = _SCount - (count (units _Group)) - 1;

            for "_x" from 0 to _CREWC do {
                private _unit = GroupQRF createUnit [selectRandom East_Units, _poss, [], 0, "None"];
                [_unit] joinSilent GroupQRF;
            };

            // Intelligence items distribution
            private _INTSTF = ["FlashDisk", "FilesSecret", "SmartPhone", "MobilePhone", "DocumentsSecret"];
            private _INTENMALL = units GroupQRF;
            private _INTENMCNT = count _INTENMALL;
            private _INTENMCNTNEW = round (_INTENMCNT / 2);
            private _INTENMALLNEW = _INTENMALL call BIS_fnc_arrayShuffle;
            private _INTENMSEL = _INTENMALLNEW select [0, _INTENMCNTNEW];
            {_x addItem selectRandom _INTSTF;} foreach _INTENMSEL;

            // Waypoints for the helicopter
            private _WPAB_1 = _Group addWaypoint [_poss1, 0];
            _WPAB_1 setWaypointType "MOVE";
            _WPAB_1 setWaypointBehaviour "CARELESS";
            _WPAB_1 setWaypointForceBehaviour true;
            _WPAB_1 setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; GroupQRF leaveVehicle (vehicle this);"];
            _WPAB_1 setWaypointSpeed "FULL";

            private _WPAB_2 = _Group addWaypoint [_poss, 0];
            _WPAB_2 setWaypointType "MOVE";
            _WPAB_2 setWaypointSpeed "FULL";

            // Waypoints for the QRF
            private _WPS_1 = GroupQRF addWaypoint [_poss1, 0];
            _WPS_1 setWaypointType "GETOUT";
            _WPS_1 setWaypointBehaviour "COMBAT";
            _WPS_1 setWaypointCompletionRadius 100;

            private _WPS_2 = GroupQRF addWaypoint [getPos _thisHeliInsertTrigger, 0];
            _WPS_2 setWaypointType "SAD";
            _WPS_2 setWaypointBehaviour "COMBAT";

            {_x moveInCargo _Heli_1} foreach units GroupQRF;

            (driver _Heli_1) disableAI "LIGHTS";
            _Heli_1 setPilotLight true;
            _Heli_1 setCollisionLight true;

            // Implement nap-of-the-earth flying pattern
            _Heli_1 flyInHeightASL [30 + random 20];

            // Dynamic altitude adjustment
            private _playerPositions = allPlayers apply {getPosASL _x};
            private _closestPlayerDistance = _playerPositions min {(_Heli_1 distance _x)};
            if (_closestPlayerDistance < 1000) then {
                _Heli_1 flyInHeightASL [10 + random 10];
            };

            // Determine LZ type
            private _LZType = if (_closestPlayerDistance < 500) then {"Hot LZ"} else {"Cold LZ"};
            hint format ["LZ Type: %1", _LZType];

            // Strategic considerations
            private _primaryLZ = _poss;
            private _backupLZ = _poss1;
            if (_LZType == "Hot LZ") then {
                _primaryLZ = _backupLZ;
                hint "Switching to Backup LZ due to heavy fire!";
            };

            // Adjust insert point based on player capabilities
            private _playerAA = allPlayers select {any [weapons _x, {_x isKindOf "Launcher"}]};
            if (count _playerAA > 0) then {
                _primaryLZ = _backupLZ;
                hint "Avoiding Anti-Air capabilities!";
            };

            // Use terrain features for LZ
            private _terrainFeatures = nearestTerrainObjects [_primaryLZ, ["FOREST", "ROCKS", "BUILDING"], 500];
            if (count _terrainFeatures > 0) then {
                _primaryLZ = getPos (selectRandom _terrainFeatures);
                hint "Using terrain features for cover!";
            };
        };
    };
};
