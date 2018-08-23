/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [["_o",objNull,[objNull]]];
if (isNull _o) exitwith {};
// I think I did this to avoid some arma logs but it really doesn't help at all
if (local _o OR isSimpleObject _o) then {deleteVehicle _o} else {[_o] remoteExecCall ["CaptureTheFlag_c_system_deleteVehicle",_o]};
