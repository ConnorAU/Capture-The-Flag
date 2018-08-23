/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

disableSerialization;
private _display = uiNamespace getVariable ["CaptureTheFlag_UI_ClothingShop",displayNull];
if (isNull _display) exitwith {};

params [["_item","",[""]]];
(_display getVariable ["itemStats",[]]) params ["_statsEquipmentMin","_statsEquipmentMax"];

private _itemStats = ([
	[[configFile >> "CfgWeapons" >> _item,configFile >> "CfgGoggles" >> _item] select (isClass(configFile >> "CfgGoggles" >> _item))],
	["passthrough","armor","maximumLoad","mass"],
	[false,false,false,false],
	_statsEquipmentMin
] call bis_fnc_configExtremes) param [1,[],[[]]];


private _statArmorShot = linearConversion [_statsEquipmentMin select 0,_statsEquipmentMax select 0,_itemStats select 0,0,1];
private _statArmorExpl = linearConversion [_statsEquipmentMin select 1,_statsEquipmentMax select 1,_itemStats select 1,0,1];

[
	[_item,"displayName",_item] call CaptureTheFlag_c_system_searchConfigFile,
	"Ballistic Protection: "+(round(_statArmorShot*100) call CaptureTheFlag_c_system_numberText)+"%",
	"Explosive Resistance: "+(round(_statArmorExpl*100) call CaptureTheFlag_c_system_numberText)+"%",
	"Load: "+(round(_itemStats select 2) call CaptureTheFlag_c_system_numberText)+" units",
	"Weight: "+(round(_itemStats select 3) call CaptureTheFlag_c_system_numberText)+" units"
] joinstring endl