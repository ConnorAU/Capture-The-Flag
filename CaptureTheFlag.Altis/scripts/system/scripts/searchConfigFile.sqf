/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [
	["_item","",[""]],
	["_token","",[""]],
	["_output",false]
];
{
	if (isClass (configFile >> _x >> _item)) exitwith {
		_output = switch true do {
			case (isText(configFile >> _x >> _item >> _token)):{getText(configFile >> _x >> _item >> _token)};
			case (isArray(configFile >> _x >> _item >> _token)):{getArray(configFile >> _x >> _item >> _token)};
			case (isNumber(configFile >> _x >> _item >> _token)):{getNumber(configFile >> _x >> _item >> _token)};
			case (isClass(configFile >> _x >> _item) && {_token == ""}):{configFile >> _x >> _item};
			default {_output};
		};
	};
}foreach ["CfgMagazines","CfgWeapons","CfgVehicles","CfgGlasses"];
_output