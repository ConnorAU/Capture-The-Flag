/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"
if !canSuspend exitwith {_this spawn CaptureTheFlag_c_spawn_camera};

CaptureTheFlag_spawn_camera_canRespawn = false;
_this spawn {
	if CaptureTheFlag_session_firstSpawn then {
		if ((missionNamespace getVariable ["CaptureTheFlag_session_restricted",""])!="") then {
			["showNotification",[format["<t shadow=1>You are restricted for: <t color='#FF0000'>%1</t>",missionNamespace getVariable ["CaptureTheFlag_session_restricted",""]],0]] call CaptureTheFlag_c_ui_HUD_NotificationSmall;
			for "_i" from 0 to 5 do {_i enableChannel [false,false]};
			waituntil {false};
		};
	};
	["showNotification",["<t shadow=1>Press any button to continue</t>",0]] call CaptureTheFlag_c_ui_HUD_NotificationSmall;
	CaptureTheFlag_spawn_camera_canRespawn = true;
};

private _camera = "CAMERA" camCreate [0,0,1.17115];
_camera cameraEffect ["INTERNAL","BACK"];
private _targetFlag = [BLUFOR_FLAG_POLE,OPFOR_FLAG_POLE] select SIDE_INDEX;
private _camDist = 10;
private _camRotation = round random 360;
private _camDirection = [0.5,-0.5] select (round random 1);
_camera camSetTarget _targetFlag;
_camera camSetPos (_targetFlag modelToWorld [(_camDist/1.5) * sin _camRotation, (_camDist/1.5) * cos _camRotation, _camDist*0.5]);
_camera camSetFOV 1;
_camera camCommit 0;

CaptureTheFlag_spawn_camera_killSwitch = true;
CaptureTheFlag_spawn_camera_killSwitchEVH = (findDisplay 46) displayAddEventHandler ["keydown",{
	if CaptureTheFlag_spawn_camera_canRespawn then {
		(_this select 0) displayRemoveEventHandler ["keydown",CaptureTheFlag_spawn_camera_killSwitchEVH];
		[] spawn {
			disableSerialization;
			"CaptureTheFlag_FadeLayer" cutText ["","BLACK OUT",2];
			"CaptureTheFlag_FadeLayer" cutFadeOut 999999;
			["hideNotification",[2]] call CaptureTheFlag_c_ui_HUD_NotificationSmall;
			uisleep 2;
			CaptureTheFlag_spawn_camera_killSwitch = false;
		};
	};
	((_this select 1)!=1)OR!(missionNamespace getVariable ["CaptureTheFlag_session_dataRead",false])
}];

while {CaptureTheFlag_spawn_camera_killSwitch} do {
	_camRotation = _camRotation + _camDirection;
	if (true in [_camRotation>=360,_camRotation<=-360]) then {_camRotation = 0};
	_camera camSetPos (_targetFlag modelToWorld [(_camDist/1.5) * sin _camRotation, (_camDist/1.5) * cos _camRotation, _camDist*0.5]);
	_camera camCommit 0.1;
	_tick = diag_tickTime + 0.1;
	waituntil {diag_tickTime > _tick};
};

CaptureTheFlag_spawn_camera_killSwitch = nil;
CaptureTheFlag_spawn_camera_killSwitchEVH = nil;
CaptureTheFlag_spawn_camera_canRespawn = nil;
uiNamespace setVariable ["CaptureTheFlag_spawn_camera_text",nil];

_camera cameraEffect ["TERMINATE","BACK"];
camDestroy _camera;

[player] call CaptureTheFlag_c_spawn_moveToSpawn;

CaptureTheFlag_ui_headsUpIcons_hide = false;
"CaptureTheFlag_FadeLayer" cutText ["","BLACK IN",2];
