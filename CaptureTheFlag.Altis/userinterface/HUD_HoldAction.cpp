class CaptureTheFlag_HUD_HoldAction: CaptureTheFlag_3DEN_ctrlControlsGroupNoScrollbars {
    x=SZ_X;
    y=SZ_Y_OFFSET(0.575);
    w=SZ_W;
    h=SZ_H;

    onLoad="['init',_this] call (missionnamespace getvariable ['CaptureTheFlag_c_ui_holdAction',{}])";

    class controls {
        class background: CaptureTheFlag_3DEN_ctrlStructuredText {
            idc=1;

            x="0";
            y="0";
            w=SZ_W;
            h=SZ_H;
            size=SZ_sizeEx_04;

            shadow=2;

            class Attributes {
                size=1;

                align="center";
                color="#ffffff";
                colorLink="";
                font="RobotoCondensedBold";
            };
        };
        class foreground: background {
            idc=2;

            class Attributes {
                size=1;

                align="center";
                color="#ffffff";
                colorLink="";
                font="RobotoCondensedBold";
            };
        };
    };
};