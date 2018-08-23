/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

// Had to make my own version of the holdAction system for a few reasons 
// The A3 holdActions didn't work for some players which I found weightRTD
// This version allows for modifiers to change the hold time dynamically so its a bit nicer
// Looks the same visually

#include "..\..\defines.sqf"

params [["_mode","",[""]],["_params",[]]];
switch _mode do {
	case "init":{
		_params params [["_display",controlNull,[controlNull]]];
		if !(isNull _display) then {
			uiNameSpace setVariable ["CaptureTheFlag_HUD_HoldAction",_display];
		};
	};
	case "addTemplate":{
		_params params [
			["_target",objNull,[objNull]],
			["_actionClass","defaultAction",[""]]
		];
		
		if (isNull _target) exitwith {-1};
		private _configDir = missionConfigFile >> "CfgScripts" >> "ui" >> "configs" >> "holdActionTemplate" >> _actionClass;
		if !(isClass _configDir) exitwith {-1};
		private _factions = getArray(_configDir >> "factions") apply {call compile _x};
		if !(SIDE_VAR(player) in _factions) exitwith {-1};
		
		[
			"add",
			[
				_target,
				getText(_configDir >> "title"),
				getText(_configDir >> "idleIcon"),
				getText(_configDir >> "progressIcon"),
				getText(_configDir >> "condShow"),
				compile getText(_configDir >> "condProgress"),
				compile getText(_configDir >> "codeStart"),
				compile getText(_configDir >> "codeProgress"),
				compile getText(_configDir >> "codeCompleted"),
				compile getText(_configDir >> "codeInterupted"),
				getArray (_configDir >> "arguments") apply {call compile _x},
				getNumber(_configDir >> "duration"),
				getText(_configDir >> "durationModifier"),
				getNumber(_configDir >> "priority"),
				[getNumber(_configDir >> "removeCompleted")] call CaptureTheFlag_c_system_toBool,
				getNumber(_configDir >> "distance"),
				[getNumber(_configDir >> "showUncon")] call CaptureTheFlag_c_system_toBool
			]
		] call CaptureTheFlag_c_ui_holdAction;
	};
	case "add":{
		_params params [
			["_target",objNull,[objNull]],
			["_title","",[""]],
			["_idleIcon","",[""]],
			["_progressIcon","",[""]],
			["_condShow","",[""]],
			["_condProgress",{},[{}]],
			["_codeStart",{},[{}]],
			["_codeProgress",{},[{}]],
			["_codeCompleted",{},[{}]],
			["_codeInterupted",{},[{}]],
			["_arguments",[]],
			["_duration",0,[0]],
			["_durationModifier","1",[""]],
			["_priority",0,[0]],
			["_removeCompleted",false,[true]],
			["_distance",0,[0]],
			["_showUncon",false,[true]]
		];
		if (isNull _target OR {"" in [_title,_idleIcon,_progressIcon]}) exitwith {-1};
		if (_duration <= 0) then {
			_target addAction [_title,_codeCompleted,_arguments,_priority,true,true,"",_condShow,_distance,_showUncon,""];
		} else {
			CaptureTheFlag_ui_holdAction_queue pushback [_target,_title,_idleIcon,_progressIcon,compile _condShow,_condProgress,_codeStart,_codeProgress,_codeCompleted,_codeInterupted,_arguments,_duration,_durationModifier,_priority,_removeCompleted,_distance,_showUncon];
		};
	};
	case "remove":{
		_params params [["_id",-1,[0]]];
		if (_id < 0 OR {_id > (count CaptureTheFlag_ui_holdAction_queue - 1)}) exitwith {false};
		CaptureTheFlag_ui_holdAction_queue set [_id,0];
		true
	};
	case "monitor":{
		if (!isNil "CaptureTheFlag_ui_holdAction_thread" && {!scriptDone CaptureTheFlag_ui_holdAction_thread}) exitwith {true};
		private _condRunThread = {
			(
			 	_target isequalto player OR 
			 	{
			 		cursorObject isequalto _target
			 	}
			) && 
			{
				player distance _target <= _distance && 
				{
					_arguments call _condShow && 
					{
						(
						 	_showUncon OR 
							{
								!_showUncon && 
								{
									!NEEDS_REVIVE(player)
								}
							}
						) && 
						{
							!visibleMap && 
							{
								count(allDisplays select [allDisplays find (findDisplay 46),count allDisplays]) <= 2
							}
						}
					}
				}
			}
		};
		{
			if (_x isEqualType []) then {
				_x params [
					["_target",objNull,[objNull]],"","","",
					["_condShow",{},[{}]],"","","","","",
					["_arguments",[],[[]]],"","","","",
					["_distance",0,[0]],
					["_showUncon",false,[true]]
				];
				if (call _condRunThread) exitwith {
					CaptureTheFlag_ui_holdAction_thread = ["thread",_x+[_condRunThread,_forEachIndex]] spawn CaptureTheFlag_c_ui_holdAction;
				};
			};
		} foreach CaptureTheFlag_ui_holdAction_queue;
		!isNil "CaptureTheFlag_ui_holdAction_thread" && {!scriptDone CaptureTheFlag_ui_holdAction_thread}
	};
	case "thread":{
		scriptName "<spawn>";
		_params params ["_target","_title","_idleIcon","_progressIcon","_condShow","_condProgress","_codeStart","_codeProgress","_codeCompleted","_codeInterupted","_arguments","_duration","_durationModifier","_priority","_removeCompleted","_distance","_showUncon","_condRunThread","_fei"];

		_title = format[
			"Hold %1 to %2",
			format[
				"<t color=%2>%1</t>",
				(keyName 57) select [1,count (keyName 57) - 2],
				str([
					profilenamespace getvariable ["GUI_BCG_RGB_R",0.77],
					profilenamespace getvariable ["GUI_BCG_RGB_G",0.51],
					profilenamespace getvariable ["GUI_BCG_RGB_B",0.08]
				] call BIS_fnc_colorRGBtoHTML)
			],
			_title
		];
		_duration = _duration*([call compile _durationModifier] param [0,1,[0]]);

		private _setActionText = {
			disableSerialization;
			params [
				["_backgroundT","",[""]],
				["_foregroundT","",[""]]
			];
			private _parent = uiNamespace getVariable ["CaptureTheFlag_HUD_HoldAction",controlNull];
			private _backgroundC = _parent controlsGroupCtrl 1;
			private _foregroundC = _parent controlsGroupCtrl 2;
			if (true in ([_parent,_backgroundC,_foregroundC] apply {isNull _X})) exitwith {};
			_backgroundC ctrlSetStructuredText parseText _foregroundT;
			_foregroundC ctrlSetStructuredText parseText _backgroundT;
		};
		private _showIdleAction = {
			if (CaptureTheFlag_ui_holdAction_thread_idleTick>diag_tickTime) exitwith {};
			private _template = "<img size='2.25' shadow='0' color='#ffffffff' image='%1'/>";
			private _idleIcons = ["#BFFFFFFF","#E2FFFFFF","#F9FFFFFF","#FEFFFFFF","#EFFFFFFF","#D1FFFFFF","#ADFFFFFF","#8FFFFFFF","#80FFFFFF","#85FFFFFF","#9DFFFFFF","#BFFFFFFF"] apply {format["<img size='2.25' shadow='0' color='%1' image='\A3\Ui_f\data\IGUI\Cfg\HoldActions\in\in_0_ca.paa'/>",_x]};
			[
				_idleIcons param [CaptureTheFlag_ui_holdAction_thread_idleFrame,""],
				format[_template,_idleIcon] + "<br/><t size='0.85'>" + _title + "</t>"
			] call _setActionText;
			CaptureTheFlag_ui_holdAction_thread_idleTick = diag_ticktime + 0.065;
			CaptureTheFlag_ui_holdAction_thread_idleFrame = (CaptureTheFlag_ui_holdAction_thread_idleFrame+1)%12
		};
		private _startHolding = {
			CaptureTheFlag_ui_holdAction_thread_state = 2;
			_arguments call _codeStart;
			for "_i" from 0 to 3 do {
				uisleep 0.05;
				if (CaptureTheFlag_ui_holdAction_thread_state != 2) exitwith {};
				private _template = "<img size='2.25' shadow='0' color='#ffffffff' image='%1'/>";
				[
					format[_template,format["\A3\Ui_f\data\IGUI\Cfg\HoldActions\in\in_%1_ca.paa",_i]],
					format[_template,_progressIcon] + "<br/><t size='0.85'>" + _title + "</t>"
				] call _setActionText;
			};
		};
		private _continueHolding = {
			if (isNil "CaptureTheFlag_ui_holdAction_thread_nextHoldingUpdate") then {
				CaptureTheFlag_ui_holdAction_thread_nextHoldingUpdate = 0;
				CaptureTheFlag_ui_holdAction_thread_frameNumber = 0;
			};
			if (diag_tickTime > CaptureTheFlag_ui_holdAction_thread_nextHoldingUpdate) then {
				if (CaptureTheFlag_ui_holdAction_thread_frameNumber > 24) exitwith {
					CaptureTheFlag_ui_holdAction_thread_state = 4;
				};
				_arguments call _codeProgress;

				private _template = "<img size='2.25' shadow='0' color='#ffffffff' image='%1'/>";
				[
					format[_template,format["\A3\Ui_f\data\IGUI\Cfg\HoldActions\progress\progress_%1_ca.paa",CaptureTheFlag_ui_holdAction_thread_frameNumber]],
					format[_template,_progressIcon] + "<br/><t size='0.85'>" + _title + "</t>"
				] call _setActionText;

				CaptureTheFlag_ui_holdAction_thread_frameNumber = CaptureTheFlag_ui_holdAction_thread_frameNumber + 1;
				CaptureTheFlag_ui_holdAction_thread_nextHoldingUpdate = diag_tickTime + (_duration/25);
			};
		};

		CaptureTheFlag_ui_holdAction_thread_state = 0;
		CaptureTheFlag_ui_holdAction_thread_idleFrame = 0;
		CaptureTheFlag_ui_holdAction_thread_idleTick = 0;

		waituntil {
			switch CaptureTheFlag_ui_holdAction_thread_state do {
				case 0:{
					call _showIdleAction;
				};
				case 1:{
					call _startHolding;
				};
				case 2:{
					if (_arguments call _condProgress) then {
						call _continueHolding;
					};
				};
				case 3:{
					CaptureTheFlag_ui_holdAction_thread_frameNumber = nil;
					CaptureTheFlag_ui_holdAction_thread_nextHoldingUpdate = nil;
					CaptureTheFlag_ui_holdAction_thread_keyDownTick = nil;
					CaptureTheFlag_ui_holdAction_thread_state = 0;
					_arguments call _codeInterupted;
				};
				case 4:{
					CaptureTheFlag_ui_holdAction_thread_state = 5;
					_arguments call _codeCompleted;
					if _removeCompleted then {
						["remove",[_fei]] call CaptureTheFlag_c_ui_holdAction;
					};
				};
				default {};
			};
			(CaptureTheFlag_ui_holdAction_thread_state>=5) OR {!(call _condRunThread)}
		};

		if (!(call _condRunThread) && {CaptureTheFlag_ui_holdAction_thread_state in [1,2]}) then {_arguments call _codeInterupted;};
		CaptureTheFlag_ui_holdAction_thread_keyDownTick = nil;
		CaptureTheFlag_ui_holdAction_thread_frameNumber = nil;
		CaptureTheFlag_ui_holdAction_thread_nextHoldingUpdate = nil;
		CaptureTheFlag_ui_holdAction_thread_idleFrame = nil;
		CaptureTheFlag_ui_holdAction_thread_idleTick=0;
		["",""] call _setActionText;
		CaptureTheFlag_ui_holdAction_thread_idleTick = nil;
		if (CaptureTheFlag_ui_holdAction_thread_state in [5]) then {uisleep 1.5};
		CaptureTheFlag_ui_holdAction_thread_state = nil;

	};
	case "keyDown":{
		if (isNil "CaptureTheFlag_ui_holdAction_thread" OR {scriptDone CaptureTheFlag_ui_holdAction_thread}) exitwith {false};
		_params params ["","_code"];
		if (_code in [57]) exitwith {
			if (isNil "CaptureTheFlag_ui_holdAction_thread_state") exitwith {false};
			if (isNil "CaptureTheFlag_ui_holdAction_thread_keyDownTick") then {
				CaptureTheFlag_ui_holdAction_thread_keyDownTick = diag_ticktime;
				CaptureTheFlag_ui_holdAction_thread_state = 1;
			};
			true
		};
		false;
	};
	case "keyUp":{
		if (isNil "CaptureTheFlag_ui_holdAction_thread" OR {scriptDone CaptureTheFlag_ui_holdAction_thread}) exitwith {false};
		_params params ["","_code"];
		if (_code in [57]) exitwith {
			if (CaptureTheFlag_ui_holdAction_thread_state == 0) exitwith {true};
			CaptureTheFlag_ui_holdAction_thread_keyDownTick = nil;
			CaptureTheFlag_ui_holdAction_thread_state = [3,0] select (CaptureTheFlag_ui_holdAction_thread_state == 1);
			true
		};
		false;
	};
	case "modifier":{
		switch (_params param [0,"",[""]]) do {
			case "reviveTeammate":{
				[1,1-((SKILL_VALUE("lifeSaver"))/10)] select SKILL_ACTIVE("lifeSaver")
			};
			case "repairVehicle":{
				private _value = [nil,"rv"] call CaptureTheFlag_c_system_getVehicleRepairValue;
				[_value,_value*(1-((((SKILL_VALUE("mechanic"))-1)max 0)/10))] select SKILL_ACTIVE("mechanic")
			};
			case "repairAndRearmVehicle":{
				[vehicle player,"rar"] call CaptureTheFlag_c_system_getVehicleRepairValue
			};
			case "stealFlag";
			case "pickUpFlag";
			case "returnFlag";
			case "captureFlag":{
				[1,1-((SKILL_VALUE("conqueror"))/10)] select SKILL_ACTIVE("conqueror")
			};
			default {1};
		};
	};	
	default {false};
};

