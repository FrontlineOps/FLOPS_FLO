/* Server-owned restoration; callers authenticate the release before reaching this boundary. */
params ["_entity"];
if (!isServer) exitWith { false };
private _state = _entity getVariable ["IDS_Logistics_VisibilityState", []];
if (_state isEqualTo []) exitWith { false };
if (isRemoteExecuted && {(_state select 0) != remoteExecutedOwner}) exitWith { false };
_entity hideObjectGlobal (_state select 1);
_entity enableSimulationGlobal (_state select 2);
_entity setVariable ["IDS_Logistics_VisibilityState", nil];
IDS_Logistics_ManipulatedEntities = IDS_Logistics_ManipulatedEntities - [_entity];
true
