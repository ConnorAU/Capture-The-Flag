/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

disableSerialization;
params [["_mode","",[""]],["_params",[]]];

private _display = uiNameSpace getVariable ["CaptureTheFlag_HUD_Main",controlNull];

switch _mode do {
	case "init":{
		if !canSuspend exitwith {_this spawn CaptureTheFlag_c_ui_HUD_Main};
		_params params [["_display",controlNull,[controlNull]]];
		if (isNull _display) exitwith {};
		uiNameSpace setVariable ["CaptureTheFlag_HUD_Main",_display];

		waitUntil {missionNamespace getVariable ["CaptureTheFlag_session_dataRead",false]};
		_display ctrlShow true;

		private _flagHomeBG= _display controlsGroupCtrl 1;
		private _flagImg = _display controlsGroupCtrl 2;
		private _flagCapturePointBG = _display controlsGroupCtrl 11;

		_flagHomeBG ctrlSetText "";
		_flagCapturePointBG ctrlSetText "";
		_flagImg ctrlSetText "resources\images\hud\flag.paa";

		["updateBluforScore",[true]] call CaptureTheFlag_c_ui_HUD_Main;
		["updateOpforScore",[true]] call CaptureTheFlag_c_ui_HUD_Main;
		["updateCash"] call CaptureTheFlag_c_ui_HUD_Main;
		["updateRank"] call CaptureTheFlag_c_ui_HUD_Main;
		["updateXP",[true]] call CaptureTheFlag_c_ui_HUD_Main;

	};
	case "updateTime":{
		private _ctrl = _display controlsGroupCtrl 21;
		private _time = [(time-CaptureTheFlag_info_roundStartTick)max 0,["MM:SS","HH:MM:SS"]select ((time-CaptureTheFlag_info_roundStartTick)>=3600)] call BIS_fnc_secondsToString;
		if (ctrlText _ctrl != _time) then {_ctrl ctrlSetText _time};
	};
	case "updateBluforScore":{
		_params params [["_instant",false,[true]]];

		private _bluforFlagProgressBG = _display controlsGroupCtrl 3;
		private _bluforFlagProgress = _display controlsGroupCtrl 4;
		private _bluforFlagCount = _display controlsGroupCtrl 5;

		(ctrlPosition _bluforFlagProgressBG) params ["","","_maxWidth"];
		private _progress = ctrlPosition _bluforFlagProgress;
		_progress set [2,(CaptureTheFlag_info_blufor_flag_captures/CaptureTheFlag_serverSetting_maxFlagCaptures)*_maxWidth];
		_bluforFlagProgress ctrlSetPosition _progress;
		_bluforFlagProgress ctrlCommit ([2,0] select _instant);
		_bluforFlagCount ctrlSetText ([CaptureTheFlag_info_blufor_flag_captures] call CaptureTheFlag_c_system_numberText);
	};
	case "updateOpforScore":{
		_params params [["_instant",false,[true]]];

		private _opforFlagProgressBG = _display controlsGroupCtrl 13;
		private _opforFlagProgress = _display controlsGroupCtrl 14;
		private _opforFlagCount = _display controlsGroupCtrl 15;

		(ctrlPosition _opforFlagProgressBG) params ["_xStart","","_maxWidth"];
		private _progress = ctrlPosition _opforFlagProgress;
		_progress set [2,(CaptureTheFlag_info_opfor_flag_captures/CaptureTheFlag_serverSetting_maxFlagCaptures)*_maxWidth];
		_progress set [0,(_xStart+_maxWidth)-(_progress select 2)];
		_opforFlagProgress ctrlSetPosition _progress;
		_opforFlagProgress ctrlCommit ([2,0] select _instant);
		_opforFlagCount ctrlSetText ([CaptureTheFlag_info_opfor_flag_captures] call CaptureTheFlag_c_system_numberText);
	};
	case "updateCash":{
		private _playerCash = _display controlsGroupCtrl 32;
		_playerCash ctrlSetText format["$%1",CaptureTheFlag_session_currency call CaptureTheFlag_c_system_numberText];
	};
	case "updateRank":{
		private _playerRank = _display controlsGroupCtrl 31;
		_playerRank ctrlSetText format["Rank: %1",CaptureTheFlag_statistic_rank call CaptureTheFlag_c_system_numberText];
		player setVariable ["rank",CaptureTheFlag_statistic_rank,true];
	};
	case "updateXP":{
		_params params [["_instant",false,[true]]];

		private _playerEXPBG = _display controlsGroupCtrl 33;
		private _playerEXP = _display controlsGroupCtrl 34;
		private _playerEXPText = _display controlsGroupCtrl 35;

		(ctrlPosition _playerEXPBG) params ["","","_maxWidth"];
		private _progress = ctrlPosition _playerEXP;
		_progress set [2,(CaptureTheFlag_session_experience/(CaptureTheFlag_statistic_rank*EXP_PER_RANK))*_maxWidth];
		_playerEXP ctrlSetPosition _progress;
		_playerEXP ctrlCommit ([2,0] select _instant);
		_playerEXPText ctrlSetText format["%1/%2",CaptureTheFlag_session_experience call CaptureTheFlag_c_system_numberText,(CaptureTheFlag_statistic_rank*EXP_PER_RANK) call CaptureTheFlag_c_system_numberText];

	};

	case "flag_atBase":{
		private _flagHomeBG = _display controlsGroupCtrl 1;
		private _flagImg = _display controlsGroupCtrl 2;
		private _flagCapturePointBG = _display controlsGroupCtrl 11;

		if (ctrlText _flagHomeBG != "resources\images\hud\indep_bg_solid.paa") then {
			_flagHomeBG ctrlSetText "resources\images\hud\indep_bg_solid.paa";
			_flagHomeBG ctrlSetFade 0;
			_flagHomeBG ctrlcommit 0;
		};
		if (ctrlText _flagCapturePointBG != "") then {
			_flagCapturePointBG ctrlSetText "";
			_flagCapturePointBG ctrlSetFade 0;
			_flagCapturePointBG ctrlcommit 0;
		};

		private _fXPos = (ctrlPosition _flagHomeBG) select 0;
		if (_fXPos != (ctrlPosition _flagImg) select 0) then {
			_flagImg ctrlSetPosition ([_fXPos]+(ctrlPosition _flagImg select [1,3]));
			_flagImg ctrlSetFade 0;
			_flagImg ctrlCommit 0;
		};
	};
	case "flag_stealingInProgress":{
		_params params [["_flag",objNull,[objNull]]];
		private _flagHomeBG = _display controlsGroupCtrl 1;
		if (ctrlText _flagHomeBG != "resources\images\hud\indep_bg_dotted.paa") then {
			_flagHomeBG ctrlSetText "resources\images\hud\indep_bg_dotted.paa";
			[_flagHomeBG,_flag] spawn {
				disableSerialization;
				params ["_c","_f"];
				while {(_f getVariable ["FlagState","AtBase"]) == "Stealing"} do {
					_c ctrlSetFade ([0.7,0] select (round (ctrlFade _c)));
					_c ctrlcommit 0.5;
					uisleep 0.5;
				};
			};
		};
	};
	case "flag_onMove":{
		_params params [["_flag",objNull,[objNull]]];
		private _flagHomeBG = _display controlsGroupCtrl 1;
		private _flagImg = _display controlsGroupCtrl 2;
		private _flagCapturePointBG = _display controlsGroupCtrl 11;

		private _unitStolen = _flag getVariable ["UnitStolen",objNull];
		private _stolenSide = OBJECTIVE_FLAG_POLE getVariable ["SideStolen",SIDE_VAR(_unitStolen)];

		if (ctrlText _flagHomeBG != "resources\images\hud\indep_bg_dotted.paa") then {
			_flagHomeBG ctrlSetText "resources\images\hud\indep_bg_dotted.paa";
		};
		_flagHomeBG ctrlSetFade 0;
		_flagHomeBG ctrlcommit 0;

		private _bgImg = [
			"resources\images\hud\blufor_bg_dotted.paa",
			"resources\images\hud\opfor_bg_dotted.paa"
		] param [SIDE_INDEX_SIDE(_stolenSide),""];
		if (ctrlText _flagCapturePointBG != _bgImg) then {
			_flagCapturePointBG ctrlSetText _bgImg;
			_flagCapturePointBG ctrlSetFade 0;
			_flagCapturePointBG ctrlcommit 0;
		};

		private _capturePoint = [
			BLUFOR_FLAG_BASE,
			OPFOR_FLAG_BASE
		] param [SIDE_INDEX_SIDE(_stolenSide),OBJECTIVE_FLAG_BASE];

		private _distance = [_unitStolen distance _capturePoint] param [0,1];
		private _maxDistance = [OBJECTIVE_FLAG_BASE distance _capturePoint] param [0,1000];
		private _travel = (_maxDistance-(_distance min _maxDistance))/_maxDistance;

		private _fXPos = (ctrlposition _flagHomeBG) select 0;
		private _cXPos = (ctrlposition _flagCapturePointBG) select 0;

		_flagImg ctrlSetPosition ([_fXPos+(((_cXPos-_fXPos)*_travel)max 0)]+(ctrlPosition _flagImg select [1,3]));
		_flagImg ctrlSetFade 0;
		_flagImg ctrlCommit 0;
	};
	case "flag_dropped":{
		_params params [["_flag",objNull,[objNull]]];
		private _flagImg = _display controlsGroupCtrl 2;

		if (isNil "CaptureTheFlag_ui_HUD_Main_flag_dropped_handle") then {
			["flag_onMove",[_flag]] call CaptureTheFlag_c_ui_HUD_Main;	
			CaptureTheFlag_ui_HUD_Main_flag_dropped_handle = [_flagImg,OBJECTIVE_FLAG_POLE] spawn {
				disableSerialization;
				params ["_c","_f"];
				while {
					!isNull(_f getVariable ["UnitStolen",objNull]) &&
					{!((_f getVariable ["UnitStolen",objNull]) isKindOf "CAManBase")}
				} do {
					_c ctrlSetFade ([0.7,0] select (round (ctrlFade _c)));
					_c ctrlcommit 0.5;
					uisleep 0.5;
				};
				CaptureTheFlag_ui_HUD_Main_flag_dropped_handle = nil;
			};		
		};
	};
	default {};
};