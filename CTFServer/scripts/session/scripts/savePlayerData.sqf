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
	["_type",0,[true]],
	["_packet",0,[[]]],
	["_side",0,[sideUnknown]]
];
if (0 in [_type,_packet,_side]) exitwith {};
 
if extDB3_var_loaded then {
	// Select correct query and sync
	[[["updatePlayerDataSettCore","updatePlayerDataSettOpti" + (["B","O"] select ([west,	east] find _side))]select _type,_packet] call CaptureTheFlag_s_mysql_formatQuery,1] 	call CaptureTheFlag_s_mysql_extdbCall;
	[_side,_packet select (count _packet - 1)] call CaptureTheFlag_s_session_savePlayerTime;
} else {
	private _uid = _packet deleteAt (count _packet - 1);
	private _pdb = GVAR(PDB_VAR_PLAYER_SETTINGS(_uid),[]);
	if _type then {
		// clothing index depends on the side
		_pdb set [[2,3] select ([west,east] find _side),_packet param [0,[],[[]]]];
		_pdb = (_pdb select [0,4]) + (_packet select [1,count _packet]);
	} else {
		_pdb = _packet + (_pdb select [2,count _pdb]);
	};
	SVAR(PDB_VAR_PLAYER_SETTINGS(_uid),_pdb);
};

// Tell the client the sync has finished
missionNameSpace setVariable ["CaptureTheFlag_session_syncInProgress",false,remoteExecutedOwner];