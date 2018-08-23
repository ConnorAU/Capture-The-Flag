/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

// Bad params
if (count _this < 1) exitwith {
	[] spawn {
		[] call BIS_fnc_forceEnd;
		endLoadingScreen;
		uisleep 0.1;
		endmission "dataReadError";
		failMission "dataReadError";
		uisleep 3;
		(findDisplay 46) closeDisplay 2;
	};
};

// Kick if restricted (things like team kills)
private _restricted = param [0,"",[""]];
if (_restricted != "") then {
	missionNamespace setVariable ["CaptureTheFlag_session_restricted",_restricted];
};

// Set variable with values given to us from the DB fetch
{_x params ["_var","_def"];missionNamespace setVariable [_var,param[_forEachIndex+1,_def,[_def]]];}foreach[
	["CaptureTheFlag_session_currency",0],
	["CaptureTheFlag_session_experience",0],
	["CaptureTheFlag_setting_clothing",[]],
	["CaptureTheFlag_setting_vehicles",[]],
	["CaptureTheFlag_setting_weapons",[]],
	["CaptureTheFlag_setting_skills",[]],
	["CaptureTheFlag_setting_enableEnvironment",0],
	["CaptureTheFlag_setting_showPlayerTags",0],
	["CaptureTheFlag_setting_showHitMarkers",0],
	["CaptureTheFlag_setting_terrainSmoothingMode",0],
	["CaptureTheFlag_setting_footViewDistance",0],
	["CaptureTheFlag_setting_landViewDistance",0],
	["CaptureTheFlag_setting_airViewDistance",0],
	["CaptureTheFlag_statistic_rank",0],
	["CaptureTheFlag_skill_steadyAim",0],
	["CaptureTheFlag_skill_athlete",0],
	["CaptureTheFlag_skill_ammo",0],
	["CaptureTheFlag_skill_mechanic",0],
	["CaptureTheFlag_skill_lifeSaver",0],
	["CaptureTheFlag_skill_packingHeat",0],
	["CaptureTheFlag_skill_flakJacket",0],
	["CaptureTheFlag_skill_conqueror",0]
];

// Ready to play
missionNamespace setVariable ["CaptureTheFlag_session_dataRead",true];
missionNamespace setVariable ["CaptureTheFlag_session_syncInProgress",false];