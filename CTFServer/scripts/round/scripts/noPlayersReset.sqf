/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

// Wait 10 minutes, if no one reconnects we restart the game
private _tick = diag_ticktime+(10*60);
waituntil {diag_ticktime > _tick OR (count(allPlayers-allDead))>0};
if ((count(allPlayers-allDead))>0) exitwith {};
["update"] call CaptureTheFlag_s_round_manageDBStats;
["end",false] call CaptureTheFlag_s_round_manageDBStats;
uisleep 3;
endmission "end1";
