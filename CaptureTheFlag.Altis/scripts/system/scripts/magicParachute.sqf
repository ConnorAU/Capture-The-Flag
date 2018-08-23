/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

if (isTouchingGround player) exitwith {};
if ((getposatl player select 2)<60) exitwith {};

private _l = getUnitLoadout player;
removeBackpack player;
player addBackpack "B_Parachute";

waituntil {
	!alive player OR 
	{
		vehicle player != player OR 
		{
			(getposatl player select 2)<40
		}
	}
};

if (!alive player) exitwith {};
player setUnitLoadout _l;
if (vehicle player != player) exitwith {};

private _p = createvehicle ["Steerable_Parachute_F",getPosASL player,[],0,"CAN_COLLIDE"];
_p setposatl (getposatl player);
_p setDir (getDir player);
player moveInDriver _p;