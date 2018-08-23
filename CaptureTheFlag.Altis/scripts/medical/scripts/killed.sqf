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
	["_unit",objNull,[objNull]],
	["_source",objNull,[objNull]],
	["_sourceWeapon","",[""]],
	["_sourceVehicle","",[""]],
	["_sourceUsedVehicleWeapon",false,[true]]
];
if (objNull in [_unit,_source]) exitwith {};
if (-1 in [SIDE_INDEX_GLOBAL(_unit),SIDE_INDEX_GLOBAL(_source)]) exitwith {};
if !(_sourceVehicle isKindOf "CAManBase") then {
	if _sourceUsedVehicleWeapon then {
		_sourceWeapon = _sourceVehicle;
	};
};
private _sourceWeaponImage = [_sourceWeapon,"picture",""] call CaptureTheFlag_c_system_searchConfigFile;
if (_sourceWeaponImage == "") then {_sourceWeaponImage = "resources\images\skull.paa"};

[
	[
		["bluforKillBlufor","bluforKillOpfor"] select SIDE_INDEX_GLOBAL(_unit),
		["opforKillBlufor","opforKillOpfor"] select SIDE_INDEX_GLOBAL(_unit)
	] select SIDE_INDEX_GLOBAL(_source),
	[
		STREAM_SAFE_NAME(_source),
		STREAM_SAFE_NAME(_unit),
		ceil(_unit distance _source) call CaptureTheFlag_c_system_numberText,
		_sourceWeaponImage
	]
] call CaptureTheFlag_c_ui_notifFeed_useTemplate;
if (SIDE_VAR(_unit) != SIDE_VAR(_source)) then {
	if (_source isEqualTo player) then {
		["kills_normal"] call CaptureTheFlag_c_session_handleEvent;
		[] call CaptureTheFlag_c_session_killStreak;
		if isClass(configFile >> "CfgVehicles" >> _sourceWeapon) then {
			["kills_roadkill"] call CaptureTheFlag_c_session_handleEvent;
		};
		if (_unit getVariable ["CaptureTheFlag_unit_headshot",false]) then {
			["kills_headshot"] call CaptureTheFlag_c_session_handleEvent;
		};
		if ((_unit getVariable ["CaptureTheFlag_unit_distance",0])>=500) then {
			["kills_longdistance"] call CaptureTheFlag_c_session_handleEvent;
		};
		_source setVariable ["CaptureTheFlag_unit_lastKill",time+3.5];
	} else {
		if (_unit getVariable ["CaptureTheFlag_unit_hit",false]) then {
			["kills_assist"] call CaptureTheFlag_c_session_handleEvent;
		} else {
			if (
			    SIDE_VAR(_source) isequalto SIDE_VAR(player) && 
			    {
					(vehicle _source) isequalto (vehicle player) && 
					{
						driver (vehicle player) isequalto player
					}
			    }
			) then {
				["kills_assist_driver"] call CaptureTheFlag_c_session_handleEvent;
			};
		};
	};
	if (_unit isequalto player) then {
		if ((_unit getVariable ["CaptureTheFlag_unit_lastKill",0])>time) then {
			["kills_avenger"] remoteExecCall ["CaptureTheFlag_c_session_handleEvent",_source];
		};
	};
} else {
	if (_source isEqualTo player) then {
		["Default",["Watch your fire! <t color='#FF0000'>Team killing</t> is prohibited."]] call CaptureTheFlag_c_ui_notifFeed_useTemplate;
	};
};
{_unit setVariable [_x,nil]} foreach [
	"CaptureTheFlag_unit_hit",
	"CaptureTheFlag_unit_headshot",
	"CaptureTheFlag_unit_distance",
	"CaptureTheFlag_unit_lastKill"
];