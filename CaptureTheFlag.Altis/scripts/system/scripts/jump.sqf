/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [["_unit",player,[objNull]]];
if (
    vehicle _unit != _unit OR 
    {
	    speed _unit < 10 OR 
    	{
			currentWeapon _unit == "" OR 
			{
				currentWeapon _unit != primaryWeapon _unit
			}
    	}
    }
) exitwith {};
if (isNil "CaptureTheFlag_system_jumpTick") then {CaptureTheFlag_system_jumpTick = 0};
if (CaptureTheFlag_system_jumpTick > diag_tickTime) exitwith {};
CaptureTheFlag_system_jumpTick = diag_tickTime + 1;
[_unit,"AovrPercMrunSrasWrflDf"] remoteExec ["switchMove",0];
