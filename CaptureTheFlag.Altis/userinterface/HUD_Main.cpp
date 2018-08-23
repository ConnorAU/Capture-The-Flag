class CaptureTheFlag_HUD_Main: CaptureTheFlag_3DEN_ctrlControlsGroupNoScrollbars {

    // these defines are undefined in the watermark file due to cross-usage
    #define HUD_MAIN_W 0.284999
    #define HUD_MAIN_H 0.212
    #define HUD_MAIN_BLOCK_Y_FLOOR (SZ_Y_OFFSET(1)-(1.25*HUD_MAIN_H))

    #define HUD_MAIN_005 0.005
    #define HUD_MAIN_035 0.035
    #define HUD_MAIN_075 0.075
    #define HUD_MAIN_1375 0.1375
    #define HUD_MAIN_1425 0.1425
    #define HUD_MAIN_165 0.165
    #define HUD_MAIN_274999 0.274999

    x=(SZ_X+SZ_W)-(HUD_MAIN_W+0.015);
    y=HUD_MAIN_BLOCK_Y_FLOOR-HUD_MAIN_H;
    w=(HUD_MAIN_W);
    h=(HUD_MAIN_H);

    show=0;
    onLoad="['init',_this] call (missionnamespace getvariable ['CaptureTheFlag_c_ui_HUD_Main',{}])";

    class controls {
        class background: CaptureTheFlag_3DEN_ctrlStaticBackground {
            x="0";
            y="0";
            w=(HUD_MAIN_W);
            h="0.2075";

            colorBackground[]={0,0,0,0.3};
        };
        class flagHomeBG: CaptureTheFlag_3DEN_ctrlStaticPictureKeepAspect {
            idc=1;

            x=(HUD_MAIN_005);
            y=(HUD_MAIN_005);
            w="0.0487501";
            h="0.065";
        };
        class flagCapturePointBG: flagHomeBG {
            idc=11;

            x="0.23125";
        };
        class flagImg: flagHomeBG {
            idc=2;
        };
        class bluforFlagProgressBG: CaptureTheFlag_3DEN_ctrlStaticTitle {
            idc=3;

            x=(HUD_MAIN_005);
            y=(HUD_MAIN_075);
            w=(HUD_MAIN_1375);
            h=(HUD_MAIN_035);

            colorBackground[]={0,0.15,0.32,0.5};
        };
        class bluforFlagProgress: bluforFlagProgressBG {
            idc=4;

            w="0";

            colorBackground[]={0,0.3,0.6,1};
        };
        class bluforFlagCount: CaptureTheFlag_3DEN_ctrlStaticTitle {
            idc=5;
            style=2;

            x=(HUD_MAIN_005);
            y=(HUD_MAIN_075);
            w=(HUD_MAIN_1375);
            h=(HUD_MAIN_035);
            sizeEx=SZ_sizeEx_04;

            colorBackground[]={0,0,0,0};
            shadow=0;
        };
        class opforFlagProgressBG: CaptureTheFlag_3DEN_ctrlStaticTitle {
            idc=13;

            x=(HUD_MAIN_1425);
            y=(HUD_MAIN_075);
            w=(HUD_MAIN_1375);
            h=(HUD_MAIN_035);

            colorBackground[]={0.25,0,0,0.5};
        };
        class opforFlagProgress: opforFlagProgressBG {
            idc=14;

            x="0.21225";
            w="0";

            colorBackground[]={0.5,0,0,1};
        };
        class opforFlagCount: CaptureTheFlag_3DEN_ctrlStaticTitle {
            idc=15;
            style=2;

            x=(HUD_MAIN_1425);
            y=(HUD_MAIN_075);
            w=(HUD_MAIN_1375);
            h=(HUD_MAIN_035);
            sizeEx=SZ_sizeEx_04;

            colorBackground[]={0,0,0,0};
            shadow=0;
        };
        class time: CaptureTheFlag_3DEN_ctrlStaticTitle {
            idc=21;
            style=2;

            x=(HUD_MAIN_005);
            y=(HUD_MAIN_005);
            w=(HUD_MAIN_274999);
            h="0.065";
            sizeEx=SZ_sizeEx_04;

            colorBackground[]={0,0,0,0};
            shadow=0;
        };
        class playerRank: CaptureTheFlag_3DEN_ctrlStaticTitle {
            idc=31;

            x=(HUD_MAIN_005);
            y="0.12";
            w=(HUD_MAIN_1375);
            h="0.04";
            sizeEx=SZ_sizeEx_04;

            colorBackground[]={0,0,0,0};
            shadow=0;
        };
        class playerCash: playerRank {
            idc=32;
            style=1;

            x=(HUD_MAIN_1425);
        };
        class playerEXPBG: CaptureTheFlag_3DEN_ctrlStaticTitle {
            idc=33;

            x=(HUD_MAIN_005);
            y=(HUD_MAIN_165);
            w=(HUD_MAIN_274999);
            h=(HUD_MAIN_035);

            colorBackground[]={0,0,0,0.4};
        };
        class playerEXP: playerEXPBG {
            idc=34;

            w="0";

            colorBackground[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
        };
        class playerEXPText: CaptureTheFlag_3DEN_ctrlStaticTitle {
            idc=35;
            style=2;

            x=(HUD_MAIN_005);
            y=(HUD_MAIN_165);
            w=(HUD_MAIN_274999);
            h=(HUD_MAIN_035);
            sizeEx=SZ_sizeEx_04;

            colorBackground[]={0,0,0,0};
            shadow=0;
        };
    };

    #undef HUD_MAIN_005
    #undef HUD_MAIN_035
    #undef HUD_MAIN_075
    #undef HUD_MAIN_1375
    #undef HUD_MAIN_1425
    #undef HUD_MAIN_165
    #undef HUD_MAIN_274999

};