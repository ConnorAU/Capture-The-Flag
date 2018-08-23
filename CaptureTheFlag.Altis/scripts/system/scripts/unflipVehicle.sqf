/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

private _o = param [0,cursorObject,[objNull]];
if (isNull _o) exitwith {};
if (local _o) then {
	private _z = getPosATL _o param [2,0];
	_o setVectorUp surfaceNormal getPosWorld _o;
	_o setPosATL ((getPosATL _o select [0,2])+[_z-(boundingCenter _o param [2,0])]);
} else {
	[_o] remoteExecCall ["CaptureTheFlag_c_system_unflipVehicle",_o];
};