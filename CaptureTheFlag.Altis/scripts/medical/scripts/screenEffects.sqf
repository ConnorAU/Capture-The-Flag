/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

private _unit = param [0,objNull,[objNull]];
if (isNull _unit) exitwith {};

private _startTick = diag_ticktime;
private _timeUntilBleedout = 2*60;

private _ppColor = ppEffectCreate ["ColorCorrections", 1632];
private _ppVig = ppEffectCreate ["ColorCorrections", 1633];
private _ppBlur = ppEffectCreate ["DynamicBlur", 525];

// Effects taken from a3\functions_f_mp_mark\revive\fn_revivebleedout.sqf
_ppColor ppEffectAdjust [1,1,0.15,[0.3,0.3,0.3,0],[0.3,0.3,0.3,0.3],[1,1,1,1]];
_ppVig ppEffectAdjust [1,1,0,[0.15,0,0,1],[1.0,0.5,0.5,1],[0.587,0.199,0.114,0],[1,1,0,0,0,0.2,1]];
_ppBlur ppEffectAdjust [0];
{
	_x ppEffectCommit 0;
	_x ppEffectEnable true;
	_x ppEffectForceInNVG true;
} forEach [_ppColor,_ppVig,_ppBlur];
uisleep 1;

private ["_blood","_bright","_intense","_blur"];
while {NEEDS_REVIVE(_unit) && {((diag_ticktime-_startTick)/_timeUntilBleedout)<1}} do {
	_blood = 1-((diag_ticktime-_startTick)/_timeUntilBleedout);

	_bright = 0.2+(0.1*_blood);
	_ppColor ppEffectAdjust [1,1,0.15*_blood,[0.3,0.3,0.3,0],[_bright,_bright,_bright,_bright],[1,1,1,1]];

	_intense = 0.6+(0.4*_blood);
	_ppVig ppEffectAdjust [1,1,0,[0.15,0,0,1],[1.0,0.5,0.5,1],[0.587,0.199,0.114,0],[_intense,_intense,0,0,0,0.2,1]];

	_blur = 0.7*(1-_blood);
	_ppBlur ppEffectAdjust [_blur];

	{_x ppEffectCommit 1} forEach [_ppColor,_ppVig,_ppBlur];
	CaptureTheFlag_session_lastMovementTick = diag_ticktime;
	uisleep 1;
};

if (((diag_ticktime-_startTick)/_timeUntilBleedout)>=1) then {_unit call CaptureTheFlag_c_medical_forceRespawn};

_ppColor ppEffectAdjust [1,1,0,[1,1,1,0],[0,0,0,1],[0,0,0,0]];
_ppVig ppEffectAdjust [1,1,0,[1,1,1,0],[0,0,0,1],[0,0,0,0]];
_ppBlur ppEffectAdjust [0];

{_x ppEffectCommit 1} forEach [_ppColor,_ppVig,_ppBlur];
uisleep 1;
{_x ppEffectEnable false;ppEffectDestroy _x} forEach [_ppColor,_ppVig,_ppBlur];