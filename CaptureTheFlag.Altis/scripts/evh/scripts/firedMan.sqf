/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

params["_unit","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile","_vehicle"];

// Looking at this it could be just a single check... but I'm sure there was a reason it isnt

// No shooting in spawn
if ([_unit,["BLUFOR_ZONE","OPFOR_ZONE"] select SIDE_INDEX] call CaptureTheFlag_c_system_inArea) then {
    deleteVehicle _projectile;
    /*if (_weapon in ["Put","Throw"]) then {
    	//[] call CaptureTheFlag_c_setup_setLoadout;
		["Default",[["You cannot place explosives in the safezone","You cannot throw grenades in the safezone"] select (["Put","Throw"] find _weapon)]] call CaptureTheFlag_c_ui_notifFeed_useTemplate;
    };*/
};

// No shooting in the enemy spawn
if ([_unit,["OPFOR_ZONE","BLUFOR_ZONE"] select SIDE_INDEX] call CaptureTheFlag_c_system_inArea) then {
	deleteVehicle _projectile;
};