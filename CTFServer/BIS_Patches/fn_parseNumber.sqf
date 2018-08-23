/*
	Author: Karel Moricky

	Description:
	Return number from expression

	Parameter(s):
	_this: NUMBER or STRING or CODE or CONFIG

	Returns:
	NUMBER
*/
private ["_number","_index"];
_number = _this param [0,-1,[0,"",{},configfile]];
switch (typename _number) do {

	case (typename {}): {
		_number = call _number;
		if (isnil {_number}) then {_number = -1;};
		_number
	};

	case (typename ""): {
// ~~ Modification start
		for "_i" from 0 to 1 step 0 do {
			_index = _number find ";";
			if (_index == -1) exitwith {};
			_number = _number select [_index + 1];
		};
// ~~ Modification end
		_number = call compile _number;
		if (isnil {_number}) then {_number = -1;};
		_number
	};

	case (typename configfile): {

		if (isnumber _number) then {
			getnumber _number
		} else {
			if (istext _number) then {
				(gettext _number) call bis_fnc_parsenumber
			} else {
				-1
			};
		};
	};

	default {_number};
};