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
params ["_type","_ctrl"];

private _price = round(CaptureTheFlag_shop_clothing_price*([CLOTHING_SHOP_BUY_MULTIPLIER,CLOTHING_SHOP_SAVE_MULTIPLIER] select (_type == "save")));

if (_price>CaptureTheFlag_session_currency) exitwith {
	["Default",["You don't have the funds for this purchase"]] call CaptureTheFlag_c_ui_notifFeed_useTemplate;
};

if (
    _type == "save" && 
    {
    	!([
    		"Are you sure you want to replace your default loadout?",
    		"Set Default Clothing Loadout",
    		"Confirm",
    		"Cancel"
    	] call BIS_fnc_GUImessage)
    }
) exitwith {};

[-_price] call CaptureTheFlag_c_session_currency;

private _clothing = CLOTHING_SHOP_CURRENT_LOADOUT;
{
	if (_x != "") then {
		_clothing set[_forEachIndex,_x];
	};
} foreach CaptureTheFlag_shop_clothing_selection;
if (_type == "save") then {
	CaptureTheFlag_setting_clothing = +_clothing;
	true call CaptureTheFlag_c_session_writeData;
};

[_clothing] call CaptureTheFlag_c_setup_setLoadout;

(ctrlParent _ctrl) closeDisplay 2;