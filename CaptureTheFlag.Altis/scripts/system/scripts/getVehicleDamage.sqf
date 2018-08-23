/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

private _o = param [0,objNull,[objNull]];
if (isNull _o) exitwith {0};
private _c = 0;
private _l = getAllHitPointsDamage _o param [2,[]];
{_c = _c + _x} foreach _l;
_c