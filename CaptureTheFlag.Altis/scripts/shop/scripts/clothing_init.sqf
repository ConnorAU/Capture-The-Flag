/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

disableSerialization;
params ["_display"];
uiNamespace setVariable ["CaptureTheFlag_UI_ClothingShop",_display];
_display displayAddEventHandler ["KeyDown",{(_this select 1)in([57]+actionKeys"MoveForward" + actionKeys"MoveBack" + actionKeys"TurnLeft" + actionKeys"TurnRight")}];
_display displayAddEventHandler ["Unload",{
	CaptureTheFlag_shop_clothing_selection = nil;
	CaptureTheFlag_shop_clothing_price = nil;
}];

private _selectedUniform = _display displayCtrl 20;
private _selectedVest = _display displayCtrl 21;
private _selectedHat = _display displayCtrl 22;
private _selectedEyes = _display displayCtrl 23;
private _purchaseButton = _display displayCtrl 30;
private _setAsLoadout = _display displayCtrl 31;
private _exitButton = _display displayCtrl 2;

_selectedUniform ctrlAddEventHandler ["buttonclick",{["uniform"] call CaptureTheFlag_c_shop_clothing_populateSlider}];
_selectedVest ctrlAddEventHandler ["buttonclick",{["vest"] call CaptureTheFlag_c_shop_clothing_populateSlider}];
_selectedHat ctrlAddEventHandler ["buttonclick",{["hat"] call CaptureTheFlag_c_shop_clothing_populateSlider}];
_selectedEyes ctrlAddEventHandler ["buttonclick",{["eyes"] call CaptureTheFlag_c_shop_clothing_populateSlider}];
_purchaseButton ctrlAddEventHandler ["buttonclick",{["buy",_this select 0] call CaptureTheFlag_c_shop_clothing_purchaseItems}];
_setAsLoadout ctrlAddEventHandler ["buttonclick",{["save",_this select 0] spawn CaptureTheFlag_c_shop_clothing_purchaseItems}];
_exitButton ctrlAddEventHandler ["buttonclick",{(ctrlParent(_this select 0)) closeDisplay 2}];

_purchaseButton ctrlSetTooltip "Purchase the selected loadout for one use";
_setAsLoadout ctrlSetTooltip "Purchase the selected loadout and save it as your default loadout";

// Stats script from arsenal i believe
private _statsEquipment = [
	("getnumber (_x >> 'scope') == 2 && getnumber (_x >> 'itemInfo' >> 'type') in [605,701,801]") configclasses (configfile >> "cfgweapons"),
	["passthrough","armor","maximumLoad","mass"],
	[false,false,false,false]
] call bis_fnc_configExtremes;
private _statsBackpacks = [
	("getnumber (_x >> 'scope') == 2 && getnumber (_x >> 'isBackpack') == 1") configclasses (configfile >> "cfgvehicles"),
	["passthrough","armor","maximumLoad","mass"],
	[false,false,false,false]
] call bis_fnc_configExtremes;

_statsEquipment params ["_statsEquipmentMin","_statsEquipmentMax"];
_statsBackpacks params ["_statsBackpacksMin","_statsBackpacksMax"];
for "_i" from 2 to 3 do {
	_statsEquipmentMin set [_i,(_statsEquipmentMin select _i) min (_statsBackpacksMin select _i)];
	_statsEquipmentMax set [_i,(_statsEquipmentMax select _i) max (_statsBackpacksMax select _i)];
};

_display setVariable ["itemStats",[_statsEquipmentMin,_statsEquipmentMax]];

CaptureTheFlag_shop_clothing_selection = ["","","",""];

[] call CaptureTheFlag_c_shop_clothing_populateBuyButtons;
[] call CaptureTheFlag_c_shop_clothing_populateItemButtons;
[] call CaptureTheFlag_c_shop_clothing_populateSlider;