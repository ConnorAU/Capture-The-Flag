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
private _display = uiNamespace getVariable ["CaptureTheFlag_UI_ClothingShop",displayNull];
if (isNull _display) exitwith {};

private _selectedUniform = _display displayCtrl 20;
private _selectedVest = _display displayCtrl 21;
private _selectedHat = _display displayCtrl 22;
private _selectedEyes = _display displayCtrl 23;

private _curLoadout = CLOTHING_SHOP_CURRENT_LOADOUT;
private _selLoadout = +CaptureTheFlag_shop_clothing_selection;

private ["_selIndex","_item","_image"];
{
	_selIndex = _selLoadout param [_forEachIndex,"",[""]];
	_item = [_selIndex,_curLoadout param [_forEachIndex,"",[""]]] select (_selIndex == "");
	_image = [_item,"picture",""] call CaptureTheFlag_c_system_searchConfigFile;
	_x ctrlSetText ([_image,
		[
			"\a3\ui_f\data\gui\rsc\rscdisplayarsenal\uniform_ca.paa",
			"\a3\ui_f\data\gui\rsc\rscdisplayarsenal\vest_ca.paa",
			"\a3\ui_f\data\gui\rsc\rscdisplayarsenal\headgear_ca.paa",
			"\a3\ui_f\data\gui\rsc\rscdisplayarsenal\goggles_ca.paa"
		] param [_forEachIndex,""]
	] select (_image == ""));
	_x ctrlSetTooltip ([_item] call CaptureTheFlag_c_shop_clothing_itemStats);
} foreach [_selectedUniform,_selectedVest,_selectedHat,_selectedEyes];