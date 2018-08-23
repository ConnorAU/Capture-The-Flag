/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

if (vehicle player != player) exitwith {false};
private _v = cursorobject;
(
 	player distance _v < (([_v,"d"] call CaptureTheFlag_c_system_getVehicleRepairValue)*1.5) && 
	{
		(locked _v) in _this && 
		{
			(_v getvariable ["owner",""]) isequalto CaptureTheFlag_info_playerUID && 
			{
				(_v getVariable ["side",sideUnknown]) isequalto SIDE_VAR(player)
			}
		}
	}
)