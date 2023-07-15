
#include "macros.inc"

private [ "_connectionType", "_fromID", "_toID", "_from", "_to" ];

{
	_connectionType = getText ( _x >> "CustomData" >> "type" );
	_fromID = getNumber( _x >> "item0" );
	_toID = getNumber( _x >> "item1" );
	_from = _ids select _fromID;
	_to = _ids select _toID;

	_msg = "";

	if ( !isNil "_from" && !isNil "_to" ) then {

		switch ( _connectionType ) do {

			case 'WaypointActivation' : {
				private [ "_trg", "_wp" ];

				if ( { !( _x isEqualType [] ) }count[ _from, _to ] > 0 ) then {
					_trg = {
						if !( _x isEqualType [] ) exitWith { _x };
					}forEach [ _from, _to ];
					_wp = ( [ _from, _to ] - [ _trg ] ) select 0;
					_trg synchronizeTrigger [ _wp ];
					_msg = format[ "WaypointActivation T:%1 >> W:%2", _trg, _wp ];
				}else{
					_from synchronizeWaypoint [ _to ];
					_msg = format[ "WaypointActivation W:%1 >> W:%2", _from, _to ];
				};
			};

			case 'Sync' : {
				_from synchronizeObjectsAdd [ _to ];
				_msg = format[ "Sync F:%1, %2 >> T:%3, %4", typeOf _from, _fromID, typeOf _to, _toID ];
			};

			case "RandomStart" : {

			};

			case "TriggerOwner" : {
				private [ "_info", "_trg", "_owner", "_type", "_act", "_condition", "_cond" ];

				_info = {
					if ( typeOf _x isEqualTo "EmptyDetector" ) exitWith { [ _x, _forEachIndex ] };
				}forEach [ _from, _to ];
				_trg = _info select 0;
				_owner = ( [ _from, _to ] - [ _trg ] ) select 0;
				( _objects select ( [ _toID, _fromID ] select ( _info select 1 )))params[ "_id", "_cfg" ];
				_type = [ ( _cfg >> "Attributes" >> "activationByOwner" ), "TXT", "VEHICLE" ] call LARs_fnc_getCfgValue;
				_act = triggerActivation _trg;
				_act set [ 0, _type ];
				_condition = [ ( _cfg >> "Attributes" >> "condition" ), "TXT", "this" ] call LARs_fnc_getCfgValue;
				_cond = triggerStatements _trg;
				_cond set [ 0, _condition ];
				if ( _type isEqualTo "STATIC" ) then {
					_trg triggerAttachObject [ _owner ];
					_msg = format[ "TriggerAttachObject T:%1 >> O:%2", _trg, _owner ];
				}else{
					_trg triggerAttachVehicle [ _owner ];
					_msg = format[ "TriggerAttachVehicle T:%1 >> O:%2", _trg, _owner ];
				};
				_trg setTriggerActivation _act;
				_trg setTriggerStatements _cond;
			};
		};
	}else{
		//diag_log format[ "connection object missing - Fid: %1, F: %2, Tid: %3, T: %4", _fromID, _from, _toID, _to ];
	};

	if !( _msg isEqualTo "" ) then {
		DEBUG_MSG( DEBUG, _msg );
	};
}forEach ( "true" configClasses ( _compCfg >> "connections" >> "Links" ) );