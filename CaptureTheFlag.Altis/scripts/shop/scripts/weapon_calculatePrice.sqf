/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\defines.sqf"

CaptureTheFlag_shop_weapon_price = 0;
{
	{
		CaptureTheFlag_shop_weapon_price = (CaptureTheFlag_shop_weapon_price + (
			switch true do {
				case (isClass(WEAPON_SHOP_CONFIG_PATH >> "primary" >> _x)):{getNumber(WEAPON_SHOP_CONFIG_PATH >> "primary" >> _x >> "price")};
				case (isClass(WEAPON_SHOP_CONFIG_PATH >> "launcher" >> _x)):{getNumber(WEAPON_SHOP_CONFIG_PATH >> "launcher" >> _x >> "price")};
				case (isClass(WEAPON_SHOP_CONFIG_PATH >> "pistol" >> _x)):{getNumber(WEAPON_SHOP_CONFIG_PATH >> "pistol" >> _x >> "price")};
				case (isClass(WEAPON_SHOP_CONFIG_PATH >> "optic" >> _x)):{getNumber(WEAPON_SHOP_CONFIG_PATH >> "optic" >> _x >> "price")};
				case (isClass(WEAPON_SHOP_CONFIG_PATH >> "muzzle" >> _x)):{getNumber(WEAPON_SHOP_CONFIG_PATH >> "muzzle" >> _x >> "price")};
				case (isClass(WEAPON_SHOP_CONFIG_PATH >> "pointer" >> _x)):{getNumber(WEAPON_SHOP_CONFIG_PATH >> "pointer" >> _x >> "price")};
				case (isClass(WEAPON_SHOP_CONFIG_PATH >> "bipod" >> _x)):{getNumber(WEAPON_SHOP_CONFIG_PATH >> "bipod" >> _x >> "price")};
				default {0};
			}
		)) max 0;
	} foreach _x;
} foreach CaptureTheFlag_shop_weapon_selection;
