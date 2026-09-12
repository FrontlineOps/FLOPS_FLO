/* Deferred current-format batteries use the same selected composition as range queries. */
params ["_groupId", "_groupData", "_position", "_side"];
[_groupData] call FLO_fnc_virtualizationResolveStaticAAComposition;
[_groupId, _side, "static_aa", _position, _groupData get "comp", _groupData] call FLO_fnc_virtualizationSpawnFromComposition
