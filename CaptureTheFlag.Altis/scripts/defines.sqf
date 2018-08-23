/*-------------------------------------------------------
|														|
| ~ Global Info 	 									|
|														|
-------------------------------------------------------*/
#define IS_DEVELOPMENT_SERVER (["development",servername] call BIS_fnc_inString)
#define MISSION_ROOT (str missionConfigFile select [0, count str missionConfigFile - 15])
#define SIDE_VAR(UNIT) (UNIT getVariable ["side",side UNIT])
#define SIDE_INDEX ([west,east] find (player getVariable ["side",playerside]))
#define SIDE_INDEX_GLOBAL(UNIT) ([west,east] find SIDE_VAR(UNIT))
#define SIDE_INDEX_SIDE(SIDE) ([west,east] find SIDE)
#define PROFILE_COLOURS [\
	profilenamespace getvariable ["GUI_BCG_RGB_R",0.77],\
	profilenamespace getvariable ["GUI_BCG_RGB_G",0.51],\
	profilenamespace getvariable ["GUI_BCG_RGB_B",0.08]\
]
#define NEEDS_REVIVE(UNIT) (lifeState UNIT == "Incapacitated")
#define STREAM_SAFE_NAME(UNIT) [UNIT getVariable["name",name UNIT],"You"] select (isStreamFriendlyUIEnabled && {UNIT isEqualTo player})
#define MAX_PLAYERS getNumber(missionConfigFile >> "Header" >> "maxPlayers")
#define EXP_PER_RANK 250
#define END_MISSION_SAFE(TOKEN) TOKEN spawn {\
	[] call BIS_fnc_forceEnd;\
	endLoadingScreen;\
	uisleep 0.1;\
	endmission _this;\
	failMission _this;\
	uisleep 3;\
	(findDisplay 46) closeDisplay 2;\
}
#define SKILL_ACTIVE(SKILL) (SKILL in (missionNameSpace getVariable ["CaptureTheFlag_setting_skills",[]]))
#define SKILL_VALUE(SKILL) missionNameSpace getVariable ["CaptureTheFlag_skill_"+SKILL,0]

/*-------------------------------------------------------
|														|
| ~ Map Info 		 									|
|														|
-------------------------------------------------------*/
#define AO_MARKER "CTF_AO_MARKER"

#define BLUFOR_SAFE_ZONE "BLUFOR_ZONE"
#define BLUFOR_VEH_RAR_ZONE "BLUFOR_ZONE_VEH_RAR"
#define OPFOR_SAFE_ZONE "OPFOR_ZONE"
#define OPFOR_VEH_RAR_ZONE "OPFOR_ZONE_VEH_RAR"

#define BLUFOR_FLAG_IMG "a3\data_f\flags\flag_nato_co.paa"
#define OPFOR_FLAG_IMG "a3\data_f\flags\flag_csat_co.paa"
#define OBJECTIVE_FLAG_IMG "a3\data_f\flags\flag_altis_co.paa"

#define BLUFOR_VEH_RAR_IMAGE "\A3\ui_f\data\map\markers\nato\b_maint.paa"
#define OPFOR_VEH_RAR_IMAGE "\A3\ui_f\data\map\markers\nato\o_maint.paa"