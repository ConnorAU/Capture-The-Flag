/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"
params [["_unit",cursorTarget,[objNull]]];
if (isNull _unit) exitwith {false};
(
 	vehicle player isequalto player && 
 	{
 		SIDE_VAR(_unit) isequalto SIDE_VAR(player) && 
 		{
 			NEEDS_REVIVE(_UNIT) && 
 			{
 				_unit iskindof "CAManBase" && 
 				{
 					player distance _unit < 2
 				}
 			}
 		}
 	}
)