/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

private _unit = param [0,player,[objNull]];
if (isNull _unit OR {!local _unit}) exitwith {};

[] call CaptureTheFlag_c_skill_reload;
[
	CaptureTheFlag_setting_clothing,
	CaptureTheFlag_setting_weapons
] call CaptureTheFlag_c_setup_setLoadout;

private _logic = ([BLUFOR_UNIT_SPAWN,OPFOR_UNIT_SPAWN] select SIDE_INDEX);
_unit setposatl getposatl _logic;
_unit setdir getdir _logic;

CaptureTheFlag_info_spawned = true;
BIS_dynamicGroups_allowInterface = true;

["addTemplate",[_unit,"forceRespawn"]] call CaptureTheFlag_c_ui_holdAction;
["addTemplate",[_unit,"executeTarget"]] call CaptureTheFlag_c_ui_holdAction;
["addTemplate",[_unit,"lockVehicle"]] call CaptureTheFlag_c_ui_holdAction;
["addTemplate",[_unit,"unlockVehicle"]] call CaptureTheFlag_c_ui_holdAction;
["addTemplate",[_unit,"repairAndRearmVehicle"]] call CaptureTheFlag_c_ui_holdAction;
["addTemplate",[_unit,"unflipVehicle"]] call CaptureTheFlag_c_ui_holdAction;
["addTemplate",[_unit,"reviveTeammate"]] call CaptureTheFlag_c_ui_holdAction;
["addTemplate",[_unit,"repairVehicle"]] call CaptureTheFlag_c_ui_holdAction;
["addTemplate",[_unit,"pickupFlag"]] call CaptureTheFlag_c_ui_holdAction;
["addTemplate",[_unit,"returnFlag"]] call CaptureTheFlag_c_ui_holdAction;

[[_unit],{_this call CaptureTheFlag_c_evh_addGlobalEVHs}] remoteExec ["CaptureTheFlag_c_system_JIPcall",-2,_unit];
["load"] spawn CaptureTheFlag_c_system_handleTeamKill;

if CaptureTheFlag_session_firstSpawn then {
	CaptureTheFlag_session_firstSpawn = false;

	_unit setVariable ["name",name _unit,true];
	_unit setVariable ["side",playerSide,true];
	_unit setVariable ["rank",CaptureTheFlag_statistic_rank,true];

	_unit addEventHandler ["getInMan",{_this call CaptureTheFlag_c_evh_getInMan}];
	_unit addEventHandler ["getOutMan",{_this call CaptureTheFlag_c_evh_getOutMan}];
	_unit addEventHandler ["handleDamage",{_this call CaptureTheFlag_c_evh_handleDamage}];
	_unit addEventHandler ["dammaged",{_this call CaptureTheFlag_c_evh_dammaged}];
	_unit addEventHandler ["respawn",{_this call CaptureTheFlag_c_evh_respawn}];
	_unit addEventHandler ["hitPart",{_this call CaptureTheFlag_c_evh_hitPart}];
	_unit addEventHandler ["firedMan",{_this call CaptureTheFlag_c_evh_firedMan}];
	_unit addEventHandler ["inventoryOpened",{_this call CaptureTheFlag_c_evh_inventoryOpened}];
	
	[] spawn {
		["CaptureTheFlag_UI_ControlsAndRules"] call CaptureTheFlag_c_ui_createDialog;
		uisleep 0.5;
		{
			["Default",[_x]] call CaptureTheFlag_c_ui_notifFeed_useTemplate;
			uisleep CaptureTheFlag_serverSetting_welcomeMessageInterval;
		} foreach CaptureTheFlag_serverSetting_welcomeMessages;
	};
};