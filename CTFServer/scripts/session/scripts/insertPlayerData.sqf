/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\defines.sqf"
scriptName "CTF: Insert Player Data";

params [
	["_sendTo",remoteExecutedOwner,[0]],
	["_uid","",[""]],
	["_name","",[""]]
];

// params check and make sure we arent already inserting for this uid
if ("" in [_uid,_name] OR _sendTo < 3 OR (missionNamespace getVariable ["CaptureTheFlag_session_insertingID_"+_uid,false])) exitwith {};
missionNamespace setVariable ["CaptureTheFlag_session_insertingID_"+_uid,true];


if extDB3_var_loaded then {
	// Expect returns to ensure the data is there before we request it again
	[["insertPlayerData1:",[
		_uid,
		_name,
		[],
		""
	]]call CaptureTheFlag_s_mysql_formatQuery,2] call CaptureTheFlag_s_mysql_extDBCall;
	[["insertPlayerData2:",[
		_uid,
		DEFAULT_MONEY,
		DEFAULT_EXP,
		DEFAULT_ARRAY,
		DEFAULT_ENABLEENVIRONMENT,
		DEFAULT_SHOWPLAYERTAGS,
		DEFAULT_SHOWHITMARKERS,
		DEFAULT_TERRAINSMOOTHINGMODE,
		DEFAULT_FOOTVIEWDISTANCE,
		DEFAULT_LANDVIEWDISTANCE,
		DEFAULT_AIRVIEWDISTANCE
	]]call CaptureTheFlag_s_mysql_formatQuery,2] call CaptureTheFlag_s_mysql_extDBCall;
	[["insertPlayerData3:",[
		_uid,
		DEFAULT_STATISTIC,
		1
	]]call CaptureTheFlag_s_mysql_formatQuery,2] call CaptureTheFlag_s_mysql_extDBCall;
	[["insertPlayerData4:",[
		_uid,
		DEFAULT_STATISTIC
	]]call CaptureTheFlag_s_mysql_formatQuery,2] call CaptureTheFlag_s_mysql_extDBCall;
} else {
	// Local profile save because extdb init failed
	private _info = [
		"" 	// restriction
	];
	private _settings = [
		DEFAULT_MONEY,
		DEFAULT_EXP,
		DEFAULT_ARRAY,	// west clothing
		DEFAULT_ARRAY,	// east clothing
		DEFAULT_ARRAY,	// vehicles
		DEFAULT_ARRAY,	// weapons
		DEFAULT_ARRAY,	// skills
		DEFAULT_ENABLEENVIRONMENT,
		DEFAULT_SHOWPLAYERTAGS,
		DEFAULT_SHOWHITMARKERS,
		DEFAULT_TERRAINSMOOTHINGMODE,
		DEFAULT_FOOTVIEWDISTANCE,
		DEFAULT_LANDVIEWDISTANCE,
		DEFAULT_AIRVIEWDISTANCE
	];
	private _statistics = [
		1 // rank
	];
	private _skills = [
		DEFAULT_STATISTIC,	// steadyAim
		DEFAULT_STATISTIC,	// athlete
		DEFAULT_STATISTIC,	// ammo
		DEFAULT_STATISTIC,	// mechanic
		DEFAULT_STATISTIC,	// lifeSaver
		DEFAULT_STATISTIC,	// packingHeat
		DEFAULT_STATISTIC,	// flakJacket
		DEFAULT_STATISTIC	// conqueror
	];
	SVAR(PDB_VAR_PLAYER_INFO(_uid),_info);
	SVAR(PDB_VAR_PLAYER_SETTINGS(_uid),_settings);
	SVAR(PDB_VAR_PLAYER_STATISTICS(_uid),_statistics);
	SVAR(PDB_VAR_PLAYER_SKILLS(_uid),_skills);
};

missionNamespace setVariable ["CaptureTheFlag_session_insertingID_"+_uid,nil];
_this call CaptureTheFlag_s_session_fetchPlayerData;