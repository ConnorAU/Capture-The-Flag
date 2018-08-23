/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

params [["_mode","",[""]],["_params",[]]];
switch _mode do {
	case "flag_captures_c";
	case "flag_captures_e";
	case "flag_steals_c";
	case "flag_steals_e";
	case "flag_pickups_c";
	case "flag_pickups_e";
	case "flag_team_capture_bonus_c";
	case "flag_team_capture_bonus_e";
	case "flag_returns_c";
	case "flag_returns_e":{
		// Rewards change depending on the number of players online
		({side _x isEqualTo ([east,west] select SIDE_INDEX)}count allPlayers)/((MAX_PLAYERS/3)/2)
	};
	case "heal_player_c";
	case "heal_player_e":{
		_params
	};
	case "repaired_vehicle_c";
	case "repaired_vehicle_e":{
		[
			(_params getVariable ["owner",""]) != CaptureTheFlag_info_playerUID && 
			{
				isNil{_params getVariable "repaired"}
			}
		] call CaptureTheFlag_c_system_toBool
	};
	case "player_delivered_to_ao_ground_c";
	case "player_delivered_to_ao_ground_e";
	case "player_delivered_to_ao_air_c";
	case "player_delivered_to_ao_air_e":{
		// can't transport the same unit object twice
		[!(_params in CaptureTheFlag_session_unitsDeliveredToAO)] call CaptureTheFlag_c_system_toBool
	};
	case "round_victory_c";
	case "round_victory_e":{
		// Win bonus based on max enemys online that game AND if you were on for longer than 5 mins before the round ended
		(1 min ((time-CaptureTheFlag_session_joinTick)/300) max 0)*(([CaptureTheFlag_info_playerCountEastMax,CaptureTheFlag_info_playerCountWestMax] select SIDE_INDEX)/(MAX_PLAYERS/2))
	};
	case "refund_vehicles_c":{
		// End game refunds
		private _out = 0;
		{_out = _out + (_x getVariable ["price",0])}foreach (vehicles select {
			alive _x && 
			{
				([_x,["LandVehicle","Air"]] call CaptureTheFlag_c_system_isKindOf) && 
				{
					(_x getVariable ["owner",""]) == CaptureTheFlag_info_playerUID && 
					{
						(_x getVariable ["side",sideUnknown]) isEqualTo SIDE_VAR(player)
					}
				}
			}
		});
		round _out
	};
	default {0};
};