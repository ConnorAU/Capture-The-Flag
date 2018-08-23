/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#define A(NAME) class NAME {allowedTargets=0;jip=0;};
#define AJ(NAME) class NAME {allowedTargets=0;jip=1;};
#define C(NAME) class NAME {allowedTargets=1;jip=0;};
#define CJ(NAME) class NAME {allowedTargets=1;jip=1;};
#define S(NAME) class NAME {allowedTargets=2;jip=0;};
class CfgRemoteExec {
	class Functions {
		mode = 1;
		jip = 0;

		A(CaptureTheFlag_c_system_deleteVehicle)
		AJ(CaptureTheFlag_c_system_JIPcall)
		A(CaptureTheFlag_c_system_unflipVehicle)
		A(BIS_fnc_dynamicGroups)
        A(BIS_fnc_effectKilledAirDestruction)
        A(BIS_fnc_effectKilledSecondaries)

		C(CaptureTheFlag_c_map_modifyFlag)
		C(CaptureTheFlag_c_medical_executed)
		C(CaptureTheFlag_c_medical_killed)
		C(CaptureTheFlag_c_medical_revived)
		C(CaptureTheFlag_c_session_handleEvent)
		C(CaptureTheFlag_c_system_flagCaptured)
		C(CaptureTheFlag_c_system_handleTeamKill)
		C(CaptureTheFlag_c_ui_HUD_notificationBig)
		C(CaptureTheFlag_c_ui_notifFeed_useTemplate)

		S(CaptureTheFlag_s_session_fetchPlayerData)
		S(CaptureTheFlag_s_session_savePlayerData)
		S(CaptureTheFlag_s_session_savePlayerRestriction)
		S(CaptureTheFlag_s_session_savePlayerSkill)
		S(CaptureTheFlag_s_session_savePlayerStat)
		S(bis_fnc_debugconsoleexec)

	};
	class Commands {
		mode = 1;
		jip = 0;

		A(lock)
		A(switchMove)

		S(addPlayerScores)
	};
};
#undef A
#undef AJ
#undef C
#undef CJ
#undef S