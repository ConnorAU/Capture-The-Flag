/*-------------------------------------------------------
|                                                       |
| ~ Load Map From File                                  |
|                                                       |
-------------------------------------------------------*/
// There was a good reason for this to be a macro but I can't figure out what it was
#define LMFF_V53_HANDLE_ITEM_CUSTOM_ATTRIBUTES {\
	_customAttributeValue = (_x >> "value" >> "data" >> "value") call BIS_fnc_getCfgData;\
	_customAttributeValueType = getArray(_x >> "value" >> "data" >> "type" >> "type") param [0,typename _customAttributeValue,[""]];\
	if (typename _customAttributeValue != _customAttributeValueType) then {\
		_customAttributeValue = switch _customAttributeValueType do {\
			case (typename 0):{\
				if (typename _customAttributeValue == typename "") exitwith {parseNumber _customAttributeValue};\
				_customAttributeValue\
			};\
			case (typename true):{\
				if (typename _customAttributeValue == typename 0) exitwith {_customAttributeValue isEqualTo 1};\
				if (typename _customAttributeValue == typename "") exitwith {[call compile _customAttributeValue]param[0,false,[true]]};\
				_customAttributeValue\
			};\
			default {_customAttributeValue};\
		};\
	};\
	_customAttributeExpression = getText(_x >> "expression");\
	[_customAttributeValue,_createdItem] call compile ("params ['_value','_this'];"+_customAttributeExpression);\
}foreach("true" configClasses (_x >> "CustomAttributes"));