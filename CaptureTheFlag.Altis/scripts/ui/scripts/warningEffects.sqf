/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [["_toggle",false,[true]]];

if _toggle then {
	"ColorCorrections" ppEffectEnable true;
	"ColorCorrections" ppEffectAdjust [1,1,0,[0,0,0,0.5],[1,1,1,0],[0.299,0.587,0.114,0]];
	"ColorCorrections" ppEffectCommit 2;
	"FilmGrain" ppEffectEnable true;
	"FilmGrain" ppEffectAdjust [0.75,1.5,1.7,0.2,1.0,true];
	"FilmGrain" ppEffectCommit 1;
} else {
	"ColorCorrections" ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.299,0.587,0.114,0],[-1,-1,0,0,0,0,0]];
	"ColorCorrections" ppEffectCommit 2;
	"FilmGrain" ppEffectAdjust [0,1.5,1.7,0.2,1.0,true];
	"FilmGrain" ppEffectCommit 1;
};