/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\defines.sqf"

params ["_skill","_maxTier","_price"];
if !(isClass (SKILLS_SHOP_CONFIG_PATH >> _skill)) exitwith {};

private _var = "CaptureTheFlag_skill_"+_skill;
private _value = missionNameSpace getVariable [_var,0];

if (_value >= _maxTier) exitwith {};
if (CaptureTheFlag_session_currency<_price) exitwith {};
[-_price] call CaptureTheFlag_c_session_currency;
missionNamespace setVariable [_var,_value+1];

CaptureTheFlag_session_writePlayerData = true;
[_skill] call CaptureTheFlag_c_session_writeSkill;

CaptureTheFlag_shop_skill_edited = true;
[] call CaptureTheFlag_c_shop_skill_populateContainer;