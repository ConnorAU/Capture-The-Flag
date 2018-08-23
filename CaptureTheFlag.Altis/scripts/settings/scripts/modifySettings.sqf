/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\defines.sqf"

CaptureTheFlag_settings_modified = true;
params ["_mode","_params"];
_params params ["_ctrl","_bool"];
switch _mode do {
	case "viewDistance":{
		private _ctrlDisplay = _ctrl getVariable ["displayCtrl",controlNull];
		private _value = parseNumber (ctrlText _ctrlDisplay);
		_value = 200 max (_value + ([-50,50] select _bool)) min 12000;
		_ctrlDisplay ctrlSetText str _value;

		private _var = _ctrlDisplay getVariable ["type",""];
		missionNamespace setVariable ["CaptureTheFlag_setting_"+_var+"ViewDistance",_value];

		[] call CaptureTheFlag_c_settings_applyViewDistance;
	};
	case "terrainGrid":{
		private _ctrlDisplay = _ctrl getVariable ["displayCtrl",controlNull];
		private _value = ctrlText _ctrlDisplay;

		private _index = [_value,TERRAIN_GRID_OPTIONS] call CaptureTheFlag_c_system_findInArray;
		_index = 0 max (_index+([1,-1] select _bool)) min 4;

		CaptureTheFlag_setting_terrainSmoothingMode = _index;
		_ctrlDisplay ctrlSetText ((TERRAIN_GRID_OPTIONS select _index) select 1);
		[] call CaptureTheFlag_c_settings_applyTerrainGrid;
	};
	case "enableEnvironment":{
		CaptureTheFlag_setting_enableEnvironment = _bool;
		enableEnvironment (_bool call CaptureTheFlag_c_system_toBool);
	};
	case "showPlayerTags":{
		CaptureTheFlag_setting_showPlayerTags = _bool;
	};
	case "showHitMarkers":{
		CaptureTheFlag_setting_showHitMarkers = _bool;
	};
	default {};
};