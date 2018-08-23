/*-------------------------------------------------------
|														|
| ~ Init Setver 	 									|
|														|
-------------------------------------------------------*/
#define INITSERVER_SETTINGS_CFG_PATH configFile >> "CfgCTFSettings"


/*-------------------------------------------------------
|														|
| ~ Init Round  	 									|
|														|
-------------------------------------------------------*/
#define INITROUND_MAP_CFG_PATH INITSERVER_SETTINGS_CFG_PATH >> "Maps" >> worldName
#define INITROUND_TIME_CFG_PATH configFile >> "CfgCTFScripts" >> "setup" >> "configs" >> "TimePresets"