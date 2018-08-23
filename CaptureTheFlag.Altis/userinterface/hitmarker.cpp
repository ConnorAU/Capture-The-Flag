// Credit to Atlas Hitmarkers for this one - https://steamcommunity.com/sharedfiles/filedetails/?id=772802287
class CaptureTheFlag_UI_HitMarker {
	idd=-1;
	movingEnable=0;
	enableSimulation=1;
	fadein=0;
	fadeout=0.2;
	duration=0.2;
	controlsBackground[]={"hitMarker"};
	controls[]={};
	class hitMarker {
		idc=-1;
		type=0;
		style=2096;

		#define HM_S 0.08

		x=SZ_centerXA(HM_S);
		y=SZ_centerYA(HM_S);
		w=HM_S;
		h=HM_S;

		#undef HM_S

		font="RobotoCondensed";
		sizeEx=0;
		colorBackground[]={0,0,0,0};
		colorText[]={1,1,1,1};
		text="\a3\ui_f\data\IGUI\Cfg\Cursors\iconCursorSupport_ca.paa";
	};
};
class CaptureTheFlag_UI_HitMarkerFriendly: CaptureTheFlag_UI_HitMarker {
	class hitMarker: hitMarker {
		colorText[]={1,0,0,1};
	};
};