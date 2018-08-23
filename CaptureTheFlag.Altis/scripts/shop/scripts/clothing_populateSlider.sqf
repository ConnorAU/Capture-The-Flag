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

disableSerialization;
private _display = uiNamespace getVariable ["CaptureTheFlag_UI_ClothingShop",displayNull];
if (isNull _display) exitwith {};

private _scollerContainer = _display displayCtrl 10;

{ctrlDelete _x} foreach (_scollerContainer getVariable ["children",[]]);

private _type = param[0,"uniform",[""]];
private _children = [];
private _list = ("true"configclasses(CLOTHING_SHOP_CONFIG_PATH >> _type >> str SIDE_VAR(player)));
private _ctrl = controlNull;
private _ex = 0;
private _hasDLC = false;

{
	_ctrl = _display ctrlCreate ["CaptureTheFlag_UI_ClothingShop_SliderButton",-1,_scollerContainer];
	_ctrl ctrlSetText ([configname _x,"picture",""] call CaptureTheFlag_c_system_searchConfigFile);

	_hasDLC = [configname _x] call CaptureTheFlag_c_system_isItemDLCOwned;

	if _hasDLC then {
		_selectedPurchase ctrlSetText "Purchase Vehicle";
		_selectedPurchase ctrlEnable true;
	} else {
		private _dlcName = configSourceMod (configFile >> "CfgVehicles" >> _class);
		_dlcName = _dlcName splitString "";
		_dlcName set [0,toUpper (_dlcName select 0)];
		_dlcName = _dlcName joinString "";
		_selectedPurchase ctrlSetText ("DLC: "+_dlcName);
		_selectedPurchase ctrlEnable false;
	};

	if (CaptureTheFlag_statistic_rank>=getnumber(_x >> "rank")) then {
		if _hasDLC then {
			_ctrl ctrlSetTooltip ([configname _x] call CaptureTheFlag_c_shop_clothing_itemStats);
			_ctrl ctrlAddEventHandler ["ButtonClick",{_this call CaptureTheFlag_c_shop_clothing_selectItem}];
		} else {
			_ctrl ctrlSetTooltip (format["Requires DLC: %1%2",getText(configFile >> "CfgMods" >> configSourceMod([configname _x] call CaptureTheFlag_c_system_searchConfigFile) >> "nameShort"),endl]+([configname _x] call CaptureTheFlag_c_shop_clothing_itemStats));
			_ctrl ctrlSetTextColor [1,1,1,0.5];
		};
	} else {
		_ctrl ctrlSetTooltip (format["Requires Rank %1%2",getnumber(_x >> "rank"),endl]+([configname _x] call CaptureTheFlag_c_shop_clothing_itemStats));
		_ctrl ctrlSetTextColor [1,1,1,0.5];
	};
	_ctrl setVariable ["class",configname _x];
	_ctrl ctrlsetposition ([_ex]+(ctrlPosition _ctrl select [1,3]));
	_ctrl ctrlcommit 0;
	_ex=_ex+(ctrlPosition _ctrl select 2)+0.005;
	_children pushback _ctrl;
} foreach _list;

_scollerContainer setVariable ["children",_children];
_display setVariable ["type",_type];