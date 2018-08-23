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

if CaptureTheFlag_ui_headsUpIcons_hide exitwith {};

if (CaptureTheFlag_setting_showPlayerTags call CaptureTheFlag_c_system_toBool) then {
	{
		if (player distance _x < 1000 && {_x != player}) then {
			_pos = (_x modelToWorldVisual (_x selectionPosition "head")) vectorAdd [0,0,0.5];
			_dist = player distance _pos;
			_imgSize = 0.4 max (5/_dist) min 0.7;
			_txtSize = 0.025 max (0.25/_dist) min 0.04;
			_colour = [1,1,1];
			_text = format["%2 - %1",STREAM_SAFE_NAME(_x),_x getVariable ["rank",0]];
			_icon = if (getPlayerChannel _x > -1) then {
				"a3\ui_f\data\igui\rscingameui\rscdisplaychannel\mutevon_ca.paa";
			} else {
				if (lifeState _x == "Incapacitated") then {
					_text = "";
					_colour = [1,0,0];
					MISSION_ROOT+"resources\images\skull.paa"
				} else {
					"A3\ui_f\data\map\diary\icons\player"+(["west_ca.paa","east_ca.paa"] select SIDE_INDEX);
				};
			};
			drawIcon3D [
				_icon,_colour+[0.5 max (10/_dist) min 1],
				_pos,_imgSize,_imgSize,0, 
				["",["",_text] select CaptureTheFlag_ui_HUI_showPlayerNames] select true,2,_txtSize,"PuristaMedium","center",
				false
			];
		};
	}foreach (playableUnits select {SIDE_VAR(_x) isequalto SIDE_VAR(player) && {alive _x}});
};


if ([player,[BLUFOR_SAFE_ZONE,OPFOR_SAFE_ZONE] select SIDE_INDEX] call CaptureTheFlag_c_system_inArea) then {
	drawIcon3D [
		"a3\ui_f\data\gui\rsc\rscdisplaymultiplayer\arrow_up_ca.paa", 
		[1,1,1,1],
		getMarkerPos AO_MARKER vectorAdd [0,0,100], 
		1.25,0.75,180, 
		"This way to the battlefield!",2,0.034,"PuristaMedium","center",
		true
	];

	if !(isNull CaptureTheFlag_ui_lastPurchasedVehicle) then {
		drawIcon3D [
			MISSION_ROOT+"resources\images\holdaction\car.paa", 
			[0.8,1,0.8,1],
			getPosVisual CaptureTheFlag_ui_lastPurchasedVehicle vectorAdd [0,0,((boundingBox CaptureTheFlag_ui_lastPurchasedVehicle param [1,[]]) param [2,0])*1.2], 
			0.75,0.75,0, 
			"",2,0.034,"PuristaMedium","center",
			false
		];
	};

	private _spawn = [BLUFOR_UNIT_SPAWN,OPFOR_UNIT_SPAWN] select SIDE_INDEX;
	if (player distance _spawn < 40) then {
		{
			_x params ["_obj","_txt"];
			_pos = (_obj modelToWorldVisual (_obj selectionPosition "head")) vectorAdd [0,0,0.6];
			_dist = player distance _pos;
			_size = 0.025 max (0.25/_dist) min 0.04;
			if (_size >= 0) then {
				drawIcon3D [
					"", 
					[1,1,1,0 max (5/_dist) min 1],
					_pos, 
					1.25,0.75,0, 
					_txt,2,_size max 0.025,"PuristaMedium","center",
					false
				];
			};
		}foreach [
			[[BLUFOR_WEAPONS_NPC,OPFOR_WEAPONS_NPC] select SIDE_INDEX,"Weapons & Attachments"],
			[[BLUFOR_VEHICLE_NPC,OPFOR_VEHICLE_NPC] select SIDE_INDEX,"Vehicles"],
			[[BLUFOR_CLOTHING_NPC,OPFOR_CLOTHING_NPC] select SIDE_INDEX,"Clothing"],
			[[BLUFOR_SKILLS_NPC,OPFOR_SKILLS_NPC] select SIDE_INDEX,"Skills"]
		];
	};

} else {	
	private _obj = OBJECTIVE_FLAG_POLE;
	private _flagStolenBy = _obj getVariable ["UnitStolen",objNull];
	if (isNull _flagStolenBy) then {
		HUI_DRAWICON_PARAMS1(OBJECTIVE_FLAG_IMG,"Steal") call HUI_DRAWICON_CODE;
	} else {
		_obj = _flagStolenBy;
		private _txt = "";
		if (_obj isKindOf "CAManBase") then {
			_txt = ["Attack","Protect"] select (SIDE_VAR(player) isequalto SIDE_VAR(_obj));
			HUI_DRAWICON_PARAMS2(OBJECTIVE_FLAG_IMG,_txt) call HUI_DRAWICON_CODE;

			[
				[BLUFOR_FLAG_POLE,BLUFOR_FLAG_IMG],
				[OPFOR_FLAG_POLE,OPFOR_FLAG_IMG]
			] param [SIDE_INDEX_GLOBAL(_obj),0,[]] params ["_obj","_img"];
			HUI_DRAWICON_PARAMS1(_img,"Capture Point") call HUI_DRAWICON_CODE;
		} else {
			HUI_DRAWICON_PARAMS1(OBJECTIVE_FLAG_IMG,"Retrieve") call HUI_DRAWICON_CODE;
		};

	};
};