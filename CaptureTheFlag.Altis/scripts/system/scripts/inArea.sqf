/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [["_unit",objNull,[objNull]],["_zone","",["",locationNull,objNull,[]]]];
if !(_zone isEqualType []) then {_zone = [_zone]};
{_unit inArea _x} count _zone > 0;
