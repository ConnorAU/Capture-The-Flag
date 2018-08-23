/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"
private _o = cursorobject;
(
	SKILL_ACTIVE("mechanic") && 
	{
		vehicle player isequalto player && 
		{
			alive _o && 
			{
				([_o,["LandVehicle","Air"]] call CaptureTheFlag_c_system_isKindOf) && 
				{
					player distance _o < ([nil,"d"] call CaptureTheFlag_c_system_getVehicleRepairValue) && 
					{
						([_o] call CaptureTheFlag_c_system_getVehicleDamage) > 0 OR fuel _o < 0.01
					}
				}
			}
		}
	}
)