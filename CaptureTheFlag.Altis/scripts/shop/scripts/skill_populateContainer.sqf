/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\defines.sqf"
#include "..\..\defines.sqf"

disableSerialization;
private _display = uiNamespace getVariable ["CaptureTheFlag_UI_SkillShop",displayNull];
if (isNull _display) exitwith {};
private _scollerContainer = _display displayCtrl 3;

{ctrlDelete _x} foreach (_scollerContainer getVariable ["children",[]]);

private _children = [];
private _ex = 0;
private ["_container","_title","_imgCtrl","_description","_upgradeButton","_enableButton","_tier"];
{
	_container = _display ctrlCreate ["CaptureTheFlag_UI_SkillShop_SkillContainer",-1,_scollerContainer];
	_container ctrlSetPosition ([_ex]+(ctrlPosition _container select [1,3]));
	_container ctrlcommit 0;
	_ex = _ex + ((ctrlPosition _container select 3)/2) + 0.0065;
	_children pushback _container;

	_title = _container controlsGroupCtrl 10;
	_description = _container controlsGroupCtrl 16;
	_upgradeButton = _container controlsGroupCtrl 17;
	_enableButton = _container controlsGroupCtrl 18;

	_tier = missionNamespace getVariable ["CaptureTheFlag_skill_"+configname _x,0];
	_maxTier = count("true" configClasses _x);

	_title ctrlSetText getText(_x >> "displayName");
	_description ctrlSetText (getText(_x >> ("Tier"+str(_tier max 1)) >> "description"));
	_rank = getNumber(_x >> ("Tier"+str((_tier+1) min 5)) >> "rank");
	_price = getNumber(_x >> ("Tier"+str((_tier+1) min 5)) >> "price");

	for "_i" from 1 to _maxTier do {
		_imgCtrl = _container controlsGroupCtrl (10+_i);
		_imgCtrl ctrlSetText getText(_x >> "imageSmall");
		if (_tier>=_i) then {
			_imgCtrl ctrlSetTextColor [1,1,1,1];
		} else {
			_imgCtrl ctrlSetTextColor [1,1,1,0.25];
			_imgCtrl ctrlSetTooltip ("Rank Required: "+str getNumber(_x >> ("Tier"+str _i) >> "rank"));
		};
	};

	_enableButton ctrlSetText "Equip";
	if (_tier == 0) then {
		_upgradeButton ctrlSetText "Unlock";
		_upgradeButton ctrlSetTooltip format["Required Rank: %1%3Price: $%2",_rank,_price call CaptureTheFlag_c_system_numberText,endl];
		_upgradeButton ctrlEnable (CaptureTheFlag_statistic_rank>=_rank && CaptureTheFlag_session_currency>=_price);
		if (ctrlEnabled _upgradeButton) then {
			_upgradeButton ctrlAddEventHandler ["ButtonClick",format["%1 spawn CaptureTheFlag_c_shop_skill_upgrade",[configname _x,_maxTier,_price]]];
		};
		_enableButton ctrlEnable false;
	} else {
		if (_tier >= _maxTier) then {
			_upgradeButton ctrlEnable false;
		} else {
			_upgradeButton ctrlSetText "Upgrade";
			_upgradeButton ctrlSetTooltip format["Required Rank: %1%3Price: $%2",_rank,_price call CaptureTheFlag_c_system_numberText,endl];
			_upgradeButton ctrlEnable (CaptureTheFlag_statistic_rank>=_rank && CaptureTheFlag_session_currency>=_price);
			if (ctrlEnabled _upgradeButton) then {
				_upgradeButton ctrlAddEventHandler ["ButtonClick",format["%1 spawn CaptureTheFlag_c_shop_skill_upgrade",[configname _x,_maxTier,_price]]];
			};
		};
		if SKILL_ACTIVE(configname _x) then {
			_enableButton ctrlSetText "Unequip";
			_enableButton ctrlEnable true;
			_enableButton ctrlAddEventHandler ["ButtonClick",format["%1 spawn CaptureTheFlag_c_shop_skill_unequip",[configname _x]]];
		} else {
			_enableButton ctrlEnable (count CaptureTheFlag_setting_skills < 2);
			if (ctrlEnabled _enableButton) then {
				_enableButton ctrlAddEventHandler ["ButtonClick",format["%1 spawn CaptureTheFlag_c_shop_skill_equip",[configname _x]]];
			};
		};
	};
} foreach ("true" configClasses (SKILLS_SHOP_CONFIG_PATH));

_scollerContainer setVariable ["children",_children];

private _maintainWidthScrollBarCtrl = _scollerContainer controlsGroupCtrl 1;
private _maintainWidthScrollBarCtrlPos = ctrlPosition _maintainWidthScrollBarCtrl;
_maintainWidthScrollBarCtrlPos set [2,(ctrlPosition _container select 0)+(ctrlPosition _container select 2)];
_maintainWidthScrollBarCtrl ctrlSetPosition _maintainWidthScrollBarCtrlPos;
_maintainWidthScrollBarCtrl ctrlcommit 0;