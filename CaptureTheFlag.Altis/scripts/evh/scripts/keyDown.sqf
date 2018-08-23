/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

// This way of doing it seemed like a good idea at the time. I am properly ashamed of it now though, a simple switch would have worked fine :(
params ["_display","_code","_shift","_ctrl","_alt"];
private _cR = false;
private _dR = false;
private _cfgDir = (missionconfigfile >> "CfgScripts" >> "evh" >> "configs" >> "KeyDown");
{
	_x params [["_e","true"],["_d","true"]];
	if (([call compile _e] param [0,call compile _d]) isequalto (call compile _d)) exitwith {_cR = true};
}foreach getarray(_cfgDir >> "blockKeyPress");
if _cR exitwith {true};
private _aR = {
	if (_code in (actionKeys (configname _x))) then {call compile getText(_x);} else {false};
} count configProperties [_cfgDir >> "ACTION"];
if (isText (_cfgDir >> "DIK" >> str _code)) then {
	_dR = [call compile getText(_cfgDir >> "DIK" >> str _code)] param [0,false,[true]];
};
((_aR > 0) OR _dR)
