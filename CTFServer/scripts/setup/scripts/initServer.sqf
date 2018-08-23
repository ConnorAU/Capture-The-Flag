/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\defines.sqf"

// Client side functions init
[0,CaptureTheFlag_s_setup_initFunctions] remoteExec ["spawn",-2,true];

addMissionEventHandler ["PlayerConnected",{_this call CaptureTheFlag_s_evh_playerConnected}];
addMissionEventHandler ["PlayerDisconnected",{_this call CaptureTheFlag_s_evh_playerDisconnected}];
addMissionEventHandler ["handleDisconnect",{_this call CaptureTheFlag_s_evh_handleDisconnect;false}];

["Initialize"] call BIS_fnc_dynamicGroups;

// Settings from the config file
{
	_x params ["_var","_broadcast"];
	["Settings",format["%1 = %2",_var,[INITSERVER_SETTINGS_CFG_PATH >> _var] call BIS_fnc_getCfgData]] call CaptureTheFlag_c_system_log;
	missionNamespace setVariable ["CaptureTheFlag_serverSetting_"+_var,[INITSERVER_SETTINGS_CFG_PATH >> _var] call BIS_fnc_getCfgData,_broadcast];
}foreach[
	["maxFlagCaptures",true],
	["restartServerAfterXRounds",false],
	["teamBalanceEnabled",true],
	["teamBalancePlayerThreshold",true],
	["teamBalanceMinPlayersPerSide",true],
	["disablePlaySameMapTwiceInRow",false],
	["disableFriendlyFire",true],
	["disableVehicleThermals",true],
	["welcomeMessages",true],
	["welcomeMessageInterval",true]
];

// Broadcast rules
missionNameSpace setVariable [
	"CaptureTheFlag_serverSetting_rules",
	("true"configClasses(INITSERVER_SETTINGS_CFG_PATH >> "Rules"))apply{[getText(_x>>"title"),getText(_x>>"text")]},
	true
];

// XP and cash modifiers
missionNamespace setVariable ["CaptureTheFlag_serverSetting_currencyModifier",compilefinal "1",true];
missionNamespace setVariable ["CaptureTheFlag_serverSetting_experienceModifier",compilefinal "1",true];

// Was going to use these for an autobalance script but never got around to it.
// The idea was it stored clients in their side in the order they connected so you would boot off newer players first.
CaptureTheFlag_serverSession_westClients = [];
CaptureTheFlag_serverSession_eastClients = [];

// Restrictions that never got implemented properly
/*{
	_restrictionName = _x;
	{
		["Settings",format["%1 = %2","CaptureTheFlag_serverSetting_"+_restrictionName+"_"+configName _x,[_x] call BIS_fnc_getCfgData]] call CaptureTheFlag_c_system_log;
		missionNamespace setVariable ["CaptureTheFlag_serverSetting_"+_restrictionName+"_"+configName _x,[_x] call BIS_fnc_getCfgData,true];
	} foreach (configProperties[INITSERVER_SETTINGS_CFG_PATH >> _x,"([_x] call BIS_fnc_getCfgData) in []",true]);
} foreach ["SkillRestriction","WeaponRestriction","VehicleRestriction"];*/

// Fix for modules not hiding hidden destroyed buildings
addMissionEventHandler ["BuildingChanged",{
	params ["_previous","_current","_isRuin"];
	if (isObjectHidden _previous) then {
		if isServer then {
			_current hideObjectGlobal true;
		} else {
			_current hideObject true;
		};
	};
}];

missionNamespace setVariable ["CaptureTheFlag_setup_serverIsSetup",true,true];