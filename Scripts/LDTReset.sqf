

_FRUNTS = [F_Officer, F_Assault_Eng, F_Assault_TL,  F_Assault_SL, F_Assault_Eod, F_Assault_AT, F_Assault_Mg, F_Assault_Med, F_Assault_Uav, F_Assault_Mrk, F_Assault_Amm, F_Recon_Snp, F_Recon_Sct, F_Recon_TL, F_Recon_Mrk, F_Recon_AT, F_Recon_Mg, F_Recon_Eod, F_Recon_Med, F_Recon_Eng, F_Diver_TL, F_Diver_Rfl, F_Diver_Eod];



{
_UNTType = _x ;
_UNTTypeName = str _UNTType ;
_missionTag = missionName;
_missionTag = [_missionTag] call BIS_fnc_filterString;
private _LoadOutName = _missionTag + _UNTTypeName;

profileNamespace setVariable [_LoadOutName, nil];
} forEach _FRUNTS ;