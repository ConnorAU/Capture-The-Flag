/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

// Adds event handlers that need to be set on all clients
params [["_unit",objNull,[objNull]]];
if (isNull _unit OR {_unit isequalto player}) exitwith {};
_unit addEventHandler ["HandleHeal",{_this call CaptureTheFlag_c_evh_handleHeal}];	
_unit addEventHandler ["HitPart",{_this call CaptureTheFlag_c_evh_hitPart}];	