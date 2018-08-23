/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */


// I think this was for actions on some objects that were too thin to look at. 
// The idea was if the object was in a region on ur screen the action would show.
// I don't recall it working very well

params [
	["_pos",[0,0,0],[objNull,[]]],
	["_ex",[0.3,0.5],[[]]],
	["_y",[0.6,1.1],[[]]]
];
_ex params [
	["_exMin",0.3,[0]],
	["_exMax",0.5,[0]]
];
_y params [
	["_yMin",0.6,[0]],
	["_yMax",1.1,[0]]
];

if (_pos isEqualType objNull) then {
	_pos = _pos modelToWorldVisual [0,0,0];
};
_pos = worldToScreen _pos;
_pos params [
	["_posX",0,[0]],
	["_posY",0,[0]]
];


(
 	_posX > _exMin && 
 	{
 		_posX < _exMax && 
 		{
 			_posY > _yMin && 
 			{
 				_posY < _yMax
 			}
 		}
 	}
)