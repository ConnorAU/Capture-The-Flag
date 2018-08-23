/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [
	["_item",nil],
	["_arr",[],[[]]],
	["_return",-1]
];
if (isNil "_item") exitwith {_return};
{
	if (!isNil {_x} && {_x isEqualType []}) then {
		if(_item in _x) exitWith {
			_return = _forEachIndex;
	    };
	};
	if (_return > -1) exitwith {};
} foreach _arr;
_return;
