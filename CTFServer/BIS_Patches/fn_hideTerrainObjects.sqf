/*
	Had an error using this on the dynamic map sqm files.
	I'm writing this as I prepare it for github (17 Aug 2018) so not 100% sure what it was,
	but I'm pretty sure it had to do with _a and/or _b not being set.
	From memory this is a copy paste of what I needed from the original BIS file with default values added in params (L22)
*/

private _mode = param [0,"",[""]];
private _input = param [1,[],[[]]];
private _module = _input param [0,objNull,[objNull]];

switch _mode do
{
	case "init":
	{
		if (!is3DEN) then
		{
			private _area = [getPos _module];
			_area append (_module getVariable ["objectarea",[1,1]]);
			_area params ["_pivot",["_a",0],["_b",0]];

			private _radius = (_a max _b) * 1.42;
			private _objects = [];

			private _value = _module getVariable ["#filter",0];
			private _flags = _value call bis_fnc_decodeFlags2;

			{
				if (_x == 1) then
				{
					private _found = nearestTerrainObjects [_module,[["BUILDING","HOUSE","CHURCH","CHAPEL","FUELSTATION","HOSPITAL","RUIN","BUNKER"],["WALL","FENCE"],["TREE","SMALL TREE","BUSH"],["ROCK","ROCKS","FOREST BORDER","FOREST TRIANGLE","FOREST SQUARE","CROSS","FORTRESS","FOUNTAIN","VIEW-TOWER","LIGHTHOUSE","QUAY","HIDE","BUSSTOP","ROAD","FOREST","TRANSMITTER","STACK","TOURISM","WATERTOWER","TRACK","MAIN ROAD","POWER LINES","RAILWAY","POWERSOLAR","POWERWAVE","POWERWIND","SHIPWRECK","TRAIL"]] select _forEachIndex,_radius,false,true];

					{_x hideObjectGlobal true;} forEach (_found inAreaArray _area);
				};
			}
			forEach _flags;

			deleteVehicle _module;
		};
	};
};