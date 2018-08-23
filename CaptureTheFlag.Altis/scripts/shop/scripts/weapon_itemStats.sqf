/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\defines.sqf"

disableSerialization;
private _display = uiNamespace getVariable ["CaptureTheFlag_UI_WeaponShop",displayNull];
if (isNull _display) exitwith {};

params [["_item","",[""]],["_weapon",false,[true]]];
if _weapon then {
	([[_item,"displayName",_item] call CaptureTheFlag_c_system_searchConfigFile] + (
	    getArray(WEAPON_SHOP_CONFIG_PATH >> (_display getVariable ["weaponMode","primary"]) >> _item >> "ammo") apply {format["%1x %2",_x select 1,[_x select 0,"displayName","Ammo"] call CaptureTheFlag_c_system_searchConfigFile]}
	)) joinstring endl
} else {
	[_item,"displayName","No Attachment"] call CaptureTheFlag_c_system_searchConfigFile
};