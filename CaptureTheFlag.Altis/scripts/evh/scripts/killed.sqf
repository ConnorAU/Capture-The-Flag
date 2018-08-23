/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

params ["_victim","_killer","_shooter"];
_killer = [_shooter,_killer] select (isNull _shooter);
if (
    isNull _killer OR 
    {
    	!([_killer,"CAManBase"] call CaptureTheFlag_c_system_isKindOf) OR 
    	{
	    	!([_victim,["LandVehicle","Air","Ship"]] call CaptureTheFlag_c_system_isKindOf) OR 
	    	{
	    		(_victim getVariable ["side",sideUnknown]) isequalto SIDE_VAR(_killer) OR 
	    		{
	    			(_victim getVariable ["owner",""]) isequalto (getplayeruid _killer)
	    		}
	    	}
    	}
    }
) exitwith {};
if (!isServer && {_killer isEqualTo player}) then {
	["enemy_vehicles_destroyed"] call CaptureTheFlag_c_session_handleEvent;
} else {
	if (remoteExecutedOwner > 0) exitwith {}; // stop a loop if the remoteexec goes back to the server
	["enemy_vehicles_destroyed"] remoteexec ["CaptureTheFlag_c_session_handleEvent",_killer];
};