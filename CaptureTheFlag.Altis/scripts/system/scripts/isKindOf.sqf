/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [["_class","",["",objNull]],["_types","",["",[]]]];
if (_types isEqualType "") then {_types = [_types];};
({_class iskindof _x} count _types) > 0
/*if (_class isEqualType "") then {
	private _parents = ([configfile >> "cfgvehicles" >> _class,true] call BIS_fnc_returnParents)apply{tolower _x};
	({(tolower _x) in _parents} count _types) > 0
} else {
};*/
