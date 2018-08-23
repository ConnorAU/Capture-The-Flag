/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [["_unit",missionnamespace getVariable ["CaptureTheFlag_medical_revivingTarget",[player,5] call CaptureTheFlag_c_system_getNearestUnit],[objNull]]];
CaptureTheFlag_medical_revivingTarget = nil;
if (isNull _unit) exitwith {};
if (_unit isequalto player) exitwith {};
if !(alive _unit) exitwith {};

[] remoteExecCall ["CaptureTheFlag_c_medical_revived",_unit];
["revive_player"] call CaptureTheFlag_c_session_handleEvent;