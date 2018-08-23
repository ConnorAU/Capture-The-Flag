/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#define VEHICLE_SHOP_CONFIG_PATH missionconfigfile >> "CfgScripts" >> "Shop" >> "configs" >> "VehicleShopInfo"
#define SIDE_INDEX ([west,east] find _side)

params [
	["_cfgToken",0,[""]],
	["_side",0,[sideUnknown]],
	["_doSleep",0,[false]]
];
if (0 in [_cfgToken,_side,_doSleep]) exitwith {};

// Used to delay spawning new free vehicle
if _doSleep then {
	uisleep ((random ceil 5)*60);
};

private _anims = getArray(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> "animations");
private _class = getText(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> (str _side) >> "classname");
private _layers = getArray(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> (str _side) >> (["colorLayers","camoLayers"] select (isClass(VEHICLE_SHOP_CONFIG_PATH >> _cfgToken >> (str _side) >> "camoLayers"))));

// Select spawn list
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

// Create spawn list
private _allSpawns = [];
for "_i" from 1 to _spawns do {
	_logic = call compile format["%1_%2_SPAWN_%3",["BLUFOR","OPFOR"] select SIDE_INDEX,["LAND","AIR"] select ([_class,"Air"] call CaptureTheFlag_c_system_isKindOf),_i];
	if !(isNil "_logic") then {_allSpawns pushback _logic};
};

// Select empty spawn point
private _freeSpawns = _allSpawns select {count(nearestObjects[_x,["LandVehicle","Air"],_sizeOf])<1};
private _spawnLogic = if (count _freeSpawns>0) then {
	selectRandom (_freeSpawns select [0,6]);
} else {objNull};
private _spawnPos = [getPos _spawnLogic,[]] select (isNull _spawnLogic);
private _spawnDir = [getDir _spawnLogic,[]] select (isNull _spawnLogic);

// Couldn't find a spawn, try again
if (count _spawnPos < 1 OR {_spawnPos isequalto [0,0,0]}) exitwith {_this spawn CaptureTheFlag_s_round_spawnFreeVehicle;};

// Create free vehicle
private _vehicle = createVehicle[_class,_spawnPos,[],0,"NONE"];
_vehicle setDir _spawnDir;
{_vehicle setObjectTextureGlobal [_forEachIndex,_x]}foreach _layers;
{_vehicle animate _x}foreach _anims;
_vehicle lock false;
_vehicle enableRopeAttach false;
_vehicle disableTIEquipment (CaptureTheFlag_serverSetting_disableVehicleThermals call CaptureTheFlag_c_system_toBool);
_vehicle setPlateNumber (["BLUFOR","OPFOR"] select SIDE_INDEX);
_vehicle setVariable ["side",_side,true];
_vehicle setVariable ["clutterProtected",true];
_vehicle setVariable ["lastUsed",time];

// Events to manage the vehicle while its active and create a replacement if this one is destroyed
_vehicle addEventHandler ["deleted",format["%1 spawn CaptureTheFlag_s_round_spawnFreeVehicle",[_cfgToken,_side,true]]];
_vehicle addEventHandler ["getIn","[1,_this select 0] call CaptureTheFlag_s_round_freeVehicleIdleManager"];
_vehicle addEventHandler ["getOut","[2,_this select 0] call CaptureTheFlag_s_round_freeVehicleIdleManager"];
[_vehicle,{
	_this addEventHandler ["handleDamage",{_this call CaptureTheFlag_c_evh_handleDamage}];
	_this addEventHandler ["killed",{_this call CaptureTheFlag_c_evh_killed}];
}] remoteExec ["CaptureTheFlag_c_system_JIPcall",0,_vehicle];

[0,_vehicle] call CaptureTheFlag_s_round_freeVehicleIdleManager;

clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;