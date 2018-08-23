/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"
params ["_unit","_container"];

// For making it inconvenient to have one super rich guy kit up the whole team
if ([_unit,[BLUFOR_SAFE_ZONE,OPFOR_SAFE_ZONE] select SIDE_INDEX_GLOBAL(_unit)] call CaptureTheFlag_c_system_inArea) exitwith {
	["Default",["You cannot open your inventory inside the safezone"]] call CaptureTheFlag_c_ui_notifFeed_useTemplate;
	true
};
if ([_container,["LandVehicle","Air"]] call CaptureTheFlag_c_system_isKindOf) exitwith {
	["Default",["You cannot use the vehicle inventory"]] call CaptureTheFlag_c_ui_notifFeed_useTemplate;
	true
};