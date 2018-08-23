/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

if !extDB3_var_loaded exitwith {};

params [
	["_side",sideUnknown,[sideUnknown]],
	["_uid","",[""]]
];
if (_side isEqualTo sideUnknown OR _uid == "" OR !extDB3_var_loaded) exitwith {};
[["updatePlayerDataTimePlayed",[["play_time_blufor","play_time_opfor"] select ([west,east] find _side),_uid]] call CaptureTheFlag_s_mysql_formatQuery,1] call CaptureTheFlag_s_mysql_extdbCall;