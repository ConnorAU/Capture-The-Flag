/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [["_mode","",[""]],["_params",[]]];
switch _mode do {
	case "load":{
		private _pid = missionnamespace getVariable ["CaptureTheFlag_info_teamKilled",""];
		CaptureTheFlag_info_teamKilled = nil;
		private _unit = [_pid] call CaptureTheFlag_c_system_getUnitFromPID;
		if (isNull _unit) exitwith {};
		disableSerialization;
		["CaptureTheFlag_UI_TeamKilled"] call CaptureTheFlag_c_ui_createDialog;
		private _display = uiNamespace getVariable ["CaptureTheFlag_UI_TeamKilled",displayNull];
		if (isNull _display) exitwith {};
		_display setVariable ["pid",_pid];
		_display setVariable ["tick",diag_ticktime+60];

		private _timeout = {
			disableSerialization;
			params ["_display"];
			private _t = _display getVariable ["tick",diag_tickTime+1];
			if (diag_tickTime>_t) then {_display closeDisplay 2;};
		};

		// Repetitive task that terminates when the display closes
		_display displayAddEventHandler ["MouseHolding",_timeout];
		_display displayAddEventHandler ["MouseMoving",_timeout];

		private _ctrl = _display displayCtrl 1;
		_ctrl ctrlSetStructuredText parseText format["You were team killed by %1<br/>Would you like to forgive or punish them?",name _unit];
		_ctrl ctrlSetPosition ((ctrlPosition _ctrl select [0,3])+[ctrlTextHeight _ctrl]);
		_ctrl ctrlCommit 0;
		_ctrl ctrlEnable false;

		_ctrl = _display displayCtrl 2;
		_ctrl ctrlSetText "Forgive";
		_ctrl ctrlAddEventHandler ["ButtonClick",{(ctrlParent(_this select 0))closeDisplay 2}];

		_ctrl = _display displayCtrl 3;
		_ctrl ctrlSetText "Punish";
		_ctrl ctrlAddEventHandler ["ButtonClick",{["ButtonClick",[ctrlParent(_this select 0)]] call CaptureTheFlag_c_system_handleTeamKill}];
	};
	case "ButtonClick":{
		disableSerialization;
		_params params ["_display"];
		private _pid = _display getVariable ["pid",""];
		_display closeDisplay 2;
		private _unit = [_pid] call CaptureTheFlag_c_system_getUnitFromPID;
		if !(isNull _unit) then {
			["addTK",_pid] remoteExecCall ["CaptureTheFlag_c_system_handleTeamKill",_unit];
		};
	};
	case "addTK":{
		if (CaptureTheFlag_info_playerUID != _params) exitwith {};
		CaptureTheFlag_session_tkCounter = CaptureTheFlag_session_tkCounter + 1;
		if (CaptureTheFlag_session_tkCounter >= 3) then {
			["Team Killing"] spawn CaptureTheFlag_c_round_restricted;
		};
	};	
	default {};
};