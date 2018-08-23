/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

// KK
params [["_unit",cursorObject,[objNull]],["_pos",[],[[]]]];
if (count _pos == 0) then {_pos = getPosWorld _unit};
lineIntersectsSurfaces [
    _pos,
    _pos vectorAdd [0,0,50],
    _unit,objNull,true,1,"GEOM","NONE"
] param [0,[]] params ["","","",["_obj",objNull]];
_obj
