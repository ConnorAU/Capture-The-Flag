/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

if !(missionNamespace getVariable ["CaptureTheFlag_session_dataRead",false]) exitwith {};
params [["_skillRef","",[""]]];
if (_skillRef == "") exitwith {};
CaptureTheFlag_session_syncInProgress = true;
[_skillRef,missionnamespace getVariable ["CaptureTheFlag_skill_"+_skillRef,0],CaptureTheFlag_info_playerUID] remoteExecCall ["CaptureTheFlag_s_session_savePlayerSkill",2];