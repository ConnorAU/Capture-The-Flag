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
params ["_display"];
if (isNull _display) exitwith {};

[] call CaptureTheFlag_c_shop_weapon_calculatePrice;

private _purchaseButton = _display displayCtrl 30;
private _setAsLoadout = _display displayCtrl 31;


_purchaseButton ctrlEnable (({({_x != ""}count _x)>0} count CaptureTheFlag_shop_weapon_selection)>0);
_setAsLoadout ctrlEnable (({({_x != ""}count _x)>0} count CaptureTheFlag_shop_weapon_selection)>0);

_purchaseButton ctrlSetTextColor ([[1,1,1,1],[1,0,0,1]] select ((CaptureTheFlag_shop_weapon_price*WEAPON_SHOP_BUY_MULTIPLIER)>CaptureTheFlag_session_currency));
_purchaseButton ctrlSetText format["Purchase: $%1",(CaptureTheFlag_shop_weapon_price*WEAPON_SHOP_BUY_MULTIPLIER) call CaptureTheFlag_c_system_numberText];

_setAsLoadout ctrlSetTextColor ([[1,1,1,1],[1,0,0,1]] select ((CaptureTheFlag_shop_weapon_price*WEAPON_SHOP_SAVE_MULTIPLIER)>CaptureTheFlag_session_currency));
_setAsLoadout ctrlSetText format["Set as Default: $%1",(CaptureTheFlag_shop_weapon_price*WEAPON_SHOP_SAVE_MULTIPLIER) call CaptureTheFlag_c_system_numberText];