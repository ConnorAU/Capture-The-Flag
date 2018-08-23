/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

params ["","","_vehicle"];
player setVariable ["vehicle",_vehicle,true];
if (!isNull CaptureTheFlag_info_unitCarryingFlag) then {
	// Show flag on vehicle if you're carrying it
	_vehicle forceFlagTexture (CaptureTheFlag_info_unitCarryingFlag getVariable ["FlagTexture",""]);
};
if (_vehicle isKindOf "air" && {[player,[BLUFOR_SAFE_ZONE,OPFOR_SAFE_ZONE] select SIDE_INDEX] call CaptureTheFlag_c_system_inArea}) then {
	// Used for air drop xp to the pilot
	CaptureTheFlag_evh_inHeliFromBase = true;
};
[] call CaptureTheFlag_c_settings_applyViewDistance;

// Hides new vehicle HUD icon
CaptureTheFlag_ui_lastPurchasedVehicle = objNull;