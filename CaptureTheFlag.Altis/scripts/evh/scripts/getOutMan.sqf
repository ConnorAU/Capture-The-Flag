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
if CaptureTheFlag_info_spawned then {
	player setVariable ["vehicle",nil,true];
};
if (!isNull CaptureTheFlag_info_unitCarryingFlag) then {
	// Remove flag texture from vehicle if carrying the flag
	_vehicle forceFlagTexture "";
};
if (count crew _vehicle < 1) then {
	// for the cleanup
	_vehicle setVariable ["lastUsed",time,2];
};
if !(isNil "CaptureTheFlag_evh_inHeliFromBase") then {
	CaptureTheFlag_evh_inHeliFromBase = nil;
	if (
	    _vehicle isKindOf "Air" && 
	    {
	    	!([player,[BLUFOR_SAFE_ZONE,OPFOR_SAFE_ZONE] select SIDE_INDEX] call CaptureTheFlag_c_system_inArea) && 
	    	{
	    		[player,AO_MARKER] call CaptureTheFlag_c_system_inArea && 
	    		{
				    alive player && 
				    {
				    	!NEEDS_REVIVE(player) && 
				    	{
				    		!isNull driver _vehicle
				    	}
				    }
	    		}
	    	}
	    }
	) then {
		// GG Pilot
		[
			["player_delivered_to_ao_air","player_delivered_to_ao_ground"] select ((getposatl player param [2,0]) < 5),
			player
		] remoteExecCall ["CaptureTheFlag_c_session_handleEvent",driver _vehicle];
	};
};
[] call CaptureTheFlag_c_settings_applyViewDistance;
[] spawn CaptureTheFlag_c_system_magicParachute;