/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"
params [["_restriction","",[""]]];
[_restriction,CaptureTheFlag_info_playerUID] remoteExecCall ["CaptureTheFlag_s_session_savePlayerRestriction",2];
CaptureTheFlag_session_firstSpawn = true;
CaptureTheFlag_session_restricted = _restriction;
CaptureTheFlag_info_spawned = false;
[] spawn CaptureTheFlag_c_spawn_camera;
player setPos (getmarkerpos "respawn");