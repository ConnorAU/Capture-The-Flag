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
	["_statVal","",[0]],
	["_uid","",[""]]
];
if ("" in [_uid,_statVal,_statRef]) exitwith {};
 
if extDB3_var_loaded then {
	[["updatePlayerDataSkill",[_statRef,_statVal,_uid]]call CaptureTheFlag_s_mysql_formatQuery,1] call CaptureTheFlag_s_mysql_extdbCall;
} else {
	private _pdb = GVAR(PDB_VAR_PLAYER_SKILLS(_uid),[]);
	private _index = [
		"steadyaim",
		"athlete",
		"ammo",
		"mechanic",
		"lifesaver",
		"packingheat",
		"flakjacket",
		"conqueror"
	] find (tolower _statRef);
	_pdb set [_index,_statVal];
	SVAR(PDB_VAR_PLAYER_SKILLS(_uid),_pdb);
};

// Tell the client the sync has finished
missionNameSpace setVariable ["CaptureTheFlag_session_syncInProgress",false,remoteExecutedOwner];