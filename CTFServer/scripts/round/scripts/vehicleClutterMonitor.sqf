/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

if ((missionNamespace getVariable ["CaptureTheFlag_round_vehicleClutterMonitor_tick",0])>diag_tickTime) exitwith {};
CaptureTheFlag_round_vehicleClutterMonitor_tick = diag_tickTime + 60;

// This is hard to look at but read it one line at a time and it'l start to make sense
private _vList = vehicles select {
	alive _x && 
	{
		[_x,["LandVehicle","Air"]] call CaptureTheFlag_c_system_isKindOf && 
		{
			isNil {_x getVariable "clutterProtected"} && 
			{
				count crew _x < 1 && 
				{
					locked _x in [2,3] && 
					{
						(
						 	count((nearestObjects[_x,["CAManBase"],50])select{isPlayer _x})<1 && 
							{
								!([_x,"CTF_AO_MARKER"] call CaptureTheFlag_c_system_inArea) OR 
								{
									isNull([_x getVariable ["owner",""]]call CaptureTheFlag_c_system_getUnitFromPID)
								}
							}
						) OR 
						{
							[_x,["BLUFOR_ZONE","OPFOR_ZONE"] param [[west,east] find (_x getVariable ["side",sideUnknown]),""]] call CaptureTheFlag_c_system_inArea && 
							{
								(
								 	count((nearestObjects[_x,["CAManBase"],15])select{isPlayer _x})<1 OR 
								 	{
										(
										 	isNull([_x getVariable ["owner",""]]call CaptureTheFlag_c_system_getUnitFromPID) OR
										 	{
										 		!([
													[_x getVariable ["owner",""]]call CaptureTheFlag_c_system_getUnitFromPID,
													["BLUFOR_ZONE","OPFOR_ZONE"] param [[west,east] find (_x getVariable ["side",sideUnknown]),""]
												] call CaptureTheFlag_c_system_inArea)
										 	}
										)
								 	}
								) && 
								{
									time-(_x getVariable ["lastUsed",time])>600
								}
							}
						}
					}
				}
			}
		}
	}
};
if (count _vList > 0) then {
	["Vehicle Clutter Monitor",format["Removing %1 vehicle%2",count _vList,["","s"] select (count _vList>1)]] call CaptureTheFlag_c_system_log;
};
{deleteVehicle _x;} foreach _vList;