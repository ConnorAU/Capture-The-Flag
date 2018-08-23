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

params [["_display",displayNull,[displayNull]]];
private _cfgToken = _display getVariable ["token",""];
private _skin = _display getVariable ["skin",""];

if ("" in [_cfgToken,_skin] OR isnull _display) exitwith {};
_display closeDisplay 2;

private _rank = getNumber(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> "rank");
private _price = getNumber(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> "price");

if (CaptureTheFlag_statistic_rank<_rank) exitwith {
	["Default",["You do not meet the required rank for this vehicle"]] call CaptureTheFlag_c_ui_notifFeed_useTemplate;
};
if !([-_price] call CaptureTheFlag_c_session_currency) exitwith {
	["Default",["You do not have the funds for this vehicle"]] call CaptureTheFlag_c_ui_notifFeed_useTemplate;
};

private _anims = getArray(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> "animations");
private _class = getText(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> str SIDE_VAR(player) >> "classname");
private _layers = getArray(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> str SIDE_VAR(player) >> (["colorLayers","camoLayers"] select (_skin == "camo")));

private _spawns = (missionnamespace getvariable [
	[
		["CaptureTheFlag_mapSetting_westAirSpawns","CaptureTheFlag_mapSetting_eastAirSpawns"] select SIDE_INDEX,
		["CaptureTheFlag_mapSetting_westLandSpawns","CaptureTheFlag_mapSetting_eastLandSpawns"] select SIDE_INDEX
	] select ([_class,"Land"] call CaptureTheFlag_c_system_isKindOf),1]
);

private _sizeOf = (sizeOf _class)/2;
if (_sizeOf == 0) then {
	private _dummy = _class createVehicleLocal [0,0,random 5000 max 100];
	_sizeOf = (sizeOf _class)/2;
	deleteVehicle _dummy;
};

private _allSpawns = [];
for "_i" from 1 to _spawns do {
	_logic = call compile format["%1_%2_SPAWN_%3",["BLUFOR","OPFOR"] select SIDE_INDEX,["LAND","AIR"] select ([_class,"Air"] call CaptureTheFlag_c_system_isKindOf),_i];
	if !(isNil "_logic") then {_allSpawns pushback _logic};
};

private _freeSpawns = _allSpawns select {count(nearestObjects[_x,["LandVehicle","Air"],_sizeOf])<1};
private _spawnLogic = if (count _freeSpawns>0) then {
	selectRandom (_freeSpawns select [0,6]);
} else {
	/*[
		{
			_x = (getPos _x) findEmptyPosition [0,20,_class];
			if (count _x > 0) exitwith {_x};
		}foreach (_allSpawns call BIS_fnc_arrayShuffle)
	] param [0,[],[[]],3];*/
	objNull
};
private _spawnPos = [getPos _spawnLogic,[]] select (isNull _spawnLogic);
private _spawnDir = [getDir _spawnLogic,[]] select (isNull _spawnLogic);

if (count _spawnPos < 1 OR {_spawnPos isequalto [0,0,0]}) exitwith {_this spawn CaptureTheFlag_s_round_spawnFreeVehicle;};

private _vehicle = createVehicle[_class,_spawnPos,[],0,"NONE"];
_vehicle setDir _spawnDir;
{_vehicle setObjectTextureGlobal [_forEachIndex,_x]}foreach _layers;
{_vehicle animate _x}foreach _anims;
_vehicle lock true;
_vehicle enableRopeAttach false;
_vehicle disableTIEquipment (CaptureTheFlag_serverSetting_disableVehicleThermals call CaptureTheFlag_c_system_toBool);
_vehicle setPlateNumber (["BLUFOR","OPFOR"] select SIDE_INDEX);
_vehicle setVariable ["owner",CaptureTheFlag_info_playerUID,true];
_vehicle setVariable ["side",SIDE_VAR(player),true];
_vehicle setVariable ["price",_price,true];
_vehicle setVariable ["lastUsed",time,2];
[_vehicle,{
	_this addEventHandler ["handleDamage",{_this call CaptureTheFlag_c_evh_handleDamage}];
	_this addEventHandler ["killed",{_this call CaptureTheFlag_c_evh_killed}];
}] remoteExec ["CaptureTheFlag_c_system_JIPcall",0,_vehicle];

CaptureTheFlag_ui_lastPurchasedVehicle = _vehicle;

clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;

["Default",["Your "+getText(configFile >> "CfgVehicles" >> _class >> "displayName")+" is ready"]] call CaptureTheFlag_c_ui_notifFeed_useTemplate;

CaptureTheFlag_setting_vehicles = ([_cfgToken] + (CaptureTheFlag_setting_vehicles - [_cfgToken])) select [0,5];
true call CaptureTheFlag_c_session_writeData;