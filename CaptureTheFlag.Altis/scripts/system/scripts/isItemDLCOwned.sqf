/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

private _item = param [0,"",[""]];
private _configPath = [_item,"",configfile >> "CfgMods" >> "A3"] call CaptureTheFlag_c_system_searchConfigFile;
private _source = configSourceMod _configPath;
_source == "" OR {getNumber(configFile >> "CfgMods" >> _source >> "appID") in (getDLCs 1)}