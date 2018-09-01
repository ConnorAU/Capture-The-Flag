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

params [["_cfgToken","",[""]],["_class","",[""]]];

private _display = uiNamespace getVariable ["CaptureTheFlag_UI_VehicleShop",displayNull];
if (isNull _display) exitwith {};
_display setVariable ["token",_cfgToken];

private _selectedImage = _display displayCtrl 20;
private _selectedDetails = _display displayCtrl 21;
private _selectedSkinSide = _display displayCtrl 22;
private _selectedSkinCamo = _display displayCtrl 23;
private _selectedPurchase = _display displayCtrl 24;

private _name = getText(configFile >> "CfgVehicles" >> _class >> "displayName");
private _price = getNumber(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> "price");

private _v = _class createvehiclelocal [0,0,random 5000 max 100];
private _weapons = (weapons _v apply {getText(configFile >> "CfgWeapons" >> _x >> "displayName")}) joinstring ", ";
private _seatsList = fullCrew [_v,"",true] apply {tolower (_x select 1)};
private _hasDLC = [_class] call CaptureTheFlag_c_system_isItemDLCOwned;
deletevehicle _v;
private _seats = [];
if ({_x in ["driver"]}count _seatsList > 0) then {
	_seats pushback format["%1 Driver",{_x == "driver"}count _seatsList];
};
if ({_x in ["commander"]}count _seatsList > 0) then {
	_seats pushback format["%1 Commander",{_x == "commander"}count _seatsList];
};
if ({_x in ["cargo"]}count _seatsList > 0) then {
	_seats pushback format["%1 Passenger",{_x == "cargo"}count _seatsList];
};
if ({_x in ["turret","gunner"]}count _seatsList > 0) then {
	_seats pushback format["%1 Gunner",{_x in ["turret","gunner"]}count _seatsList];
};
_seats = _seats joinString ", ";


_selectedImage ctrlSetText getText(configFile >> "CfgVehicles" >> _class >> "editorPreview");

_selectedDetails ctrlSetStructuredText parsetext ([
		"Name: "+_name,
		"Price: <t color='#"+(["FFB1A8","CCFFCC"] select (CaptureTheFlag_session_currency >= _price))+"'>$"+(_price call CaptureTheFlag_c_system_numberText)+"</t>",
		"Seats: "+_seats,
		if (_weapons in ["","Horn"]) then {""} else {"Weapons: "+_weapons}
] joinString "<br/>");

_selectedSkinSide ctrlSetText (
    if (isText(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> str SIDE_VAR(player) >> "colorName")) then {
    	gettext(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> str SIDE_VAR(player) >> "colorName")+" Skin"
    } else {
    	["Blue Skin","Red Skin"] select SIDE_INDEX
    }
);
_selectedSkinCamo ctrlSetText (
    if (isText(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> str SIDE_VAR(player) >> "camoName")) then {
    	gettext(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> str SIDE_VAR(player) >> "camoName")+" Skin"
    } else {"Camo Skin"});

if (CaptureTheFlag_statistic_rank >= getNumber(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> "rank")) then {
	_selectedSkinSide ctrlEnable (isArray(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> str SIDE_VAR(player) >> "colorLayers"));
	_selectedSkinCamo ctrlEnable (isArray(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> str SIDE_VAR(player) >> "camoLayers"));
	if _hasDLC then {
		_selectedPurchase ctrlSetText "Purchase Vehicle";
		_selectedPurchase ctrlEnable true;
	} else {
		private _dlcName = getText(configFile >> "CfgMods" >> configSourceMod(configFile >> "CfgVehicles" >> _class) >> "nameShort");
		_selectedPurchase ctrlSetText ("DLC: "+_dlcName);
		_selectedPurchase ctrlEnable false;
	};
	([["camo",_selectedSkinCamo],["color",_selectedSkinSide]] select (ctrlEnabled _selectedSkinSide)) call CaptureTheFlag_c_shop_vehicle_skinSelected;
} else {
	_selectedSkinSide ctrlenable false;
	_selectedSkinCamo ctrlenable false;
	_selectedPurchase ctrlEnable false;
	_selectedPurchase ctrlSetText format["Required Rank: %1",getNumber(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> "rank")];
};
