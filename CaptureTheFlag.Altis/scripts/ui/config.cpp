class ui {
	class functions {
		class initHUD {};
		class createDialog {};
		class playerMenu {};
		class onPauseScript {};
		class mapIcons {};
		class gpsIcons {};
		class headsUpIcons {};
		
		class HUD_Main {};
		class HUD_NotificationBig {};
		class HUD_NotificationSmall {};
		class HUD_Watermark {};

		class holdAction {};

		class notifFeed_add {};
		class notifFeed_useTemplate {};
		class notifFeed_update {};
		class warningEffects {};
		class zoneWarning {};
	};
	class configs {
		#include "configs\holdActionTemplate.cpp"
		#include "configs\notificationAddTemplate.cpp"
		#include "configs\zoneWarningTemplate.cpp"
	};
};

