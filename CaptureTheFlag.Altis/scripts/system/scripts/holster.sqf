/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

if (vehicle player != player OR {NEEDS_REVIVE(player)}) exitwith {};
if (currentWeapon player != "") then {
	player action ["switchweapon",player,player,100];
} else {
	private _w = ([primaryWeapon player,handgunWeapon player,secondaryWeapon player]-[""])param [0,"",[""]];
	if (_w != "") then {
		player selectWeapon _w;
	};
};