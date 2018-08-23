/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [["_obj",cursorTarget,[objNull]],["_modifier","",[""]]];
if (isNull _obj) exitwith {0};
private _value = boundingBoxReal _obj param [1,[],[[]]] param [1,0,[0]];
switch _modifier do {
	case "d":{
		switch tolower(typeof _obj) do {
			case (tolower"C_Kart_01_F");
			case (tolower"B_QUADBIKE_01_F");
			case (tolower"O_QUADBIKE_01_F"):{_value*2};
			case (tolower"C_Hatchback_01_F");
			case (tolower"C_Hatchback_01_sport_F"):{_value*1.2};
			case (tolower"C_Truck_02_transport_F"):{_value/1.5};
			case (tolower"B_Truck_01_transport_F"):{_value/1.4};
			case (tolower"B_Heli_Light_01_F"):{_value/1.6};
			case (tolower"O_Heli_Transport_04_bench_F"):{_value/2};
			case (tolower"O_Heli_Light_02_unarmed_F"):{_value/2.1};
			case (tolower"O_Heli_Light_02_unarmed_F"):{_value/2.1};
			default {_value};
		};
	};
	case "rv":{
		_value = _value * 3;
		switch tolower(typeof _obj) do {
			//case (tolower"B_Heli_Light_01_F");
			//case (tolower"O_Heli_Transport_04_bench_F");
			//case (tolower"O_Heli_Light_02_unarmed_F"):{_value+7};
			default {_value};
		};
	};
	case "rar":{
		_value = _value * 2.5;
		switch true do {
			case ([_obj,"Air"] call CaptureTheFlag_c_system_isKindOf):{_value+7};
			case ([_obj,"Truck_F"] call CaptureTheFlag_c_system_isKindOf):{_value+3};
			default {_value};
		};
	};
	default {_value};
};