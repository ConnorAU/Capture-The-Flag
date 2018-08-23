/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

_this spawn {
	params ["_unit","_healer"];
	private _t = diag_ticktime + 10;
	private _damage = damage _unit;
	waitUntil{damage _unit < _damage OR diag_ticktime > _t};
	if (damage _unit < _damage) then {
		{_unit setHitPointDamage [_x,0]} forEach (getAllHitPointsDamage _unit select 0);
		_unit setDamage 0;
		if (!isNull _healer && {_healer != _unit && {alive _healer}}) then {
			// For their stats
			["healed"] remoteExecCall ["CaptureTheFlag_c_session_handleEvent",_unit];
			// don't give me xp or cash if i damaged the unit
			["heal_player",_unit getVariable ["CaptureTheFlag_unit_friendlyFire",1]] call CaptureTheFlag_c_session_handleEvent;
		};
	};
};