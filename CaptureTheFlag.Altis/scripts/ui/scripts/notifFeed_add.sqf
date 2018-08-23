/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

private _notifPosition = getArray(missionConfigFile >> "CfgScripts" >> "ui" >> "configs" >> "NotificationTemplates" >> "position") apply {call compile _x};

// Create the notification
disableSerialization;
_notifControl = (uiNamespace getVariable ["CaptureTheFlag_UI_HUD_Master",findDisplay 46]) ctrlCreate ["CaptureTheFlag_UI_NotifFeed_Text",-1];
_notifControl ctrlSetPosition _notifPosition;
_notifControl ctrlSetFade 1;
_notifControl ctrlCommit 0;
_notifControl ctrlSetStructuredText parseText param[0,"",[""]];
CaptureTheFlag_ui_notifFeed_list = [[_notifControl,diag_tickTime+30]] + CaptureTheFlag_ui_notifFeed_list;

// Move existing notifications to make room for the new one 
private _yPos = 0;
{
	_x params [["_notifControl",controlNull,[controlNull]]];
	if !(isNull _notifControl) then {
		_notifPosition = ctrlPosition _notifControl;
		if (_forEachIndex isEqualTo 0) then	{
			// This is the newest notification, all other notifications should be positioned above it.
			_yPos = _notifPosition select 1;
			_notifControl ctrlSetFade 0;
		} else {
			if (_forEachIndex >= 20) then {
				// We don't want more than 20 notifications on screen, this will be deleted by the each frame updater
				_notifControl ctrlSetFade 1;
				_x set [1,diag_tickTime + 0.5];
				_x set [2,true];
			};
			// Move notification up previous line height
			_notifPosition set [1,_yPos];
		};
		_notifControl ctrlSetPosition _notifPosition;
		_notifControl ctrlCommit 0.25;
		_yPos = _yPos - (_notifPosition select 3); // Subtract the ctrl height so the next control moves up the screen
	};
} forEach CaptureTheFlag_ui_notifFeed_list;