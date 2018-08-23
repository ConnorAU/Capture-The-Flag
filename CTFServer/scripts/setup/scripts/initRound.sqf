/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\defines.sqf"

["Round Setup","Started"] call CaptureTheFlag_c_system_log;


// ~~ Selecting Map
private _lastMap = uinameSpace getVariable ["CaptureTheFlag_info_lastMap",""];
private _allMaps = [];
{
	if (getNumber(_x >> "mapTickets") > 0) then {
		for "_i" from 1 to getNumber(_x >> "mapTickets") do {
			_allMaps pushback (configName _x);
		};
	};
}foreach ("true" configClasses (INITROUND_MAP_CFG_PATH));
if (CaptureTheFlag_serverSetting_disablePlaySameMapTwiceInRow call CaptureTheFlag_c_system_toBool && {count _allMaps > 1}) then {
	_allMaps = _allMaps - [_lastMap];
};

private _selectedMap = selectRandom _allMaps;
if (isNil "_selectedMap") then {
	_selectedMap = uinameSpace getVariable ["CaptureTheFlag_info_lastMap",""];
};
["Round Setup","Previous Map: "+_lastMap] call CaptureTheFlag_c_system_log;
["Round Setup","Current Map: "+_selectedMap] call CaptureTheFlag_c_system_log;
private _loadMapTick = diag_ticktime;
["Round Setup",(["Failed to load map: ","Successfully loaded map: "]select([_selectedMap] call CaptureTheFlag_s_map_loadMapFromFile))+_selectedMap] call CaptureTheFlag_c_system_log;
["Round Setup","Time elapsed: "+str(diag_ticktime-_loadMapTick)+" seconds"] call CaptureTheFlag_c_system_log;
with uiNamespace do {
	CaptureTheFlag_info_lastMap = _selectedMap;
	if (isNil "CaptureTheFlag_info_roundsPlayed") then {CaptureTheFlag_info_roundsPlayed = 0};
	CaptureTheFlag_info_roundsPlayed = CaptureTheFlag_info_roundsPlayed + 1;
};


// ~~ Select Time
private _allTimes = [];
{
	if (getNumber(_x) > 0) then {
		for "_i" from 1 to getNumber(_x) do {
			_allTimes pushback ([configName _x,"Tickets",""] call CaptureTheFlag_c_system_replaceInString);
		};
	};
}foreach (configProperties[INITROUND_MAP_CFG_PATH >> _selectedMap >> "times","true",true]);


private _selectedTime = selectRandom _allTimes;

["Round Setup","Setting Time: "+_selectedTime] call CaptureTheFlag_c_system_log;
setDate (getArray(INITROUND_TIME_CFG_PATH >> "date")+getArray(INITROUND_TIME_CFG_PATH >> _selectedTime));
setTimeMultiplier 0;

// ~~ Set public variable evh code
private _pvarServerCode = {
	_this spawn {
		params ["_var","_value"];
		[_var,_value] remoteExecCall ["CaptureTheFlag_c_system_flagCaptured",-2];
		if (_value >= CaptureTheFlag_serverSetting_maxFlagCaptures) then {
			["update"] call CaptureTheFlag_s_round_manageDBStats;
			["end",true] call CaptureTheFlag_s_round_manageDBStats;
			private _restartingServer = (uiNamespace getVariable ["CaptureTheFlag_info_roundsPlayed",1]) >= CaptureTheFlag_serverSetting_restartServerAfterXRounds;
			if _restartingServer then {
				uisleep 5;
				for "_i" from 1 to 3 do {
					[[],{["default",["This server is about to perform a hard restart"]]call CaptureTheFlag_c_ui_notifFeed_useTemplate}] remoteExec ["CaptureTheFlag_c_system_JIPcall",-2,true];
				};
				uisleep 10;
				saveProfileNamespace; // ensure pdb is saved
				uiSleep 5;
				// TCAdmin will auto restart from a detected "process crash"
				getText(configFile >> "CfgCTFSettings" >> "keysToTheKingdom") serverCommand "#shutdown"; 
				//getText(configFile >> "CfgCTFSettings" >> "keysToTheKingdom") serverCommand "#restartServer"; 
			} else {
				//getText(configFile >> "CfgCTFSettings" >> "keysToTheKingdom") serverCommand format["#mission %1.%2 CaptureTheFlag",missionname,worldname]; 
				uisleep 15;
				saveProfileNamespace; // ensure pdb is saved
				uiSleep 5;
				endMission "end1";
			};
		} else {
			["update"] call CaptureTheFlag_s_round_manageDBStats;
		};
	};
};

// Set public variables and related eventhandler code
{
	_x params [["_var","",[""]],["_val",0],["_sevh",{},[{}]],["_cevh",{},[{}]]];
	missionNamespace setVariable [_var,_val,true];
	if (str _sevh != "{}") then {
		_var addPublicVariableEventHandler _sevh;
	};
	if (str _cevh != "{}") then {
		[[_var,_cevh],{(_this select 0) addPublicVariableEventHandler (_this select 1)}] remoteExec ["CaptureTheFlag_c_system_JIPcall",-2,true];
	};
}foreach [
	["CaptureTheFlag_info_blufor_flag_captures",0,_pvarServerCode],
	["CaptureTheFlag_info_opfor_flag_captures",0,_pvarServerCode],
	["CaptureTheFlag_info_playerCountWestMax",0],
	["CaptureTheFlag_info_playerCountEastMax",0]
];

// Default value
BLUFOR_FLAG_POLE setVariable ["FlagBase",BLUFOR_FLAG_BASE,true];
OPFOR_FLAG_POLE setVariable ["FlagBase",OPFOR_FLAG_BASE,true];
OBJECTIVE_FLAG_POLE setVariable ["FlagBase",OBJECTIVE_FLAG_BASE,true];

// Free side vehicle
["ZAMAK_TRANSPORT",west,false] spawn CaptureTheFlag_s_round_spawnFreeVehicle;
["ZAMAK_TRANSPORT",east,false] spawn CaptureTheFlag_s_round_spawnFreeVehicle;

// Wait to start the round until players connect, then run repetitive tasks
CaptureTheFlag_setup_roundMonitor = _selectedMap spawn {
	scriptName "CaptureTheFlag: Monitor";
	private _roundStart = {
		missionNamespace setVariable ["CaptureTheFlag_info_roundStartTick",time+(1.5*60),true];
		waitUntil {time > CaptureTheFlag_info_roundStartTick};
		["init",_this] call CaptureTheFlag_s_round_manageDBStats;

	};
	while {true} do {
		waitUntil {count playableUnits > 0};
		_init = _this spawn _roundStart;
		waitUntil {count playableUnits < 1 OR scriptDone _init};
		if (scriptDone _init) exitwith {};
		terminate _init;
		missionNamespace setVariable ["CaptureTheFlag_info_roundStartTick",nil,true];
	};
	waituntil {
		["FlagUpdateServer",[OBJECTIVE_FLAG_POLE]] call CaptureTheFlag_c_map_modifyFlag;
		[3] call CaptureTheFlag_s_round_freeVehicleIdleManager;
		[] call CaptureTheFlag_s_round_vehicleClutterMonitor;
		//[] call CaptureTheFlag_s_round_autoTeamBalance;
		false;
	};
};

["Round Setup","Complete"] call CaptureTheFlag_c_system_log;
