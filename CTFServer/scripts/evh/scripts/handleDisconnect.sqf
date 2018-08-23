/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params["_unit","_id","_uid","_name"];

["System",_name+" ("+_uid+") disconnected"] call CaptureTheFlag_c_system_log;

// If they were carrying the flag it needs to be dropped where they were
if ((OBJECTIVE_FLAG_POLE getVariable ["UnitStolen",objNull])==_unit) then {
	["System",_name+" was carrying flag, dropping now"] call CaptureTheFlag_c_system_log;
	["dropFlag",[_unit,OBJECTIVE_FLAG_POLE]] call CaptureTheFlag_c_map_modifyFlag;
};

// If they were in the middle of stealing the flag the status needs to be reset
if ((OBJECTIVE_FLAG_POLE getVariable ["UnitStealing",objNull])==_unit) then {
	["System",_name+" was stealing flag, resetting now"] call CaptureTheFlag_c_system_log;
	["InteruptSteal",[OBJECTIVE_FLAG_POLE]] call CaptureTheFlag_c_map_modifyFlag;
};

deleteVehicle _unit;

// Reset round if no players are connected
if (count (allPlayers-allDead) < 1) then {
	[] spawn CaptureTheFlag_s_round_noPlayersReset;
};

