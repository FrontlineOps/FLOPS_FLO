/* Captures linked campaign domains and vehicle ownership in one unscheduled boundary. */
params [["_installationMarkers", [], [[]]], ["_saveRadius", 300, [0]]];

private _campaignState = createHashMap;
private _captureError = "";
private _captureStart = diag_tickTime;
isNil {
try {
    // Funding/deployment ticks are unscheduled. Capture their linked state and
    // physical/virtual vehicle ownership together before scheduled encoding.
    call FLO_fnc_virtualizationValidateRegistry;
    private _sideResources = createHashMap;
    { _sideResources set [_x, [_y] call FLO_fnc_sideResourcesSerialize]; } forEach FLO_SideResources;
    private _logistics = createHashMap;
    { _logistics set [_x, [_y] call FLO_fnc_logisticsNetworkSerialize]; } forEach FLO_Logistics_Networks;
    _campaignState = +createHashMapFromArray [
        ["sideResources", _sideResources],
        ["logisticsNetworkBySide", _logistics],
        ["objectives", FLO_Objectives],
        ["virtualGroups", call FLO_fnc_virtualizationGetGroupMap],
        ["baseDeploymentState", call FLO_fnc_baseDeploySerializeState],
        ["capturedAtTick", diag_tickTime]
    ];
    {
        _y set ["captureTimerVersion", 1];
        _y set ["captureTimerSampleTick", _campaignState get "capturedAtTick"];
    } forEach (_campaignState get "objectives");
    private _virtualVehicles = [];
    { _virtualVehicles append (_y get "realVehicles"); } forEach (_campaignState get "virtualGroups");
    private _vehHash = createHashMap;
    private _savedIds = createHashMap;
    {
        private _nearVehs = (getMarkerPos _x) nearEntities [["Air", "Ship", "LandVehicle"], _saveRadius];
        {
            private _veh = _x;
            if (_veh in _virtualVehicles) then { continue };
            if (alive _veh && { (crew _veh select { isPlayer _x }) isEqualTo [] }) then {
                private _existingId = _veh getVariable ["FLO_SaveID", ""];
                if (_existingId == "" || !(_savedIds getOrDefault [_existingId, false])) then {
                    private _id = if (_existingId != "") then { _existingId } else { [] call FLO_fnc_createUUID };
                    _veh setVariable ["FLO_SaveID", _id, true];
                    _savedIds set [_id, true];
                    private _hadAICrew = ({ alive _x && {!isPlayer _x} } count (crew _veh)) > 0;
                    _vehHash set [_id, createHashMapFromArray [
                        ["type", typeOf _veh], ["posATL", getPosATL _veh], ["fuel", fuel _veh],
                        ["damage", damage _veh], ["damagedHitpoints", [_veh] call FLO_fnc_saveGetCompressedDamage],
                        ["vectorDirAndUp", [vectorDir _veh, vectorUp _veh]], ["locked", locked _veh], ["engineOn", isEngineOn _veh],
                        ["hadAICrew", _hadAICrew],
                        ["storeVehicle", _veh getVariable ["FLO_StoreVehicle", false]],
                        ["mobileRespawnVehicle", _veh getVariable ["FLO_MobileRespawnVehicle", false]],
                        ["supportVehicleRoles", +(_veh getVariable ["FLO_SupportVehicleRoles", []])]
                    ]];
                };
            };
        } forEach _nearVehs;
    } forEach _installationMarkers;
    _campaignState set ["vehicles", _vehHash];
    ["SAVE", 3, format ["Vehicles: %1", count _vehHash]] call FLO_fnc_log;
    private _crateHash = createHashMap;
    private _saveCrates = (entities "ReammoBox_F") select { alive _x && { _x getVariable ["FLO_save_crate", false] } };
    {
        private _id = [] call FLO_fnc_createUUID;
        _x setVariable ["FLO_SaveID", _id, true];
        private _items = [_x] call FLO_fnc_saveGetAllCargo;
        _x setVariable ["FLO_crate_items", _items, true];
        private _crateData = createHashMapFromArray [
            ["type", typeOf _x], ["posASL", getPosASL _x],
            ["vectorDirAndUp", [vectorDir _x, vectorUp _x]],
            ["items", _items], ["damage", damage _x], ["locked", locked _x]
        ];
        if (_x getVariable ["FLO_LogisticsShipment", false]) then {
            private _shipmentSide = _x getVariable ["FLO_LogisticsSide", sideUnknown];
            if !(_shipmentSide in [west, east]) then {
                throw format ["Logistics shipment %1 has invalid side %2", _id, _shipmentSide];
            };
            _crateData set ["logisticsShipment", true];
            _crateData set ["logisticsDelivered", _x getVariable ["FLO_LogisticsDelivered", false]];
            _crateData set ["logisticsSideKey", [_shipmentSide] call FLO_fnc_sideKey];
            _crateData set ["logisticsOriginNodeId", _x getVariable ["FLO_LogisticsOriginNodeId", ""]];
            _crateData set ["logisticsThroughput", _x getVariable ["FLO_LogisticsThroughput", -1]];
            _crateData set ["logisticsContributorUID", _x getVariable ["FLO_LogisticsContributorUID", ""]];
            _crateData set ["logisticsContributorName", _x getVariable ["FLO_LogisticsContributorName", ""]];
            _crateData set ["developmentTargetObjectiveId", _x getVariable ["FLO_DevelopmentTargetObjectiveId", ""]];
        };
        _crateHash set [_id, _crateData];
    } forEach _saveCrates;
    _campaignState set ["crates", _crateHash];
    ["SAVE", 3, format ["Crates: %1", count _crateHash]] call FLO_fnc_log;
    private _fobArray = [];
    private _opArray = [];
    private _fobType = FLO_FactionFobType;
    private _fobContainerType = FLO_FactionFobTerminalType;
    private _opType = FLO_FactionCopType;
    private _opContainerType = FLO_FactionCopTerminalType;
    {
        if !(_x isEqualType "" && {_x != ""} && {isClass (configFile >> "CfgVehicles" >> _x)}) then {
            throw format ["Base structure class is invalid: %1", _x];
        };
    } forEach [_fobType, _fobContainerType, _opType, _opContainerType];

    // Find and save FOBs with their containers
    if (_fobType != "") then {
        {
            if (!isNull _x && alive _x && { _x getVariable ["FLO_FOB_Initialized", false] }) then {
                private _building = _x;
                private _marker = _building getVariable ["fobMarkerName", ""];
                private _baseSide = _building getVariable "FLO_BaseSide";
                private _baseSaveId = _building getVariable "FLO_BaseSaveId";
                private _logisticsNodeId = _building getVariable "FLO_LogisticsNodeId";
                if (
                    !(_baseSide in [east, west])
                    || {!(_baseSaveId isEqualType "" && {_baseSaveId != ""})}
                    || {!(_logisticsNodeId isEqualType "" && {_logisticsNodeId != ""})}
                ) then {
                    throw format ["FOB at %1 has invalid save identity", getPosASL _building];
                };

                private _nearContainer = _building getVariable "FLO_BaseTerminal";
                if (isNil "_nearContainer" || {!(_nearContainer isEqualType objNull)}) then {
                    throw format ["Base %1 has no initialized terminal ownership", _baseSaveId];
                };
                if (!isNull _nearContainer && {(_nearContainer getVariable ["FLO_BaseOwner", objNull]) isNotEqualTo _building}) then {
                    throw format ["Base %1 terminal ownership is not reciprocal", _baseSaveId];
                };

                // Save full FOB data
                private _fobData = createHashMapFromArray [
                    ["buildingType", typeOf _building],
                    ["buildingPosASL", getPosASL _building],
                    ["buildingDir", getDir _building],
                    ["buildingVectorUp", vectorUp _building],
                    ["markerName", _marker],
                    ["baseSideKey", [_baseSide] call FLO_fnc_sideKey],
                    ["baseSaveId", _baseSaveId],
                    ["logisticsNodeId", _logisticsNodeId]
                ];

                // Add container data if found
                if (!isNull _nearContainer) then {
                    _fobData set ["containerType", typeOf _nearContainer];
                    _fobData set ["containerPosASL", getPosASL _nearContainer];
                    _fobData set ["containerDir", getDir _nearContainer];
                    _fobData set ["containerVectorUp", vectorUp _nearContainer];
                };

                _fobArray pushBack _fobData;
            };
        } forEach (allMissionObjects _fobType);
    };

    // Find and save OPs with their containers
    if (_opType != "") then {
        {
            if (!isNull _x && alive _x && { _x getVariable ["FLO_OP_Initialized", false] }) then {
                private _building = _x;
                private _marker = _building getVariable ["opMarkerName", ""];
                private _baseSide = _building getVariable "FLO_BaseSide";
                private _baseSaveId = _building getVariable "FLO_BaseSaveId";
                private _logisticsNodeId = _building getVariable "FLO_LogisticsNodeId";
                if (
                    !(_baseSide in [east, west])
                    || {!(_baseSaveId isEqualType "" && {_baseSaveId != ""})}
                    || {!(_logisticsNodeId isEqualType "" && {_logisticsNodeId != ""})}
                ) then {
                    throw format ["OP at %1 has invalid save identity", getPosASL _building];
                };

                private _nearContainer = _building getVariable "FLO_BaseTerminal";
                if (isNil "_nearContainer" || {!(_nearContainer isEqualType objNull)}) then {
                    throw format ["Base %1 has no initialized terminal ownership", _baseSaveId];
                };
                if (!isNull _nearContainer && {(_nearContainer getVariable ["FLO_BaseOwner", objNull]) isNotEqualTo _building}) then {
                    throw format ["Base %1 terminal ownership is not reciprocal", _baseSaveId];
                };

                // Save full OP data
                private _opData = createHashMapFromArray [
                    ["buildingType", typeOf _building],
                    ["buildingPosASL", getPosASL _building],
                    ["buildingDir", getDir _building],
                    ["buildingVectorUp", vectorUp _building],
                    ["markerName", _marker],
                    ["baseSideKey", [_baseSide] call FLO_fnc_sideKey],
                    ["baseSaveId", _baseSaveId],
                    ["logisticsNodeId", _logisticsNodeId]
                ];

                // Add container data if found
                if (!isNull _nearContainer) then {
                    _opData set ["containerType", typeOf _nearContainer];
                    _opData set ["containerPosASL", getPosASL _nearContainer];
                    _opData set ["containerDir", getDir _nearContainer];
                    _opData set ["containerVectorUp", vectorUp _nearContainer];
                };

                _opArray pushBack _opData;
            };
        } forEach (allMissionObjects _opType);
    };

    _campaignState set ["fobs", _fobArray];
    _campaignState set ["ops", _opArray];
    ["SAVE", 3, format ["Structures: %1 FOBs, %2 OPs", count _fobArray, count _opArray]] call FLO_fnc_log;
} catch { _captureError = _exception; };
};
if (_captureError != "") then {
    ["SAVE", 1, format ["Campaign snapshot rejected: %1", _captureError]] call FLO_fnc_log;
    throw _captureError;
};
private _captureMs = (diag_tickTime - _captureStart) * 1000;
if (_captureMs > 20) then {
    ["SAVE", 4, format ["[PERF] Coherent snapshot groups=%1 objectives=%2 vehicles=%3 sides=%4 captureMs=%5", count (_campaignState get "virtualGroups"), count (_campaignState get "objectives"), count (_campaignState get "vehicles"), count (_campaignState get "sideResources"), _captureMs]] call FLO_fnc_log;
};

_campaignState
