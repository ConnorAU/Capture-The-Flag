/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"
params [["_var","",[""]],["_value",0,[0]]];
private _side = ["Blufor","Opfor"] select (["opfor",_var] call BIS_fnc_instring);
["update"+_side+"Score"] call CaptureTheFlag_c_ui_HUD_Main;
if (_value>=CaptureTheFlag_serverSetting_maxFlagCaptures) then {
	[_side+"Event",["won the round"]] call CaptureTheFlag_c_ui_notifFeed_useTemplate;
	[[west,east] select (_side=="opfor")] spawn CaptureTheFlag_c_round_maxScoreReached;
} else {
	[_side+"Event",["captured the flag"]] call CaptureTheFlag_c_ui_notifFeed_useTemplate;
	["showNotification",[format["<t color='#%2'>%1</t> have captured the flag",_side,["11B8EC","bf0000"] param [["Blufor","Opfor"] find _side,"FFFFFF"]],1,5]] call CaptureTheFlag_c_ui_HUD_notificationBig;
};