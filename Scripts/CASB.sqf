params [
	"_position","_direction",["_vehicle","B_Plane_CAS_01_F"],["_type",2],
	"_logic"
];

_logic = "Logic" createVehicleLocal _position;
_logic setDir _direction;
_logic setVariable ["vehicle",_vehicle];
_logic setVariable ["type",_type];

[_logic,nil,true] call BIS_fnc_moduleCAS;

deleteVehicle _logic;