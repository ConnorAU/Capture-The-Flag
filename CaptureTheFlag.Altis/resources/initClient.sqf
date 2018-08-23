/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */


// Set this here because its before jip messages are executed and it was the only place this was possible before preparing the mission for public release
missionNamespace setVariable ["CaptureTheFlag_c_system_JIPcall",compileFinal "
	params [['_params',[]],['_code',{},['',{}]]];
	if(_code isEqualType '')then{_code = compile _code};
	if !isServer then {
		waituntil {missionNamespace getVariable ['CaptureTheFlag_setup_initClientCompleted',false]};
	};
	_params call _code;
"];
if !isServer then {
	addMissionEventHandler["PreloadFinished",{
		CaptureTheFlag_setup_preloadFinished = true;
		removeMissionEventHandler ["PreloadFinished",_thisEventHandler];
	}];
	"CaptureTheFlag_FadeLayer" cutText ["","BLACK OUT",2];
	"CaptureTheFlag_FadeLayer" cutFadeOut 999999;
	{
		// Smoothly move the progress bar
		private ["_t","_pD","_pE","_pS"];
		private _pC = 0;
		private _d = 2;
		for "_i" from 0 to 1 step 0 do {
			_t = diag_tickTime;
			_pE = CaptureTheFlag_setup_progressLoadingScreen;
			_pS = _pC;
			_pD = _pE - _pC;
			waituntil {
				_pC = 1 min ((((diag_tickTime-_t)/_d)*_pD)+_pS);
				progressLoadingScreen _pC;
				_pC >= (1 min _pE)
			};
			if (_pE >= 1) exitwith {CaptureTheFlag_setup_progressLoadingScreen = nil;};
			waituntil {CaptureTheFlag_setup_progressLoadingScreen != _pE};
		};
	} spawn {
		// Wait for preloading to finish
		waituntil {!isNil "CaptureTheFlag_setup_preloadFinished"};
		CaptureTheFlag_setup_preloadFinished = nil;

		// Start our own loading screen
		startLoadingScreen [""];
		CaptureTheFlag_setup_progressLoadingScreen = 0;
		0 spawn _this;

		// Wait for our client to be ready
		waituntil {
			!isNull player && 
			{
				player isKindOf "CAManBase" && 
				{
					(netid player) != ""
				}
			}
		};
		removeAllWeapons player;
		CaptureTheFlag_setup_progressLoadingScreen = 0.25;

		// Wait for server to be ready and variables to be received
		waituntil {!isNil "CaptureTheFlag_setup_serverIsSetup"};
		waituntil {!isNil "CaptureTheFlag_setup_SIMBV"};
		waituntil {!(true in ((call CaptureTheFlag_setup_SIMBV) apply {isNil _x}))};
		CaptureTheFlag_setup_progressLoadingScreen = 0.5;

		// Request player information
		[clientOwner,getplayeruid player,profilename,player,netid player,playerside] remoteExec ["CaptureTheFlag_s_session_fetchPlayerData",2];
		waituntil {missionnamespace getVariable ["CaptureTheFlag_session_dataRead",false]};
		CaptureTheFlag_setup_progressLoadingScreen = 0.75;

		// Run pending scripts from the init queue
		CaptureTheFlag_setup_initFunctions_runPendingRequests = true;
		waituntil {isNil "CaptureTheFlag_setup_initFunctions_runPendingRequests"};
		CaptureTheFlag_setup_progressLoadingScreen = 1;

		// Wait for progress bar to reach 100%
		waituntil {isNil "CaptureTheFlag_setup_progressLoadingScreen"};
		"CaptureTheFlag_FadeLayer" cutText ["","BLACK IN",2];
		uiSleep 0.1;
		endLoadingScreen;
	};
};
true
