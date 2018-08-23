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
if (_mode in ["primary","launcher","pistol"]) then {[_mode,_display] call CaptureTheFlag_c_shop_weapon_populateTiles};
private _scollerContainer = _display displayCtrl 15;
_display setVariable ["sliderMode",_mode];
{ctrlDelete _x} foreach (_scollerContainer getVariable ["children",[]]);

private _children = [];
private _ex = 0;
private _isWeapon = _mode in WEAPON_SHOP_WEP_ORDER;
private _selWeapon = (_display displayCtrl 20) getVariable ["class",""];
private _selWeaponAttachments = (
	getarray(WEAPON_SHOP_CFGWEP_DIR(_selWeapon) >> "CowsSlot" >> "compatibleItems")+
	getarray(WEAPON_SHOP_CFGWEP_DIR(_selWeapon) >> "MuzzleSlot" >> "compatibleItems")+
	getarray(WEAPON_SHOP_CFGWEP_DIR(_selWeapon) >> "PointerSlot" >> "compatibleItems")+
	getarray(WEAPON_SHOP_CFGWEP_DIR(_selWeapon) >> "UnderBarrelSlot" >> "compatibleItems")
) apply {tolower _x};
private _ctrlType = ["CaptureTheFlag_UI_WeaponShop_SliderButton_Short","CaptureTheFlag_UI_WeaponShop_SliderButton_Long"] select _isWeapon;
private _defaultImg = [
	WEAPON_SHOP_PWEP_IMG,
	WEAPON_SHOP_SWEP_IMG,
	WEAPON_SHOP_HWEP_IMG,
	WEAPON_SHOP_OATT_IMG,
	WEAPON_SHOP_PATT_IMG,
	WEAPON_SHOP_MATT_IMG,
	WEAPON_SHOP_BATT_IMG
] select (["primary","launcher","pistol","optic","pointer","muzzle","bipod"] find _mode);
private _hasDLC = false;
private _reqRank = 0;

{
	if (_isWeapon OR {tolower(configname _x) in (_selWeaponAttachments+["remove_item"])}) then {
		_ctrl = _display ctrlCreate [_ctrlType,-1,_scollerContainer];
		_ctrl ctrlSetText ([configname _x,"picture",_defaultImg] call CaptureTheFlag_c_system_searchConfigFile);

		_hasDLC = [configname _x] call CaptureTheFlag_c_system_isItemDLCOwned;
		_reqRank = [
			getnumber(_x >> "rank"),
			(_display getVariable ["weaponRank",0])+getnumber(_x >> "rank")
		] select (_mode in ["optic","pointer","muzzle","bipod"]);

		if (CaptureTheFlag_statistic_rank>=_reqRank) then {
			if _hasDLC then {
				_ctrl ctrlSetTooltip ([configname _x,_isWeapon] call CaptureTheFlag_c_shop_weapon_itemStats);
				_ctrl ctrlAddEventHandler ["ButtonClick",{_this call CaptureTheFlag_c_shop_weapon_selectItem}];
			} else {
				_ctrl ctrlSetTooltip (format["Requires DLC: %1%2",getText(configFile >> "CfgMods" >> configSourceMod([configname _x] call CaptureTheFlag_c_system_searchConfigFile) >> "nameShort"),endl]+([configname _x,_isWeapon] call CaptureTheFlag_c_shop_weapon_itemStats));
				_ctrl ctrlSetTextColor [1,1,1,0.5];
			};
		} else {
			_ctrl ctrlSetTooltip (format["Requires Rank %1%2",_reqRank,endl]+([configname _x,_isWeapon] call CaptureTheFlag_c_shop_weapon_itemStats));
			_ctrl ctrlSetTextColor [1,1,1,0.5];
		};
		_ctrl setVariable ["class",configname _x];
		_ctrl ctrlsetposition ([_ex]+(ctrlPosition _ctrl select [1,3]));
		_ctrl ctrlcommit 0;
		_ex=_ex+(ctrlPosition _ctrl select 2)+0.005;
		_children pushback _ctrl;
	};
} foreach ("true" configClasses (WEAPON_SHOP_CONFIG_PATH >> _mode));
_scollerContainer setVariable ["children",_children];