/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

params ["_unit", "", "_damage","","_hitPoint","_source"];

// Unlikely but let's play safe
if (_unit != player) exitwith {};

// Are we going to die?
if (alive _unit && {_damage >= 1 && {_hitPoint == "Incapacitated" && {!NEEDS_REVIVE(_unit) && {CaptureTheFlag_info_spawned}}}}) then {
	CaptureTheFlag_info_spawned = false;
	BIS_dynamicGroups_allowInterface = false;
	_unit allowDamage false;
	_source = CaptureTheFlag_evh_forceKiller;
	private _sourceVehicle = _source getVariable ["vehicle",vehicle _sourceVehicle];

	if (isNull _source) then {
		// You fucking idiot
		[["bluforSuicide","opforSuicide"] select SIDE_INDEX_GLOBAL(_unit),[STREAM_SAFE_NAME(_unit)]] remoteExecCall ["CaptureTheFlag_c_ui_notifFeed_useTemplate",-2];
	} else {
		if (_source isEqualType objNull && {isPlayer _source}) then {
			if (_source == _unit) then {
				// :face_palm: 
				[["bluforSuicide","opforSuicide"] select SIDE_INDEX_GLOBAL(_unit),[STREAM_SAFE_NAME(_unit)]] remoteExecCall ["CaptureTheFlag_c_ui_notifFeed_useTemplate",-2];
			} else {
				if (SIDE_VAR(_unit) isequalto SIDE_VAR(_source)) then {
					// Team kill
					if ((_unit getVariable ["vehicle",vehicle _unit]) isequalto _sourceVehicle) then {
						_source = _unit;
					} else {
						[_source,[-1,0,0,0,0]] remoteExec ["addPlayerScores",2];
					};
				} else {
					// Noice!
					[_unit,[0,0,0,0,1]] remoteExec ["addPlayerScores",2];
					[_source,[1,0,0,0,0]] remoteExec ["addPlayerScores",2];
				};
				if (_source != _unit) then {
					// Send kill alert to all clients, and run some stuff on the source
					[_unit,_source,[currentWeapon _source,CaptureTheFlag_evh_forceWeaponKilled] select (CaptureTheFlag_evh_forceWeaponKilled != ""),typeof _sourceVehicle,tolower(((fullCrew _sourceVehicle select {(_x select 0)==_source})param[0,[]])param[1,""])in["driver","gunner"]] remoteExecCall ["CaptureTheFlag_c_medical_killed",-2];
				} else {
					// Not possible unless you ran yourself over
					[["bluforSuicide","opforSuicide"] select SIDE_INDEX_GLOBAL(_unit),[STREAM_SAFE_NAME(_unit)]] remoteExecCall ["CaptureTheFlag_c_ui_notifFeed_useTemplate",-2];
				};
			};
		};
	};

	// If you were carrying the flag, drop it.
	["dropFlag",[_unit,CaptureTheFlag_info_unitCarryingFlag]] call CaptureTheFlag_c_map_modifyFlag;
	["deaths"] call CaptureTheFlag_c_session_handleEvent;

	if (vehicle _unit != _unit) then {
		// Get out
		moveout _unit;
	};

	// No revives for the team killed
	if (SIDE_VAR(_unit) isEqualTo SIDE_VAR(_source)) then {
		if (getplayeruid _unit != getplayeruid _source) then {
			CaptureTheFlag_info_teamKilled = getPlayerUID _source;
		};
		_unit call CaptureTheFlag_c_medical_forceRespawn;
	};

	// I think this was to force units into the death animation if they were using a FAK when killed
	if (["medic",animationState _unit] call BIS_fnc_instring) then {
		[_unit] spawn {
			params ["_unit"];
			private _t = diag_tickTime + 5;
			waitUntil {stance _unit in ["UNDEFINED","INCAPACITATED"] OR diag_tickTime > _t};
			[_unit,"unconsciousrevivedefault"] remoteExec ["switchMove",0];
		};
	};

	// you DEAD
	_unit setUnconscious true;
	_unit switchCamera "INTERNAL"; // first person for dramatic effect
	[_unit] spawn CaptureTheFlag_c_medical_screenEffects;
};
