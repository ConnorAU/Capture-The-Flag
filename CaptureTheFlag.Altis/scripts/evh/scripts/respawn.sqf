/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

startLoadingScreen [""];
_this spawn {
	params ["_unit","_corpse"];
	removeAllActions _corpse;
	waituntil {player isequalto _unit};
	[_unit] call CaptureTheFlag_c_spawn_moveToSpawn;
	CaptureTheFlag_session_writePlayerData = true;
	endLoadingScreen;
};