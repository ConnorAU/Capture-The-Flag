/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

params [["_mode","",[""]]];
switch _mode do {
	case "perform_p":{
		player setDamage 0;
		[] call CaptureTheFlag_c_setup_setLoadout;
		CaptureTheFlag_system_rearmAndRepair_p_tick = diag_tickTime + (2*60);
	};
	case "perform_v":{
		vehicle player setDamage 0;
		vehicle player setVehicleAmmo 1;
		vehicle player setFuel 1;
		CaptureTheFlag_system_rearmAndRepair_v_tick = diag_tickTime + (2*60);
	};
	case "condition_p":{
		diag_ticktime>(missionNameSpace getVariable ["CaptureTheFlag_system_rearmAndRepair_p_tick",0])
	};
	case "condition_v":{
		diag_ticktime>(missionNameSpace getVariable ["CaptureTheFlag_system_rearmAndRepair_v_tick",0]) && 
		{
			vehicle player != player && 
			{
				local (vehicle player) && 
				{
					(driver(vehicle player)) isequalto player && 
					{
						([vehicle player,["BLUFOR_ZONE_VEH_RAR","OPFOR_ZONE_VEH_RAR"] select SIDE_INDEX] call CaptureTheFlag_c_system_inArea) && 
						{
							speed (vehicle player) < 1
						}
					}
				}
			}
		}
	};
	default {false};
};