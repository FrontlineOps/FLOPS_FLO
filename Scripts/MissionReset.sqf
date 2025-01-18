[[west,"HQ"], "Resetting Mission ..."] remoteExec ["sideChat", 0];


_missionTag = missionName;
_missionTag = [_missionTag] call BIS_fnc_filterString;

private _MarkerTimeName = _missionTag + "_Time";
private _MarkerDataName = _missionTag + "_markers";
private _VehicleDataName = _missionTag + "_Vehicles";
private _ObjectDataName = _missionTag + "_Objects";

sleep 2;

missionProfileNamespace setVariable [_MarkerTimeName, nil];
missionProfileNamespace setVariable [_MarkerDataName, nil];
missionProfileNamespace setVariable [_VehicleDataName, nil];
missionProfileNamespace setVariable [_ObjectDataName, nil];


sleep 5;
[[west,"HQ"], "Mission Reset !"] remoteExec ["sideChat", 0];


sleep 5;
"" remoteExec ["hint", 0];	