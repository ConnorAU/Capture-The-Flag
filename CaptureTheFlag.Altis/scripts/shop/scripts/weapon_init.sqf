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

disableSerialization;
params ["_display"];
uiNamespace setVariable ["CaptureTheFlag_UI_WeaponShop",_display];
_display displayAddEventHandler ["KeyDown",{(_this select 1)in([57]+actionKeys"MoveForward" + actionKeys"MoveBack" + actionKeys"TurnLeft" + actionKeys"TurnRight")}];
_display displayAddEventHandler ["Unload",{
	CaptureTheFlag_shop_weapon_selection = nil;
	CaptureTheFlag_shop_weapon_price = nil;
}];

private _purchaseButton = _display displayCtrl 30;
private _setAsLoadout = _display displayCtrl 31;
private _exitButton = _display displayCtrl 2;
private _primaryButton = _display displayCtrl 10;
private _launcherButton = _display displayCtrl 11;
private _handgunButton = _display displayCtrl 12;
private _selectedWeapon = _display displayCtrl 20;
private _selectedOptic = _display displayCtrl 21;
private _selectedPointer = _display displayCtrl 22;
private _selectedMuzzle = _display displayCtrl 23;
private _selectedBipod = _display displayCtrl 24;

_purchaseButton ctrlAddEventHandler ["buttonclick",{["buy",_this select 0] call CaptureTheFlag_c_shop_weapon_purchaseItems}];
_setAsLoadout ctrlAddEventHandler ["buttonclick",{["save",_this select 0] spawn CaptureTheFlag_c_shop_weapon_purchaseItems}];
_exitButton ctrlAddEventHandler ["buttonclick",{(ctrlParent(_this select 0)) closeDisplay 2}];

_primaryButton ctrlSetText "Primary";
_primaryButton ctrlAddEventHandler ["buttonclick",{["primary",ctrlParent(_this select 0)] call CaptureTheFlag_c_shop_weapon_populateSlider}];
_launcherButton ctrlSetText "Launcher";
if SKILL_ACTIVE("packingHeat") then {
	_launcherButton ctrlAddEventHandler ["buttonclick",{["launcher",ctrlParent(_this select 0)] call CaptureTheFlag_c_shop_weapon_populateSlider}];
} else {
	_launcherButton ctrlenable false;
	_launcherButton ctrlSetTooltip ("Equip the "+str gettext(SKILLS_SHOP_CONFIG_PATH >> "packingHeat" >> "displayName")+" skill to purchase launchers");
};
_handgunButton ctrlSetText "Pistol";
_handgunButton ctrlAddEventHandler ["buttonclick",{["pistol",ctrlParent(_this select 0)] call CaptureTheFlag_c_shop_weapon_populateSlider}];

_selectedWeapon ctrlAddEventHandler ["buttonclick",{[ctrlParent(_this select 0) getVariable ["weaponmode","primary"],ctrlParent(_this select 0)] call CaptureTheFlag_c_shop_weapon_populateSlider}];
_selectedOptic ctrlAddEventHandler ["buttonclick",{["optic",ctrlParent(_this select 0)] call CaptureTheFlag_c_shop_weapon_populateSlider}];
_selectedPointer ctrlAddEventHandler ["buttonclick",{["pointer",ctrlParent(_this select 0)] call CaptureTheFlag_c_shop_weapon_populateSlider}];
_selectedMuzzle ctrlAddEventHandler ["buttonclick",{["muzzle",ctrlParent(_this select 0)] call CaptureTheFlag_c_shop_weapon_populateSlider}];
_selectedBipod ctrlAddEventHandler ["buttonclick",{["bipod",ctrlParent(_this select 0)] call CaptureTheFlag_c_shop_weapon_populateSlider}];

CaptureTheFlag_shop_weapon_selection = [["","","","",""],["","","","",""],["","","","",""]];

["primary",_display] call CaptureTheFlag_c_shop_weapon_populateSlider;
[_display] call CaptureTheFlag_c_shop_weapon_populateBuyButtons;


actionKeys"MoveForward" + actionKeys"MoveBack" + actionKeys"TurnLeft" + actionKeys"TurnRight"