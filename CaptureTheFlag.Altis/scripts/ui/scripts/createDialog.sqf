/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

disableSerialization;
params [
	["_ui","",[""]],
	["_d",findDisplay 46,[displayNull]]
];
if (!isClass(missionConfigFile >> _ui) && {!(tolower _ui in (["RscDisplayDynamicGroups"] apply {tolower _x}))}) exitwith {};

// It's done this way so you can still use ur mic and run around and stuff with the dialog open
private _d = _d createDisplay _ui;