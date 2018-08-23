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

private _display = uiNameSpace getVariable ["CaptureTheFlag_HUD_Watermark",controlNull];

switch _mode do {
	case "init":{
		_params params [["_display",controlNull,[controlNull]]];
		if !(isNull _display) then {
			uiNameSpace setVariable ["CaptureTheFlag_HUD_Watermark",_display];
		};

		(_display controlsGroupCtrl 1) ctrlSetText "resources\images\saving.paa";
	};
	case "updateIcons":{
		// Only reson this is in this script is because they share a display and I never ended up splitting them
		private _ctrl = controlNull;
		private _ctrlID = 4;
		{
			_x params [["_condition",false,[true]],["_code",{},[{}]]];
			_ctrl = _display controlsGroupCtrl _ctrlID;
			if _condition then {
				_ctrl call _code;
				_ctrl ctrlShow true;
				_ctrlID = _ctrlID - 1;
			};
		} foreach [
			// Loads these from right to left
			[
				(CaptureTheFlag_setting_skills param [1,"",[""]]) != "",
				{
					_this ctrlSetAngle [0,0.5,0.5];
					_this ctrlSetText getText(missionConfigFile >> "CfgScripts" >> "skill" >> "configs" >> "SkillsInfo" >> (CaptureTheFlag_setting_skills param [1,"",[""]]) >> "image");
				}
			],
			[
				(CaptureTheFlag_setting_skills param [0,"",[""]]) != "",
				{
					_this ctrlSetAngle [0,0.5,0.5];
					_this ctrlSetText getText(missionConfigFile >> "CfgScripts" >> "skill" >> "configs" >> "SkillsInfo" >> (CaptureTheFlag_setting_skills param [0,"",[""]]) >> "image");
				}
			],
			[
				CaptureTheFlag_info_earplugsIn,
				{
					_this ctrlSetAngle [0,0.5,0.5];
					_this ctrlSetText "resources\images\mute.paa";
				}
			],
			[
				CaptureTheFlag_session_syncInProgress,
				{
					_this ctrlSetAngle [diag_ticktime*100%360,0.5,0.5];
					_this ctrlSetText "resources\images\saving.paa";
				}
			]
		];
		for "_i" from _ctrlID to 1 step -1 do {
			// Hide unused image controls (if there are any)
			_ctrl = _display controlsGroupCtrl _i;
			_ctrl ctrlShow false;
			_ctrl ctrlSetAngle [0,0.5,0.5];
		};
	};
	default {};
}; 