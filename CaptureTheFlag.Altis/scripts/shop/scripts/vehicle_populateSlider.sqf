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
params ["_type"];
if (_type == "") exitwith {};

private _display = uiNamespace getVariable ["CaptureTheFlag_UI_VehicleShop",displayNull];
if (isNull _display) exitwith {};
private _scollerContainer = _display displayCtrl 15;

{ctrlDelete _x}foreach (_scollerContainer getVariable ["children",[]]);

private _list = if (_type == "Recent") then {
	(CaptureTheFlag_setting_vehicles apply {VEHICLE_SHOP_CONFIG_PATH >> _x}) - [configNull]
} else {
	("true"configClasses(VEHICLE_SHOP_CONFIG_PATH))
};

private ["_rank","_image","_class","_button"];
private _children = [];
private _ex = 0;
private _fired = false;
{
	if (isClass(_x >> str SIDE_VAR(player))) then {
		_class = getText(_x >> str SIDE_VAR(player) >> "classname");
		if (_type == "Recent" OR {_type != "Recent" && ([_class,_type] call CaptureTheFlag_c_system_isKindOf)}) then {
			_rank = getNumber(_x >> "rank");
			_image = getText(configFile >> "CfgVehicles" >> _class >> "picture");

			_button = _display ctrlCreate ["CaptureTheFlag_UI_VehicleShop_SliderButton",-1,_scollerContainer];

			_button ctrlSetText _image;
			_button ctrlSetTextColor ([[1,1,1,0.25],[1,1,1,1]] select (CaptureTheFlag_statistic_rank>=_rank));
			_button ctrlAddEventHandler ["ButtonClick",format["%1 call CaptureTheFlag_c_shop_vehicle_populateDetails",[configname _x,_class]]];
			_button ctrlSetPosition ([_ex]+(ctrlposition _button select [1,3]));
			_button ctrlcommit 0;
			_children pushback _button;
			_ex=_ex+(ctrlPosition _button select 2)+0.005;

			if !_fired then {
				_fired = true;
				[configname _x,_class] call CaptureTheFlag_c_shop_vehicle_populateDetails
			};
		};
	};
} foreach _list;
_scollerContainer setVariable ["children",_children];