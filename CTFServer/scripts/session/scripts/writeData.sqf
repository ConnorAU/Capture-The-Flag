/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#define PACKET_CORE [\
	CaptureTheFlag_session_currency,\
	CaptureTheFlag_session_experience\
]
#define PACKET_OPTI [\
	CaptureTheFlag_setting_clothing,\
	CaptureTheFlag_setting_vehicles,\
	CaptureTheFlag_setting_weapons,\
	CaptureTheFlag_setting_skills,\
	CaptureTheFlag_setting_enableEnvironment,\
	CaptureTheFlag_setting_showPlayerTags,\
	CaptureTheFlag_setting_showHitMarkers,\
	CaptureTheFlag_setting_terrainSmoothingMode,\
	CaptureTheFlag_setting_footViewDistance,\
	CaptureTheFlag_setting_landViewDistance,\
	CaptureTheFlag_setting_airViewDistance\
]

if !(missionNamespace getVariable ["CaptureTheFlag_session_dataRead",false]) exitwith {};
if (isNil "_this" OR {!(_this isEqualType true)}) exitwith {};
CaptureTheFlag_session_syncInProgress = true;
// There are two kinds of syncs here, core and options. We select the one we want and send it to the server
[_this,([PACKET_CORE,PACKET_OPTI] select _this)+[CaptureTheFlag_info_playerUID],player getVariable ["side",playerSide]] remoteExecCall ["CaptureTheFlag_s_session_savePlayerData",2];