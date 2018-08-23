/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

if (isNil "CaptureTheFlag_ui_notifFeed_list") exitWith {CaptureTheFlag_ui_notifFeed_list = [];};
disableSerialization;
{
	_x params [["_notifControl",controlNull,[controlNull]],["_nextUpdate",0,[0]],["_canDelete",false,[true]]];
	if !(isNull _notifControl) then {
		if (diag_tickTime >= _nextUpdate) then {
			if _canDelete then {
				// Delete notification control
				ctrlDelete _notifControl;
			} else {
				// Hide the notification so we can delete it 
				_notifControl ctrlSetFade 1;
				_notifControl ctrlCommit 0.25;
				_x set [1,diag_tickTime + 0.5];
				_x set [2,true];
			};
		};
	} else {
		// Remove element from the array
		CaptureTheFlag_ui_notifFeed_list set [_forEachIndex,0];
	};
} forEach CaptureTheFlag_ui_notifFeed_list;

// We remove elements this way because if we deleted from the array as we were iterating through it we would jump an index
CaptureTheFlag_ui_notifFeed_list = CaptureTheFlag_ui_notifFeed_list - [0];