/*-------------------------------------------------------
|                                                       |
| ~ MySQL DB                                            |
|                                                       |
-------------------------------------------------------*/
#define DATABASE "CaptureTheFlag"
#define PROTOCOL "SQL_CUSTOM"

// again with the code macros... must have been going through a phase
//#define LOG_TO_RPT
#define LOG_CODE {diag_log parsetext (["[MySQL: ",_this param [0,""],"] ",_this param [1,""]] joinString "")}
#define CODE_LOCKSERVER {getText(configFile >> "CfgCTFSettings" >> "keysToTheKingdom") serverCommand "#shutdown";}