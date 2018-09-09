/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\defines.sqf"

scriptName "CTF: Fetch Player Data";

params [
	["_sendTo",remoteExecutedOwner,[0]],
	["_uid","",[""]],
	["_name","",[""]],
	["_unit",objnull,[objnull]],
	["_netid","",[""]],
	["_side",sideUnknown,[sideUnknown]]
];

if ("" in [_uid,_name,_netid] OR _sendTo < 3) exitwith {};

// Get info from the db (we do this first incase the player needs to be inserted into the db)
private _playerData = if (call extDB3_var_loaded) then {
	["fetchPlayerData:"+_uid,2] call CaptureTheFlag_s_mysql_extDBCall;
} else {
	private _pdb = [];
	// Check savePlayerRestriction.sqf for reason for fetching this from UINS
	//_pdb append (GVAR(PDB_VAR_PLAYER_INFO(_uid),[]));
	_pdb append (GVAR(PDB_VAR_PLAYER_SETTINGS(_uid),[]));
	_pdb append (GVAR(PDB_VAR_PLAYER_STATISTICS(_uid),[]));
	_pdb append (GVAR(PDB_VAR_PLAYER_SKILLS(_uid),[]));
	if (count _pdb > 1) then {
		_pdb = [_name,[serverName]] + (uiNamespace getVariable [PDB_VAR_PLAYER_INFO(_uid),[""]]) + _pdb;
	};
	_pdb
};

if (count _playerData < 1) exitwith {_this call CaptureTheFlag_s_session_insertPlayerData};

// Make sure the unit exists
if ([_unit,_netid,_sendTo,_side,_uid] call CaptureTheFlag_s_checks_initUnit) exitwith {};

// Get info and delete it from the return
private _playerName = [_playerData deleteAt 0] param [0,"",[""]];
private _serverList = [_playerData deleteAt 0] param [0,[],[[]]];

// remove faction specific data from the array for the side the player is NOT on
_playerData deleteAt ([4,3] select ([west,east] find _side));

// Update name in the db
if (_name != _playerName) then {
	[["updatePlayerDataInfo",["name",_name,_uid]] call CaptureTheFlag_s_mysql_formatQuery,1] call CaptureTheFlag_s_mysql_extDBCall;
};

// If you have multiple servers connected to the same database, its nice to know who has been where
if ((_serverList pushBackUnique serverName)>-1) then {
	[["updatePlayerDataInfo",["servers_played_on",_serverList,_uid]] call CaptureTheFlag_s_mysql_formatQuery,1] call CaptureTheFlag_s_mysql_extDBCall;
};

_playerData remoteExec ["CaptureTheFlag_c_session_readData",_sendTo];