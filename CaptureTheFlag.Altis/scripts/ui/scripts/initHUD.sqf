/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

addMissionEventHandler ["EachFrame",{
	if (isNull (uiNamespace getVariable ["CaptureTheFlag_UI_HUD_Master",displayNull])) then {
		"CaptureTheFlag_UI_HUD_Master_Layer" cutRsc ["CaptureTheFlag_UI_HUD_Master","PLAIN"];
	};
	[] call CaptureTheFlag_c_ui_headsUpIcons;
	[] call CaptureTheFlag_c_ui_groupMenuUpdate;
	[] call CaptureTheFlag_c_ui_notifFeed_update;
	["updateTime"] call CaptureTheFlag_c_ui_HUD_Main;
	["updateIcons"] call CaptureTheFlag_c_ui_HUD_Watermark;
}];