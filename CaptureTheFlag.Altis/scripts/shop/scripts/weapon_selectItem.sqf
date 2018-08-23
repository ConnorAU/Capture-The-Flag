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
params ["_ctrl"];
private _display = ctrlParent _ctrl;
private _sliderMode = _display getVariable ["sliderMode",""];
private _weaponMode = _display getVariable ["weaponMode",""];

if (isNull _display) exitwith {};
if ("" in [_sliderMode,_weaponMode]) exitwith {};

private _weaponIndex = WEAPON_SHOP_WEP_ORDER find _weaponMode;
private _selectedModeIndex = [["","muzzle","pointer","optic","bipod"] find _sliderMode,0] select (_sliderMode in WEAPON_SHOP_WEP_ORDER);
private _selectedItem = _ctrl getVariable ["class",""];

if (-1 in [_selectedModeIndex,_weaponIndex] OR _selectedItem == "") exitwith {};

private _selectedArray = +CaptureTheFlag_shop_weapon_selection select _weaponIndex;

if (_selectedModeIndex == 0) then {
	_selectedArray = [[_selectedItem,""] select (_selectedItem == ([primaryWeapon player,secondaryWeapon player,handgunWeapon player] select _weaponIndex)),"","","",""];
} else {
	private _itemOwned = if ((_selectedArray select 0) in [[primaryWeapon player,secondaryWeapon player,handgunWeapon player] select _weaponIndex,""]) then {
	 	tolower _selectedItem in ([primaryWeaponItems player,secondaryWeaponItems player,handgunItems player] select _weaponIndex apply {tolower _x});
	} else {
		false
	};
	_selectedArray set [_selectedModeIndex,[_selectedItem,""] select _itemOwned];
};

CaptureTheFlag_shop_weapon_selection set [_weaponIndex,_selectedArray];
[_weaponMode,_display] call CaptureTheFlag_c_shop_weapon_populateTiles;