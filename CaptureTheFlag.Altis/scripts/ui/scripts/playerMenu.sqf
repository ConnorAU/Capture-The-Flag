/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

params [
	["_mode","",[""]],
	["_params",[]]
];

switch _mode do {
	case "init":{
		_params params ["_display"];

		private _button1 = _display displayCtrl 1;
		private _button2 = _display displayCtrl 2;
		private _button3 = _display displayCtrl 3;
		private _button4 = _display displayCtrl 4;
		private _button5 = _display displayCtrl 5;
		private _button6 = _display displayCtrl 6;
		private _button7 = _display displayCtrl 7;

		_button1 ctrlAddEventHandler ["ButtonClick",{["RscDisplayDynamicGroups",ctrlParent(_this select 0)] call CaptureTheFlag_c_ui_createDialog}];
		_button2 ctrlAddEventHandler ["ButtonClick",{["CaptureTheFlag_UI_Settings",ctrlParent(_this select 0)] call CaptureTheFlag_c_ui_createDialog}];
		_button3 ctrlAddEventHandler ["ButtonClick",{[] spawn CaptureTheFlag_c_session_forceSync}];
		_button4 ctrlAddEventHandler ["ButtonClick",{["CaptureTheFlag_UI_ControlsAndRules",ctrlParent(_this select 0)] call CaptureTheFlag_c_ui_createDialog}];
		_button7 ctrlAddEventHandler ["ButtonClick",{(ctrlParent(_this select 0)) closeDisplay 2}];
	};
	case "rulesAndControls":{
		_params params ["_display"];

		private _ctrl = _display displayCtrl 1;
		private _txt = [];
		{
			_txt pushback ("<t size='1.2' color='"+(PROFILE_COLOURS call BIS_fnc_colorRGBtoHTML)+"'>"+(_x param [0,"",[""]])+"</t><br/>");
			_txt pushback ("<t size='0.8'>"+(_x param [1,"",[""]])+"</t><br/>");
			_txt pushback "<br/>";
		}foreach ([[
		    "Controls",
			[
				"Player Menu: ~",
				"Toggle Earplugs: "+(call compile keyName 59)+" or Custom User Action 1",
				"Toggle Name Tags: "+(call compile keyName 60)+" or Custom User Action 2",
				"Jump: "+(call compile keyName 42)+" + "+(call compile keyName 47)+" or Custom User Action 3",
				"Holster Weapon: "+(call compile keyName 42)+" + "+(call compile keyName 35)+" or Custom User Action 4"
			]joinstring "<br/>"
		]]+CaptureTheFlag_serverSetting_rules);

		_ctrl ctrlSetStructuredText parseText (_txt joinString "");
		_ctrl ctrlSetPosition ((ctrlPosition _ctrl select [0,3])+[ctrlTextHeight _ctrl]);
		_ctrl ctrlCommit 0;
		_ctrl ctrlEnable false;

		(_display displayCtrl 2) ctrlAddEventHandler ["ButtonClick",{(ctrlParent(_this select 0))closeDisplay 2}];
	};
	case "settingsLoad":{
		_params params ["_display"];
		_display displayAddEventHandler ["Unload",{
			if !(isNil "CaptureTheFlag_settings_modified") then {
				CaptureTheFlag_settings_modified = nil;
				true call CaptureTheFlag_c_session_writeData;
			};
		}];

		private _ctrl = _display displayctrl 1;
		_ctrl ctrlAddEventHandler ["ButtonClick",{(ctrlParent(_this select 0)) closeDisplay 2;}];

		{
			_ctrlDisplay = _display displayCtrl (((_forEachIndex+1)*10)+1);
			_ctrlDisplay setVariable ["type",_x];
			_ctrlDisplay ctrlSetText str(missionnamespace getVariable ["CaptureTheFlag_setting_"+_x+"ViewDistance",0]);

			_ctrl = _display displayCtrl ((_forEachIndex+1)*10);
			_ctrl setVariable ["displayCtrl",_ctrlDisplay];
			_ctrl ctrlAddEventHandler ["ButtonClick",{["viewDistance",[_this select 0,false]] call CaptureTheFlag_c_settings_modifySettings}];

			_ctrl = _display displayCtrl (((_forEachIndex+1)*10)+2);
			_ctrl setVariable ["displayCtrl",_ctrlDisplay];
			_ctrl ctrlAddEventHandler ["ButtonClick",{["viewDistance",[_this select 0,true]] call CaptureTheFlag_c_settings_modifySettings}];
		} foreach ["Foot","Land","Air"];

		_ctrlDisplay = _display displayCtrl 41;
		_ctrlDisplay ctrlSetText ([] call CaptureTheFlag_c_settings_interpretTerrainGrid);

		_ctrl = _display displayCtrl 40;
		_ctrl ctrlSetTooltip "Lower settings can increase FPS at the expense of terrain detail.";
		_ctrl setVariable ["displayCtrl",_ctrlDisplay];
		_ctrl ctrlAddEventHandler ["ButtonClick",{["terrainGrid",[_this select 0,false]] call CaptureTheFlag_c_settings_modifySettings}];

		_ctrl = _display displayCtrl 42;
		_ctrl ctrlSetTooltip "Higher settings can increase terrain detail at the expense of FPS.";
		_ctrl setVariable ["displayCtrl",_ctrlDisplay];
		_ctrl ctrlAddEventHandler ["ButtonClick",{["terrainGrid",[_this select 0,true]] call CaptureTheFlag_c_settings_modifySettings}];


		_ctrl = _display displayCtrl 50;
		_ctrl ctrlSetTooltip "Disabling this may improve FPS on low end systems. Controls ambient noise and animals (crickets, rain, rabits, snakes, etc).";
		_ctrl cbSetChecked (CaptureTheFlag_setting_enableEnvironment call CaptureTheFlag_c_system_toBool);
		_ctrl ctrlAddEventHandler ["CheckedChanged",{["enableEnvironment",_this] call CaptureTheFlag_c_settings_modifySettings}];

		_ctrl = _display displayCtrl 60;
		_ctrl ctrlSetTooltip "Show/Hide player tags above friendly players heads.";
		_ctrl cbSetChecked (CaptureTheFlag_setting_showPlayerTags call CaptureTheFlag_c_system_toBool);
		_ctrl ctrlAddEventHandler ["CheckedChanged",{["showPlayerTags",_this] call CaptureTheFlag_c_settings_modifySettings}];

		_ctrl = _display displayCtrl 70;
		_ctrl ctrlSetTooltip "Show/Hide hitmarkers when shooting other players.";
		_ctrl cbSetChecked (CaptureTheFlag_setting_showHitMarkers call CaptureTheFlag_c_system_toBool);
		_ctrl ctrlAddEventHandler ["CheckedChanged",{["showHitMarkers",_this] call CaptureTheFlag_c_settings_modifySettings}];

	};
	default {};
};