/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [
    ["_in","",[""]],
    ["_old","",[""]],
    ["_new","",[""]],
    "_oldCount","_out","_index"
];
_oldCount = count _old;
_out = [];
for "_i" from 0 to 1 step 0 do {
    _index = _in find _old;
    if (_index < 0) exitwith {_out pushback _in;};
    _out pushback (_in select [0,_index]);
    _out pushback _new;
    _in = (_in select [_index + _oldCount,count _in]);
};
_out joinString ""
