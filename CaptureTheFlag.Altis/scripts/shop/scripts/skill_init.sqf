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
uiNamespace setVariable ["CaptureTheFlag_UI_SkillShop",_display];
_display displayAddEventHandler ["KeyDown",{(_this select 1)in([57]+actionKeys"MoveForward" + actionKeys"MoveBack" + actionKeys"TurnLeft" + actionKeys"TurnRight")}];
_display displayAddEventHandler ["Unload",{
	if !(isNil "CaptureTheFlag_shop_skill_edited") then {
		CaptureTheFlag_shop_skill_edited = nil;
		true call CaptureTheFlag_c_session_writeData;
		[] call CaptureTheFlag_c_skill_reload;
		[] call CaptureTheFlag_c_setup_setLoadout;
	};
}];

private _exitButton = _display displayCtrl 2;
_exitButton ctrlAddEventHandler ["buttonclick",{(ctrlParent(_this select 0)) closeDisplay 2}];

[] call CaptureTheFlag_c_shop_skill_populateContainer;