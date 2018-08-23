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

if !visibleGPS exitwith {};

disableSerialization;
params ["_ctrl"];
private _zoom = ctrlMapScale _ctrl;

private _w = 57.6*([1,1-(_zoom*5)] select (_zoom >= 0.03));
private _h = 36*([1,1-(_zoom*5)] select (_zoom >= 0.03));
private _drawIcons = {
	params ["_f","_p",["_t",""],["_w",_w],["_h",_h],["_c",[1,1,1,1]]];
	_ctrl drawIcon [
		_f,_c,
		_p,_w,_h,0,
		_t,2,0.034,"PuristaMedium","center"
	];
};
private _getFlagPos = {
	if (isNull(_obj getVariable ["UnitStolen",objNull])) then {getPos _obj} else {getPos (_obj getVariable ["UnitStolen",objNull])}
};

private _obj = OPFOR_FLAG_POLE;
[OPFOR_FLAG_IMG,call _getFlagPos] call _drawIcons;

_obj = BLUFOR_FLAG_POLE;
[BLUFOR_FLAG_IMG,call _getFlagPos] call _drawIcons;

_obj = OBJECTIVE_FLAG_POLE;
[OBJECTIVE_FLAG_IMG,call _getFlagPos] call _drawIcons;

[
	[BLUFOR_VEH_RAR_IMAGE,OPFOR_VEH_RAR_IMAGE] select SIDE_INDEX,
	getMarkerPos ([BLUFOR_VEH_RAR_ZONE,OPFOR_VEH_RAR_ZONE] select SIDE_INDEX),
	"",_w*0.5,_h*0.75,
	[
	 	[["Map_BLUFOR_R",0],["Map_BLUFOR_G",1],["Map_BLUFOR_B",1],["Map_BLUFOR_A",0.8]] apply {profileNamespace getVariable _x},
	 	[["Map_OPFOR_R",0],["Map_OPFOR_G",1],["Map_OPFOR_B",1],["Map_OPFOR_A",0.8]] apply {profileNamespace getVariable _x}
	] select SIDE_INDEX
] call _drawIcons;