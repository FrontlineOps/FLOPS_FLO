/*
 * Function: FLO_fnc_virtualizationCloneValue
 * Description:
 *   Deep-copies registry values with the engine's recursive container copy.
 */

params ["_value"];

if (_value isEqualType [] || {_value isEqualType createHashMap}) exitWith { +_value };

_value
