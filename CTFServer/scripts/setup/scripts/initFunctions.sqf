/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */


// Exit if config doesnt exist
if !(isClass (missionConfigFile >> "CfgScripts")) exitwith {};

private _doLog = {
	params ["_text",["_force",false]];
	if _force then {diag_log parsetext format["[Capture the Flag: Client Module Init] %1",_text]};
};
private _fncCount = 0;
private _executeCount = 0;
private _tickTime = diag_tickTime;
private _executeList = [];

["Started",true] call _doLog;
private ["_moduleName","_functionContent","_functionName","_executePriority"];
{
	_moduleName = configName _x;
	{
		_functionName = "CaptureTheFlag_c_"+_moduleName+"_"+configName _x;
		if ((isServer && getNumber(_x >> "compileOnServer") == 1) OR !isServer) then {
			_functionContent = preprocessFile ("scripts\"+_moduleName+"\scripts\"+configName _x+".sqf");

			missionNameSpace setVariable [_functionName,compileFinal _functionContent];
			["Compiled "+_functionName,false] call _doLog;
			_fncCount = _fncCount + 1;
			if (isNumber(_x >> "executePriority")) then {
				_executePriority = getNumber(_x >> "executePriority");
				_executeList set [_executePriority,(_executeList param [_executePriority,[],[[]]])+[_functionName]];
				_executeCount = _executeCount + 1;
			};
		} else {
			// Most client functions don't need to be loaded on the server, but we still set them so they can't be overridden
			missionNamespace setVariable [_functionName,compileFinal ("diag_log '"+_functionName+" is a reserved function';")];
			["Reserved "+_functionName,false] call _doLog;
		};
	}foreach("true" configClasses (_x >> "functions"));
} foreach ("true" configClasses (missionConfigFile >> "CfgScripts"));

[format["%1 functions compiled",_fncCount],true] call _doLog;
[format["%1 functions queued for execution",_executeCount],false] call _doLog;
[format["%1 seconds elapsed",diag_tickTime - _tickTime],true] call _doLog;

if !isServer then {
	// Functions have loaded, now we need to wait for other init scripts to catch up
	waitUntil {!isNil "CaptureTheFlag_setup_initFunctions_runPendingRequests"};
};

{
	if (!isNil {_x} && {_x isEqualType []}) then {
		{
			["Executing "+_x,false] call _doLog;
			[] call (missionNamespace getVariable [_x,{}]);
		} foreach _x;
	};
}foreach _executeList;
CaptureTheFlag_setup_initFunctions_runPendingRequests = nil;