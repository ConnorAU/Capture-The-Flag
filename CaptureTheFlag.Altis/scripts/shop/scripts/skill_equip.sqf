/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\defines.sqf"
#include "..\..\defines.sqf"

params ["_skill"];
if !(isClass (SKILLS_SHOP_CONFIG_PATH >> _skill)) exitwith {};
if (SKILL_ACTIVE(_skill) OR {count CaptureTheFlag_setting_skills >= 2}) exitwith {};

CaptureTheFlag_setting_skills pushback _skill;

CaptureTheFlag_shop_skill_edited = true;
[] call CaptureTheFlag_c_shop_skill_populateContainer;