/*
	Author: Karel Moricky

	Description:
	Convert a number into string (avoiding scientific notation)

	Parameter(s):
	_this: NUMBER

	Returns:
	STRING
*/
params [
	["_number",0,[0]],
	["_seperator",",",[""]],
	["_mod",3,[0]]
];

private _digits = _number call bis_fnc_numberDigits;
if (_seperator == "") exitwith {_digits joinstring ""};

private _digitsCount = count _digits - 1;
private _modBase = _digitsCount % _mod;
private _numberText = "";
{
	_numberText = _numberText + str _x;
	if ((_foreachindex - _modBase) % (_mod) == 0 && _foreachindex != _digitsCount) then {_numberText = _numberText + _seperator;};
} foreach _digits;
_numberText;
