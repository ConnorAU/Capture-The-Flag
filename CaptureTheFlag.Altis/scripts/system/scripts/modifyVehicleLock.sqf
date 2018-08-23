/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [["_vehicle",objNull,[objNull]],["_lock",true,[true]]];
if (local _vehicle) then {
	_vehicle lock _lock;
} else {
	[_vehicle,_lock] remoteExec ["lock",_vehicle];
};