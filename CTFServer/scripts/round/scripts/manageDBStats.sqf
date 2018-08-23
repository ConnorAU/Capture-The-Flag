/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */


params [["_mode","",[""]],["_param",[]]];
if !extDB3_var_loaded exitwith {}; // We don't save round stats to the server profile
if (isNil "CaptureTheFlag_round_reservedStatsID" && {_mode != "init"}) exitwith {};
switch _mode do {
	case "init":{
		// Create round in the DB
		CaptureTheFlag_round_reservedStatsID = ([
			[
				"insertRoundStats",
				[serverName,_param]
			] call CaptureTheFlag_s_mysql_formatQuery,
			2
		] call CaptureTheFlag_s_mysql_extdbCall) param [0,-1,[""]];
	};
	case "update":{
		// Update round in the DB (can be used to display live stats on a website or discord for example)
		[
			[
				"updateRoundStats",
				[
					CaptureTheFlag_info_blufor_flag_captures,
					CaptureTheFlag_info_opfor_flag_captures,
					CaptureTheFlag_round_reservedStatsID
				]
			] call CaptureTheFlag_s_mysql_formatQuery,
			1
		] call CaptureTheFlag_s_mysql_extdbCall;
	};
	case "end":{
		// Mark the end of the round in the DB
		[
			[
				"endRoundStats",
				[CaptureTheFlag_round_reservedStatsID]
			] call CaptureTheFlag_s_mysql_formatQuery,
			1
		] call CaptureTheFlag_s_mysql_extdbCall;
	};
	default {};
};