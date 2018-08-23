/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

params [
	["_clothing",[uniform player,vest player,headgear player,goggles player],[[]]],
	["_weapons",(getUnitLoadout player select [0,3]) apply {(_x select [0,4])+[_x param [6,nil]]},[[]]]
];
private _sideStr = str SIDE_VAR(player);
private _marksmenWeapons = ["srifle_DMR_01_F","srifle_LRR_F","srifle_DMR_07_blk_F","srifle_DMR_06_camo_F","srifle_GM6_F","srifle_DMR_05_blk_F","srifle_DMR_04_F","srifle_DMR_02_F","srifle_EBR_F","arifle_SPAR_03_blk_F","srifle_DMR_03_F"] apply {tolower _x};
private _loadout = [[],[],[],["",[]],["",[]],[],"","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];

private _clothingCfg = missionConfigFile >> "CfgScripts" >> "Shop" >> "configs" >> "ClothingShopInfo";
private _defaultUniform = getText(_clothingCfg >> "uniform" >> _sideStr >> "default");
private _defaultVest = getText(_clothingCfg >> "vest" >> _sideStr >> "default");
private _defaultHat = getText(_clothingCfg >> "hat" >> _sideStr >> "default");
private _defaultEyes = getText(_clothingCfg >> "eyes" >> _sideStr >> "default");

_clothing params [
	["_uniform",_defaultUniform,[""]],
	["_vest",_defaultVest,[""]],
	["_hat",_defaultHat,[""]],
	["_eyes",_defaultEyes,[""]]
];

if (
    _uniform != _defaultUniform && 
    {
    	_uniform == "" OR	
    	!isClass(_clothingCfg >> "uniform" >> _sideStr >> _uniform) OR 
    	CaptureTheFlag_statistic_rank<getNumber(_clothingCfg >> "uniform" >> _sideStr >> _uniform >> "rank")
    }
) then {_uniform = _defaultUniform};
if (
    _vest != _defaultVest && 
    {
    	_vest == "" OR	
    	!isClass(_clothingCfg >> "vest" >> _sideStr >> _vest) OR 
    	CaptureTheFlag_statistic_rank<getNumber(_clothingCfg >> "vest" >> _sideStr >> _vest >> "rank")
    }
) then {_vest = _defaultVest};
if (
    _hat != _defaultHat && 
    {
    	_hat == "" OR	
    	!isClass(_clothingCfg >> "hat" >> _sideStr >> _hat) OR 
    	CaptureTheFlag_statistic_rank<getNumber(_clothingCfg >> "hat" >> _sideStr >> _hat >> "rank")
    }
) then {_hat = _defaultHat};
if (
    _eyes != _defaultEyes && 
    {
    	_eyes == "" OR	
    	!isClass(_clothingCfg >> "eyes" >> _sideStr >> _eyes) OR 
    	CaptureTheFlag_statistic_rank<getNumber(_clothingCfg >> "eyes" >> _sideStr >> _eyes >> "rank")
    }
) then {_eyes = _defaultEyes};

(_loadout param [3,["",[]]]) set [0,_uniform];
(_loadout param [4,["",[]]]) set [0,_vest];
_loadout set [6,_hat];
_loadout set [7,_eyes];



private _weaponCfg = missionConfigFile >> "CfgScripts" >> "Shop" >> "configs" >> "WeaponShopInfo";

getArray(_weaponCfg >> "defaultLoadout") params [
	["_defaultPrimary",[],[[]]],
	["_defaultLauncher",[],[[]]],
	["_defaultPistol",[],[[]]]
];

_weapons params [
	["_primary",_defaultPrimary,[[]]],
	["_launcher",_defaultLauncher,[[]]],
	["_pistol",_defaultPistol,[[]]]
];
if (count _primary < 5) then {_primary = _defaultPrimary};
if (count _launcher < 5) then {_launcher = _defaultLauncher};
if (count _pistol < 5) then {_pistol = _defaultPistol};

private ["_wepCond","_wepRank","_muzCond","_optCond","_poiCond","_bipCond"];
private _addItems = [];
private _binos = "Binocular";
{
	_x params [
		["_weapon","",[""]],
		["_muzzle","",[""]],
		["_pointer","",[""]],
		["_optic","",[""]],
		["_bipod","",[""]]
	];
	if (_weapon != "") then {

		_wepRank = 0;
		_wepCond = false;
		switch true do {
			case (isClass(_weaponCfg >> "primary" >> _weapon)):{
				_wepRank = getNumber(_weaponCfg >> "primary" >> _weapon >> "rank");
				_wepCond = CaptureTheFlag_statistic_rank>=_wepRank;
			};
			case (isClass(_weaponCfg >> "launcher" >> _weapon)):{
				_wepRank = getNumber(_weaponCfg >> "launcher" >> _weapon >> "rank");
				_wepCond = CaptureTheFlag_statistic_rank>=_wepRank;
			};
			case (isClass(_weaponCfg >> "pistol" >> _weapon)):{
				_wepRank = getNumber(_weaponCfg >> "pistol" >> _weapon >> "rank");
				_wepCond = CaptureTheFlag_statistic_rank>=_wepRank;
			};
			default {};
		};
		_muzCond = isClass(_weaponCfg >> "muzzle" >> _muzzle) && {CaptureTheFlag_statistic_rank>=(_wepRank+getNumber(_weaponCfg >> "muzzle" >> _muzzle >> "rank"))};
		_optCond = isClass(_weaponCfg >> "optic" >> _optic) && {CaptureTheFlag_statistic_rank>=(_wepRank+getNumber(_weaponCfg >> "optic" >> _optic >> "rank"))};
		_poiCond = isClass(_weaponCfg >> "pointer" >> _pointer) && {CaptureTheFlag_statistic_rank>=(_wepRank+getNumber(_weaponCfg >> "pointer" >> _pointer >> "rank"))};
		_bipCond = isClass(_weaponCfg >> "bipod" >> _bipod) && {CaptureTheFlag_statistic_rank>=(_wepRank+getNumber(_weaponCfg >> "bipod" >> _bipod >> "rank"))};

		_ammo = getArray(_weaponCfg >> (["primary","launcher","pistol"] param [_forEachIndex,""]) >> _weapon >> "ammo");
		_loadout set [_forEachIndex,[
			["",_weapon] select _wepCond,
			["",_muzzle] select _muzCond,
			["",_pointer] select _poiCond,
			["",_optic] select _optCond,
			[_ammo param [0,[""]] param [0,nil],1],[],
			["",_bipod] select _bipCond
		]];
		_addItems append (_ammo apply {
			_x set [1,(((_x param [1,0])-1) max 0)+(if (_forEachIndex < 1) then {[0,[0,1,1,2,2,3] param [SKILL_VALUE("ammo"),0]] select SKILL_ACTIVE("ammo")} else {0})];
				_x
			});

		if (_forEachIndex == 0) then {
			_binos = ["Binocular","Rangefinder"] select ((tolower(["",_weapon] select _wepCond)) in _marksmenWeapons);
		};
	};
} foreach [_primary,[[],_launcher] select SKILL_ACTIVE("packingHeat"),_pistol];

_loadout set [8,[_binos,"","","",[],[],""]];

{if ((_x select 1)>0) then {_addItems pushback _x}} foreach [
	["HandGrenade",[0,[0,0,0,1,2,2] param [SKILL_VALUE("ammo"),0]] select SKILL_ACTIVE("ammo")],
	["SmokeShell",[0,[0,0,1,1,2,2] param [SKILL_VALUE("ammo"),0]] select SKILL_ACTIVE("ammo")],
	["FirstAidKit",1+([0,[0,1,1,2,2,3] param [SKILL_VALUE("lifeSaver"),0]] select SKILL_ACTIVE("lifeSaver"))]
];

private _getItemWeight = {
	switch true do {
		case (isNumber(configfile >> "CfgMagazines" >> _this >> "mass")):{getNumber(configfile >> "CfgMagazines" >> _this >> "mass")};
		case (isNumber(configfile >> "CfgWeapons" >> _this >> "mass")):{getNumber(configfile >> "CfgWeapons" >> _this >> "mass")};
		case (isNumber(configfile >> "CfgWeapons"  >> _this >> "ItemInfo" >> "mass")):{getNumber(configfile >> "CfgWeapons"  >> _this >> "ItemInfo" >> "mass")};
		default {0};
	};
};

private _addItemsTMP = [];
private _totalLoadWeight = 0;
{
	_x params ["_i","_c"];
	_t = [];
	_t resize _c;
	_addItemsTMP = _addItemsTMP + (_t apply {_i});
	_t = _i call _getItemWeight;
	_totalLoadWeight = _totalLoadWeight + ((_t*_c)max 0);
} foreach _addItems;
_addItems = +_addItemsTMP;


private _uniformLoad = getNumber(configfile >> "cfgvehicles" >> gettext(configFile >> "cfgWeapons" >> _uniform >> "ItemInfo" >> "containerClass") >> "maximumLoad");
private _vestLoad = getNumber(configfile >> "cfgvehicles" >> gettext(configFile >> "cfgWeapons" >> _vest >> "ItemInfo" >> "containerClass") >> "maximumLoad");

private _backpack = switch true do {
	case ((_uniformLoad+_vestLoad)>_totalLoadWeight):{""};
	case ((_totalLoadWeight-(_uniformLoad+_vestLoad))<=80):{
		["B_OutdoorPack_tan","B_OutdoorPack_blk"] select SIDE_INDEX
	};
	case ((_totalLoadWeight-(_uniformLoad+_vestLoad))<=160):{
		["B_AssaultPack_mcamo","B_AssaultPack_ocamo"] select SIDE_INDEX
	};
	case ((_totalLoadWeight-(_uniformLoad+_vestLoad))<=240):{
		["B_TacticalPack_mcamo","B_TacticalPack_ocamo"] select SIDE_INDEX
	};
	case ((_totalLoadWeight-(_uniformLoad+_vestLoad))<=320 OR {((_totalLoadWeight-(_uniformLoad+_vestLoad))>320)&&{!(["B_Bergen_mcamo_F"] call CaptureTheFlag_c_system_isItemDLCOwned)}}):{
		["B_Carryall_mcamo","B_Carryall_ocamo"] select SIDE_INDEX
	};
	case ((_totalLoadWeight-(_uniformLoad+_vestLoad))>320):{
		["B_Bergen_mcamo_F","B_Bergen_hex_F"] select SIDE_INDEX
	};
	default {""};
};
private _backpackLoad = getNumber(configfile >> "cfgvehicles" >> _backpack >> "maximumLoad");


private _genItemList = {
	params [["_loadLimit",0,[0]]];
	private _loadValue = 0;
	private _tmpArr = _addItems apply {[_x call _getItemWeight,_x]};
	private _outArr = [];
	{
		_x params ["_w","_i"];
		if ((_loadValue+_w)<=_loadLimit) then {
			_loadValue = _loadValue + _w;
			_outArr pushback _i;
			_addItems set [_addItems find _i,0];
		};
	} foreach _tmpArr;
	_addItems = _addItems - [0];
	_tmpArr = +_outArr;
	_outArr = [];
	while {count _tmpArr > 0} do {
		_outArr pushback [_tmpArr select 0,{_x isequalto (_tmpArr select 0)} count _tmpArr];
		_tmpArr = _tmpArr - [_tmpArr select 0];
	};
	_outArr apply {if (isClass(configFile >> "CfgMagazines" >> (_x select 0))) then {_x+[1]} else {_x};};
};

_loadout set [3,[_uniform,[_uniformLoad] call _genItemList]];
_loadout set [4,[_vest,[_vestLoad] call _genItemList]];
if (_backpack!="")then{_loadout set [5,[_backpack,[_backpackLoad] call _genItemList]];};

player setUnitLoadout [_loadout,true];

_loadout