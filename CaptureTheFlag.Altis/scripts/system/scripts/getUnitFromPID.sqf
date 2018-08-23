/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [["_pid","",[""]],["_exclusion",[],[[]]]];
if (_pid == "") exitwith {objNull};
((playableUnits-_exclusion) select {getPlayerUID _x == _pid}) param [0,objnull]
