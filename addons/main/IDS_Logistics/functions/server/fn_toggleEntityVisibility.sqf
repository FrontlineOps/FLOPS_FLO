/**
 * @name IDS_Logistics_fnc_toggleEntityVisibility
 * @category Logistics_Server
 * 
 * @author IDSolutions
 * @version 1.0
 * @date 2025-03-10
 * 
 * @description
 * Server-side function to hide or show an entity during manipulation.
 * Used when an entity is being picked up or placement is cancelled.
 *
 * @param {String} _netId - The netId of the entity to manipulate
 * @param {Boolean} _hide - True to hide entity, false to show
 *
 * @return {Nothing}
 */

if (!isServer) exitWith { false };
params [
    ["_netId", "", [""]],
    ["_hide", true, [true]],
    ["_requester", objNull, [objNull]]
];

if (_netId == "") exitWith { false };

// Find entity by netId
private _entity = objectFromNetId _netId;

if (isNull _entity) exitWith { false };

private _state = _entity getVariable ["IDS_Logistics_VisibilityState", []];
private _requestOwner = if (isRemoteExecuted) then { remoteExecutedOwner } else { clientOwner };
if (_state isNotEqualTo [] && {(_state select 0) != _requestOwner}) exitWith {
    ["IDS_LOGISTICS", 2, "Rejected visibility change: another client owns the placement"] call FLO_fnc_log;
    false
};

if (_hide) then {
    if (_state isNotEqualTo []) exitWith {};
    _entity setVariable ["IDS_Logistics_VisibilityState", [_requestOwner, isObjectHidden _entity, simulationEnabled _entity, _requester]];
    IDS_Logistics_ManipulatedEntities pushBackUnique _entity;
    _entity hideObjectGlobal true;
    _entity enableSimulationGlobal false;
} else {
    if (_state isEqualTo []) exitWith {};
    [_entity] call IDS_Logistics_fnc_releaseEntity;
};

if (!isNil "FLO_fnc_netDebugRecord") then {
    ["idsVisibilityToggles", 1] call FLO_fnc_netDebugRecord;
};
true
