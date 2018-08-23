class CaptureTheFlag_UI_TeamKilled {
    idd=-1;
    enableSimulation=1;
    movingEnable=0;
    name="CaptureTheFlag_UI_TeamKilled";
    onLoad="uiNameSpace setVariable ['CaptureTheFlag_UI_TeamKilled',_this select 0];";

    class controls {

        #define TK_MAIN_W 0.55
        #define TK_MAIN_H 0.08
        #define TK_BUTTON_H 0.04

        class title: CaptureTheFlag_3DEN_ctrlStaticTitle {
            style=2;
            text="Team Killed";
            sizeEx=SZ_sizeEx_04;

            x=SZ_centerXA(TK_MAIN_W);
            y=SZ_centerYA(TK_MAIN_H)-TK_BUTTON_H;
            w=(TK_MAIN_W);
            h=(TK_BUTTON_H);

            colorBackground[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };
        class background: CaptureTheFlag_3DEN_ctrlStaticBackground {
            x=SZ_centerXA(TK_MAIN_W);
            y=SZ_centerYA(TK_MAIN_H);
            w=(TK_MAIN_W);
            h=TK_MAIN_H+TK_BUTTON_H;

            colorBackground[]={0,0,0,0.6};
        };
        class textContainer: CaptureTheFlag_3DEN_ctrlControlsGroup {
            x=SZ_centerXA(TK_MAIN_W);
            y=SZ_centerYA(TK_MAIN_H);
            w=(TK_MAIN_W);
            h=(TK_MAIN_H);

            class controls {
                class text: CaptureTheFlag_3DEN_ctrlStructuredText {
                    idc=1;

                    size=SZ_sizeEx_04;
                    x=0;
                    y=0;
                    w=(TK_MAIN_W);
                    h=0;

                    colorBackground[]={0,0,0,0};

                    class Attributes: Attributes {
                        font="RobotoCondensed";
                    };
                };
            };
        };
        class forgiveButton: CaptureTheFlag_3DEN_ctrlButton {
            idc=2;
            style=2;
            sizeEx=SZ_sizeEx_04;

            x=SZ_centerXA(TK_MAIN_W);
            y=SZ_centerYA(TK_MAIN_H)+TK_MAIN_H;
            w=TK_MAIN_W/2;
            h=(TK_BUTTON_H);

            colorBackground[]={0,0,0,0};
            colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };
        class punishButton: forgiveButton {
            idc=3;
            x=SZ_centerXA(TK_MAIN_W)+(TK_MAIN_W/2);
        };

        #undef TK_MAIN_W
        #undef TK_MAIN_H
        #undef TK_BUTTON_H

    };
};
