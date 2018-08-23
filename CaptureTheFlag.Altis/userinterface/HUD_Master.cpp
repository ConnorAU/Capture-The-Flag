class CaptureTheFlag_UI_HUD_Master {
	idd=-1;
	movingEnable=0;
	enableSimulation=1;
	fadein=2;
	fadeout=0;
	duration=1e14;
	onLoad="uiNameSpace setvariable ['CaptureTheFlag_UI_HUD_Master',_this select 0];";
	class controlsBackground {
		#include "HUD_Main.cpp"
		#include "HUD_Watermark.cpp"
		#include "HUD_HoldAction.cpp"
		#include "HUD_NotificationBig.cpp"
		#include "HUD_NotificationSmall.cpp"
	};
};