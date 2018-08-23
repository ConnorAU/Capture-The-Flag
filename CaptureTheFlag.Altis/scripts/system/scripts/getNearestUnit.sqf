/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [
	["_position",[0,0,0],[[],objNull]],
	["_searchRadius",500,[0]],
	["_ignore",[player],[[]]]
];
((nearestObjects [_position,["CAManBase"],_searchRadius])-_ignore)param[0,objNull,[objNull]]