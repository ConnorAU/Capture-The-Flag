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
	["_statRef","",[""]],
	["_uid","",[""]],
	["_side",sideUnknown,[sideUnknown]]
];
if ("" in [_uid,_statRef]) exitwith {};

if extDB3_var_loaded then {
	[["updatePlayerDataStat",[_statRef,_uid]]call CaptureTheFlag_s_mysql_formatQuery,1] call CaptureTheFlag_s_mysql_extdbCall;
	//[_side,_uid] call CaptureTheFlag_s_session_savePlayerTime;
} else {
	// The rest of the stats dont matter cause you cant view them ingame
	if (_statRef == "rank") then {
		private _pdb = GVAR(PDB_VAR_PLAYER_STATISTICS(_uid),[]);
		_pdb set [0,(_pdb param [0,1,[0]]) + 1];
		SVAR(PDB_VAR_PLAYER_STATISTICS(_uid),_pdb);
	};
};

// Tell the client the sync has finished
missionNameSpace setVariable ["CaptureTheFlag_session_syncInProgress",false,remoteExecutedOwner];