author="Connor";
onLoadName="Capture the Flag";
briefingName="Capture the Flag";
// Random load screen image
loadScreen = __EVAL(format["resources\images\splash_%1.paa",ceil random 3]);
onPauseScript[]={"CaptureTheFlag_c_ui_onPauseScript"};
//enableDebugConsole[]={"76561198090361580"};

joinUnassigned=0;
skipLobby=0;

respawn=3;
respawnDelay=6;
respawnDialog=1;

briefing=0;
debriefing=0;

disabledAI=1;

scriptedPlayer=1;
enableItemsDropping=0;
disableRandomization[]={"All"};
forceRotorLibSimulation=0;
showGroupIndicator=0;
showSquadRadar=0;
showUAVFeed=0;

allowFunctionsLog=0;
allowFunctionsRecompile=0;

disableChannels[]={
	{0,false,true},		// Global
	{1,false,false},	// Side
	{2,true,true},		// Command
	{3,false,false},	// Group
	{4,false,false},	// Vehicle
	{5,false,false}		// Direct
};

class Header {
    gameType="CTF";
    minPlayers=1;
    maxPlayers=120;
};

corpseManagerMode=1;
corpseLimit=100;
corpseRemovalMinTime=1;
corpseRemovalMaxTime=600;

wreckManagerMode=1;
wreckLimit=0;
wreckRemovalMinTime=10;
wreckRemovalMaxTime=11;