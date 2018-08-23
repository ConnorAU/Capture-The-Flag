/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

if (diag_tickTime>(missionNamespace getVariable ["CaptureTheFlag_session_writePlayerData_onPauseTick",0])) then {
	missionNamespace setVariable ["CaptureTheFlag_session_writePlayerData",true];
	missionNamespace setVariable ["CaptureTheFlag_session_writePlayerData_onPauseTick",diag_tickTime+30];	
};