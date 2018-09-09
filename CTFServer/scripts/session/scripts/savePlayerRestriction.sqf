/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\defines.sqf"

params [
	["_restriction","",[""]],
	["_uid","",[""]]
];
if ("" in [_restriction,_uid]) exitwith {};
 
if (call extDB3_var_loaded) then {
	[["updatePlayerDataInfo",["join_game_restriction",_restriction,_uid]]call CaptureTheFlag_s_mysql_formatQuery,1] call CaptureTheFlag_s_mysql_extdbCall;
} else {
	//SVAR(PDB_VAR_PLAYER_INFO(_uid),[_restriction]);
	// Doing it to last until hard restart because there is no way to remove it
	uiNamespace setVariable [PDB_VAR_PLAYER_INFO(_uid),[_restriction]]
};