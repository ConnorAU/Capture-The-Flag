/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

(param [0,[]]) params [["_target",objNull],["_shooter",objNull],"","","",["_selection",[]],"","","","",["_direct",false]];
if (alive _target && {!NEEDS_REVIVE(_target)}) then {
	if _direct then {
		if (!isNull _shooter && {_shooter isequalto player}) then {
			private _hitmarker = if (SIDE_VAR(_shooter) != SIDE_VAR(_target)) then {
				// Stuff for the stats
				_target setVariable ["CaptureTheFlag_unit_hit",true];
				_target setVariable ["CaptureTheFlag_unit_headshot","head" in _selection];
				_target setVariable ["CaptureTheFlag_unit_distance",_target distance _shooter];
				"CaptureTheFlag_UI_HitMarker"
			} else {
				_target setVariable ["CaptureTheFlag_unit_friendlyFire",0];
				"CaptureTheFlag_UI_HitMarkerFriendly"
			};
			if (CaptureTheFlag_setting_showHitMarkers call CaptureTheFlag_c_system_tobool) then {
				// Hitmarkers - https://steamcommunity.com/sharedfiles/filedetails/?id=772802287
				"CaptureTheFlag_HitMarker_Layer" cutRsc [_hitmarker,"PLAIN"];
			};
		};
	} else {
		if (_target isequalto player) then {CaptureTheFlag_info_splashDamage = !_direct;};
	};
};	
