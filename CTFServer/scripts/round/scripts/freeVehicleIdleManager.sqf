/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [["_mode",-1,[0]],["_params",[]]];

switch _mode do {
	case 0:{
		if (isNil "CaptureTheFlag_round_freeVehicles") then {CaptureTheFlag_round_freeVehicles=[]};
		// Add new vehicle to free vehicles list
		CaptureTheFlag_round_freeVehicles = (CaptureTheFlag_round_freeVehicles - [objNull]) + [_params];
	};
	case 1:{
		// Get in event?
		_params setVariable ["CaptureTheFlag_round_freeVehicle_removeAtTick",nil];
	};
	case 2:{
		// Get out event
		if (count crew _params < 1 && {!([_params,["BLUFOR_ZONE","OPFOR_ZONE"]] call CaptureTheFlag_c_system_inArea)}) then {
			_params setVariable ["CaptureTheFlag_round_freeVehicle_removeAtTick",diag_ticktime+(8*60)];
		};
	};
	case 3:{
		if (isNil "CaptureTheFlag_round_freeVehicles") exitwith {};
		// Destroy abandoned free vehicles
		{_x setDamage [1,false]} foreach (CaptureTheFlag_round_freeVehicles select {
			!isNull _x && 
			{
				alive _x && 
				{
					!isNil {_x getVariable "CaptureTheFlag_round_freeVehicle_removeAtTick"} && 
					{
						diag_ticktime>(_x getVariable "CaptureTheFlag_round_freeVehicle_removeAtTick") && 
						{
							count(nearestObjects[_x,["CAManBase"],50])<1
						}
					}
				}
			}
		});
	};
	default {};
};