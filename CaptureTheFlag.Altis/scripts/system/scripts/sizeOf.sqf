/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [["_obj","",[objNull,""]]];
if (_obj isEqualType objNull) then {_obj = typeof _obj};
if (_obj == "") exitwith {0};
private _size = sizeof _obj;
if (_size == 0) then {
	// sizeOf reports 0 when the class doesnt have an object of its type present in the world
	private _dV = _obj createVehicleLocal [random worldSize,random worldSize,random 10000 max 100];
	_size = sizeOf _obj;
	if (_size == 0) then {
		// If its still reporting 0 we will find it manually
		private _bB = boundingBoxReal _dV param [1,[]];
		_size = ((_bB param [0,0]) max (_bB param [1,0]))*2
	};
	deleteVehicle _dV;
};
_size
