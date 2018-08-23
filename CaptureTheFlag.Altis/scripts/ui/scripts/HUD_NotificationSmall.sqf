/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

disableSerialization;
params [["_mode","",[""]],["_params",[]]];

switch _mode do {
	case "init":{
		_params params [["_display",controlNull,[controlNull]]];
		if !(isNull _display) then {
			uiNameSpace setVariable ["CaptureTheFlag_HUD_NotificationSmall",_display];
		};
	};
	case "showNotification":{
		private _display = uiNamespace getVariable ["CaptureTheFlag_HUD_NotificationSmall",controlNull];
		if !(isNull _display) then {
			private _ctrl = _display controlsGroupCtrl 1;
			_params params [
				["_text","",[""]],
				["_fade",2,[0]],
				["_duration",-1,[0]]
			];
			_ctrl ctrlSetFade 1;
			_ctrl ctrlCommit 0;
			_ctrl ctrlSetStructuredText parsetext _text;
			_ctrl ctrlSetFade 0;
			_ctrl ctrlcommit _fade;
			if (_duration > -1) then {
				CaptureTheFlag_ui_notificationSmall_tick = diag_ticktime;
				[CaptureTheFlag_ui_notificationSmall_tick,_duration] spawn {
					params ["_tick","_duration"];
					waituntil {diag_ticktime > (_tick+_duration) OR CaptureTheFlag_ui_notificationSmall_tick != _tick};
					if (CaptureTheFlag_ui_notificationSmall_tick != _tick) exitwith {};
					["hideNotification"] call CaptureTheFlag_c_ui_HUD_NotificationSmall;
				};
			};
		};
	};
	case "hideNotification":{
		private _display = uiNamespace getVariable ["CaptureTheFlag_HUD_NotificationSmall",controlNull];
		if !(isNull _display) then {
			private _ctrl = _display controlsGroupCtrl 1;
			_params params [
				["_fade",2,[0]]
			];
			_ctrl ctrlSetFade 1;
			_ctrl ctrlcommit _fade;
		};
	};
	default {};
};