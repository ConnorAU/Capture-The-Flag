class CaptureTheFlag_UI_ControlsAndRules {
    idd=-1;
    enableSimulation=1;
    movingEnable=0;
    name="CaptureTheFlag_UI_ControlsAndRules";
    onLoad="['rulesAndControls',_this] call (missionnamespace getvariable ['CaptureTheFlag_c_ui_playerMenu',{}])";

    class controls {

        #define CAR_MAIN_W 0.6
        #define CAR_MAIN_H 0.6
        #define CAR_BUTTON_H 0.04

        class title: CaptureTheFlag_3DEN_ctrlStaticTitle {
            style=2;
            text="Controls & Rules";
            sizeEx=SZ_sizeEx_04;

            x=SZ_centerXA(CAR_MAIN_W);
            y=SZ_centerYA(CAR_MAIN_H)-CAR_BUTTON_H;
            w=(CAR_MAIN_W);
            h=(CAR_BUTTON_H);

            colorBackground[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };
        class background: CaptureTheFlag_3DEN_ctrlStaticBackground {
            x=SZ_centerXA(CAR_MAIN_W);
            y=SZ_centerYA(CAR_MAIN_H);
            w=(CAR_MAIN_W);
            h=CAR_MAIN_H+CAR_BUTTON_H;

            colorBackground[]={0,0,0,0.6};
        };
        class textContainer: CaptureTheFlag_3DEN_ctrlControlsGroup {
            x=SZ_centerXA(CAR_MAIN_W);
            y=SZ_centerYA(CAR_MAIN_H);
            w=(CAR_MAIN_W);
            h=(CAR_MAIN_H);

            class controls {
                class text: CaptureTheFlag_3DEN_ctrlStructuredText {
                    idc=1;

                    size=SZ_sizeEx_04;
                    x=0;
                    y=0;
                    w=(CAR_MAIN_W);
                    h=0;

                    colorBackground[]={0,0,0,0};

                    class Attributes {
                        font="RobotoCondensed";
                    };
                };
            };
        };
        class exitButton: CaptureTheFlag_3DEN_ctrlButton {
            idc=2;
            style=2;
            text="Exit Menu";
            sizeEx=SZ_sizeEx_04;

            x=SZ_centerXA(CAR_MAIN_W);
            y=SZ_centerYA(CAR_MAIN_H)+CAR_MAIN_H;
            w=(CAR_MAIN_W);
            h=(CAR_BUTTON_H);

            colorBackground[]={0,0,0,0};
            colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };

        #undef CAR_MAIN_W
        #undef CAR_MAIN_H
        #undef CAR_BUTTON_H

    };
};
