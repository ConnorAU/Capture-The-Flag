/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

class CfgSounds
{
	sounds[]={};
	class RankUp
	{
		name = "RankUp";
		sound[] = {"resources\audio\rankup.ogg", 0.8, 1};
		titles[] = {};
    }
    class endWin
	{
		name = "endWin";
		sound[] = {"@A3\music_f_argo\music\leadtrack01_f_malden.ogg", 0.7, 1};
		titles[] = {};
    };
    class endLose
	{
		name = "endLose";
		sound[] = {"@A3\music_f_orange\music\eventtrack02_f_orange.ogg", 0.7, 1};
		titles[] = {};
    };

};