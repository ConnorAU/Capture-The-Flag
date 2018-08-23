/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [
	["_addOrRemove",0,[true]],
	["_item","",[""]],
	["_replace",false,[true]],
	["_forceInINV",false,[true]],
	["_extraParam",-1]
];
if (_addOrRemove isEqualType 0) exitwith {false};
if (_item == "") exitwith {false};


private ["_itemCfg","_itemType","_itemInfoType","_retAttachmentType","_tmp","_addToInv","_addToWep"];
_itemCfg = switch true do {
	case (isClass(configFile >> "CfgMagazines" >> _item)):{"CfgMagazines"};
	case (isClass(configFile >> "CfgWeapons" >> _item)):{"CfgWeapons"};
	case (isClass(configFile >> "CfgVehicles" >> _item)):{"CfgVehicles"};
	case (isClass(configFile >> "CfgGlasses" >> _item)):{"CfgGlasses"};
	default {""};
};
if (_itemCfg == "") exitwith {false};
_itemType = switch _itemCfg do {
	case "CfgVehicles":{getText(configFile >> _itemCfg >> _item >> "vehicleClass")};
	case "CfgWeapons":{getNumber(configFile >> _itemCfg >> _item >> "type")};
	default {-1};
};
_itemInfoType = switch _itemCfg do {
	case "CfgWeapons":{
		if (isClass(configfile >> _itemCfg >> _item >> "ItemInfo")) then {
			getNumber(configFile >> _itemCfg >> _item >> "ItemInfo" >> "Type")
		} else {-1};
	};
	default {-1};
};


if _addOrRemove then {
	_addToInv = {
		switch true do {
			case (player canAddItemToBackpack _this):{player addItemToBackpack _this;true};
			case (player canAddItemToVest _this):{player addItemToVest _this;true};
			case (player canAddItemToUniform _this):{player addItemToUniform _this;true};
			default {false};
		};
	};
	switch _itemCfg do {
		case "CfgGlasses":{
			if _forceInINV then {
				_item call _addToInv;
			} else {
				if _replace then {
					player addGoggles _item;
					true
				} else {
					if (goggles player == "") then {
						player addGoggles _item;
						true
					} else {
						_item call _addToInv;
					};
				};
			};
		};
		case "CfgVehicles":{
			if (backpack player != "") then {
				_tmp = backpackitems player;
				removeBackpack player;
			};
			player addBackpack _item;
			clearAllItemsFromBackpack player;
			if (!isNil "_tmp" && {_tmp isequaltype []}) then {
				{_x call _addToInv}foreach _tmp;
			};
			true
		};
		case "CfgMagazines":{
			if (player canAdd _item) then {
				if (_extraParam < 0) then {player addMagazine _item;} else {player addMagazine [_item,_extraParam];};
				true
			} else {false};
		};
		case "CfgWeapons":{
			if _forceInINV then {
				_item call _addToInv;
			} else {
				_tmp = if (_itemType in [1,2,4,5,4096]) then {
					if (_itemType isEqualTo 4096) then {
						if (_itemInfoType isEqualTo -1) then {true} else {false};
					} else {
						true
					};
				} else {
					false
				};
				if _tmp then {
					if (_item == "MineDetector") then {
						_item call _addToInv;
					} else {
						if _replace then {
							player addWeapon _item;
							true
						} else {
							switch _itemType do {
								case 1:{
									if (primaryWeapon player != "") then {_item call _addToInv} else {player addWeapon _item;true};
								};
								case 2:{
									if (handgunWeapon player != "") then {_item call _addToInv} else {player addWeapon _item;true};
								};
								case 4:{
									if (secondaryWeapon player != "") then {_item call _addToInv} else {player addWeapon _item;true};
								};
								case 4096:{
									_tmp = [];
									{_tmp pushback (tolower(configname _x))}foreach ("getNumber(_x >> ""type"") == 4096 && !isClass(_x >> ""ItemInfo"")" configclasses (configfile >> "CfgWeapons"));
									{if (_x in ((assignedItems player) apply {tolower _x})) exitwith {_tmp = true;};}foreach _tmp;
									if (_tmp isequaltype true) then {_item call _addToInv} else {player addweapon _item;true};
								};
								default {_item call _addToInv};
							};
						};
					};
				} else {
					_addToWep = {
						params [
							["_item","",[""]],
							["_wepType",-1,[0]],
							["_canAddToWep",false,[true]]
						];
						if _canAddToWep then {
							switch _wepType do {
								case 0:{player addPrimaryWeaponItem _item;true};
								case 1:{player addHandgunItem _item;true};
								case 2:{player addSecondaryWeaponItem _item;true};
								default {_item call _addToInv};
							};
						} else {
							_item call _addToInv;
						};
					};
					_retAttachmentType = {
						params [
							["_item","",[""]],
							["_attType",-1,[0]],
							["_return",[-1,false],[[]]]
						];
						if (_item == "" OR _attType < 0) exitwith {_return};
						{
							if (_x != "") then {
								if ((tolower _item) in (getArray(configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo" >> (["CowsSlot","MuzzleSlot","PointerSlot","UnderBarrelSlot"] param [_attType,""]) >> "compatibleItems") apply {tolower _x})) exitwith {
									private _currentItems = call compile format["%1items player",["primaryWeapon","handgun","secondaryWeapon"] select _foreachindex];
									_return = [_foreachindex,_currentItems select ([2,0,1,3] select _attType) == ""];
								};
							};
							if ((_return select 0) >= 0) exitwith {};
						}foreach [primaryWeapon player,handgunWeapon player,secondaryWeapon player];
						_return
					};
					switch _itemInfoType do {
						case 0:{
							_tmp = _item call _addToInv;
							if (_tmp && {!((tolower _item) in ((assignedItems player)apply{tolower _x}))}) then {player assignItem _item;};
							_tmp
						};
						case 605:{
							if (headgear player != "" && !_replace) then {_item call _addToInv} else {player addHeadgear _item;true};
						};
						case 801:{
							if (uniform player != "") then {
								if _replace then {
									_tmp = uniformItems player;
									player forceAddUniform _item;
									if (count _tmp > 0) then {
										{if (player canAddItemToUniform _x) then {player addItemToUniform _x} else {_x call _addToInv;};}foreach _tmp;};
									true
								} else {
									_item call _addToInv;
								};
							} else {
								player forceAddUniform _item;true
							};
						};
						case 701:{
							if (vest player != "") then {
								if _replace then {
									_tmp = vestItems player;
									player addVest _item;
									if (count _tmp > 0) then {
										{if (player canAddItemToVest _x) then {player addItemToVest _x} else {_x call _addToInv;};}foreach _tmp;};
									true
								} else {
									_item call _addToInv;
								};
							} else {
								player addVest _item;true
							};
						};
						case 101:{
							_tmp = [_item,1] call _retAttachmentType;
							[_item,_tmp param [0,-1,[0]],_replace OR (_tmp param [1,false,[true]])] call _addToWep;
						};
						case 201:{
							_tmp = [_item,0] call _retAttachmentType;
							[_item,_tmp param [0,-1,[0]],_replace OR (_tmp param [1,false,[true]])] call _addToWep;
						};
						case 301:{
							_tmp = [_item,2] call _retAttachmentType;
							[_item,_tmp param [0,-1,[0]],_replace OR (_tmp param [1,false,[true]])] call _addToWep;
						};
						case 302:{
							_tmp = [_item,3] call _retAttachmentType;
							[_item,_tmp param [0,-1,[0]],_replace OR (_tmp param [1,false,[true]])] call _addToWep;
						};
						case 621:{
							_tmp = [];
							{_tmp pushback (tolower(configname _x))}foreach ("getNumber(_x >> ""type"") == 4096 && getNumber(_x >> ""ItemInfo"" >> ""Type"") == 621" configclasses (configfile >> "CfgWeapons"));
							{if (_x in ((assignedItems player) apply {tolower _x})) exitwith {_tmp = true;};}foreach _tmp;
							if !(_tmp isequaltype true) then {
								_tmp = _item call _addToInv;
								player assignItem _item;
								_tmp
							} else {
								_item call _addToInv;
							};
						};
						case 616:{
							_tmp = [];
							{_tmp pushback (tolower(configname _x))}foreach ("getNumber(_x >> ""type"") == 4096 && getNumber(_x >> ""ItemInfo"" >> ""Type"") == 616" configclasses (configfile >> "CfgWeapons"));
							{if (_x in ((assignedItems player) apply {tolower _x})) exitwith {_tmp = true;};}foreach _tmp;
							if !(_tmp isequaltype true) then {
								_tmp = _item call _addToInv;
								player assignItem _item;
								_tmp
							} else {
								_item call _addToInv;
							};
						};
						default {_item call _addToInv};
					};
				};
			};
		};
		default {false};
	};
} else {
	switch _itemCfg do {
		case "CfgGlasses":{
			if (goggles player == _item) then {
				removeGoggles player;
			} else {
				player removeItem _item;
			};
			true
		};
		case "CfgVehicles":{
			if (backpack player == _item) then {
				removeBackpack player;
			} else {
				player removeItem _item;
			};
			true
		};
		case "CfgMagazines":{
			if (_extraParam isEqualTo -1 && {(tolower _item) in ((uniformItems player + vestitems player + backpackitems player) apply {tolower _x})}) then {
				player removeMagazine _item;
			} else {
				private _weaponAtt = [];
				switch true do {
					case (_item in primaryWeaponMagazine player):{
						_weaponAtt = primaryWeaponItems player;
						player addWeapon primaryWeapon player;
						removeAllPrimaryWeaponItems player;
						{if (_x != "") then {player addPrimaryWeaponItem _x}} foreach _weaponAtt;
					};
					case (_item in secondaryWeaponMagazine player):{
						_weaponAtt = secondaryWeaponItems player;
						player addWeapon secondaryWeapon player;
						{if (_x != "") then {player removeSecondaryWeaponItem _x}} foreach (secondaryWeaponItems player);
						{if (_x != "") then {player addSecondaryWeaponItem _x}} foreach _weaponAtt;
					};
					case (_item in handgunMagazine player):{
						_weaponAtt = handgunItems player;
						player addWeapon handgunWeapon player;
						removeAllHandgunItems player;
						{if (_x != "") then {player addHandgunItem _x}} foreach _weaponAtt;
					};
					default {};
				};
			};
			true
		};
		case "CfgWeapons":{
			_tmp = if (_itemType in [1,2,4,5,4096]) then {
				if (_itemType isEqualTo 4096) then {
					if (_itemInfoType isEqualTo -1) then {true} else {false};
				} else {
					true
				};
			} else {
				false
			};
			if _tmp then {
				if (tolower _item in (["MineDetector","ItemCompass","ItemGPS","ItemMap","ItemRadio","ItemWatch"]apply{tolower _x})) then {
					player removeItem _item;
				} else {
					_tmp = ((tolower _item) in (([primaryweapon player,handgunWeapon player,secondaryWeapon player]+(assignedItems player)) apply {tolower _x}));
					if _tmp then {
						player removeWeapon _item;
					} else {
						player removeItem _item;
					};
				};
			} else {
				switch _itemInfoType do {
                    case 0;
                    case 616;
                    case 621:{player unassignItem _item;player removeItem _item;};
                    case 605:{if (headgear player == _item) then {removeHeadgear player} else {player removeItem _item};};
                    case 801:{if (uniform player == _item) then {removeUniform player} else {player removeItem _item};};
                    case 701:{if (vest player == _item) then {removeVest player} else {player removeItem _item};};
                    default {
                        switch true do {
                            case (_item in primaryWeaponItems player) : {player removePrimaryWeaponItem _item;};
                            case (_item in handgunItems player) : {player removeHandgunItem _item;};
                            case (_item in secondaryWeaponItems player) : {player removeSecondaryWeaponItem _item;};
                            default {player removeItem _item;};
                        };
                    };
				};
			};
			true
		};
		default {false};
	};
};
