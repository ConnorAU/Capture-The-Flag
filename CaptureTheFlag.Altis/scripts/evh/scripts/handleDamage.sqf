/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

params ["_object","","_damage","_source","_projectile","","_instigator"];
switch true do {
	// Man unit?
	case ([_object,"CAManBase"] call CaptureTheFlag_c_system_isKindOf):{
		_source = [_instigator,_source] select (isNull _instigator);

		// Dont take damage if im already dead
		if NEEDS_REVIVE(_object) exitwith {damage _object};

		// Dont take damage if im in my safezone
		if ([_object,[BLUFOR_SAFE_ZONE,OPFOR_SAFE_ZONE] select SIDE_INDEX_GLOBAL(_object)] call CaptureTheFlag_c_system_inArea) exitwith {damage _object};

		// Dont take damage if the source is shooting from inside their safezone
		if (!isNull _source && {[_source,[BLUFOR_SAFE_ZONE,OPFOR_SAFE_ZONE] select SIDE_INDEX_GLOBAL(_source)] call CaptureTheFlag_c_system_inArea}) exitwith {damage _object};

		// Dont take damage from friendly fire if the setting is enabled
		if ((CaptureTheFlag_serverSetting_disableFriendlyFire call CaptureTheFlag_c_system_toBool) && {SIDE_VAR(_object) isequalto SIDE_VAR(_source)}) exitwith {damage _object};

		if CaptureTheFlag_info_splashDamage then {
			// Not entirely sure this works tbh
			if SKILL_ACTIVE("flakJacket") then {
				_damage = _damage * (1-((SKILL_VALUE("flakJacket"))/20));
			};
		};

		CaptureTheFlag_evh_forceKiller = _source;
		if (_projectile != "") then {
			// for the killfeed image
			CaptureTheFlag_evh_forceWeaponKilled = switch (tolower _projectile) do {
				case (tolower "GrenadeHand"):{"HandGrenade"};
				case (tolower "FuelExplosion");
				case (tolower "FuelExplosionBig"):{_projectile};
				default {""};
			};
		};
		_damage min 0.95
	};
	// Vehicle?
	case ([_object,["LandVehicle","Air"]] call CaptureTheFlag_c_system_isKindOf):{
		private _side = _object getVariable ["side",sideUnknown];
		if (_side in [west,east]) then {
			if ([_object,[BLUFOR_SAFE_ZONE,OPFOR_SAFE_ZONE] select SIDE_INDEX_SIDE(_side)] call CaptureTheFlag_c_system_inArea) then {
				_damage = damage _object;
				// 100% the worst possible way to do this
				[_object,getAllHitPointsDamage _object,_damage] spawn {
					params ["_object","_hitpointinfo","_damage"];
					_hitpointinfo params ["_hitPointN","","_hitPointD"];
					private _t = diag_tickTime + 1;
					waituntil {damage _object >= _damage OR diag_tickTime > _t};
					if (diag_tickTime > _t) exitwith {};
					if (local _object) then {
						{
							if !((_object getHitPointDamage _x) isEqualTo (_hitPointD param [_forEachIndex,0,[0]])) then {
								_object setHitPointDamage [_x,_hitPointD param [_forEachIndex,0,[0]],false];
							};
						} foreach _hitPointN;
					};
				};
			};
		};
		_damage
	};
	default {_damage};
};
