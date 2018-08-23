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

[] call CaptureTheFlag_c_shop_clothing_calculatePrice;

private _purchaseButton = _display displayCtrl 30;
private _setAsLoadout = _display displayCtrl 31;

_purchaseButton ctrlEnable ({_x != ""} count CaptureTheFlag_shop_clothing_selection > 0);
_setAsLoadout ctrlEnable ({_x != ""} count CaptureTheFlag_shop_clothing_selection > 0);

_purchaseButton ctrlSetTextColor ([[1,1,1,1],[1,0,0,1]] select ((CaptureTheFlag_shop_clothing_price*CLOTHING_SHOP_BUY_MULTIPLIER)>CaptureTheFlag_session_currency));
_purchaseButton ctrlSetText format["Purchase: $%1",(CaptureTheFlag_shop_clothing_price*CLOTHING_SHOP_BUY_MULTIPLIER) call CaptureTheFlag_c_system_numberText];

_setAsLoadout ctrlSetTextColor ([[1,1,1,1],[1,0,0,1]] select ((CaptureTheFlag_shop_clothing_price*CLOTHING_SHOP_SAVE_MULTIPLIER)>CaptureTheFlag_session_currency));
_setAsLoadout ctrlSetText format["Set as Default: $%1",(CaptureTheFlag_shop_clothing_price*CLOTHING_SHOP_SAVE_MULTIPLIER) call CaptureTheFlag_c_system_numberText];