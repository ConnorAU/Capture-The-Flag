/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [
	["_unit",objNull,[objNull]],
	["_netID","",[""]],
	["_owner",remoteExecutedOwner,[0]],
	["_side",sideUnknown,[sideUnknown]],
	["_pid","",[""]]
];

// Macro because I somehow thought this was better than a local function
#define KICK_UNIT(REASON) [REASON,{\
	if isserver exitwith {};\
	[] call BIS_fnc_forceEnd;\
	endLoadingScreen;\
	uisleep 0.1;\
	endmission _this;\
	failMission _this;\
	uisleep 3;\
	(findDisplay 46) closeDisplay 2;\
}] remoteExec ["spawn",_owner];

/*if (isNull _unit && {isNull (objectFromNetId _netID)}) then {
	private _tick = diag_tickTime+10;
	waituntil {diag_tickTime>_tick OR !(isNull(objectFromNetId _netID))};
};*/

// Rare issue where the player object was only created locally. If the server can't see you, it kicks you.
if (isNull _unit && {isNull (objectFromNetId _netID)}) exitwith {
	if (_owner > 2) then {
		KICK_UNIT("nullUnit");
		["System",format["Null unit connected: %1",[str _netID,_owner,_side,str _pid]]] call CaptureTheFlag_c_system_log;
	};
	true
};
if !(_side in [west,east]) exitwith {
	if (_owner > 2) then {
		KICK_UNIT("genericError");
		["System",format["Unit does not belong to a permitted side: %1",[_unit,str _netID,_owner,_side,str _pid]]] call CaptureTheFlag_c_system_log;
	};
	true
};

private _pCount = {(_x getVariable ["side",side _x]) isEqualTo _side} count playableUnits;
switch _side do {
	case west:{
		// For the autobalance that never got done
		CaptureTheFlag_serverSession_westClients pushBack _owner;

		// Used to calculate XP and Cash rewards
		missionNamespace setVariable ["CaptureTheFlag_info_playerCountWestMax",CaptureTheFlag_info_playerCountWestMax max _pCount,true];
	};
	case east:{
		CaptureTheFlag_serverSession_eastClients pushBack _owner;
		missionNamespace setVariable ["CaptureTheFlag_info_playerCountEastMax",CaptureTheFlag_info_playerCountEastMax max _pCount,true];
	};
	default {};
};

false