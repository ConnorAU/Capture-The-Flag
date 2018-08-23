/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

if (CaptureTheFlag_session_lastTimeSync>diag_tickTime) exitwith {
	["Default",[format["Force sync cooldown: <t color='#FF0000'>%1</t>",[CaptureTheFlag_session_lastTimeSync-diag_ticktime,"MM:SS"] call BIS_fnc_secondsToString]]] call CaptureTheFlag_c_ui_notifFeed_useTemplate;
};
CaptureTheFlag_session_lastTimeSync = diag_tickTime+(2*60);
CaptureTheFlag_session_writePlayerData = true;