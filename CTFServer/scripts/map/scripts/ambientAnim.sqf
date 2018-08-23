/*
	Somewhere near the bottom I think it is a modified version of BIS_fnc_ambientAnim 
	Had to make this replacement to prevent NPC's standing still for players who loaded in immediatly after a soft restart
*/


//surpress the debuglog output
private["_fnc_log_disable"];_fnc_log_disable = false;

if (isNil "BIS_fnc_ambientAnim__group") then
{
	BIS_fnc_ambientAnim__group = createGroup west;
};

//do the immediate operations ----------------------------------------------------------------------
private["_unit","_animset","_gear","_anims","_anim","_linked","_xSet","_azimutFix","_interpolate","_canInterpolate","_attach"];
private["_attachOffset","_attachObj","_attachSpecsAuto","_attachSpecs","_attachSnap","_noBackpack","_noWeapon","_randomGear","_weapon","_forcedSnapPoint","_params"];

_unit  	 	 = _this param [0, objNull, [objNull]];
_animset 	 = _this param [1, "STAND", [""]];
_gear    	 = _this param [2, "RANDOM", [""]];
_forcedSnapPoint = _this param [3, objNull, [objNull]];
_interpolate	 = _this param [4, false, [true]];
_attach		 = _this param [5, true, [true]];

if (isNull _unit) exitWith
{
	//["Function terminated, unit doesn't exist!"] call BIS_fnc_logFormat;
};

if (isNil "_forcedSnapPoint") then
{
	["Forced snappoint doesn't exist!"] call BIS_fnc_error;

	_forcedSnapPoint = objNull;
};

if ((_unit getVariable ["BIS_fnc_ambientAnim__animset",""]) != "") exitWith
{
	["[%1] Trying to play an ambient animation [%3] while another [%2] is already playing!",_unit,_unit getVariable ["BIS_fnc_ambientAnim__animset",""],_animset] call BIS_fnc_logFormat;

	/*
	_unit call BIS_fnc_ambientAnim__terminate;

	_this spawn
	{
		sleep 1;

		_this call BIS_fnc_ambientAnim;
	};
	*/
};

//surpress the unit "intelligence"
{_unit disableAI _x} forEach ["ANIM","AUTOTARGET","FSM","MOVE","TARGET"];

//detach unit, if already attached to something
detach _unit;

//store primary weapon
_weapon = primaryWeapon _unit;

if (_weapon != "") then
{
	_unit setVariable ["BIS_fnc_ambientAnim__weapon",_weapon];
};

/*--------------------------------------------------------------------------------------------------

	GET ANIMATION PARAMETERS

--------------------------------------------------------------------------------------------------*/
_params = _animset call BIS_fnc_ambientAnimGetParams;

//defaults
_anims		= _params select 0;
_azimutFix 	= _params select 1;
_attachSnap 	= _params select 2;
_attachOffset 	= _params select 3;
_noBackpack 	= _params select 4;
_noWeapon 	= _params select 5;
_randomGear 	= _params select 6;
_canInterpolate = _params select 7;

if (count _anims == 0) exitWith {};

if (_gear == "RANDOM") then
{
	_gear = _randomGear call BIS_fnc_selectRandom;
};

//setup the gear
[_unit,_gear,_noWeapon,_noBackpack,_weapon] spawn
{
	private["_unit","_gear","_noWeapon","_noBackpack","_weapon"];

	_unit 		= _this select 0;
	_gear 		= _this select 1;
	_noWeapon 	= _this select 2;
	_noBackpack 	= _this select 3;
	_weapon		= _this select 4;

	sleep 1;

	switch (_gear) do
	{
		case "NONE":
		{
			removeGoggles _unit;
			removeHeadgear _unit;
			removeVest _unit;
			removeAllWeapons _unit;

			_noBackpack = true;
			_noWeapon = true;
		};
		case "LIGHT":
		{
			removeGoggles _unit;
			removeHeadgear _unit;
			removeVest _unit;

			_noBackpack = true;
		};
		case "MEDIUM":
		{
			removeGoggles _unit;
			removeHeadgear _unit;
		};
		case "FULL":
		{
			removeGoggles _unit;
		};
		default
		{
		};
	};

	//remove NV goggles from units without helmets
	if (_gear != "ASIS") then
	{
		{ _unit unassignItem _x } forEach 
		[ 
			"NVGogglesB_grn_F", 
			"NVGoggles_tna_F",
			"NVGogglesB_gry_F",
			"NVGoggles_ghex_F",
			"NVGoggles_hex_F",
			"NVGoggles_urb_F",
			"nvgoggles", 
			"nvgoggles_opfor", 
			"nvgoggles_indep"
		];
	};

	//remove backpack for some anim sets
	if (_noBackpack) then
	{
		removeBackpack _unit;
	};

	//["[%1] _noWeapon = %2 | _storedWeapon = %3",_unit,_noWeapon,_unit getVariable ["BIS_fnc_ambientAnim__weapon",""]] call BIS_fnc_logFormat;

	//remove primary weapon for some anim sets
	if (_noWeapon) then
	{
		_unit removeWeapon _weapon;
	}
	else
	{
		private["_storedWeapon"];

		_storedWeapon = _unit getVariable ["BIS_fnc_ambientAnim__weapon",""];

		if (primaryWeapon _unit == "" && _storedWeapon != "") then
		{
			//["Weapon [%1] provided to unit [%2].",_storedWeapon,_unit] call BIS_fnc_logFormat;

			_unit addWeapon _storedWeapon;
			_unit selectWeapon _storedWeapon;
		};
	};
};

//find linked units = nearby units playing same animation set
_linked = _unit nearObjects ["man",5];
_linked = _linked - [_unit];

//["[%1] RAW linked: %2",_unit,_linked] call BIS_fnc_logFormat;

{
	_xSet = _x getVariable ["BIS_fnc_ambientAnim__animset",""];

	//["[%1] %2 has animset %3",_unit,_x,_xSet] call BIS_fnc_logFormat;

	if (_xSet != _animset || _xSet == "") then
	{
		_linked set [_forEachIndex,objNull];

		//["[%1] unit %2 removed from linked",_unit,_x] call BIS_fnc_logFormat;
	}
	else
	{
		//put a backlink into the linked unit
		_xLinked = _x getVariable ["BIS_fnc_ambientAnim__linked",[]];

		//["[%1] %2 has linked units %3",_unit,_x,_xLinked] call BIS_fnc_logFormat;

		if !(_unit in _xLinked) then
		{
			_xLinked = _xLinked + [_unit];
			_x setVariable ["BIS_fnc_ambientAnim__linked",_xLinked];

			//["[%1] %2 got a backlink to %1",_unit,_x] call BIS_fnc_logFormat;
		};
	};
}
forEach _linked; _linked = _linked - [objNull];

//["[%1] AFTER CLEAN linked: %2",_unit,_linked] call BIS_fnc_logFormat;

//get the auto snappoint specs
_attachSpecsAuto = switch (_animset) do
{
	case "SIT_AT_TABLE":
	{
		[
			["Land_CampingChair_V2_F",[0,0.08,-0.02],-180],
			["Land_ChairPlastic_F",[0,0.08,-0.02],90],
			["Land_ChairWood_F",[0,0.02,-0.02],-180]
		];
	};
	case "SIT";
	case "SIT1";
	case "SIT2";
	case "SIT3";
	case "SIT_U1";
	case "SIT_U2";
	case "SIT_U3":
	{
		[
			["Land_CampingChair_V2_F",[0,0.08,0.05],-180],
			["Land_ChairPlastic_F",[0,0.08,0.05],90],
			["Land_ChairWood_F",[0,0.02,0.05],-180]
		];
	};

	case "SIT_SAD1":
	{
		[
			["Box_NATO_Wps_F",[0,-0.27,0.03],0]
		];
	};
	case "SIT_SAD2":
	{
		[
			["Box_NATO_Wps_F",[0,-0.3,0.05],0]
		];
	};
	case "SIT_HIGH1":
	{
		[
			["Box_NATO_Wps_F",[0,-0.23,0.03],0]
		];
	};
	case "SIT_HIGH";
	case "SIT_HIGH2":
	{
		[
			["Box_NATO_Wps_F",[0,-0.12,-0.20],0]
		];
	};


	default
	{
		[];
	};
};

//adjust the auto attach data according to the soldiers gear
if ((count _attachSpecsAuto > 0) && !(_gear in ["NONE","LIGHT"])) then
{
	private["_attachPoint","_attachGearFix","_vest"];

	_attachGearFix = 0.06;
	_vest = toLower (vest _unit);

	if (_vest in ["v_platecarrier1_rgr"]) then
	{
		_attachGearFix = _attachGearFix + 0.08;
	};

	{
		_attachPoint = _x select 1;
		_attachPoint set [1, (_attachPoint select 1) + _attachGearFix];
		_x set [1, _attachPoint];
	}
	forEach _attachSpecsAuto;
};

//add the possible helper snappoint
_attachSpecsAuto = _attachSpecsAuto + [["Sign_Pointer_Cyan_F",[0,0,_attachOffset],0]];

if !(isNull _forcedSnapPoint) then
{
	_attachObj = _forcedSnapPoint;
	_attachSpecs = [typeOf _forcedSnapPoint,[0,0,_attachOffset],0];

	//get the attach specs
	{
		if ((_x select 0) == typeOf _forcedSnapPoint) exitWith
		{
			_attachSpecs = _x;
		};
	}
	forEach _attachSpecsAuto;
}
else
{
	//default situation, snappoint not found = using unit position
	_attachSpecs = [typeOf _unit,[0,0,_attachOffset],0];
	_attachObj = _unit;

	//get the snappoint object
	private["_obj"];

	{
		_obj = nearestObject [_unit, _x select 0];

		if (([_obj,_unit] call BIS_fnc_distance2D) < _attachSnap) exitWith
		{
			_attachSpecs = _x;
			_attachObj = _obj;
		};
	}
	forEach _attachSpecsAuto;
};


//store linked units, won't be changed
_unit setVariable ["BIS_fnc_ambientAnim__linked",_linked];		//array of units that should be checked for not playing same animation

//store persistant animation data in the units namespace
_unit setVariable ["BIS_fnc_ambientAnim__anims",_anims,true];
_unit setVariable ["BIS_fnc_ambientAnim__animset",_animset];
_unit setVariable ["BIS_fnc_ambientAnim__interpolate",_interpolate && _canInterpolate];

//store variable animation data in the units namespace
_unit setVariable ["BIS_fnc_ambientAnim__time",0];			//time when the animation has started

//disable collisions between unit and helper/attach object
_attachObj disableCollisionWith _unit;
_unit disableCollisionWith _attachObj;

//do the delayed operations ------------------------------------------------------------------------
[_unit,_attachObj,_attachSpecs,_azimutFix,_attach] spawn
{
	private["_unit","_attachObj","_attachSpecs","_azimutFix","_group","_attach"];
	private["_attachPos","_logic","_ehAnimDone","_ehKilled"];

	_unit		= _this select 0;
	_attachObj	= _this select 1;
	_attachSpecs	= _this select 2;
	_azimutFix	= (_this select 3) + (_attachSpecs select 2);	//animation dir fix + snappoint (object) direction fix
	_attach		= _this select 4;

	//wait for the simulation to start
	waitUntil{time > 0};

	if (isNil "_unit") exitWith {};
	if (isNull _unit) exitWith {};
	if !(alive _unit && canMove _unit) exitWith {};

	_attachPos = getPosASL _attachObj;

	//create a logic for attaching of the unit
	//_group = createGroup west;
	//_group = group _unit;
	_group = BIS_fnc_ambientAnim__group;

	_logic = _group createUnit ["Logic", [_attachPos select 0,_attachPos select 1,0], [], 0, "NONE"];

	if (isNull _logic) exitWith
	{
		if (count units _group == 0) then
		{
			deleteGroup _group;
		};
	};

	_logic setPosASL _attachPos;
	_logic setDir ((getDir _attachObj) + _azimutFix);

	//4debug
	_unit setVariable ["BIS_fnc_ambientAnim__logic",_logic];
	_unit setVariable ["BIS_fnc_ambientAnim__helper",_attachObj];

	//attach the unit to the game logic
	if (_attach) then
	{
		_unit attachTo [_logic,_attachSpecs select 1];
		_unit setVariable ["BIS_fnc_ambientAnim__attached",true];
	};

	//client side JIP
	_pool = _unit getVariable ["BIS_fnc_ambientAnim__anims",[]];
	_unit switchMove (_pool param [0,""]);
	[[netid _unit,_pool param [0,""]],{
		if isserver exitwith {};
		params [["_netid","",[""]],["_anim","",[""]]];
		waituntil {!isNull (objectFromNetId _netid)};
		(objectFromNetId _netid) switchMove _anim;
		(objectFromNetId _netid) addEventHandler ["AnimDone",{
			params ["_unit","_anim"];
			private _pool = _unit getVariable ["BIS_fnc_ambientAnim__anims",[_anim]];
			if (count _pool > 1) then {_pool = _pool - [_anim]};
			if (alive _unit) then{_unit switchMove (selectRandom _pool)};
		}];
	}] remoteExec ["CaptureTheFlag_c_system_JIPcall",-2,true];

};