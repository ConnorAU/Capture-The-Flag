/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

disableSerialization;
params ["_ctrl"];

private _display = ctrlParent _ctrl;
private _buttons = [_display displayCtrl 10,_display displayCtrl 11,_display displayCtrl 12];

{_x ctrlSetTextColor [1,1,1,1]}foreach _buttons;
_ctrl ctrlSetTextColor (PROFILE_COLOURS+[1]);

[_ctrl getVariable ["type",""]] call CaptureTheFlag_c_shop_vehicle_populateSlider;