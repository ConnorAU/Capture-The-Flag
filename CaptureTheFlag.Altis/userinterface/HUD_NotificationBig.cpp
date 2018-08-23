class CaptureTheFlag_HUD_NotificationBig: CaptureTheFlag_3DEN_ctrlControlsGroupNoScrollbars {
    x=SZ_X;
    y=SZ_Y+(0.25*SZ_H);
    w=SZ_W;
    h=SZ_H;

    onLoad="['init',_this] call (missionnamespace getvariable ['CaptureTheFlag_c_ui_HUD_NotificationBig',{}])";

    class controls {
        class Notification: CaptureTheFlag_3DEN_ctrlStructuredText {
            idc=1;
            style=2;

            x=0;
            y=0;
            w=SZ_W;
            h=SZ_H;
            size=SZ_sizeEx(3);

            colorBackground[]={0,0,0,0};
            shadow=2;

            class Attributes
            {
                align="center";
                color="#ffffff";
                colorLink="";
                size=1;
                font="RobotoCondensed";
            };
        };
    };
};