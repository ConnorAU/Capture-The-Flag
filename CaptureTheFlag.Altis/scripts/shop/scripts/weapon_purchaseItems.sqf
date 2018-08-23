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

private _price = round(CaptureTheFlag_shop_weapon_price*([WEAPON_SHOP_BUY_MULTIPLIER,WEAPON_SHOP_SAVE_MULTIPLIER] select (_type == "save")));

if (_price>CaptureTheFlag_session_currency) exitwith {
	["Default",["You don't have the funds for this purchase"]] call CaptureTheFlag_c_ui_notifFeed_useTemplate;
};

if (
    _type == "save" && 
    {
    	!([
    		"Are you sure you want to replace your default loadout?",
    		"Set Default Weapon Loadout",
    		"Confirm",
    		"Cancel"
    	] call BIS_fnc_GUImessage)
    }
) exitwith {};

[-_price] call CaptureTheFlag_c_session_currency;

private ["_wepIndex","_buyIndex"];
private _weapons = (getUnitLoadout player select [0,3]) apply {(_x select [0,4])+[_x param [6,nil]]};

for "_i" from 0 to 2 do {
	_wepIndex = _weapons param [_i,[],[[]]];
	_buyIndex = CaptureTheFlag_shop_weapon_selection param [_i,[],[[]]];
	if ((_buyIndex param [0,""]) == "" && {(_wepIndex param [0,""]) != ""}) then {
		_buyIndex = [
			([_buyIndex,_wepIndex] select ((_buyIndex select 0) == "")) select 0,
			([_buyIndex,_wepIndex] select ((_buyIndex select 1) == "")) select 1,
			([_buyIndex,_wepIndex] select ((_buyIndex select 2) == "")) select 2,
			([_buyIndex,_wepIndex] select ((_buyIndex select 3) == "")) select 3,
			([_buyIndex,_wepIndex] select ((_buyIndex select 4) == "")) select 4
		];
	};

	_weapons set [_i,_buyIndex apply {[_x,""] select (_x == "remove_item")}];
};
if (_type == "save") then {
	{if (count _x >= 5) then {CaptureTheFlag_setting_weapons set [_forEachIndex,_x]}} foreach _weapons;
	CaptureTheFlag_setting_weapons = CaptureTheFlag_setting_weapons apply {if (isNil "_x") then {[]} else {_x}};
	true call CaptureTheFlag_c_session_writeData;
};
CaptureTheFlag_shop_weapon_selection = _weapons;
[nil,_weapons] call CaptureTheFlag_c_setup_setLoadout;

(ctrlParent _ctrl) closeDisplay 2;