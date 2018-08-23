/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

player setUnconscious false;
player allowDamage true;
player setdamage 0.25;
if !(isNil {player getVariable "vehicle"}) then {
	player setVariable ["vehicle",nil,true];
};
CaptureTheFlag_info_spawned = true;
BIS_dynamicGroups_allowInterface = true;
["revived"] call CaptureTheFlag_c_session_handleEvent;