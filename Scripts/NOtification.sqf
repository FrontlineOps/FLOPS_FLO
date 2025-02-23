_Reward = _this select 0;
_OBJStr = _this select 1;

{playMusic "EventTrack01_F_Curator";} remoteExec ["call", 0];

["showNotification", ["REWARD", format["%1 SECURED - %2 Points", _OBJStr, _Reward], "success"]] call FLO_fnc_intelSystem;
