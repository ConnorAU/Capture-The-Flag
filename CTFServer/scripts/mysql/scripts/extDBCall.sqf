/*
	Author: "Tonic"
	Parameters:
		0: STRING (Query to be ran).
		1: INTEGER (1 = ASYNC + not return for update/insert, 2 = ASYNC + return for query's).
		3: BOOL (True to return a single array, false to return multiple entries mainly for garage).
*/
#include "..\defines.sqf"
scriptName "CTF: Execute DB Query";

if !extDB3_var_loaded exitwith {};

params [
	["_queryStmt","",[""]],
	["_mode",1,[0]],
	["_multiarr",false,[true]]
];

#ifdef LOG_TO_RPT
    ["Query",_queryStmt] call LOG_CODE;
#endif

private _key = "extDB3" callExtension ([_mode,call CaptureTheFlag_mysql_sessionID,_queryStmt] joinString ":");
if (_mode isEqualTo 1) exitWith {true};

_key = (call compile _key) select 1;
private _queryResult = "extDB3" callExtension ([4,_key] joinString ":");

if (_queryResult isEqualTo "[3]") then {
    for "_i" from 0 to 1 step 0 do {
        if (!(_queryResult isEqualTo "[3]")) exitWith {};
        _queryResult = "extDB3" callExtension ("4:"+_key);
    };
};

if (_queryResult isEqualTo "[5]") then {
    _queryResult = [];
    for "_i" from 0 to 1 step 0 do {
        _pipe = "extDB3" callExtension ("5:"+_key);
        if (_pipe isEqualTo "") exitWith {};
        _queryResult pushback _pipe;
    };
    _queryResult = _queryResult joinString "";
};

_queryResult = call compile _queryResult;

#ifdef LOG_TO_RPT
    ["Reply",_queryResult param [1,[]]] call LOG_CODE;
#endif

private _return = (_queryResult select 1);
if (!_multiarr && count _return > 0) then {
    _return = (_return select 0);
};

_return;