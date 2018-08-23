/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

private _v = vehicle player;
setViewDistance ([
	CaptureTheFlag_setting_landViewDistance,
	CaptureTheFlag_setting_airViewDistance
] param [
	[
		_v isKindOf "LandVehicle",
		_v isKindOf "Air"
	] find true,
	CaptureTheFlag_setting_footViewDistance
]);