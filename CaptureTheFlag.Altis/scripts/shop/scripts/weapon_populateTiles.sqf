/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\defines.sqf"

params ["_mode","_display"];
if (isNull _display) exitwith {};
_display setVariable ["weaponMode",_mode];

private _selectedWeapon = _display displayCtrl 20;
private _selectedOptic = _display displayCtrl 21;
private _selectedPointer = _display displayCtrl 22;
private _selectedMuzzle = _display displayCtrl 23;
private _selectedBipod = _display displayCtrl 24;

private _index = WEAPON_SHOP_WEP_ORDER find _mode;
(CaptureTheFlag_shop_weapon_selection select _index) params ["_weapon","_muzzle","_pointer","_optic","_bipod"];

switch _index do {
	case 1:{
		if (_weapon == "") then {
			_weapon = secondaryWeapon player;
			if (_muzzle == "") then {_muzzle = (secondaryWeaponItems player) select 0};
			if (_optic == "") then {_optic = (secondaryWeaponItems player) select 2};
			if (_pointer == "") then {_pointer = (secondaryWeaponItems player) select 1};
			if (_bipod == "") then {_bipod = (secondaryWeaponItems player) select 3};
		};
	};
	case 2:{
		if (_weapon == "") then {
			_weapon = handgunWeapon player;
			if (_muzzle == "") then {_muzzle = (handgunItems player) select 0};
			if (_optic == "") then {_optic = (handgunItems player) select 2};
			if (_pointer == "") then {_pointer = (handgunItems player) select 1};
			if (_bipod == "") then {_bipod = (handgunItems player) select 3};
		};
	};
	default {
		if (_weapon == "") then {
			_weapon = primaryWeapon player;
			if (_muzzle == "") then {_muzzle = (primaryWeaponItems player) select 0};
			if (_optic == "") then {_optic = (primaryWeaponItems player) select 2};
			if (_pointer == "") then {_pointer = (primaryWeaponItems player) select 1};
			if (_bipod == "") then {_bipod = (primaryWeaponItems player) select 3};
		};
	};
};

_display setVariable ["weaponRank",getNumber(WEAPON_SHOP_CONFIG_PATH >> (WEAPON_SHOP_WEP_ORDER select _index) >> _weapon >> "rank")];

private _img = "";
{
	_x params ["_ctrl","_class","_defaultImg","_enable"];
	_img = [_class,"picture",""] call CaptureTheFlag_c_system_searchConfigFile;
	if (_img == "") then {_img = _defaultImg};
	_ctrl ctrlSetText _img;
	_ctrl setVariable ["class",_class];
	_ctrl ctrlEnable _enable;
	_ctrl ctrlSetTooltip ([_class,_forEachIndex < 1] call CaptureTheFlag_c_shop_weapon_itemStats);
} foreach [
	[
		_selectedWeapon,
		_weapon,
		[
			WEAPON_SHOP_PWEP_IMG,
			WEAPON_SHOP_SWEP_IMG,
			WEAPON_SHOP_HWEP_IMG
		] param [_index,WEAPON_SHOP_PWEP_IMG],
		true
	],
	[
		_selectedOptic,
		_optic,
		WEAPON_SHOP_OATT_IMG,
		count getArray(WEAPON_SHOP_CFGWEP_DIR(_weapon) >> "CowsSlot" >> "compatibleItems")>0
	],
	[
		_selectedMuzzle,
		_muzzle,
		WEAPON_SHOP_MATT_IMG,
		count getArray(WEAPON_SHOP_CFGWEP_DIR(_weapon) >> "MuzzleSlot" >> "compatibleItems")>0
	],
	[
		_selectedPointer,
		_pointer,
		WEAPON_SHOP_PATT_IMG,
		count getArray(WEAPON_SHOP_CFGWEP_DIR(_weapon) >> "PointerSlot" >> "compatibleItems")>0
	],
	[
		_selectedBipod,
		_bipod,
		WEAPON_SHOP_BATT_IMG,
		count getArray(WEAPON_SHOP_CFGWEP_DIR(_weapon) >> "UnderBarrelSlot" >> "compatibleItems")>0
	]
];

[_display] call CaptureTheFlag_c_shop_weapon_populateBuyButtons;