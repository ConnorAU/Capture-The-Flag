/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"

params [["_skin","",[""]],["_ctrl",controlNull,[controlNull]]];

private _display = ctrlParent _ctrl;

private _selectedSkinSide = _display displayCtrl 22;
private _selectedSkinCamo = _display displayCtrl 23;

{_x ctrlSetTextColor [1,1,1,1]}foreach [_selectedSkinSide,_selectedSkinCamo];
_ctrl ctrlSetTextColor (PROFILE_COLOURS+[1]);

_display setVariable ["skin",_skin];