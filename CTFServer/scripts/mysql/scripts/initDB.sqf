/*
	File: init.sqf

	Description:
	Initializes extDB, loads Protocol + options if any + Locks extDB

	Parameters:
		0: STRING Database name as in extdb-conf.ini
		1: STRING Protocol to enable
		2: STRING Optional Protocol Options i.e db_conf name for DB_CUSTOM
*/
#include "..\defines.sqf"

if (isNil{uiNamespace getVariable "CaptureTheFlag_mysql_sessionID"}) then {
	if !extDB3_var_loaded exitwith {
		//call CODE_LOCKSERVER;
		false
	};

	// extDB Connect to Database
	private _result = call compile ("extDB3" callExtension format["9:ADD_DATABASE:%1", DATABASE]);
	if (_result select 0 isEqualTo 0) exitWith {
		#ifdef LOG_TO_RPT
			["Error",_result] call LOG_CODE;
		#endif
		//call CODE_LOCKSERVER;
		extDB3_var_loaded = false;
		false
	};
	["Setup","Connected to database"] call LOG_CODE;

	// Generate Randomized Protocol Name
	private _CaptureTheFlag_mysql_sessionID = str round(random(999999));

	// extDB Load Protocol
	_result = call compile ("extDB3" callExtension format["9:ADD_DATABASE_PROTOCOL:%1:%2:%3:%4.ini", DATABASE, PROTOCOL, _CaptureTheFlag_mysql_sessionID, DATABASE]);
	if ((_result select 0) isEqualTo 0) exitWith {
		#ifdef LOG_TO_RPT
			["ERROR",_result] call LOG_CODE;
		#endif
		//call CODE_LOCKSERVER;
		extDB3_var_loaded = false;
		false
	};

	#ifdef LOG_TO_RPT
		["Setup",format["%1 %2 protocol initalized",PROTOCOL,DATABASE]] call LOG_CODE;
	#endif

	// extDB3 Lock
	"extDB3" callExtension "9:LOCK";
	
	#ifdef LOG_TO_RPT
		["Setup","Locked"] call LOG_CODE;
	#endif

	// Save Randomized ID
	missionNamespace setVariable ["CaptureTheFlag_mysql_sessionID", compileFinal _CaptureTheFlag_mysql_sessionID];
	uiNamespace setVariable ["CaptureTheFlag_mysql_sessionID", compileFinal _CaptureTheFlag_mysql_sessionID];

	true
} else {
	missionNamespace setVariable ["CaptureTheFlag_mysql_sessionID", uiNamespace getVariable "CaptureTheFlag_mysql_sessionID"];

	#ifdef LOG_TO_RPT
		["Setup","Session ID already exists"] call LOG_CODE;
	#endif

	true
};