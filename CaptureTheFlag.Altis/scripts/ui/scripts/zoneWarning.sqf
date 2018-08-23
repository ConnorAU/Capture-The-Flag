/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [["_warningToken","",[""]],["_condition",{},[{}]]];
if !(call _condition) exitwith {};
if !canSuspend exitwith {_this spawn CaptureTheFlag_c_ui_zoneWarning};

if (isNil "CaptureTheFlag_ui_zoneWarning_active") then {CaptureTheFlag_ui_zoneWarning_active = false};
if CaptureTheFlag_ui_zoneWarning_active exitwith {};
CaptureTheFlag_ui_zoneWarning_active = true;

private _cfgClass = missionConfigFile >> "CfgScripts" >> "ui" >> "configs" >> "ZoneWarningTemplate" >> _warningToken;
if !isClass(_cfgClass) exitwith {};

private _text = getText(_cfgClass >> "text");
private _time = getNumber(_cfgClass >> "time") call compile getText(_cfgClass >> "timeModifier");
private _expression = getText(_cfgClass >> "expression");

true call CaptureTheFlag_c_ui_warningEffects;

for "_i" from _time to 0 step -1 do {
	["showNotification",[format[_text,[_i,"MM:SS"] call BIS_fnc_secondsToString],[0,1] select (_i == _time)]] call CaptureTheFlag_c_ui_HUD_NotificationSmall;
	uisleep 1;
	if !(call _condition) exitwith {};
};

["hideNotification",[1]] call CaptureTheFlag_c_ui_HUD_NotificationSmall;
false call CaptureTheFlag_c_ui_warningEffects;
CaptureTheFlag_ui_zoneWarning_active = false;
if !(call _condition) exitwith {};

call compile _expression;