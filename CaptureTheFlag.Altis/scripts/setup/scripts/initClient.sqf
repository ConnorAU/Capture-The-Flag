/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

// can't join if the round has ended
if (
    CaptureTheFlag_info_blufor_flag_captures>=CaptureTheFlag_serverSetting_maxFlagCaptures OR 
    CaptureTheFlag_info_opfor_flag_captures>=CaptureTheFlag_serverSetting_maxFlagCaptures
) exitwith {END_MISSION_SAFE("roundOver");};

// This team balance works but before the round start is ignored because slow pc's would fuck the fast pc's when loading in from a soft restart
if (
	(CaptureTheFlag_serverSetting_teamBalanceEnabled call CaptureTheFlag_c_system_toBool) && 
    {
    	time>(missionnamespace getVariable ["CaptureTheFlag_info_roundStartTick",time+1]) && 
    	{
    		/*({SIDE_VAR(_x) isequalto SIDE_VAR(player)} count playableUnits) >= CaptureTheFlag_serverSetting_teamBalanceMinPlayersPerSide*/true && 
    		{
    			(
    			 	[
    			 		({SIDE_VAR(_x) isequalto west} count playableUnits)-({SIDE_VAR(_x) isequalto east} count playableUnits),
    			 		({SIDE_VAR(_x) isequalto east} count playableUnits)-({SIDE_VAR(_x) isequalto west} count playableUnits)
    			 	] select SIDE_INDEX
    			) > CaptureTheFlag_serverSetting_teamBalancePlayerThreshold
    		}
    	}
    }
) exitwith {END_MISSION_SAFE("teamBalance");};

// pretty sure grpNull has the same effect, maybe i did it like this for the autodelete?
[player] joinSilent (createGroup [playerSide,true]);
1 preloadObject player;

enableSentences false;
enableRadio false;
showSubtitles false;
showChat true;
enableSaving[false,false];
player disableConversation true;
inGameUISetEventHandler ["PrevAction", ""];
inGameUISetEventHandler ["Action", ""];
inGameUISetEventHandler ["NextAction", ""];

{_foreachindex enableChannel _x}foreach[
	[true,false],
	[true,true],
	[false,false],
	[true,true],
	[true,true],
	[true,true]
];

// Is supposed to mute the NPCs
{_x setSpeaker "NoVoice"}foreach (allUnits select {!isPlayer _x});

waituntil {!isNull(findDisplay 46)};

CaptureTheFlag_evh_blockOpenPause = false;
CaptureTheFlag_evh_forceKiller = objNull;
CaptureTheFlag_evh_forceWeaponKilled = "";
//CaptureTheFlag_evh_keyDownBlock = false;
CaptureTheFlag_info_playerUID = getPlayerUID player;
CaptureTheFlag_info_unitCarryingFlag = objNull;
CaptureTheFlag_info_spawned = false;
CaptureTheFlag_info_earplugsIn = false;
CaptureTheFlag_info_splashDamage = false;
CaptureTheFlag_session_killFeedTick = diag_ticktime;
CaptureTheFlag_session_killFeedCount = 0;
CaptureTheFlag_session_writePlayerData = false;
CaptureTheFlag_session_joinTick = time;
CaptureTheFlag_session_lastMovementTick = diag_ticktime;
CaptureTheFlag_session_firstSpawn = true;
CaptureTheFlag_session_lastTimeSync = diag_ticktime;
CaptureTheFlag_session_tkCounter = 0;
if (isNil "CaptureTheFlag_session_syncInProgress") then {CaptureTheFlag_session_syncInProgress = true};
CaptureTheFlag_session_unitsDeliveredToAO = [];
CaptureTheFlag_skill_athlete_lastFatigue = 0;
CaptureTheFlag_system_revealedUnits = [];
CaptureTheFlag_system_revealedUnitsTick = 0;
CaptureTheFlag_ui_headsUpIcons_hide = true;
CaptureTheFlag_ui_lastPurchasedVehicle = objNull;
CaptureTheFlag_ui_holdAction_queue = [];
CaptureTheFlag_ui_HUI_showPlayerNames = false;

0 spawn {
	waituntil {missionNamespace getVariable ["CaptureTheFlag_session_dataRead",false]};
	[] call CaptureTheFlag_c_settings_applyViewDistance;
	[] call CaptureTheFlag_c_settings_applyTerrainGrid;
	enableEnvironment (CaptureTheFlag_setting_enableEnvironment call CaptureTheFlag_c_system_toBool);
};

[] call CaptureTheFlag_c_groups_initGroups;
BIS_dynamicGroups_allowInterface = false;

[] call CaptureTheFlag_c_ui_initHUD;
(findDisplay 46) displayAddEventHandler ["MouseMoving",{CaptureTheFlag_session_lastMovementTick = diag_ticktime}];
(findDisplay 46) displayAddEventHandler ["KeyDown",{_this call CaptureTheFlag_c_evh_KeyDown}];
(findDisplay 46) displayAddEventHandler ["KeyUp",{_this call CaptureTheFlag_c_evh_KeyUp}];

addMissionEventHandler ["EachFrame",{
	["FlagUpdateClient",[OBJECTIVE_FLAG_POLE]] call CaptureTheFlag_c_map_modifyFlag;

	["monitor"] call CaptureTheFlag_c_ui_holdAction;

	if CaptureTheFlag_session_writePlayerData then {
		CaptureTheFlag_session_writePlayerData = false;
		false call CaptureTheFlag_c_session_writeData;
	};

	if (diag_ticktime - CaptureTheFlag_session_lastMovementTick >= 600) then {END_MISSION_SAFE("afkTimeout");};

	if (CaptureTheFlag_session_killFeedCount > 0 && {diag_tickTime > CaptureTheFlag_session_killFeedTick}) then {
		[
			[
				"","",
				"kills_doublekill",
				"kills_triplekill",
				"kills_quadkill",
				"kills_pentakill"
			] param [CaptureTheFlag_session_killFeedCount,"kills_killfeed"]
		] call CaptureTheFlag_c_session_handleEvent;
		CaptureTheFlag_session_killFeedCount = 0;
	};

	if SKILL_ACTIVE("athlete") then {
		_lastFatigue = getFatigue player - CaptureTheFlag_skill_athlete_lastFatigue;
		CaptureTheFlag_skill_athlete_lastFatigue = getFatigue player;
		if (_lastFatigue < 0) then {
		    CaptureTheFlag_skill_athlete_lastFatigue = CaptureTheFlag_skill_athlete_lastFatigue + (_lastFatigue * (0.5*CaptureTheFlag_skill_athlete));
		    player setFatigue CaptureTheFlag_skill_athlete_lastFatigue;
		} else {
		    CaptureTheFlag_skill_athlete_lastFatigue = CaptureTheFlag_skill_athlete_lastFatigue - _lastFatigue / 2;
		    player setFatigue CaptureTheFlag_skill_athlete_lastFatigue;
		};
	};

	if (diag_tickTime>CaptureTheFlag_system_revealedUnitsTick && {vehicle player == player}) then {
		CaptureTheFlag_system_revealedUnits = CaptureTheFlag_system_revealedUnits select {!isNull _x && {alive _x}};
		{
			player reveal _x;CaptureTheFlag_system_revealedUnits pushBackUnique _x;
		} foreach ((nearestObjects[player,["CAManBase"],20])-CaptureTheFlag_system_revealedUnits);
		CaptureTheFlag_system_revealedUnitsTick = diag_tickTime + 5;
	};


	if (CaptureTheFlag_info_spawned && {!isNil "CaptureTheFlag_info_roundStartTick" && {CaptureTheFlag_info_roundStartTick>time}}) then {
		if (isNil "CaptureTheFlag_setup_roundStartCountdown") then {
			CaptureTheFlag_setup_roundStartCountdown = [] spawn {
				private _displayNotif = {
					params [["_time",0,[0]],["_fade",0,[0]]];
					["showNotification",[format["<t shadow=1>Game starts in %1</t>",[_time,"MM:SS"]call BIS_fnc_secondsToString],_fade]] call CaptureTheFlag_c_ui_HUD_NotificationSmall;
				};
				[round(CaptureTheFlag_info_roundStartTick-time),1] call _displayNotif;
				uisleep 1;
				for "_i" from (round(CaptureTheFlag_info_roundStartTick-time)) to 0 step -1 do {
					if (CaptureTheFlag_info_spawned && {([player,[BLUFOR_SAFE_ZONE,OPFOR_SAFE_ZONE] select SIDE_INDEX] call CaptureTheFlag_c_system_inArea)}) then {
						[_i,0] call _displayNotif;
					};
					uisleep 1;
				};
				["hideNotification",[1]] call CaptureTheFlag_c_ui_HUD_NotificationSmall;
			};
		};
		[
			"preRound",
			{
				CaptureTheFlag_info_spawned && 
				{
					!([player,[BLUFOR_SAFE_ZONE,OPFOR_SAFE_ZONE] select SIDE_INDEX] call CaptureTheFlag_c_system_inArea) && 
					{
						!NEEDS_REVIVE(player)
					}
				}
			}
		] call CaptureTheFlag_c_ui_zoneWarning;
	};
	
	[
		"outsideAO",
		{
			CaptureTheFlag_info_spawned && 
			{
				!([player,AO_MARKER] call CaptureTheFlag_c_system_inArea) && 
				{
					!NEEDS_REVIVE(player)
				}
			}
		}
	] call CaptureTheFlag_c_ui_zoneWarning;
	[
		"inEnemySZ",
		{
			CaptureTheFlag_info_spawned && 
			{
				[player,[OPFOR_SAFE_ZONE,BLUFOR_SAFE_ZONE] select SIDE_INDEX] call CaptureTheFlag_c_system_inArea && 
				{
					!NEEDS_REVIVE(player)
				}
			}
		}
	] call CaptureTheFlag_c_ui_zoneWarning;
	[
		"inFriendlySZWithFlag",
		{
			CaptureTheFlag_info_spawned && 
			{
				[player,[BLUFOR_SAFE_ZONE,OPFOR_SAFE_ZONE] select SIDE_INDEX] call CaptureTheFlag_c_system_inArea && 
				{
					!isNull CaptureTheFlag_info_unitCarryingFlag
				}
			}
		}
	] call CaptureTheFlag_c_ui_zoneWarning;

}];

0 spawn {
	disableSerialization;
	waitUntil {!isNull(findDisplay 12 displayCtrl 51)};
	(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw",{_this call CaptureTheFlag_c_ui_mapIcons}];
	waitUntil {!isNull((uinamespace getVariable "RscCustomInfoMiniMap") displayCtrl 101)};
	((uinamespace getVariable "RscCustomInfoMiniMap") displayCtrl 101) ctrlAddEventHandler ["Draw",{_this call CaptureTheFlag_c_ui_gpsIcons}];
	// This is supposed to fix an overlap issue with the hud and these custom panel positions. 
	// It kind of screws with people who have already moved their panels but eh
	{
		{
			_cP = ctrlPosition _x;
			_cP set [0,(_cP select 0)+(0.0045375*safezonew)];
			_cP set [1,(_cP select 1)-(1/8.5*safezoneh)];
			_x ctrlSetPosition _cP;
			_x ctrlCommit 0;
		} foreach allControls(uiNamespace getVariable _x);
	}foreach [
		"rsccustominfominedetect",
		"rsccustominfoslingload",
		"rsccustominfominimap",
		"rsccustominfouavfeed",
		"rsccustominfocrew"
	];
};

addMissionEventHandler ["Map",{
	if (_this select 0) then {
		if (ctrlMapScale (findDisplay 12 displayCtrl 51) >= 0.1) then {
			// Auto focus on my position
			(findDisplay 12 displayCtrl 51) ctrlMapAnimAdd [0,0.1,getMarkerPos AO_MARKER];
			ctrlMapAnimCommit (findDisplay 12 displayCtrl 51);
		};
	};
}];

// NPC actions
["addTemplate",[[BLUFOR_WEAPONS_NPC,OPFOR_WEAPONS_NPC] select SIDE_INDEX,"WeaponShop"]] call CaptureTheFlag_c_ui_holdAction;
["addTemplate",[[BLUFOR_VEHICLE_NPC,OPFOR_VEHICLE_NPC] select SIDE_INDEX,"VehicleShop"]] call CaptureTheFlag_c_ui_holdAction;
["addTemplate",[[BLUFOR_CLOTHING_NPC,OPFOR_CLOTHING_NPC] select SIDE_INDEX,"ClothingShop"]] call CaptureTheFlag_c_ui_holdAction;
["addTemplate",[[BLUFOR_SKILLS_NPC,OPFOR_SKILLS_NPC] select SIDE_INDEX,"SkillShop"]] call CaptureTheFlag_c_ui_holdAction;
["addTemplate",[[BLUFOR_REARM_NPC,OPFOR_REARM_NPC] select SIDE_INDEX,"repairAndRearmPlayer"]] call CaptureTheFlag_c_ui_holdAction;

// Flag podium actions
["addTemplate",[OBJECTIVE_FLAG_BASE,"stealFlag"]] call CaptureTheFlag_c_ui_holdAction;
["addTemplate",[[BLUFOR_FLAG_BASE,OPFOR_FLAG_BASE] select SIDE_INDEX,"captureFlag"]] call CaptureTheFlag_c_ui_holdAction;

// I don't want to see these, just didnt want to hide them in the dynamic sqm
{_x setMarkerAlphaLocal 0} foreach [OPFOR_VEH_RAR_ZONE,BLUFOR_VEH_RAR_ZONE];

missionNamespace setVariable ["CaptureTheFlag_setup_initClientCompleted",true];

[] spawn CaptureTheFlag_c_spawn_camera;