/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

private _o = param [0,objNull,[objNull]];
if (isNull _o) exitwith {};
_o setDamage 0;
_o setFuel (fuel _o max 0.5);
["repaired_vehicle",_o] call CaptureTheFlag_c_session_handleEvent;