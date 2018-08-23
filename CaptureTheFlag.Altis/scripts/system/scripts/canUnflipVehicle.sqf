/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

private _v = cursorObject;
alive _v && 
{
	([_v,["LandVehicle","Air"]] call CaptureTheFlag_c_system_isKindOf) && 
	{
		(vectorUp _v param [2,1])<0.2 && 
		{
			player distance _v < ([_v,"d"] call CaptureTheFlag_c_system_getVehicleRepairValue)
		}
	}
}