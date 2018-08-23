/*-------------------------------------------------------
|														|
| ~ Stats												|
|														|
-------------------------------------------------------*/

#define DEFAULT_MONEY 1500
#define DEFAULT_EXP 0

#define DEFAULT_ARRAY []
#define DEFAULT_STATISTIC 0

#define DEFAULT_ENABLEENVIRONMENT 1
#define DEFAULT_SHOWPLAYERTAGS 1
#define DEFAULT_SHOWHITMARKERS 0
#define DEFAULT_TERRAINSMOOTHINGMODE 2
#define DEFAULT_FOOTVIEWDISTANCE 800
#define DEFAULT_LANDVIEWDISTANCE 1500
#define DEFAULT_AIRVIEWDISTANCE 2500


/*-------------------------------------------------------
|														|
| ~ PROFNS Database										|
|														|
-------------------------------------------------------*/

#define QUOTE(a) #a
#define JOIN(a,b) a##_%1_##b
#define GVAR(a,b) profileNamespace getVariable [a,b]
#define SVAR(a,b) profileNamespace setVariable [a,b]

#define PDB_PREFIX CaptureTheFlag_PDB
#define PDB_MAKEVAR(a,b) format[QUOTE(JOIN(PDB_PREFIX,a)),b]
#define PDB_VAR_PLAYER_INFO(uid) PDB_MAKEVAR(player_info,uid)
#define PDB_VAR_PLAYER_SETTINGS(uid) PDB_MAKEVAR(player_settings,uid)
#define PDB_VAR_PLAYER_STATISTICS(uid) PDB_MAKEVAR(player_statistics,uid)
#define PDB_VAR_PLAYER_SKILLS(uid) PDB_MAKEVAR(player_skills,uid)