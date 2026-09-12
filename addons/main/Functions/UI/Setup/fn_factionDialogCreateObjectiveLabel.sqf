/*
 * Function: FLO_fnc_factionDialogCreateObjectiveLabel
 * Author: Frontline Operations Development Group
 * Description:
 *   Creates a hidden objective composition label control.
 *
 * Arguments:
 * 0: Parent controls group <CONTROL>
 * 1: Control registry <ARRAY>
 * 2: Text <STRING>
 * 3: X <NUMBER>
 * 4: Y <NUMBER>
 * 5: W <NUMBER>
 * 6: H <NUMBER>
 * 7: Section label <BOOL>
 *
 * Returns:
 * Control <CONTROL>
 */
disableSerialization;
params ["_parent", "_controls", "_text", "_ctrlX", "_ctrlY", "_ctrlW", "_ctrlH", ["_section", false]];

private _class = ["FLO_FactionTuneLabel", "FLO_FactionTuneSection"] select (_section);
private _ctrl = (ctrlParent _parent) ctrlCreate [_class, -1, _parent];
_ctrl ctrlSetText _text;
_ctrl ctrlSetPosition [_ctrlX, _ctrlY, _ctrlW, _ctrlH];
_ctrl ctrlCommit 0;
_ctrl ctrlShow false;
_controls pushBack _ctrl;

_ctrl
