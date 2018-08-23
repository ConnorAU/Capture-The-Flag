/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"
#define PROFILE_COLOURS [\
	profilenamespace getvariable ["GUI_BCG_RGB_R",0.77],\
	profilenamespace getvariable ["GUI_BCG_RGB_G",0.51],\
	profilenamespace getvariable ["GUI_BCG_RGB_B",0.08]\
]

params [["_event","",[""]],["_params",[]]];

private _eventsDirectory = missionConfigFile >> "CfgScripts" >> "Session" >> "configs" >> "Events";
if !(isClass(_eventsDirectory >> _event)) exitwith {};

// Calculate cash and xp rewards for this event
private _text = getText(_eventsDirectory >> _event >> "text");
private _currency = round((getNumber(_eventsDirectory >> _event >> "currency")*(_params call compile getText(_eventsDirectory >> _event >> "currencyModifier")))*(call CaptureTheFlag_serverSetting_currencyModifier));
private _experience = round((getNumber(_eventsDirectory >> _event >> "experience")*(_params call compile getText(_eventsDirectory >> _event >> "experienceModifier")))*(call CaptureTheFlag_serverSetting_experienceModifier));

// Decide if we need to notify the player and which format to use
private _notification = switch true do {
	case ((_currency > 0) && (_experience > 0)):{["addCandE",[
		_text,
		_experience call CaptureTheFlag_c_system_numberText,
		PROFILE_COLOURS call BIS_fnc_colorRGBtoHTML,
		_currency call CaptureTheFlag_c_system_numberText
	]]};
	case ((_currency > 0) && (_experience <= 0)):{["addCurrency",[_text,_currency call CaptureTheFlag_c_system_numberText]]};
	case ((_currency <= 0) && (_experience > 0)):{["addExperience",[_text,_experience call CaptureTheFlag_c_system_numberText,PROFILE_COLOURS call BIS_fnc_colorRGBtoHTML]]};
	default {0};
};
if (_notification isEqualType [] && {_text != ""}) then {
	_notification call CaptureTheFlag_c_ui_notifFeed_useTemplate;
};

// Add the cash
if (_currency > 0) then {
	[_currency] call CaptureTheFlag_c_session_currency;
};

// Add the xp
if (_experience > 0) then {
	CaptureTheFlag_session_experience = CaptureTheFlag_session_experience + _experience;

	// Rank up boizzz
	if (CaptureTheFlag_session_experience>=(CaptureTheFlag_statistic_rank*EXP_PER_RANK)) then {
		CaptureTheFlag_session_experience = (CaptureTheFlag_session_experience - (CaptureTheFlag_statistic_rank*EXP_PER_RANK))max 0;
		["rank"] call CaptureTheFlag_c_session_handleEvent;
	};
	CaptureTheFlag_session_writePlayerData = true;
	["updateXP"] call CaptureTheFlag_c_ui_HUD_Main;
};

// Add statistic if condition is met
if (_params call compile getText(_eventsDirectory >> _event >> "statCondition")) then {
	[_event] call CaptureTheFlag_c_session_writeStat;
	_params call compile getText(_eventsDirectory >> _event >> "statExpression");
};