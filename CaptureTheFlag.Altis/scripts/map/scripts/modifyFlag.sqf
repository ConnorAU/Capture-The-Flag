/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\defines.sqf"
#include "..\..\defines.sqf"
#include "..\..\..\userinterface\_defines.sqf"
params [["_mode","",[""]],["_params",[],[[]]]];
_params params [["_target",objNull,[objNull]]];
_target = switch _target do {
	case BLUFOR_FLAG_BASE:{BLUFOR_FLAG_POLE};
	case OPFOR_FLAG_BASE:{OPFOR_FLAG_POLE};
	case OBJECTIVE_FLAG_BASE:{OBJECTIVE_FLAG_POLE};
	default {_target};
};

switch _mode do {
	case "ResetFlag":{
		_target setVariable ["FlagState",FLAG_STATE_ATBASE,true];
		_target setVariable ["UnitStealing",objNull,true];
		_target setVariable ["UnitStolen",objNull,true];
		_target setVariable ["SideStolen",sideUnknown,true];
		_target setVariable ["StealSpeed",nil,true];
	};

	case "StartSteal":{
		_target setVariable ["FlagState",FLAG_STATE_STEALING,true];
		_target setVariable ["UnitStealing",player,true];
		_target setVariable ["StealSpeed",10*(["modifier",["stealFlag"]] call CaptureTheFlag_c_ui_holdAction),true];
	};
	case "InteruptSteal":{
		_target setVariable ["FlagState",FLAG_STATE_ATBASE,true];
		_target setVariable ["UnitStealing",objNull,true];
		_target setVariable ["StealSpeed",nil,true];
	};


	case "checkStealConditionShow":{
		vehicle player isequalto player && 
		{
			stance player in PERMITTED_STANCES && 
			{
				isNull CaptureTheFlag_info_unitCarryingFlag && 
				{
					cursorObject isequalto (_target getVariable ["FlagBase",objNull]) && 
					{
						isNull(_target getVariable ["UnitStolen",objNull]) && 
						{
							(_target getVariable ["FlagState",""]) == FLAG_STATE_ATBASE OR 
							(
							 	(_target getVariable ["FlagState",""]) == FLAG_STATE_STEALING &&
								(_target getVariable ["UnitStealing",objNull]) isEqualTo player
							)
						}
					}
				}
			}
		}
	};
	case "checkPickupConditionShow":{
		private _targetParent = _target getVariable ["FlagParent",objNull];
		(
			!isNull _targetParent && 
			{
				vehicle player isequalto player && 
				{
					stance player in PERMITTED_STANCES && 
					{
						isNull CaptureTheFlag_info_unitCarryingFlag && 
						{
							(_targetParent getVariable ["UnitStolen",objNull]) isequalto _target && 
							{
								(_targetParent getVariable ["FlagState",""]) == FLAG_STATE_STOLEN && 
								{
									(_targetParent getVariable ["SideStolen",sideUnknown]) isEqualTo SIDE_VAR(player) && 
									{
										player distance2D (_params param [0,_target]) <= 3 && 
										{
											[_target,[SZ_X_OFFSET(0.25),SZ_X_OFFSET(0.75)],[SZ_Y,SZ_Y_OFFSET(1)]] call CaptureTheFlag_c_system_objInScreenZone
										}
									}
								}
							}
						}
					}
				}
			}
		)
	};
	case "checkReturnConditionShow":{
		private _targetParent = _target getVariable ["FlagParent",objNull];
		(
			!isNull _targetParent && 
			{
				vehicle player isequalto player && 
				{
					stance player in PERMITTED_STANCES && 
					{
						isNull CaptureTheFlag_info_unitCarryingFlag && 
						{
							(_targetParent getVariable ["UnitStolen",objNull]) isequalto _target && 
							{
								(_targetParent getVariable ["FlagState",""]) == FLAG_STATE_STOLEN && 
								{
									!((_targetParent getVariable ["SideStolen",sideUnknown]) isEqualTo SIDE_VAR(player)) && 
									{
										player distance2D (_params param [0,_target]) <= 3 && 
										{
											[_target,[SZ_X_OFFSET(0.25),SZ_X_OFFSET(0.75)],[SZ_Y,SZ_Y_OFFSET(1)]] call CaptureTheFlag_c_system_objInScreenZone
										}
									}
								}
							}
						}
					}
				}
			}
		)
	};
	case "checkCaptureConditionShow":{
		vehicle player isequalto player &&
		{
			stance player in PERMITTED_STANCES && 
			{
				!isNull CaptureTheFlag_info_unitCarryingFlag
			}
		}
	};
	case "checkProgressCondition":{
		vehicle player isequalto player &&
		{
			stance player in PERMITTED_STANCES && 
			{
				player distance2D (_params param [0,_target]) <= 3
			}
		}
	};


	case "CompletedSteal":{
		_target setVariable ["FlagState",FLAG_STATE_STOLEN,true];
		_target setVariable ["UnitStealing",objNull,true];
		_target setVariable ["UnitStolen",player,true];
		_target setVariable ["SideStolen",SIDE_VAR(player),true];

		CaptureTheFlag_info_unitCarryingFlag = _target;
		player forceFlagTexture (_target getVariable ["FlagTexture",""]);
		[["bluforEvent","opforEvent"] select SIDE_INDEX,["have stolen the flag"]] remoteExecCall ["CaptureTheFlag_c_ui_notifFeed_useTemplate",-2];
		["showNotification",[format["<t color='#%2'>%1</t> have stolen the flag",["Blufor","Opfor"] select SIDE_INDEX,["11B8EC","bf0000"] select SIDE_INDEX],1,5]] remoteExecCall ["CaptureTheFlag_c_ui_HUD_notificationBig",-2];
		["flag_steals"] call CaptureTheFlag_c_session_handleEvent;
	};
	case "CompletedPickup":{
		private _targetParent = _target getVariable ["FlagParent",objNull];
		_targetParent setVariable ["UnitStolen",player,true];
		CaptureTheFlag_info_unitCarryingFlag = _targetParent;
		player forceFlagTexture (_targetParent getVariable ["FlagTexture",""]);
		deleteVehicle _target;
		[["bluforEvent","opforEvent"] select SIDE_INDEX,["have picked up the flag"]] remoteExecCall ["CaptureTheFlag_c_ui_notifFeed_useTemplate",-2];
		["showNotification",[format["<t color='#%2'>%1</t> have picked up the flag",["Blufor","Opfor"] select SIDE_INDEX,["11B8EC","bf0000"] select SIDE_INDEX],1,5]] remoteExecCall ["CaptureTheFlag_c_ui_HUD_notificationBig",-2];
		["flag_pickups"] call CaptureTheFlag_c_session_handleEvent;
	};
	case "CompletedReturn":{
		private _targetParent = _target getVariable ["FlagParent",objNull];
		deleteVehicle _target;
		["ResetFlag",[_targetParent]] call CaptureTheFlag_c_map_modifyFlag;
		[["bluforEvent","opforEvent"] select SIDE_INDEX,["have returned the flag"]] remoteExecCall ["CaptureTheFlag_c_ui_notifFeed_useTemplate",-2];
		["showNotification",[format["<t color='#%2'>%1</t> have returned the flag",["Blufor","Opfor"] select SIDE_INDEX,["11B8EC","bf0000"] select SIDE_INDEX],1,5]] remoteExecCall ["CaptureTheFlag_c_ui_HUD_notificationBig",-2];
		["flag_returns"] call CaptureTheFlag_c_session_handleEvent;
	};
	case "CompletedCapture":{
		if (isNull CaptureTheFlag_info_unitCarryingFlag) exitwith {};
		player forceFlagTexture "";
		["ResetFlag",[CaptureTheFlag_info_unitCarryingFlag]] call CaptureTheFlag_c_map_modifyFlag;
		CaptureTheFlag_info_unitCarryingFlag = objNull;

		private _v = ["CaptureTheFlag_info_blufor_flag_captures","CaptureTheFlag_info_opfor_flag_captures"] select SIDE_INDEX;
		missionNamespace setVariable [_v,(missionNamespace getVariable [_v,0])+1,true];

		["flag_captures"] call CaptureTheFlag_c_session_handleEvent;
		["flag_team_capture_bonus"] remoteexeccall ["CaptureTheFlag_c_session_handleEvent",allPlayers select {alive _x && {!(_x isequalto player) && {SIDE_VAR(_x) isequalto SIDE_VAR(player)}}}]; 
	};


	case "dropFlag":{
		_params params [
			["_unit",objNull,[objNull]],
			["_flag",objNull,[objNull]]
		];
		if (objNull in [_unit,_flag]) exitwith {};
		_unit forceFlagTexture "";
		if (vehicle _unit != _unit) then {vehicle _unit forceFlagTexture "";};
		if ([_unit,AO_MARKER] call CaptureTheFlag_c_system_inArea) then {
			if (
			    	(getposatl _unit) call CaptureTheFlag_c_system_surfaceIsWater OR 
			    	{
			    		[_unit,BLUFOR_SAFE_ZONE] call CaptureTheFlag_c_system_inArea OR 
			    		{
			    			[_unit,OPFOR_SAFE_ZONE] call CaptureTheFlag_c_system_inArea
			    		}
			    	}
			    ) then {
				["ResetFlag",[_flag]] call CaptureTheFlag_c_map_modifyFlag;
				[["opforEvent","bluforEvent"] select SIDE_INDEX_GLOBAL(_unit),["have returned their flag"]] remoteExecCall ["CaptureTheFlag_c_ui_notifFeed_useTemplate",-2];
				["showNotification",[format["<t color='#%2'>%1</t> have returned the flag",["Opfor","Blufor"] select SIDE_INDEX_GLOBAL(_unit),["bf0000","11B8EC"] select SIDE_INDEX_GLOBAL(_unit)],1,5]] remoteExecCall ["CaptureTheFlag_c_ui_HUD_notificationBig",-2];
			} else {
				private _flagTexture = _flag getVariable ["FlagTexture",""];
				private _droppedFlag = createvehicle ["FlagChecked_F",getposasl _unit,[],0,["NONE","CAN_COLLIDE"] select (vehicle _unit == _unit)];
				_droppedFlag allowDamage false;
				_droppedFlag setPosATL ((getPos _droppedFlag select [0,2])+[if (vehicle _unit == _unit) then {getposatl _unit select 2} else {0}]);
				_droppedFlag setFlagTexture _flagTexture;
				_droppedFlag setVariable ["FlagParent",_flag,true];
				_flag setVariable ["UnitStolen",_droppedFlag,true];
				[["bluforEvent","opforEvent"] select SIDE_INDEX_GLOBAL(_unit),["have dropped the flag"]] remoteExecCall ["CaptureTheFlag_c_ui_notifFeed_useTemplate",-2];
				["showNotification",[format["<t color='#%2'>%1</t> have dropped the flag",["Blufor","Opfor"] select SIDE_INDEX_GLOBAL(_unit),["11B8EC","bf0000"] select SIDE_INDEX_GLOBAL(_unit)],1,5]] remoteExecCall ["CaptureTheFlag_c_ui_HUD_notificationBig",-2];
				["flag_drops"] call CaptureTheFlag_c_session_handleEvent;
			};
		} else {
			["ResetFlag",[_flag]] call CaptureTheFlag_c_map_modifyFlag;
			[["opforEvent","bluforEvent"] select SIDE_INDEX_GLOBAL(_unit),["have returned their flag"]] remoteExecCall ["CaptureTheFlag_c_ui_notifFeed_useTemplate",-2];
		};
		if (_unit == player) then {CaptureTheFlag_info_unitCarryingFlag = objNull;};
	};


	case "FlagUpdateClient":{
		switch (_target getVariable ["FlagState",FLAG_STATE_ATBASE]) do {
			case FLAG_STATE_ATBASE:{
				if (flagAnimationPhase _target < 1) then {
					if !(missionNamespace getVariable ["CaptureTheFlag_map_flagGoingUp_"+netid _target,false]) then {
						missionNamespace setVariable ["CaptureTheFlag_map_flagGoingUp_"+netid _target,true];
						private _h = [_target,0.1,1] spawn CaptureTheFlag_c_map_animateFlag;
						[_h,netid _target] spawn {
							waituntil {scriptDone (_this select 0)};
							missionNamespace setVariable ["CaptureTheFlag_map_flagGoingUp_"+(_this select 1),false];
						};
					};
				};
				["flag_atBase",[_target]] call CaptureTheFlag_c_ui_HUD_Main;
			};
			case FLAG_STATE_STEALING:{
				if (flagAnimationPhase _target > 0) then {
					if !(missionNamespace getVariable ["CaptureTheFlag_map_flagGoingDown_"+netid _target,false]) then {
						missionNamespace setVariable ["CaptureTheFlag_map_flagGoingDown_"+netid _target,true];
						private _h = [_target,_target getVariable ["StealSpeed",10],0] spawn CaptureTheFlag_c_map_animateFlag;
						[_h,netid _target] spawn {
							waituntil {scriptDone (_this select 0)};
							missionNamespace setVariable ["CaptureTheFlag_map_flagGoingDown_"+(_this select 1),false];
						};
					};
				};
				["flag_stealingInProgress",[_target]] call CaptureTheFlag_c_ui_HUD_Main;
			};
			case FLAG_STATE_STOLEN:{
				[["flag_dropped","flag_onMove"] select ((_target getVariable ["UnitStolen",objNull]) isKindOf "CAManBase"),[_target]] call CaptureTheFlag_c_ui_HUD_Main;
			};
			default {};
		};	
	};
	case "FlagUpdateServer":{
		switch (_target getVariable ["FlagState",""]) do {
			case FLAG_STATE_ATBASE;
			case FLAG_STATE_STEALING:{
				if ("" in [_target getVariable ["FlagTexture","no"],flagTexture _target]) then {
					_target setFlagTexture (_target getVariable ["FlagTexture",""]);
				};
			};
			case FLAG_STATE_STOLEN:{
				if !("" in [_target getVariable ["FlagTexture","no"],flagTexture _target]) then {
					_target setFlagTexture "";
				};
			};
			default {
				_target setVariable ["FlagTexture",flagTexture _target,true];
				_target setVariable ["FlagState",FLAG_STATE_ATBASE,true];
			};
		};
	};

	// No
	default {false};
};