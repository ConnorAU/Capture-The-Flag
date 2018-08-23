/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\defines.sqf"
#include "..\..\defines.sqf"

CaptureTheFlag_shop_clothing_price = 0;
private "_type";
{
	if (_x isequaltype "" && {_x != ""}) then {
		_type = CLOTHING_SHOP_LOADOUT_ORDER param [_forEachIndex,""];
		CaptureTheFlag_shop_clothing_price=(CaptureTheFlag_shop_clothing_price+getNumber(CLOTHING_SHOP_CONFIG_PATH >> _type >> str SIDE_VAR(player) >> _x >> "price"))max 0;
	};
} foreach CaptureTheFlag_shop_clothing_selection;