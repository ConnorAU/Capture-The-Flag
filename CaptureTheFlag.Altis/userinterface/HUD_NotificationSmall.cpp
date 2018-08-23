class CaptureTheFlag_HUD_NotificationSmall: CaptureTheFlag_3DEN_ctrlControlsGroupNoScrollbars {
    x=SZ_X;
    y=SZ_Y+(0.8*SZ_H);
    w=SZ_W;
    h=SZ_H;

    onLoad="['init',_this] call (missionnamespace getvariable ['CaptureTheFlag_c_ui_HUD_NotificationSmall',{}])";

    class controls {
        class Notification: CaptureTheFlag_3DEN_ctrlStructuredText {
            idc=1;
            style=2;

            x=0;
            y=0;
            w=SZ_W;
            h=SZ_H;
            size=SZ_sizeEx_04;

            class Attributes
            {
                align="center";
                color="#ffffff";
                colorLink="";
                size=1;
                font="RobotoCondensedLight";
            };

            colorBackground[]={0,0,0,0};
            shadow=1;
        };
    };
};