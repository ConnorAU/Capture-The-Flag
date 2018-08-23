/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

if (isNull _this) exitwith {};
if !(_this isKindOf "CAManBase") exitwith {};
[] remoteExecCall ["CaptureTheFlag_c_medical_executed",_this];
["execute_player"] call CaptureTheFlag_c_session_handleEvent;