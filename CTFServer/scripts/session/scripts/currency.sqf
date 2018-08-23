/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [["_value",0,[0]]];
if (_value == 0) exitwith {false};
if ((CaptureTheFlag_session_currency+_value)<0) exitwith {false};
CaptureTheFlag_session_currency = CaptureTheFlag_session_currency + _value;
CaptureTheFlag_session_writePlayerData = true;
["updateCash"] call CaptureTheFlag_c_ui_HUD_Main;
true