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
private _class = _ctrl getVariable ["class",""];
private _type = (ctrlParent _ctrl) getVariable ["type",""];

private _index = CLOTHING_SHOP_LOADOUT_ORDER find _type;
if (_index > -1) then {
	private _curItem = CLOTHING_SHOP_CURRENT_LOADOUT param [_index,""];
	CaptureTheFlag_shop_clothing_selection set [_index,[_class,""] select (_class == _curItem)];
	[] call CaptureTheFlag_c_shop_clothing_populateBuyButtons;
	[] call CaptureTheFlag_c_shop_clothing_populateItemButtons;
};