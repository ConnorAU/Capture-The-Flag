/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

// This was used when editing the dynamic maps to make a config friendly list of walls, gates and lights that needed godmode i think.

[]spawn{
	_ris = {
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
	};
	_classes = ("true" configClasses (configfile >> "cfgvehicles"));
	_d = 100;
	_a=[];
	{
		_a append (
			(nearestTerrainObjects[getMarkerPos _x,["Wall","Tree","House"],(markerSize _x select 0) max (markerSize _x select 1)]) +
			((nearestObjects[getMarkerPos _x,[],(markerSize _x select 0) max (markerSize _x select 1)]) select {
				(["lamp",str _x] call BIS_fnc_inString) OR 
				(["pipewall_concretel",str _x] call BIS_fnc_inString) OR 
				(["gate",str _x] call BIS_fnc_inString)
			})
		);
	} foreach allmapmarkers;

	_cc = count _a;
	{
		_o = _x;
		_c = _classes select {tolower getText(_x >> "model") find tolower(getmodelinfo _o select 1)>-1} apply {configname _x};
		_a set [_foreachindex,[_c param [0,""],getModelInfo _x select 1,getpos _x]];
		systemchat str (((_foreachindex+1)/_cc)*100);
	} foreach _a;
	_a sort true;
	_a = [str _a,"[","{"] call _ris;
	_a = [_a,"]","}"] call _ris;
	a="replaceObjectsList[]="+_a+";";
	copytoclipboard a;
};