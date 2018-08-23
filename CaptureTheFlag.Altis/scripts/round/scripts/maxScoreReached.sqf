/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\..\defines.sqf"
#define MAXSCORE_COMMITTIME 15
#define MAXSCORE_FADETIME 5

if isServer exitwith {};
params [["_side",sideUnknown,[sideUnknown]]];
if (_side isequalto sideUnknown) exitwith {};

player allowdamage false;
private _winningFlag = [BLUFOR_FLAG_BASE,OPFOR_FLAG_BASE] select SIDE_INDEX_SIDE(_side);
private _win = _side isEqualTo SIDE_VAR(player);

["refund_vehicles"] call CaptureTheFlag_c_session_handleEvent;
[["round_defeat","round_victory"] select _win] call CaptureTheFlag_c_session_handleEvent;

if _win then {
	playSound "endWin";
	uisleep 0.25;
} else {
	[] spawn {
		uisleep 0.5;
		playSound "endLose";
	};
};

uisleep 2.5;
private _layerStatic = "BIS_fnc_endMission_static" call bis_fnc_rscLayer;
_layerStatic cutText ["","PLAIN"];
_layerStatic cutrsc ["RscStatic","PLAIN"];
uisleep 0.35;

showChat false;

private _endGameCam = "CAMERA" camCreate [0,0,1.17115];
waitUntil {!isNil {_endGameCam}};
_endGameCam cameraEffect ["INTERNAL","BACK"];
showCinemaBorder false;
camUseNVG false;
_endGameCam camSetFocus [1000,0];
_endGameCam camSetFov 1.2;
_endGameCam camSetPos (_winningFlag modelToWorld [-2,-5,0.5]); 
_endGameCam camSetTarget (_winningFlag modelToWorld [0,0,2]); 
_endGameCam camCommit 0;
["showNotification",[format["<t color='#%2'>%1</t> won the round",["Blufor","Opfor"] select SIDE_INDEX_SIDE(_side),["11B8EC","bf0000"] select SIDE_INDEX_SIDE(_side)],1,MAXSCORE_COMMITTIME-(MAXSCORE_FADETIME/1.5)]] call CaptureTheFlag_c_ui_HUD_notificationBig;
waitUntil {camCommitted _endGameCam};
_endGameCam camSetPos (_winningFlag modelToWorld [-2,-5,5]);
_endGameCam camSetTarget (_winningFlag modelToWorld [0,0,3]); 
_endGameCam camCommit MAXSCORE_COMMITTIME;
uisleep (MAXSCORE_COMMITTIME - (MAXSCORE_FADETIME+1));
cutText ["","BLACK OUT",MAXSCORE_FADETIME];
5 fadeSound 0;
uisleep MAXSCORE_FADETIME;
_endGameCam cameraEffect ["INTERNAL","TERMINATE"];
camDestroy _endGameCam;
showChat true;
private _endToken = [
    ["bluforLost","bluforWon"] select _win,
    ["opforLost","opforWon"] select _win
] select SIDE_INDEX;
END_MISSION_SAFE(_endToken);