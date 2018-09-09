/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

// Load required extensions
diag_log parsetext " ";
if (isNil "extDB3_var_loaded") then {
	missionNamespace setVariable ["extDB3_var_loaded",compileFinal str (("extDB3" callExtension "9:VERSION") != "")];
};
diag_log parsetext " ";

// Exit init if script cfg is missing
if !(isClass (configFile >> "CfgCTFScripts")) exitwith {};

private _doLog = {
	params ["_text",["_force",false]];
	if _force then {diag_log parsetext format["[Capture the Flag: Server Module Init] %1",_text]};
};
private _fncCount = 0;
private _executeCount = 0;
private _broadcastCount = 0;
private _tickTime = diag_tickTime;
private _executeList = [];
private _broadcastList = [];

["Started",true] call _doLog;
private ["_className","_broadcast","_functionName","_functionContent","_executePriority"];
{
	_className = configName _x;
	{
		_broadcast = getNumber(_x >> "broadcast") == 1;
		_functionName = "CaptureTheFlag_"+(["s","c"] select _broadcast)+"_"+_className+"_"+configName _x;
		_functionContent = preprocessFile ("\CTFServer\scripts\"+_className+"\scripts\"+configName _x+".sqf");

		missionNameSpace setVariable [_functionName,compileFinal _functionContent];
		["Compiled "+_functionName] call _doLog;
		_fncCount = _fncCount + 1;
		if _broadcast then {
			publicVariable _functionName;
			_broadcastCount = _broadcastCount + 1;
			_broadcastList pushback _functionName;
			["Broadcast "+_functionName] call _doLog;
		};
		if (isNumber(_x >> "executePriority")) then {
			_executePriority = getNumber(_x >> "executePriority");
			_executeList set [_executePriority,(_executeList param [_executePriority,[],[[]]])+[_functionName]];
			_executeCount = _executeCount + 1;
		};
	}foreach("true" configClasses (_x >> "functions"));
} foreach ("true" configClasses (configFile >> "CfgCTFScripts"));

// Broadcast list of public functions so the client knows what to wait for
missionNameSpace setVariable ["CaptureTheFlag_setup_SIMBV",compilefinal str _broadcastList];
publicVariable "CaptureTheFlag_setup_SIMBV";

[format["%1 functions compiled",_fncCount],true] call _doLog;
[format["%1 functions broadcast",_broadcastCount]] call _doLog;
[format["%1 functions queued for execution",_executeCount]] call _doLog;
[format["%1 seconds elapsed",diag_tickTime - _tickTime],true] call _doLog;

// Execute scripts in the queue (like pre/post init scripts)
{
	if (!isNil {_x} && {_x isEqualType []}) then {
		{
			["Executing "+_x] call _doLog;
			[] call (missionNamespace getVariable [_x,{}]);
		} foreach _x;
	};
}foreach _executeList;

true