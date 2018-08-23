/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

scriptName "CTF: Format DB Query";
params [
	["_query","",[""]],
	["_params",[],[[]]]
];
_params = ([_query]+_params) apply {
	[if (_x isEqualType "") then {_x} else {str _x},":",""] call CaptureTheFlag_c_system_replaceInString;
};
_params joinstring ":";